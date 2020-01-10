Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7A3136459
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2020 01:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730211AbgAJA0l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jan 2020 19:26:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:44402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730208AbgAJA0l (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Jan 2020 19:26:41 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2413E2077C;
        Fri, 10 Jan 2020 00:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578616000;
        bh=BKjjtf2404wIS4uuPokpSCmLc/x9thxgYjubQ6r/IE0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=TpdbEBnn59RLYGy+FOtIBRMt4WTJmeIRrQCCx7xFmLoYAVjj3mVVTyZ4fwE/XCyfV
         DyKBZQ+XortqThr+iFj7UcNlbIf+lXwipxhZ6WWfDyaH7owxMgWkEiCy7iGjSfFPL6
         QDObs1miuCuaN946p9cOeIsgV8eAKhYMjQbYD8QU=
Date:   Thu, 9 Jan 2020 18:26:38 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Prabhakar Kushwaha <prabhakar.pkin@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-pci@vger.kernel.org, linux-ide@vger.kernel.org,
        Ganapatrao Prabhakerrao Kulkarni <gkulkarni@marvell.com>,
        Kamlakant Patel <kamlakantp@marvell.com>,
        kexec mailing list <kexec@lists.infradead.org>
Subject: Re: kexec -e not working: root disk not able to detect
Message-ID: <20200110002638.GA50413@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ2QiJ+MVVztHONagmYc2-BzbtdGQhABRKO7h4+kOE9cCK=CxA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Jens, ahci.c maintainer]

On Mon, Jan 06, 2020 at 05:24:44PM +0530, Prabhakar Kushwaha wrote:
> Hi All,
> 
> I am trying kexec -e with latest kernel i.e. Linux-5.5.0-rc4.  Here
> second kernel is not able to detect/mount hard-disk having root file
> system (INTEL SSDSC2BB240G7).
> 
> [  279.690575] ata1: softreset failed (1st FIS failed)
> [  279.695446] ata1: limiting SATA link speed to 3.0 Gbps
> [  280.910020] ata1: SATA link down (SStatus 0 SControl 320)
> [  282.626018] ata1: SATA link down (SStatus 0 SControl 300)
> [  282.631409] ata1: link online but 1 devices misclassified, retrying
> [  282.637665] ata1: reset failed (errno=-11), retrying in 9 secs
> [  298.294546] ata1: failed to reset engine (errno=-5)
> [  302.042967] ata1: softreset failed (1st FIS failed)
> [  308.798609] ata1: failed to reset engine (errno=-5)
> [  337.546605] ata1: softreset failed (1st FIS failed)
> [  337.551475] ata1: limiting SATA link speed to 3.0 Gbps
> [  338.766022] ata1: SATA link down (SStatus 0 SControl 320)
> [  339.270943] ata1: EH pending after 5 tries, giving up
> 
> I found following two workaround for this issue.
> A) Define ".shutdown" in driver/ata/ahci.c.
> 
> reboot --> kernel_kexec() --> kernel_restart_prepare() -->
> device_shutdown() --> pci_device_shutdown() --> ahci_shutdown_one()
> --> new function
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 4bfd1b14b390..50a101002885 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -81,6 +81,7 @@ enum board_ids {
> 
>  static int ahci_init_one(struct pci_dev *pdev, const struct
> pci_device_id *ent);
>  static void ahci_remove_one(struct pci_dev *dev);
>  +static void ahci_shutdown_one(struct pci_dev *dev);
>  static int ahci_vt8251_hardreset(struct ata_link *link, unsigned int *class,
>                                   unsigned long deadline);
>   static int ahci_avn_hardreset(struct ata_link *link, unsigned int *class,
>  @@ -606,6 +607,7 @@ static struct pci_driver ahci_pci_driver = {
>          .id_table               = ahci_pci_tbl,
>          .probe                  = ahci_init_one,
>          .remove                 = ahci_remove_one,
>  +       .shutdown               = ahci_shutdown_one,
>          .driver = {
>                  .pm             = &ahci_pci_pm_ops,
>          },
> 
>  +static void ahci_shutdown_one(struct pci_dev *pdev)
>  +{
>  +       pm_runtime_get_noresume(&pdev->dev);
>  +       ata_pci_remove_one(pdev);
>  +}
>  +
> Note: After defining shutdown, error related to file-system write
> seen. Looks like even after device_shutdown, file system related
> transaction goes to disk.
> 
> B)) Commenting of pci_clear_master() from pci_device_shutdown()
> reboot --> kernel_kexec() --> kernel_restart_prepare() -->
> device_shutdown() --> pci_device_shutdown()
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 0454ca0e4e3f..ddffaa9321bb 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -481,8 +481,10 @@ static void pci_device_shutdown(struct device *dev)
>         /*
>          * If this is a kexec reboot, turn off Bus Master bit on the
> @@ -491,8 +493,16 @@ static void pci_device_shutdown(struct device *dev)
>          * If it is not a kexec reboot, firmware will hit the PCI
>          * devices with big hammer and stop their DMA any way.
>          */
> 
>  - if (kexec_in_progress && (pci_dev->current_state <= PCI_D3hot))
>  -                pci_clear_master(pci_dev);

I doubt we would remove this without a much clearer justification.

> Here pci_dev current_state. It is "0" i.e. D0.
> 
> From A and B. Looks like even after pci_clear_master(), Some DMA
> transactions going on PCIe device  causing device in unstable.
> Not sure if this is the reason and how to solve this problem.

Is it possible the ahci driver depends on receiving the device with
bus mastering already enabled?  I would guess that would be the common
case in a non-kexec boot -- the BIOS probably hands off the device
with bus mastering enabled.

ahci_init_one() does turn on bus mastering itself (it calls
pci_set_master()), but it's near the end, do if anything before that
depends on DMA, it wouldn't work.

And I don't know how adding a shutdown method would also be a
workaround.

Bjorn
