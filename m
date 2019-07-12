Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF1966FB3
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2019 15:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfGLNKL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Jul 2019 09:10:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:58196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727059AbfGLNKK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Jul 2019 09:10:10 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 856892080A;
        Fri, 12 Jul 2019 13:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562937009;
        bh=Y4fu5b10Lz5nbSlHs+QhwIoZP7DL4Djo1lCeP2/TmUo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dQsV3LQzb+J5e3BU3RqQsQM2ATNq6oPo4YsTpDBACSBNWRbwMVlcCeTq9nTfUGTG3
         XRb6/+OiYHi9mlb4RhYeN5ifVgxs/Jxcg0/zYY4AS2KQt7JcWAiv9JKa8jC5Ui7OvO
         7F2T43bDVtSoFftpq/ow5AhgX/ju8tz7kNndfkLA=
Date:   Fri, 12 Jul 2019 08:10:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jonathan Chocron <jonnyc@amazon.com>
Cc:     lorenzo.pieralisi@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, robh+dt@kernel.org,
        mark.rutland@arm.com, dwmw@amazon.co.uk, benh@kernel.crashing.org,
        alisaidi@amazon.com, ronenk@amazon.com, barakw@amazon.com,
        talel@amazon.com, hanochu@amazon.com, hhhawa@amazon.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 3/8] PCI/VPD: Add VPD release quirk for Amazon Annapurna
 Labs host bridge
Message-ID: <20190712131008.GC46935@google.com>
References: <20190710164519.17883-1-jonnyc@amazon.com>
 <20190710164519.17883-4-jonnyc@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710164519.17883-4-jonnyc@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 11, 2019 at 05:55:56PM +0300, Jonathan Chocron wrote:
> The Amazon Annapurna Labs pcie host bridge exposes the VPD capability,
> but there is no actual support for it.

s/pcie/PCIe/
s/host bridge/Root Port/

> The reason for not using the already existing quirk_blacklist_vpd()
> is that, although this fails pci_vpd_read/write, the 'vpd' sysfs
> entry still exists. When running lspci -vv, for example, this
> results in the following error:
> 
> pcilib: sysfs_read_vpd: read failed: Input/output error
> 
> This quirk removes the sysfs entry, which avoids the error print.
> 
> Signed-off-by: Jonathan Chocron <jonnyc@amazon.com>
> ---
>  drivers/pci/vpd.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> index 4963c2e2bd4c..b594b2895ffe 100644
> --- a/drivers/pci/vpd.c
> +++ b/drivers/pci/vpd.c
> @@ -644,4 +644,16 @@ static void quirk_chelsio_extend_vpd(struct pci_dev *dev)
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, PCI_ANY_ID,
>  			quirk_chelsio_extend_vpd);
>  
> +static void quirk_al_vpd_release(struct pci_dev *dev)
> +{
> +	if (dev->vpd) {
> +		pci_vpd_release(dev);
> +		dev->vpd = NULL;
> +		pci_warn(dev, FW_BUG "Annapurna Labs pcie quirk - Releasing VPD capability (No support for VPD read/write transactions)\n");

The "Annapurna Labs pcie quirk" text is superfluous.

> +	}
> +}
> +
> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS, 0x0031,
> +			      PCI_CLASS_BRIDGE_PCI, 8, quirk_al_vpd_release);

Why DECLARE_PCI_FIXUP_CLASS_FINAL()?  See comments on the MSI-X quirk
patch.

> +
>  #endif
> -- 
> 2.17.1
> 
> 
