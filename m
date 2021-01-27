Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08779306564
	for <lists+linux-pci@lfdr.de>; Wed, 27 Jan 2021 21:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233390AbhA0Uvj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Jan 2021 15:51:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:48650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233256AbhA0Uvi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 Jan 2021 15:51:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E854264D9F;
        Wed, 27 Jan 2021 20:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611780657;
        bh=PG1IVVNWLnFqxSk+/vBnwpgrgPzUioifx7UoAF6paEM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=V6ucyWyVzhwo9MAVgd72z/OiDy+6W7Eb8HOigwQfsd/393QNAIAAkOCXSdOVYko7/
         tOeDvNRqS8mngQv6eXjLYDW3wiRvtdwGc2cCIPDawIjeUQZgStSP5d/oP5llxKBJBg
         wCVo2QPaC59YuuxolKClPPp3gacA1VMuNeFHjeKllA4mZyUV1V20NipHu8RLuflVTl
         rlihkD/NwuDrAvCG3k5bQ4gJc0ko2TnQ7EDUtUlQYqkxQSwKyjU5QqEDrszynVJZo3
         G2EyH9ZcgW1Ow8vHd9aA/lZwYcTyrQfYRgsNrsYoQH87bp5qp/AU8k649wDA6OX7uY
         GH4mT9MLsSSuw==
Date:   Wed, 27 Jan 2021 14:50:53 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     bhelgaas@google.com, Russell Currey <ruscur@russell.cc>,
        Oliver O'Halloran <oohall@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lalithambika Krishnakumar <lalithambika.krishnakumar@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        "open list:PCI ENHANCED ERROR HANDLING (EEH) FOR POWERPC" 
        <linuxppc-dev@lists.ozlabs.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] PCI/AER: Disable AER interrupt during suspend
Message-ID: <20210127205053.GA3049358@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210127173101.446940-1-kai.heng.feng@canonical.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 28, 2021 at 01:31:00AM +0800, Kai-Heng Feng wrote:
> Commit 50310600ebda ("iommu/vt-d: Enable PCI ACS for platform opt in
> hint") enables ACS, and some platforms lose its NVMe after resume from
> firmware:
> [   50.947816] pcieport 0000:00:1b.0: DPC: containment event, status:0x1f01 source:0x0000
> [   50.947817] pcieport 0000:00:1b.0: DPC: unmasked uncorrectable error detected
> [   50.947829] pcieport 0000:00:1b.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Receiver ID)
> [   50.947830] pcieport 0000:00:1b.0:   device [8086:06ac] error status/mask=00200000/00010000
> [   50.947831] pcieport 0000:00:1b.0:    [21] ACSViol                (First)
> [   50.947841] pcieport 0000:00:1b.0: AER: broadcast error_detected message
> [   50.947843] nvme nvme0: frozen state error detected, reset controller
> 
> It happens right after ACS gets enabled during resume.
> 
> To prevent that from happening, disable AER interrupt and enable it on
> system suspend and resume, respectively.

Lots of questions here.  Maybe this is what we'll end up doing, but I
am curious about why the error is reported in the first place.

Is this a consequence of the link going down and back up?

Is it consequence of the device doing a DMA when it shouldn't?

Are we doing something in the wrong order during suspend?  Or maybe
resume, since I assume the error is reported during resume?

If we *do* take the error, why doesn't DPC recovery work?

> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=209149
> Fixes: 50310600ebda ("iommu/vt-d: Enable PCI ACS for platform opt in hint")
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/pci/pcie/aer.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 77b0f2c45bc0..0e9a85530ae6 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1365,6 +1365,22 @@ static int aer_probe(struct pcie_device *dev)
>  	return 0;
>  }
>  
> +static int aer_suspend(struct pcie_device *dev)
> +{
> +	struct aer_rpc *rpc = get_service_data(dev);
> +
> +	aer_disable_rootport(rpc);
> +	return 0;
> +}
> +
> +static int aer_resume(struct pcie_device *dev)
> +{
> +	struct aer_rpc *rpc = get_service_data(dev);
> +
> +	aer_enable_rootport(rpc);
> +	return 0;
> +}
> +
>  /**
>   * aer_root_reset - reset Root Port hierarchy, RCEC, or RCiEP
>   * @dev: pointer to Root Port, RCEC, or RCiEP
> @@ -1437,6 +1453,8 @@ static struct pcie_port_service_driver aerdriver = {
>  	.service	= PCIE_PORT_SERVICE_AER,
>  
>  	.probe		= aer_probe,
> +	.suspend	= aer_suspend,
> +	.resume		= aer_resume,
>  	.remove		= aer_remove,
>  };
>  
> -- 
> 2.29.2
> 
