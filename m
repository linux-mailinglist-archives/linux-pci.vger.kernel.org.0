Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCBE47E7397
	for <lists+linux-pci@lfdr.de>; Thu,  9 Nov 2023 22:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjKIV12 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Nov 2023 16:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjKIV11 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Nov 2023 16:27:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA453C07;
        Thu,  9 Nov 2023 13:27:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D4DC433C7;
        Thu,  9 Nov 2023 21:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699565244;
        bh=ZDkD8nE6Mqdk9hjfAmYOU/xCoxyV7u/A9MBQaroE3Fk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gYFjrn5/JVD/tBrEMnhScZbfsTW5K25i/CgTI61//ELC3FX8Dk+jMl58EIdSWmtYp
         YPiqym0Yb7bhyZjAeqGvUcJsukEqmZSKF0T43MSBfi7pPk/e0bV7Ka0l2nBvTazXJL
         v/RcRqaB5ePBhLNpfTSl+J8kJjUPq7O/wK64LdDYbPtHCSH939za/UwncG83UxOS1L
         rDWb8AConIxVgacZgWq7fpqBccCw5bOKW6KbSGaYpi2R0f7WhnFE2DKWZ9QeeFRY6a
         BbschAKBblGVzx4v0uGqpX9s2KI6cgKQ6yPWiaKb3+iozfS2RZewClNW31cWoL6WmG
         H34qHBnxwtHiw==
Date:   Thu, 9 Nov 2023 15:27:22 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Jim Quinlan <jim2101024@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 3/3] PCI: brcmstb: Set higher value for internal bus
 timeout
Message-ID: <20231109212722.GA492431@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109191355.27738-4-james.quinlan@broadcom.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 09, 2023 at 02:13:54PM -0500, Jim Quinlan wrote:
> During long periods of the PCIe RC HW being in an L1SS sleep state, there
> may be a timeout on an internal bus access, even though there may not be
> any PCIe access involved.  Such a timeout will cause a subsequent CPU
> abort.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index f45c5d0168d3..f82a3e1a843a 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -1031,6 +1031,21 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
>  	return 0;
>  }
>  
> +/*
> + * This extends the timeout period for an access to an internal bus.  This
> + * access timeout may occur during L1SS sleep periods, even without the
> + * presence of a PCIe access.
> + */
> +static void brcm_extend_rbus_timeout(struct brcm_pcie *pcie)
> +{
> +	/* TIMEOUT register is two registers before RGR1_SW_INIT_1 */
> +	const unsigned int REG_OFFSET = PCIE_RGR1_SW_INIT_1(pcie) - 8;
> +	u32 timeout_us = 4000000; /* 4 seconds, our setting for L1SS */
> +
> +	/* Each unit in timeout register is 1/216,000,000 seconds */
> +	writel(216 * timeout_us, pcie->base + REG_OFFSET);
> +}
> +
>  static void brcm_config_clkreq(struct brcm_pcie *pcie)
>  {
>  	static const char err_msg[] = "invalid 'brcm,clkreq-mode' DT string\n";
> @@ -1067,6 +1082,7 @@ static void brcm_config_clkreq(struct brcm_pcie *pcie)
>  		 * atypical and should happen only with older devices.
>  		 */
>  		clkreq_cntl |= PCIE_MISC_HARD_PCIE_HARD_DEBUG_L1SS_ENABLE_MASK;
> +		brcm_extend_rbus_timeout(pcie);

It looks like this should be squashed into the previous patch, which
added brcm_config_clkreq().  Otherwise there's a bisection hole where
somebody testing at the previous patch could see the CPU abort.

>  	} else {
>  		/*
>  		 * "safe" -- No power savings; refclk is driven by RC
