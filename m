Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0C34634B9
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 13:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbhK3Mqw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 07:46:52 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:47154 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhK3Mqw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 07:46:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 95BADCE19D9
        for <linux-pci@vger.kernel.org>; Tue, 30 Nov 2021 12:43:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96295C53FC7;
        Tue, 30 Nov 2021 12:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638276209;
        bh=fCNGB7FPSYdNaC146YDtmtbHSgbT8zIcFf3Dle6ot4Y=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=GhEvg1EaJfUIvML4NvpnIMlzekaIaq3F7rhduSowpvBTL+92HFt1OTAmSn1Gjkb4S
         Hd0IlPqw3TMQxIpRSS3REEvQJqWN4qqI9aWWqYPwr+SvSPUsxDKY6k4nDajOW4wqU5
         vANJWJ4Eu3vld/UT1LOH7JURfCZZR4RPgEN0nFt16Lg5CGITodaGXm9VUt5u8kQ47R
         ncDLg5nwzxjiHAG+0fUk83voRMNUYcFaaTgBL9ioZWEh4JGr3nJlwHnfp/Cbp1bwB6
         lFdtpVqyidomEJNOnWZnw5hY7u3p6HDsJ5a0rjKyZznSRq0PQMfpCB0I1XCx6WRaru
         GAhZQsJNiIC4w==
Received: by pali.im (Postfix)
        id E78CD7DF; Tue, 30 Nov 2021 13:43:26 +0100 (CET)
Date:   Tue, 30 Nov 2021 13:43:26 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 02/11] PCI: pci-bridge-emul: Add definitions for
 missing capabilities registers
Message-ID: <20211130124326.nbsqy5bgfgyccor5@pali>
References: <20211130123621.23062-1-kabel@kernel.org>
 <20211130123621.23062-3-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211130123621.23062-3-kabel@kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 30 November 2021 13:36:12 Marek Behún wrote:
> From: Pali Rohár <pali@kernel.org>
> 
> pci-bridge-emul driver already allocates buffer for capabilities up to the
> PCI_EXP_SLTSTA2 register, but does not define bit access behavior for these
> registers. Add these missing definitions.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Signed-off-by: Marek Behún <kabel@kernel.org>
> ---
>  drivers/pci/pci-bridge-emul.c | 39 +++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emul.c
> index a4af1a533d71..aa3320e3c469 100644
> --- a/drivers/pci/pci-bridge-emul.c
> +++ b/drivers/pci/pci-bridge-emul.c
> @@ -251,6 +251,45 @@ struct pci_bridge_reg_behavior pcie_cap_regs_behavior[PCI_CAP_PCIE_SIZEOF / 4] =
>  		.ro = GENMASK(15, 0) | PCI_EXP_RTSTA_PENDING,
>  		.w1c = PCI_EXP_RTSTA_PME,
>  	},
> +
> +	[PCI_EXP_DEVCAP2 / 4] = {
> +		/* Device capabilities 2 register has reserved bits [30:27]. */
> +		.ro = BIT(31) | GENMASK(26, 0),
> +	},
> +
> +	[PCI_EXP_DEVCTL2 / 4] = {
> +		/*
> +		 * Device control 2 register is RW.
> +		 *
> +		 * Device status 2 register is reserved.
> +		 */
> +		.rw = GENMASK(15, 0),
> +	},
> +
> +	[PCI_EXP_LNKCAP2 / 4] = {
> +		/* Link capabilities 2 register has reserved bits [30:25] and 0. */
> +		.ro = BIT(31) | GENMASK(24, 1),
> +	},
> +
> +	[PCI_EXP_LNKCTL2 / 4] = {
> +		/*
> +		 * Link control 2 register is RW.
> +		 *
> +		 * Link status 2 register has bits 5, 15 W1C;
> +		 * bits 10, 11 reserved and others are RO.
> +		 */
> +		.rw = GENMASK(15, 0),
> +		.w1c = (BIT(15) | BIT(5)) << 16,
> +		.ro = (GENMASK(14, 12) | GENMASK(9, 6) | GENMASK(4, 0)) << 16,
> +	},
> +
> +	[PCI_EXP_SLTCAP2 / 4] = {
> +		/* Slot capabilities 2 register is reserved. */
> +	},
> +
> +	[PCI_EXP_SLTCTL2 / 4] = {
> +		/* Both Slot control 2 and Slot status 2 registers are reserved. */
> +	},
>  };
>  
>  /*
> -- 
> 2.32.0
> 

This patch is old version which does not reflect all reserved bits. Few
days ago I have sent new version of this patch in patch series with
other pci-bridge-emul.c related fixes:

https://lore.kernel.org/linux-pci/20211124155944.1290-4-pali@kernel.org/
