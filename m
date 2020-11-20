Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 610192BB44E
	for <lists+linux-pci@lfdr.de>; Fri, 20 Nov 2020 20:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731022AbgKTStm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Nov 2020 13:49:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:33618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730365AbgKTStm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Nov 2020 13:49:42 -0500
Received: from localhost (129.sub-72-107-112.myvzw.com [72.107.112.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFC702242B;
        Fri, 20 Nov 2020 18:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605898181;
        bh=up7opZTW5erjOXUnHcDcwNsJbv+g/w+Qk/SBP6I39JA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ntXQcV7Skyn9XrYrJpoU8dMGlW808hpzjih8easAON/UTA0qSJJFAIQsBYC50dJVY
         AfrfQ8ToJ+urLKh2Z5om8OlTgrboSgX78f8wpMBIK3KKrwrhhKOsC+29tKQRU6Hfmm
         J7e9kdIh9I2tGjvywn3zfHWq5AK0qOq84eD50zps=
Date:   Fri, 20 Nov 2020 12:49:39 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Decode PCIe 64 GT/s link speed
Message-ID: <20201120184939.GA268823@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaaab33fe18975e123a84aebce2adb85f44e2bbe.1605739760.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 18, 2020 at 11:49:20PM +0100, Gustavo Pimentel wrote:
> PCIe r6.0, sec 7.5.3.18, defines a new 64.0 GT/s bit in the Supported
> Link Speeds Vector of Link Capabilities 2.
> 
> This does not affect the speed of the link, which should be negotiated
> automatically by the hardware; it only adds decoding when showing the
> speed to the user.
> 
> This patch adds the decoding of this new speed, previously, reading the
> speed of a link operating at this speed showed "Unknown speed" instead
> of "64.0 GT/s".
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>

Applied with Krzysztof's reviewed-by to pci/enumeration for v5.11,
thanks!

> ---
>  drivers/pci/pci.h             | 6 ++++--
>  drivers/pci/probe.c           | 3 ++-
>  include/linux/pci.h           | 1 +
>  include/uapi/linux/pci_regs.h | 4 ++++
>  4 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index f86cae9..81bf905 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -294,7 +294,8 @@ void pci_bus_put(struct pci_bus *bus);
>  
>  /* PCIe link information from Link Capabilities 2 */
>  #define PCIE_LNKCAP2_SLS2SPEED(lnkcap2) \
> -	((lnkcap2) & PCI_EXP_LNKCAP2_SLS_32_0GB ? PCIE_SPEED_32_0GT : \
> +	((lnkcap2) & PCI_EXP_LNKCAP2_SLS_64_0GB ? PCIE_SPEED_64_0GT : \
> +	 (lnkcap2) & PCI_EXP_LNKCAP2_SLS_32_0GB ? PCIE_SPEED_32_0GT : \
>  	 (lnkcap2) & PCI_EXP_LNKCAP2_SLS_16_0GB ? PCIE_SPEED_16_0GT : \
>  	 (lnkcap2) & PCI_EXP_LNKCAP2_SLS_8_0GB ? PCIE_SPEED_8_0GT : \
>  	 (lnkcap2) & PCI_EXP_LNKCAP2_SLS_5_0GB ? PCIE_SPEED_5_0GT : \
> @@ -303,7 +304,8 @@ void pci_bus_put(struct pci_bus *bus);
>  
>  /* PCIe speed to Mb/s reduced by encoding overhead */
>  #define PCIE_SPEED2MBS_ENC(speed) \
> -	((speed) == PCIE_SPEED_32_0GT ? 32000*128/130 : \
> +	((speed) == PCIE_SPEED_64_0GT ? 64000*128/130 : \
> +	 (speed) == PCIE_SPEED_32_0GT ? 32000*128/130 : \
>  	 (speed) == PCIE_SPEED_16_0GT ? 16000*128/130 : \
>  	 (speed) == PCIE_SPEED_8_0GT  ?  8000*128/130 : \
>  	 (speed) == PCIE_SPEED_5_0GT  ?  5000*8/10 : \
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 4289030..fe2e00f 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -677,7 +677,7 @@ const unsigned char pcie_link_speed[] = {
>  	PCIE_SPEED_8_0GT,		/* 3 */
>  	PCIE_SPEED_16_0GT,		/* 4 */
>  	PCIE_SPEED_32_0GT,		/* 5 */
> -	PCI_SPEED_UNKNOWN,		/* 6 */
> +	PCIE_SPEED_64_0GT,		/* 6 */
>  	PCI_SPEED_UNKNOWN,		/* 7 */
>  	PCI_SPEED_UNKNOWN,		/* 8 */
>  	PCI_SPEED_UNKNOWN,		/* 9 */
> @@ -719,6 +719,7 @@ const char *pci_speed_string(enum pci_bus_speed speed)
>  	    "8.0 GT/s PCIe",		/* 0x16 */
>  	    "16.0 GT/s PCIe",		/* 0x17 */
>  	    "32.0 GT/s PCIe",		/* 0x18 */
> +	    "64.0 GT/s PCIe",		/* 0x19 */
>  	};
>  
>  	if (speed < ARRAY_SIZE(speed_strings))
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 22207a7..e007bc3 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -281,6 +281,7 @@ enum pci_bus_speed {
>  	PCIE_SPEED_8_0GT		= 0x16,
>  	PCIE_SPEED_16_0GT		= 0x17,
>  	PCIE_SPEED_32_0GT		= 0x18,
> +	PCIE_SPEED_64_0GT		= 0x19,
>  	PCI_SPEED_UNKNOWN		= 0xff,
>  };
>  
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index a95d55f..fe9d5db 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -531,6 +531,7 @@
>  #define  PCI_EXP_LNKCAP_SLS_8_0GB 0x00000003 /* LNKCAP2 SLS Vector bit 2 */
>  #define  PCI_EXP_LNKCAP_SLS_16_0GB 0x00000004 /* LNKCAP2 SLS Vector bit 3 */
>  #define  PCI_EXP_LNKCAP_SLS_32_0GB 0x00000005 /* LNKCAP2 SLS Vector bit 4 */
> +#define  PCI_EXP_LNKCAP_SLS_64_0GB 0x00000006 /* LNKCAP2 SLS Vector bit 5 */
>  #define  PCI_EXP_LNKCAP_MLW	0x000003f0 /* Maximum Link Width */
>  #define  PCI_EXP_LNKCAP_ASPMS	0x00000c00 /* ASPM Support */
>  #define  PCI_EXP_LNKCAP_ASPM_L0S 0x00000400 /* ASPM L0s Support */
> @@ -562,6 +563,7 @@
>  #define  PCI_EXP_LNKSTA_CLS_8_0GB 0x0003 /* Current Link Speed 8.0GT/s */
>  #define  PCI_EXP_LNKSTA_CLS_16_0GB 0x0004 /* Current Link Speed 16.0GT/s */
>  #define  PCI_EXP_LNKSTA_CLS_32_0GB 0x0005 /* Current Link Speed 32.0GT/s */
> +#define  PCI_EXP_LNKSTA_CLS_64_0GB 0x0006 /* Current Link Speed 64.0GT/s */
>  #define  PCI_EXP_LNKSTA_NLW	0x03f0	/* Negotiated Link Width */
>  #define  PCI_EXP_LNKSTA_NLW_X1	0x0010	/* Current Link Width x1 */
>  #define  PCI_EXP_LNKSTA_NLW_X2	0x0020	/* Current Link Width x2 */
> @@ -670,6 +672,7 @@
>  #define  PCI_EXP_LNKCAP2_SLS_8_0GB	0x00000008 /* Supported Speed 8GT/s */
>  #define  PCI_EXP_LNKCAP2_SLS_16_0GB	0x00000010 /* Supported Speed 16GT/s */
>  #define  PCI_EXP_LNKCAP2_SLS_32_0GB	0x00000020 /* Supported Speed 32GT/s */
> +#define  PCI_EXP_LNKCAP2_SLS_64_0GB	0x00000040 /* Supported Speed 64GT/s */
>  #define  PCI_EXP_LNKCAP2_CROSSLINK	0x00000100 /* Crosslink supported */
>  #define PCI_EXP_LNKCTL2		48	/* Link Control 2 */
>  #define  PCI_EXP_LNKCTL2_TLS		0x000f
> @@ -678,6 +681,7 @@
>  #define  PCI_EXP_LNKCTL2_TLS_8_0GT	0x0003 /* Supported Speed 8GT/s */
>  #define  PCI_EXP_LNKCTL2_TLS_16_0GT	0x0004 /* Supported Speed 16GT/s */
>  #define  PCI_EXP_LNKCTL2_TLS_32_0GT	0x0005 /* Supported Speed 32GT/s */
> +#define  PCI_EXP_LNKCTL2_TLS_64_0GT	0x0006 /* Supported Speed 64GT/s */
>  #define  PCI_EXP_LNKCTL2_ENTER_COMP	0x0010 /* Enter Compliance */
>  #define  PCI_EXP_LNKCTL2_TX_MARGIN	0x0380 /* Transmit Margin */
>  #define  PCI_EXP_LNKCTL2_HASD		0x0020 /* HW Autonomous Speed Disable */
> -- 
> 2.7.4
> 
