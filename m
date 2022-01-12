Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D44C48C8A0
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jan 2022 17:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355282AbiALQm3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 11:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355266AbiALQm3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jan 2022 11:42:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E22BC06173F
        for <linux-pci@vger.kernel.org>; Wed, 12 Jan 2022 08:42:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D45461A56
        for <linux-pci@vger.kernel.org>; Wed, 12 Jan 2022 16:42:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98EBDC36AE5;
        Wed, 12 Jan 2022 16:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642005747;
        bh=oMrWAjBg0dpzc3wFCPxq90BcGWUAnNcQptVN30HJFIU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=lA0DH3zCE/p6BUcTreFZ1It/+rKxEONE1MBR2VuIeGZaWeQBG+T1gXlSfYLqQAl/f
         uPmKKiihvULhn7wDM6Nqxqag4s2C8sl2tsv5anELy+n9YuhDQYzWialsIi8JS8uXa5
         Gqv5KPHS8Sqf3PdbFqVRhYRzeUVFmuVnACipN3eyzmCuQCphZ09C2Z9GMApmffpQy/
         qBDQc0aXA2nJq5SCFCLDGn+djgw61TAL9KFEwxwk+doGPkWBD9hLTkt0WBg1V9MRve
         uQxLLkEAzWuAB9GQpFqvPt+aLgjCRr6/E0+kNNWbnA5KLonOxMe/Je8g2qRzhxxlGJ
         zRk2J3ThvuO0w==
Date:   Wed, 12 Jan 2022 10:42:26 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stefan Roese <sr@denx.de>
Cc:     linux-pci@vger.kernel.org,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [RESEND PATCH v2 2/4] PCI: Add pci_check_platform_service_irqs
Message-ID: <20220112164226.GA263789@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220112094251.1271531-2-sr@denx.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 12, 2022 at 10:42:49AM +0100, Stefan Roese wrote:
> From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> 
> Adding method pci_check_platform_service_irqs to check if platform
> has registered method to proivde dedicated IRQ lines for PCIe services
> like AER.
> 
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> Signed-off-by: Stefan Roese <sr@denx.de>
> Tested-by: Stefan Roese <sr@denx.de>
> Cc: Bjorn Helgaas <helgaas@kernel.org>
> Cc: Pali Rohár <pali@kernel.org>
> Cc: Michal Simek <michal.simek@xilinx.com>
> ---
>  include/linux/pci.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 291eadade811..d6812d596ecc 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2420,6 +2420,24 @@ static inline bool pci_ari_enabled(struct pci_bus *bus)
>  	return bus->self && bus->self->ari_enabled;
>  }
>  
> +/**
> + * pci_check_platform_service_irqs - check platform service irq's
> + * @pdev: PCI Express device to check
> + * @irqs: Array of irqs to populate
> + * @mask: Bitmask of capabilities
> + */
> +static inline void pci_check_platform_service_irqs(struct pci_dev *dev,
> +						   int *irqs, int mask)
> +{
> +	struct pci_host_bridge *bridge;
> +
> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) {
> +		bridge = pci_find_host_bridge(dev->bus);
> +		if (bridge && bridge->setup_platform_service_irq)
> +			bridge->setup_platform_service_irq(bridge, irqs, mask);
> +	}
> +}

I don't think this needs to be in include/linux/pci.h; I think it
should be in drivers/pci/pcie/portdrv_core.c where it is called.

The name and signature should be parallel to pcie_init_service_irqs()
since it is basically doing the same thing for platform-specific
interrupts.

These patches are split up a little bit *too* much.  Each one should
add some piece of functionality.  Currently they add declarations that
are not used, functions that are not called, etc.  That makes it hard
to read one patch and get any idea of what it's for.

Bjorn
