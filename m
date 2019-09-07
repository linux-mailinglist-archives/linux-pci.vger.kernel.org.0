Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA0FAC7BD
	for <lists+linux-pci@lfdr.de>; Sat,  7 Sep 2019 18:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404291AbfIGQy4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 7 Sep 2019 12:54:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:53414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404220AbfIGQy4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 7 Sep 2019 12:54:56 -0400
Received: from localhost (110.8.30.213.rev.vodafone.pt [213.30.8.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E561121835;
        Sat,  7 Sep 2019 16:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567875294;
        bh=WW2pqKWTuc80bEexpCHs8A4SULzbymeL6jLKMVanjj0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yNjyZgVbVWbkHErGVkKAHzdqL24AX3XFcY8NPTxJhEkeziczsrRenmJ90favyJ0Uj
         ae5+tA08zlTOm9JUnrn9Oh7QR/X4QZl9mflKEbA/4vEhoCcTQrMn1nE5VkLL/5UceC
         wO2yGXhtnujr5UVVQ0R7KZpHINkgG7kZwPb4KPOM=
Date:   Sat, 7 Sep 2019 11:54:50 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jonathan Chocron <jonnyc@amazon.com>
Cc:     lorenzo.pieralisi@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, robh+dt@kernel.org,
        mark.rutland@arm.com, andrew.murray@arm.com, dwmw@amazon.co.uk,
        benh@kernel.crashing.org, alisaidi@amazon.com, ronenk@amazon.com,
        barakw@amazon.com, talel@amazon.com, hanochu@amazon.com,
        hhhawa@amazon.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 2/7] PCI: Add ACS quirk for Amazon Annapurna Labs root
 ports
Message-ID: <20190907165450.GL103977@google.com>
References: <20190905140018.5139-1-jonnyc@amazon.com>
 <20190905140018.5139-3-jonnyc@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905140018.5139-3-jonnyc@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 05, 2019 at 05:00:16PM +0300, Jonathan Chocron wrote:
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
> Reviewed-by: Andrew Murray <andrew.murray@arm.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

But please tweak it as below ...

> ---
>  drivers/pci/quirks.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index ded60757a573..8fe765592943 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4418,6 +4418,24 @@ static int pci_quirk_qcom_rp_acs(struct pci_dev *dev, u16 acs_flags)
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
> +	 *
> +	 * Additionally, the root ports cannot send traffic to each other.
> +	 */
> +	acs_flags &= ~(PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_SV | PCI_ACS_UF);

There are several quirks that use this same set of bits, but they
don't use the same order, which is a needless difference.

Can you reorder them in the bit 0 ... bit 7 order?  I.e.,

    PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF

> +	if (pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT)
> +		return -ENOTTY;

This could go first (above the comment) so all the acs_flags stuff is
together.

> +	return acs_flags ? 0 : 1;
> +}
> +
>  /*
>   * Sunrise Point PCH root ports implement ACS, but unfortunately as shown in
>   * the datasheet (Intel 100 Series Chipset Family PCH Datasheet, Vol. 2,
> @@ -4611,6 +4629,8 @@ static const struct pci_dev_acs_enabled {
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
