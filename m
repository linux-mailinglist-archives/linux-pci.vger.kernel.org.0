Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 881899926B
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2019 13:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731979AbfHVLlu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Aug 2019 07:41:50 -0400
Received: from foss.arm.com ([217.140.110.172]:44554 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726844AbfHVLlu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Aug 2019 07:41:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3084B337;
        Thu, 22 Aug 2019 04:41:49 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D49F3F246;
        Thu, 22 Aug 2019 04:41:48 -0700 (PDT)
Date:   Thu, 22 Aug 2019 12:41:47 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Jonathan Chocron <jonnyc@amazon.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        robh+dt@kernel.org, mark.rutland@arm.com, dwmw@amazon.co.uk,
        benh@kernel.crashing.org, alisaidi@amazon.com, ronenk@amazon.com,
        barakw@amazon.com, talel@amazon.com, hanochu@amazon.com,
        hhhawa@amazon.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/7] PCI/VPD: Add VPD release quirk for Amazon's
 Annapurna Labs Root Port
Message-ID: <20190822114146.GP23903@e119886-lin.cambridge.arm.com>
References: <20190821153545.17635-1-jonnyc@amazon.com>
 <20190821153545.17635-4-jonnyc@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821153545.17635-4-jonnyc@amazon.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 21, 2019 at 06:35:43PM +0300, Jonathan Chocron wrote:
> The Amazon Annapurna Labs PCIe Root Port exposes the VPD capability,
> but there is no actual support for it.
> 
> The reason for not using the already existing quirk_blacklist_vpd()
> is that, although this fails pci_vpd_read/write, the 'vpd' sysfs
> entry still exists. When running lspci -vv, for example, this
> results in the following error:
> 
> pcilib: sysfs_read_vpd: read failed: Input/output error

Oh that's not nice. It's probably triggered by the -EIO in pci_vpd_read.
A quick search online seems to show that other people have experienced
this too - though from as far as I can tell this just gives you a
warning and pcilib will continnue to give other output?

I guess every vpd blacklist'd driver will have the same issue. And for
this reason I don't think that this patch is the right solution - as
otherwise all the other blacklisted drivers could follow your lead.

I don't think you need to fix this specifically for the AL driver and so
I'd suggest that you can probably drop this patch. (Ideally pciutils
could be updated to not warn for this specific use-case).

Thanks,

Andrew Murray

> 
> This quirk removes the sysfs entry, which avoids the error print.
> 
> Signed-off-by: Jonathan Chocron <jonnyc@amazon.com>
> Reviewed-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
>  drivers/pci/vpd.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> index 4963c2e2bd4c..c23a8ec08db9 100644
> --- a/drivers/pci/vpd.c
> +++ b/drivers/pci/vpd.c
> @@ -644,4 +644,20 @@ static void quirk_chelsio_extend_vpd(struct pci_dev *dev)
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, PCI_ANY_ID,
>  			quirk_chelsio_extend_vpd);
>  
> +static void quirk_al_vpd_release(struct pci_dev *dev)
> +{
> +	if (dev->vpd) {
> +		pci_vpd_release(dev);
> +		dev->vpd = NULL;
> +		pci_warn(dev, FW_BUG "Releasing VPD capability (No support for VPD read/write transactions)\n");
> +	}
> +}
> +
> +/*
> + * The 0031 device id is reused for other non Root Port device types,
> + * therefore the quirk is registered for the PCI_CLASS_BRIDGE_PCI class.
> + */
> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS, 0x0031,
> +			      PCI_CLASS_BRIDGE_PCI, 8, quirk_al_vpd_release);
> +
>  #endif
> -- 
> 2.17.1
> 
