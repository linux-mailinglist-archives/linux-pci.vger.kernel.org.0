Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA62786358
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2019 15:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732727AbfHHNn6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Aug 2019 09:43:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:39560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732297AbfHHNn6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Aug 2019 09:43:58 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 282CF2171F;
        Thu,  8 Aug 2019 13:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565271837;
        bh=33CZ8BCc/mP1hiNi8EJruOyKiaf5ldXoU8hbOOmln90=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jBGWMNbI+dfk1O1v2vrc4xhe2sxk55BGLecr95BrhBBrk8yReX3iy63K9/xXPIxfx
         XHiLJ5BLVTBxFxUnsiDVOXkj2YITt6XXw0KAhxsT2DeGM1JpYGgm493RDtJubKrXrJ
         riT9Oxg2+qwT4GGg9Hrm7srReHQpK75/WJheLbTA=
Date:   Thu, 8 Aug 2019 08:43:56 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-nvme <linux-nvme@lists.infradead.org>,
        Keith Busch <kbusch@kernel.org>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] nvme-pci: Allow PCI bus-level PM to be used if
 ASPM is disabled
Message-ID: <20190808134356.GF151852@google.com>
References: <4323ed84dd07474eab65699b4d007aaf@AUSX13MPC105.AMER.DELL.COM>
 <20190731221956.GB15795@localhost.localdomain>
 <1921165.pTveHRX1Co@kreacher>
 <1870928.r7tBYyfqdz@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1870928.r7tBYyfqdz@kreacher>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 08, 2019 at 12:10:06PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> One of the modifications made by commit d916b1be94b6 ("nvme-pci: use
> host managed power state for suspend") was adding a pci_save_state()
> call to nvme_suspend() in order to prevent the PCI bus-level PM from
> being applied to the suspended NVMe devices, but if ASPM is not
> enabled for the target NVMe device, that causes its PCIe link to stay
> up and the platform may not be able to get into its optimum low-power
> state because of that.
> 
> For example, if ASPM is disabled for the NVMe drive (PC401 NVMe SK
> hynix 256GB) in my Dell XPS13 9380, leaving it in D0 during
> suspend-to-idle prevents the SoC from reaching package idle states
> deeper than PC3, which is way insufficient for system suspend.

Just curious: I assume the SoC you reference is some part of the NVMe
drive?

> To address this shortcoming, make nvme_suspend() check if ASPM is
> enabled for the target device and fall back to full device shutdown
> and PCI bus-level PM if that is not the case.
> 
> Fixes: d916b1be94b6 ("nvme-pci: use host managed power state for suspend")
> Link: https://lore.kernel.org/linux-pm/2763495.NmdaWeg79L@kreacher/T/#t
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> -> v2:
>   * Move the PCI/PCIe ASPM changes to a separate patch.
>   * Do not add a redundant ndev->last_ps == U32_MAX check in nvme_suspend().
> 
> ---
>  drivers/nvme/host/pci.c |   13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> Index: linux-pm/drivers/nvme/host/pci.c
> ===================================================================
> --- linux-pm.orig/drivers/nvme/host/pci.c
> +++ linux-pm/drivers/nvme/host/pci.c
> @@ -2846,7 +2846,7 @@ static int nvme_resume(struct device *de
>  	struct nvme_dev *ndev = pci_get_drvdata(to_pci_dev(dev));
>  	struct nvme_ctrl *ctrl = &ndev->ctrl;
>  
> -	if (pm_resume_via_firmware() || !ctrl->npss ||
> +	if (ndev->last_ps == U32_MAX ||
>  	    nvme_set_power_state(ctrl, ndev->last_ps) != 0)
>  		nvme_reset_ctrl(ctrl);
>  	return 0;
> @@ -2859,6 +2859,8 @@ static int nvme_suspend(struct device *d
>  	struct nvme_ctrl *ctrl = &ndev->ctrl;
>  	int ret = -EBUSY;
>  
> +	ndev->last_ps = U32_MAX;
> +
>  	/*
>  	 * The platform does not remove power for a kernel managed suspend so
>  	 * use host managed nvme power settings for lowest idle power if
> @@ -2866,8 +2868,14 @@ static int nvme_suspend(struct device *d
>  	 * shutdown.  But if the firmware is involved after the suspend or the
>  	 * device does not support any non-default power states, shut down the
>  	 * device fully.
> +	 *
> +	 * If ASPM is not enabled for the device, shut down the device and allow
> +	 * the PCI bus layer to put it into D3 in order to take the PCIe link
> +	 * down, so as to allow the platform to achieve its minimum low-power
> +	 * state (which may not be possible if the link is up).
>  	 */
> -	if (pm_suspend_via_firmware() || !ctrl->npss) {
> +	if (pm_suspend_via_firmware() || !ctrl->npss ||
> +	    !pcie_aspm_enabled_mask(pdev)) {

This seems like a layering violation, in the sense that ASPM is
supposed to be hardware-autonomous and invisible to software.

IIUC the NVMe device will go to the desired package idle state if the
link is in L0s or L1, but not if the link is in L0.  I don't
understand that connection; AFAIK that would be something outside the
scope of the PCIe spec.

The spec (PCIe r5.0, sec 5.4.1.1.1 for L0s, 5.4.1.2.1 for L1) is
careful to say that when the conditions are right, devices "should"
enter L0s but it is never mandatory, or "may" enter L1.

And this patch assumes that if ASPM is enabled, the link will
eventually go to L0s or L1.  Because the PCIe spec doesn't mandate
that transition, I think this patch makes the driver dependent on
device-specific behavior.

>  		nvme_dev_disable(ndev, true);
>  		return 0;
>  	}
> @@ -2880,7 +2888,6 @@ static int nvme_suspend(struct device *d
>  	    ctrl->state != NVME_CTRL_ADMIN_ONLY)
>  		goto unfreeze;
>  
> -	ndev->last_ps = 0;
>  	ret = nvme_get_power_state(ctrl, &ndev->last_ps);
>  	if (ret < 0)
>  		goto unfreeze;
> 
> 
> 
