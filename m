Return-Path: <linux-pci+bounces-261-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6B97FE430
	for <lists+linux-pci@lfdr.de>; Thu, 30 Nov 2023 00:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0FC3B20E25
	for <lists+linux-pci@lfdr.de>; Wed, 29 Nov 2023 23:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363F147A49;
	Wed, 29 Nov 2023 23:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qq3gGhSS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181084CB5D
	for <linux-pci@vger.kernel.org>; Wed, 29 Nov 2023 23:38:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B10D0C433C7;
	Wed, 29 Nov 2023 23:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701301108;
	bh=UuAe5E2gYe6tWeYVM+NbO91LQq7MdsluQ0lAhxbAHcI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Qq3gGhSSfOYJw7os6lAJ1rNSOmIowKfDUaSmvVB4ZxCr0A884muIxuunyDHgYFqks
	 aDTl5PR4+djQlr5Jqv267EzhATzaLy7Ov8/JBnruxpEKrHAzIJNV7O9m2JEUrhq8gK
	 ZFb4k9oaT9I/rjo4eoqut+XlPHpL2RcVyxaP0HXeTTaobkyDh3zyUyXV0oLPAxsECP
	 ZlULOQ1nBJw8ZhNhXT6gK1/XoGfBX1C4nXChDL4o2yqDwFzHvaI2f8uNIUQ+EtxEWR
	 +7ceEWfIgL+1EUIxfAb6T3CR9PlSvM+a/+MWvppLTNI+lxoENYIGrMi34WMrFcurz1
	 /rcaFFkW/XXTg==
Date: Wed, 29 Nov 2023 17:38:27 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org, Wasim Khan <wasim.khan@nxp.com>,
	Wei Fang <wei.fang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH pci] PCI: remove the PCI_VENDOR_ID_NXP alias
Message-ID: <20231129233827.GA444332@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122154241.1371647-1-vladimir.oltean@nxp.com>

[+cc Greg because these mergers & spinoffs happen all the time, and
pci_ids.h doesn't necessarily need to keep up, so maybe there's
precedent for what to do here]

On Wed, Nov 22, 2023 at 05:42:41PM +0200, Vladimir Oltean wrote:
> What is today NXP is the result of some mergers (with Freescale) and
> spin-offs (from Philips).
> 
> New NXP hardware (for example NETC version 4.1 of the NXP i.MX95
> SoC) uses PCI_VENDOR_ID_PHILIPS. And some older hardware uses
> PCI_VENDOR_ID_FREESCALE.
> 
> If we have PCI_VENDOR_ID_NXP as an alias for PCI_VENDOR_ID_FREESCALE,
> we end up needing something like a PCI_VENDOR_ID_NXP2 alias for
> PCI_VENDOR_ID_PHILIPS. I think this is more confusing than just spelling
> out the vendor ID of the original company that claimed it.
> 
> FWIW, the pci.ids repository as of today has:
> 1131  Philips Semiconductors
> 1957  Freescale Semiconductor Inc
> 
> so this makes the kernel code consistent with that, and with what
> "lspci" prints.

Hmm.  I can't find the 0x1957 Vendor ID here:
https://pcisig.com/membership/member-companies, which is supposed to
be the authoritative source AFAICS.

Also, that page lists 0x1131 as "NXP Semiconductors".

There's a contact email on that page if it needs updates.

I don't quite understand the goal here.  The company is now called
"NXP", and this patch removes PCI_VENDOR_ID_NXP (the only instance of
"NXP" in pci_ids.h) and uses PCI_VENDOR_ID_FREESCALE (which apparently
does not exist any more)?

Why would we remove name of the current company and use the name of a
company that doesn't exist any more?

> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  drivers/pci/quirks.c    | 50 ++++++++++++++++++++---------------------
>  include/linux/pci_ids.h |  1 -
>  2 files changed, 25 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index d208047d1b8f..c95701e36d58 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5092,39 +5092,39 @@ static const struct pci_dev_acs_enabled {
>  	{ PCI_VENDOR_ID_ZHAOXIN, 0x3038, pci_quirk_mf_endpoint_acs },
>  	{ PCI_VENDOR_ID_ZHAOXIN, 0x3104, pci_quirk_mf_endpoint_acs },
>  	{ PCI_VENDOR_ID_ZHAOXIN, 0x9083, pci_quirk_mf_endpoint_acs },
> -	/* NXP root ports, xx=16, 12, or 08 cores */
> +	/* Freescale/NXP root ports, xx=16, 12, or 08 cores */
>  	/* LX2xx0A : without security features + CAN-FD */
> -	{ PCI_VENDOR_ID_NXP, 0x8d81, pci_quirk_nxp_rp_acs },
> -	{ PCI_VENDOR_ID_NXP, 0x8da1, pci_quirk_nxp_rp_acs },
> -	{ PCI_VENDOR_ID_NXP, 0x8d83, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_FREESCALE, 0x8d81, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_FREESCALE, 0x8da1, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_FREESCALE, 0x8d83, pci_quirk_nxp_rp_acs },
>  	/* LX2xx0C : security features + CAN-FD */
> -	{ PCI_VENDOR_ID_NXP, 0x8d80, pci_quirk_nxp_rp_acs },
> -	{ PCI_VENDOR_ID_NXP, 0x8da0, pci_quirk_nxp_rp_acs },
> -	{ PCI_VENDOR_ID_NXP, 0x8d82, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_FREESCALE, 0x8d80, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_FREESCALE, 0x8da0, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_FREESCALE, 0x8d82, pci_quirk_nxp_rp_acs },
>  	/* LX2xx0E : security features + CAN */
> -	{ PCI_VENDOR_ID_NXP, 0x8d90, pci_quirk_nxp_rp_acs },
> -	{ PCI_VENDOR_ID_NXP, 0x8db0, pci_quirk_nxp_rp_acs },
> -	{ PCI_VENDOR_ID_NXP, 0x8d92, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_FREESCALE, 0x8d90, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_FREESCALE, 0x8db0, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_FREESCALE, 0x8d92, pci_quirk_nxp_rp_acs },
>  	/* LX2xx0N : without security features + CAN */
> -	{ PCI_VENDOR_ID_NXP, 0x8d91, pci_quirk_nxp_rp_acs },
> -	{ PCI_VENDOR_ID_NXP, 0x8db1, pci_quirk_nxp_rp_acs },
> -	{ PCI_VENDOR_ID_NXP, 0x8d93, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_FREESCALE, 0x8d91, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_FREESCALE, 0x8db1, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_FREESCALE, 0x8d93, pci_quirk_nxp_rp_acs },
>  	/* LX2xx2A : without security features + CAN-FD */
> -	{ PCI_VENDOR_ID_NXP, 0x8d89, pci_quirk_nxp_rp_acs },
> -	{ PCI_VENDOR_ID_NXP, 0x8da9, pci_quirk_nxp_rp_acs },
> -	{ PCI_VENDOR_ID_NXP, 0x8d8b, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_FREESCALE, 0x8d89, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_FREESCALE, 0x8da9, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_FREESCALE, 0x8d8b, pci_quirk_nxp_rp_acs },
>  	/* LX2xx2C : security features + CAN-FD */
> -	{ PCI_VENDOR_ID_NXP, 0x8d88, pci_quirk_nxp_rp_acs },
> -	{ PCI_VENDOR_ID_NXP, 0x8da8, pci_quirk_nxp_rp_acs },
> -	{ PCI_VENDOR_ID_NXP, 0x8d8a, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_FREESCALE, 0x8d88, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_FREESCALE, 0x8da8, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_FREESCALE, 0x8d8a, pci_quirk_nxp_rp_acs },
>  	/* LX2xx2E : security features + CAN */
> -	{ PCI_VENDOR_ID_NXP, 0x8d98, pci_quirk_nxp_rp_acs },
> -	{ PCI_VENDOR_ID_NXP, 0x8db8, pci_quirk_nxp_rp_acs },
> -	{ PCI_VENDOR_ID_NXP, 0x8d9a, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_FREESCALE, 0x8d98, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_FREESCALE, 0x8db8, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_FREESCALE, 0x8d9a, pci_quirk_nxp_rp_acs },
>  	/* LX2xx2N : without security features + CAN */
> -	{ PCI_VENDOR_ID_NXP, 0x8d99, pci_quirk_nxp_rp_acs },
> -	{ PCI_VENDOR_ID_NXP, 0x8db9, pci_quirk_nxp_rp_acs },
> -	{ PCI_VENDOR_ID_NXP, 0x8d9b, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_FREESCALE, 0x8d99, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_FREESCALE, 0x8db9, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_FREESCALE, 0x8d9b, pci_quirk_nxp_rp_acs },
>  	/* Zhaoxin Root/Downstream Ports */
>  	{ PCI_VENDOR_ID_ZHAOXIN, PCI_ANY_ID, pci_quirk_zhaoxin_pcie_ports_acs },
>  	/* Wangxun nics */
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 275799b5f535..f837ff427b85 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2469,7 +2469,6 @@
>  #define PCI_DEVICE_ID_TDI_EHCI          0x0101
>  
>  #define PCI_VENDOR_ID_FREESCALE		0x1957	/* duplicate: NXP */
> -#define PCI_VENDOR_ID_NXP		0x1957	/* duplicate: FREESCALE */
>  #define PCI_DEVICE_ID_MPC8308		0xc006
>  #define PCI_DEVICE_ID_MPC8315E		0x00b4
>  #define PCI_DEVICE_ID_MPC8315		0x00b5
> -- 
> 2.34.1
> 

