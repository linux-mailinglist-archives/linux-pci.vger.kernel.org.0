Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4686350FD
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2019 22:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfFDUc0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jun 2019 16:32:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726788AbfFDUcY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Jun 2019 16:32:24 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73A842070B;
        Tue,  4 Jun 2019 20:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559680011;
        bh=/AqGiZDSEw4WYJPXkLsV5qAXCrwMCotDuhGsf4zvuCg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pokyw4qBpjQn4MzvAhuN6BHrC10UueaDCimFSZNh8SNIadcM8xlChWRwa/QoQIpTK
         QC4EuJ3iVx+GZKfzuqTTfHp4LIabb94QKzdaikpaMTH3dNttmhZdIF0ETxfVf4uwXq
         C/4ZSc2bhCFIG1th7FFi+HfYl1OnWpmzOVLxXkTI=
Date:   Tue, 4 Jun 2019 15:26:48 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     mj@ucw.cz, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Add PCIe 5.0 data rate (32 GT/s) support
Message-ID: <20190604202648.GC84290@google.com>
References: <92365e3caf0fc559f9ab14bcd053bfc92d4f661c.1559664969.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92365e3caf0fc559f9ab14bcd053bfc92d4f661c.1559664969.git.gustavo.pimentel@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 04, 2019 at 06:24:43PM +0200, Gustavo Pimentel wrote:
> PCIe 5.0 allows an effective 32.0 GT/s speed per lane.
> 
> Currently if you read a PCIe 5.0 EP link data rate through sysfs, the
> resulting output will be "Unknown speed" instead of "32.0 GT/s" as we
> would be expect.
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>

Applied to pci/enumeration for v5.3, thanks!

I reworded the commit log to emphasize that this only affects
*decoding* of the new speed; the actual *support* for operating at this
speed is in the hardware and needs no assistance from the OS.

  PCI: Decode PCIe 32 GT/s link speed

  PCIe r5.0, sec 7.5.3.18, defines a new 32.0 GT/s bit in the Supported Link
  Speeds Vector of Link Capabilities 2.  Decode this new speed.  This does
  not affect the speed of the link, which should be negotiated automatically
  by the hardware; it only adds decoding when showing the speed to the user.

  Previously, reading the speed of a link operating at this speed showed
  "Unknown speed" instead of "32.0 GT/s".

> ---
> Changes:
> v1 -> v2
>  - Rebase patch
> 
>  drivers/pci/pci-sysfs.c       | 3 +++
>  drivers/pci/pci.c             | 4 +++-
>  drivers/pci/probe.c           | 2 +-
>  drivers/pci/slot.c            | 1 +
>  include/linux/pci.h           | 1 +
>  include/uapi/linux/pci_regs.h | 4 ++++
>  6 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 6d27475..d52d304 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -182,6 +182,9 @@ static ssize_t current_link_speed_show(struct device *dev,
>  		return -EINVAL;
>  
>  	switch (linkstat & PCI_EXP_LNKSTA_CLS) {
> +	case PCI_EXP_LNKSTA_CLS_32_0GB:
> +		speed = "32 GT/s";
> +		break;
>  	case PCI_EXP_LNKSTA_CLS_16_0GB:
>  		speed = "16 GT/s";
>  		break;
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8abc843..4729a7c 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5621,7 +5621,9 @@ enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev)
>  	 */
>  	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP2, &lnkcap2);
>  	if (lnkcap2) { /* PCIe r3.0-compliant */
> -		if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_16_0GB)
> +		if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_32_0GB)
> +			return PCIE_SPEED_32_0GT;
> +		else if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_16_0GB)
>  			return PCIE_SPEED_16_0GT;
>  		else if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_8_0GB)
>  			return PCIE_SPEED_8_0GT;
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 0e8e2c1..c5f27c8 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -668,7 +668,7 @@ const unsigned char pcie_link_speed[] = {
>  	PCIE_SPEED_5_0GT,		/* 2 */
>  	PCIE_SPEED_8_0GT,		/* 3 */
>  	PCIE_SPEED_16_0GT,		/* 4 */
> -	PCI_SPEED_UNKNOWN,		/* 5 */
> +	PCIE_SPEED_32_0GT,		/* 5 */
>  	PCI_SPEED_UNKNOWN,		/* 6 */
>  	PCI_SPEED_UNKNOWN,		/* 7 */
>  	PCI_SPEED_UNKNOWN,		/* 8 */
> diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
> index f4d92b1..ae4aa0e 100644
> --- a/drivers/pci/slot.c
> +++ b/drivers/pci/slot.c
> @@ -75,6 +75,7 @@ static const char *pci_bus_speed_strings[] = {
>  	"5.0 GT/s PCIe",	/* 0x15 */
>  	"8.0 GT/s PCIe",	/* 0x16 */
>  	"16.0 GT/s PCIe",	/* 0x17 */
> +	"32.0 GT/s PCIe",	/* 0x18 */
>  };
>  
>  static ssize_t bus_speed_read(enum pci_bus_speed speed, char *buf)
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 4a5a84d..2173e6b 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -258,6 +258,7 @@ enum pci_bus_speed {
>  	PCIE_SPEED_5_0GT		= 0x15,
>  	PCIE_SPEED_8_0GT		= 0x16,
>  	PCIE_SPEED_16_0GT		= 0x17,
> +	PCIE_SPEED_32_0GT		= 0x18,
>  	PCI_SPEED_UNKNOWN		= 0xff,
>  };
>  
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 2716476..f28e562 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -528,6 +528,7 @@
>  #define  PCI_EXP_LNKCAP_SLS_5_0GB 0x00000002 /* LNKCAP2 SLS Vector bit 1 */
>  #define  PCI_EXP_LNKCAP_SLS_8_0GB 0x00000003 /* LNKCAP2 SLS Vector bit 2 */
>  #define  PCI_EXP_LNKCAP_SLS_16_0GB 0x00000004 /* LNKCAP2 SLS Vector bit 3 */
> +#define  PCI_EXP_LNKCAP_SLS_32_0GB 0x00000005 /* LNKCAP2 SLS Vector bit 4 */
>  #define  PCI_EXP_LNKCAP_MLW	0x000003f0 /* Maximum Link Width */
>  #define  PCI_EXP_LNKCAP_ASPMS	0x00000c00 /* ASPM Support */
>  #define  PCI_EXP_LNKCAP_L0SEL	0x00007000 /* L0s Exit Latency */
> @@ -556,6 +557,7 @@
>  #define  PCI_EXP_LNKSTA_CLS_5_0GB 0x0002 /* Current Link Speed 5.0GT/s */
>  #define  PCI_EXP_LNKSTA_CLS_8_0GB 0x0003 /* Current Link Speed 8.0GT/s */
>  #define  PCI_EXP_LNKSTA_CLS_16_0GB 0x0004 /* Current Link Speed 16.0GT/s */
> +#define  PCI_EXP_LNKSTA_CLS_32_0GB 0x0005 /* Current Link Speed 32.0GT/s */
>  #define  PCI_EXP_LNKSTA_NLW	0x03f0	/* Negotiated Link Width */
>  #define  PCI_EXP_LNKSTA_NLW_X1	0x0010	/* Current Link Width x1 */
>  #define  PCI_EXP_LNKSTA_NLW_X2	0x0020	/* Current Link Width x2 */
> @@ -661,6 +663,7 @@
>  #define  PCI_EXP_LNKCAP2_SLS_5_0GB	0x00000004 /* Supported Speed 5GT/s */
>  #define  PCI_EXP_LNKCAP2_SLS_8_0GB	0x00000008 /* Supported Speed 8GT/s */
>  #define  PCI_EXP_LNKCAP2_SLS_16_0GB	0x00000010 /* Supported Speed 16GT/s */
> +#define  PCI_EXP_LNKCAP2_SLS_32_0GB	0x00000020 /* Supported Speed 32GT/s */
>  #define  PCI_EXP_LNKCAP2_CROSSLINK	0x00000100 /* Crosslink supported */
>  #define PCI_EXP_LNKCTL2		48	/* Link Control 2 */
>  #define  PCI_EXP_LNKCTL2_TLS		0x000f
> @@ -668,6 +671,7 @@
>  #define  PCI_EXP_LNKCTL2_TLS_5_0GT	0x0002 /* Supported Speed 5GT/s */
>  #define  PCI_EXP_LNKCTL2_TLS_8_0GT	0x0003 /* Supported Speed 8GT/s */
>  #define  PCI_EXP_LNKCTL2_TLS_16_0GT	0x0004 /* Supported Speed 16GT/s */
> +#define  PCI_EXP_LNKCTL2_TLS_32_0GT	0x0005 /* Supported Speed 32GT/s */
>  #define PCI_EXP_LNKSTA2		50	/* Link Status 2 */
>  #define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2	52	/* v2 endpoints with link end here */
>  #define PCI_EXP_SLTCAP2		52	/* Slot Capabilities 2 */
> -- 
> 2.7.4
> 
