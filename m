Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20FDC98DB5
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2019 10:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731051AbfHVIbs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Aug 2019 04:31:48 -0400
Received: from foss.arm.com ([217.140.110.172]:41150 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727484AbfHVIbr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Aug 2019 04:31:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13188360;
        Thu, 22 Aug 2019 01:31:47 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61F1A3F706;
        Thu, 22 Aug 2019 01:31:46 -0700 (PDT)
Date:   Thu, 22 Aug 2019 09:31:44 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Jonathan Chocron <jonnyc@amazon.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        robh+dt@kernel.org, mark.rutland@arm.com, dwmw@amazon.co.uk,
        benh@kernel.crashing.org, alisaidi@amazon.com, ronenk@amazon.com,
        barakw@amazon.com, talel@amazon.com, hanochu@amazon.com,
        hhhawa@amazon.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/7] PCI: Add ACS quirk for Amazon Annapurna Labs root
 ports
Message-ID: <20190822083144.GL23903@e119886-lin.cambridge.arm.com>
References: <20190821153545.17635-1-jonnyc@amazon.com>
 <20190821153545.17635-3-jonnyc@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821153545.17635-3-jonnyc@amazon.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 21, 2019 at 06:35:42PM +0300, Jonathan Chocron wrote:
> From: Ali Saidi <alisaidi@amazon.com>
> 
> The Amazon's Annapurna Labs root ports don't advertise an ACS
> capability, but they don't allow peer-to-peer transactions and do
> validate bus numbers through the SMMU. Additionally, it's not possible
> for one RP to pass traffic to another RP.
> 
> Signed-off-by: Ali Saidi <alisaidi@amazon.com>
> Signed-off-by: Jonathan Chocron <jonnyc@amazon.com>
> Reviewed-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
>  drivers/pci/quirks.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 208aacf39329..23672680dba7 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4366,6 +4366,23 @@ static int pci_quirk_qcom_rp_acs(struct pci_dev *dev, u16 acs_flags)
>  	return ret;
>  }
>  
> +static int pci_quirk_al_acs(struct pci_dev *dev, u16 acs_flags)
> +{
> +	/*
> +	 * Amazon's Annapurna Labs root ports don't include an ACS capability,
> +	 * but do include ACS-like functionality. The hardware doesn't support
> +	 * peer-to-peer transactions via the root port and each has a unique
> +	 * segment number.
> +	 * Additionally, the root ports cannot send traffic to each other.

Nit: I'd probably put a new line between the above two lines, or start the
'Additionally' sentence on the first line. But either way...

Reviewed-by: Andrew Murray <andrew.murray@arm.com>


> +	 */
> +	acs_flags &= ~(PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_SV | PCI_ACS_UF);
> +
> +	if (pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT)
> +		return -ENOTTY;
> +
> +	return acs_flags ? 0 : 1;
> +}
> +
>  /*
>   * Sunrise Point PCH root ports implement ACS, but unfortunately as shown in
>   * the datasheet (Intel 100 Series Chipset Family PCH Datasheet, Vol. 2,
> @@ -4559,6 +4576,8 @@ static const struct pci_dev_acs_enabled {
>  	{ PCI_VENDOR_ID_AMPERE, 0xE00A, pci_quirk_xgene_acs },
>  	{ PCI_VENDOR_ID_AMPERE, 0xE00B, pci_quirk_xgene_acs },
>  	{ PCI_VENDOR_ID_AMPERE, 0xE00C, pci_quirk_xgene_acs },
> +	/* Amazon Annapurna Labs */
> +	{ PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS, 0x0031, pci_quirk_al_acs },
>  	{ 0 }
>  };
>  
> -- 
> 2.17.1
> 
