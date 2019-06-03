Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22C8A325C7
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jun 2019 02:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfFCAoS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 2 Jun 2019 20:44:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:38110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbfFCAoS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 2 Jun 2019 20:44:18 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B049027A45;
        Mon,  3 Jun 2019 00:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559522657;
        bh=DtLmciEJ3mbqMTl+ggQVqTnDTraDin4TpGIqa3Xxayc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1V2OwC3W91VU1pbRZpy1LGqlsPVAC4L4A1qBJF2G/bn+HMafkq9q5X39aT71tP3eR
         lr9u6QmgBxefDY0et1di8K50ycviGZBiyRaoYAnstU/uIEGfnLJ2YFCrNu797ttQDd
         tKa5lr7B1aKBv3c4Uq7OaUsBL7h4mvSbBr4GN3aM=
Date:   Sun, 2 Jun 2019 19:44:14 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     JD Zheng <jiandong.zheng@broadcom.com>
Cc:     linux-pci@vger.kernel.org, keith.busch@intel.com,
        bcm-kernel-feedback-list@broadcom.com,
        Alex Williamson <alex.williamson@redhat.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: SSD surprise removal leads to long wait inside pci_dev_wait()
 and FLR 65s timeout
Message-ID: <20190603004414.GA189360@google.com>
References: <8f2d88a5-9524-c4c3-a61f-7d55d97e1c18@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f2d88a5-9524-c4c3-a61f-7d55d97e1c18@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Alex, Lukas]

On Fri, May 31, 2019 at 09:55:20AM -0700, JD Zheng wrote:
> Hello,
> 
> I am running DPDK 18.11+SPDK 19.04 with v5.1 kernel. DPDK/SPDK uses SSD vfio
> devices and after running SPDK's nvmf_tgt, unplugging a SSD cause kernel to
> print out following:
> [  105.426952] vfio-pci 0000:04:00.0: not ready 2047ms after FLR; waiting
> [  107.698953] vfio-pci 0000:04:00.0: not ready 4095ms after FLR; waiting
> [  112.050960] vfio-pci 0000:04:00.0: not ready 8191ms after FLR; waiting
> [  120.498953] vfio-pci 0000:04:00.0: not ready 16383ms after FLR; waiting
> [  138.418957] vfio-pci 0000:04:00.0: not ready 32767ms after FLR; waiting
> [  173.234953] vfio-pci 0000:04:00.0: not ready 65535ms after FLR; giving up
> 
> Looks like it is a PCI hotplug racing condition between DPDK's
> eal-intr-thread thread and kernel's pciehp thread. And it causes lockup in
> pci_dev_wait() at kernel side.
> 
> When SSD is removed, eal-intr-thread immediately receives
> RTE_INTR_HANDLE_ALARM and handler calls rte_pci_detach_dev() and at kernel
> side vfio_pci_release() is triggered to release this vfio device, which
> calls pci_try_reset_function(), then _pci_reset_function_locked().
> pci_try_reset_function acquires the device lock but
> _pci_reset_function_locked() doesn't return, therefore lock is NOT released.
> 
> Inside _pci_reset_function_locked(), pcie_has_flr(), pci_pm_reset(), etc.
> call pci_dev_wait() at the end but it doesn't return and print out above
> message until 65s timeout.
> 
> At kernel pciehp side, it also detects the removal but doesn't run
> immediately as it is configured as "pciehp.pciehp_poll_time=5". So a couple
> of seconds later, it calls pciehp_unconfigure_device -> pci_walk_bus ->
> pci_dev_set_disconnected. pci_dev_set_disconnected() couldn't get the device
> lock and is stuck too because the lock is hold by eal-intr-thread.
> 
> The first issue is in pci_dev_wait(). It calls pci_read_config_dword() and
> only when id is not all ones, it can return. But when SSD is physically
> removed, id retrieved is always all ones therefore, it has to wait for FLR
> 65s timeout to return.
> 
> I did the following to check return value of pci_read_config_dword() to fix
> this:
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4439,7 +4439,11 @@ static int pci_dev_wait(struct pci_dev *dev, char
> *reset_type, int timeout)
> 
>                 msleep(delay);
>                 delay *= 2;
> -               pci_read_config_dword(dev, PCI_COMMAND, &id);
> +               if (pci_read_config_dword(dev, PCI_COMMAND, &id) ==
> +                   PCIBIOS_DEVICE_NOT_FOUND) {
> +                       pci_info(dev, "device disconnected\n");
> +                       return -ENODEV;
> +               }
>         }
> 
>         if (delay > 1000)
> 
> The second issue is that due to lock up described above, the
> pci_dev_set_disconnected() is stuck and pci_read_config_dword() won't return
> PCIBIOS_DEVICE_NOT_FOUND.
> 
> I didn't find a easy way to fix it. Maybe use device lock in
> pci_dev_set_disconnected() is too coarse and we need a finer device
> err_state lock?
> 
> BTW, pci_dev_set_disconnected wasn't using device lock until this change
> a6bd101b8f.
> 
> Any suggestions to fix this problem?

Would you mind opening a report at https://bugzilla.kernel.org and
attaching the complete dmesg log and "lspci -vv" output?

Out of curiosity, why do you use "pciehp.pciehp_poll_time=5"?

Bjorn
