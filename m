Return-Path: <linux-pci+bounces-38872-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAE7BF5EF5
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 13:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A89342782D
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 11:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50829224249;
	Tue, 21 Oct 2025 11:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OLReVaWJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C3823E340;
	Tue, 21 Oct 2025 11:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761044543; cv=none; b=VY5q1kvKrym5DntTxmJeuMaz6wx/7qX+4J1KDw43bjSvyh3IaXg9VVQ/7UX0873ppOqFVBVLnu+KLaumXkkmPVYsHymyWS3kqJhHyA198JRV3O6K8btnY/5P8BIPkqWUrQZ4MQYInVIm4YzGdqVlM83x3G2vxsQnjHHbd8tT/eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761044543; c=relaxed/simple;
	bh=4fz4wz59GVcGyxkCosyq8sO/kNH/5xlswDAosqFoi6s=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Cvao8U0IFmf/7wSh+VuvBWDfwNBL8LGf+zv8SQ8/E4sPgayUg4ivBYR4UD6J+e+8vZGSUdrV/VIub499fLnJA6LxxC0oLmPYECb6nSP6ZcHGKYbO7RR09+yVL5VH1QYrE6jJfMTec1JRl61vtDrby+dyfyASPpG35j2w/V0j4K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OLReVaWJ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761044541; x=1792580541;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=4fz4wz59GVcGyxkCosyq8sO/kNH/5xlswDAosqFoi6s=;
  b=OLReVaWJig44B2MrprUtQeNvKC01d58qNxgUvcgSEaoeeNnpzD+Il9tZ
   2etrBBjFcuZi6GvPf+liE3FUIYEnqLnEjPKFTk/FEuUzjAWWmfAFcKEzQ
   Eo8Muysv6Ntbjxu/fT+wuTQJ4S9ByMtiJctKqSY/4R4jWrDo+KINfD6Sl
   NTeFH3//5I9OwsWRhi5lNAMLF9ptY+NzhNtkqDWD6fiMwkVLRSVYVwtnj
   rE7i2On8IKgLB8OfbjS5UcytSle3AHHBPETaLUeSNI9Ei03NrR3cgZvS3
   t7Q2wDiL+ZaQAYXik1hBeG+NYehY5AfeMcuJXC/CqWjsbkz7fInSC9e3N
   g==;
X-CSE-ConnectionGUID: euxZZFC8TUGFQg4INnmJDg==
X-CSE-MsgGUID: jTXgrgqhQg+3T3pqfzTwHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="65782711"
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; 
   d="scan'208";a="65782711"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 04:02:21 -0700
X-CSE-ConnectionGUID: kHz7nIy2RDGaI5xz3kOuYQ==
X-CSE-MsgGUID: TM9H9HjAQwS0ILUyoYfweQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; 
   d="scan'208";a="187971086"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.189])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 04:02:14 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 21 Oct 2025 14:02:10 +0300 (EEST)
To: Bjorn Helgaas <helgaas@kernel.org>, 
    Jim Quinlan <james.quinlan@broadcom.com>
cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
    Bjorn Helgaas <bhelgaas@google.com>, 
    Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
    Cyril Brulebois <kibi@debian.org>, bcm-kernel-feedback-list@broadcom.com, 
    jim2101024@gmail.com, Florian Fainelli <florian.fainelli@broadcom.com>, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kwilczynski@kernel.org>, 
    Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
    "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, 
    "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
    open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] PCI: brcmstb: Add panic/die handler to driver
In-Reply-To: <20251020184832.GA1144646@bhelgaas>
Message-ID: <2b0f9620-a105-6e49-f9cb-4bac14e14ce2@linux.intel.com>
References: <20251020184832.GA1144646@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 20 Oct 2025, Bjorn Helgaas wrote:

> On Fri, Oct 03, 2025 at 03:56:07PM -0400, Jim Quinlan wrote:
> > Whereas most PCIe HW returns 0xffffffff on illegal accesses and the like,
> > by default Broadcom's STB PCIe controller effects an abort.  Some SoCs --
> > 7216 and its descendants -- have new HW that identifies error details.
> > 
> > This simple handler determines if the PCIe controller was the cause of the
> > abort and if so, prints out diagnostic info.  Unfortunately, an abort still
> > occurs.
> > 
> > Care is taken to read the error registers only when the PCIe bridge is
> > active and the PCIe registers are acceptable.  Otherwise, a "die" event
> > caused by something other than the PCIe could cause an abort if the PCIe
> > "die" handler tried to access registers when the bridge is off.
> > 
> > Example error output:
> >   brcm-pcie 8b20000.pcie: Error: Mem Acc: 32bit, Read, @0x38000000
> >   brcm-pcie 8b20000.pcie:  Type: TO=0 Abt=0 UnspReq=1 AccDsble=0 BadAddr=0
> 
> > +/* Error report registers */
> > +#define PCIE_OUTB_ERR_TREAT				0x6000
> > +#define  PCIE_OUTB_ERR_TREAT_CONFIG_MASK		0x1
> > +#define  PCIE_OUTB_ERR_TREAT_MEM_MASK			0x2
> > +#define PCIE_OUTB_ERR_VALID				0x6004
> > +#define PCIE_OUTB_ERR_CLEAR				0x6008
> > +#define PCIE_OUTB_ERR_ACC_INFO				0x600c
> > +#define  PCIE_OUTB_ERR_ACC_INFO_CFG_ERR_MASK		0x01
> > +#define  PCIE_OUTB_ERR_ACC_INFO_MEM_ERR_MASK		0x02
> > +#define  PCIE_OUTB_ERR_ACC_INFO_TYPE_64_MASK		0x04
> > +#define  PCIE_OUTB_ERR_ACC_INFO_DIR_WRITE_MASK		0x10
> > +#define  PCIE_OUTB_ERR_ACC_INFO_BYTE_LANES_MASK		0xff00
> > +#define PCIE_OUTB_ERR_ACC_ADDR				0x6010
> > +#define PCIE_OUTB_ERR_ACC_ADDR_BUS_MASK			0xff00000
> > +#define PCIE_OUTB_ERR_ACC_ADDR_DEV_MASK			0xf8000
> > +#define PCIE_OUTB_ERR_ACC_ADDR_FUNC_MASK		0x7000
> > +#define PCIE_OUTB_ERR_ACC_ADDR_REG_MASK			0xfff
> > +#define PCIE_OUTB_ERR_CFG_CAUSE				0x6014
> > +#define  PCIE_OUTB_ERR_CFG_CAUSE_TIMEOUT_MASK		0x40
> > +#define  PCIE_OUTB_ERR_CFG_CAUSE_ABORT_MASK		0x20
> > +#define  PCIE_OUTB_ERR_CFG_CAUSE_UNSUPP_REQ_MASK	0x10
> > +#define  PCIE_OUTB_ERR_CFG_CAUSE_ACC_TIMEOUT_MASK	0x4
> > +#define  PCIE_OUTB_ERR_CFG_CAUSE_ACC_DISABLED_MASK	0x2
> > +#define  PCIE_OUTB_ERR_CFG_CAUSE_ACC_64BIT__MASK	0x1

Double __

> > +#define PCIE_OUTB_ERR_MEM_ADDR_LO			0x6018
> > +#define PCIE_OUTB_ERR_MEM_ADDR_HI			0x601c
> > +#define PCIE_OUTB_ERR_MEM_CAUSE				0x6020
> > +#define  PCIE_OUTB_ERR_MEM_CAUSE_TIMEOUT_MASK		0x40
> > +#define  PCIE_OUTB_ERR_MEM_CAUSE_ABORT_MASK		0x20
> > +#define  PCIE_OUTB_ERR_MEM_CAUSE_UNSUPP_REQ_MASK	0x10
> > +#define  PCIE_OUTB_ERR_MEM_CAUSE_ACC_DISABLED_MASK	0x2
> > +#define  PCIE_OUTB_ERR_MEM_CAUSE_BAD_ADDR_MASK		0x1

Maybe use BIT() instead for single bits?

> IMO "_MASK" is not adding anything useful to these names.  But I see
> there's a lot of precedent in this driver.
>
> >  #define  PCIE_RGR1_SW_INIT_1_PERST_MASK			0x1
> >  #define  PCIE_RGR1_SW_INIT_1_PERST_SHIFT		0x0

Please don't add unnecessary _SHIFT defines as FIELD_GET/PREP() for the 
field define should have most cases covered that require shifting.

This define is also entirely unused in this patch.

> > @@ -306,6 +342,8 @@ struct brcm_pcie {
> >  	bool			ep_wakeup_capable;
> >  	const struct pcie_cfg_data	*cfg;
> >  	bool			bridge_in_reset;
> > +	struct notifier_block	die_notifier;
> > +	struct notifier_block	panic_notifier;
> >  	spinlock_t		bridge_lock;
> >  };
> >  
> > @@ -1731,6 +1769,115 @@ static int brcm_pcie_resume_noirq(struct device *dev)
> >  	return ret;
> >  }
> >  
> > +/* Dump out PCIe errors on die or panic */
> > +static int _brcm_pcie_dump_err(struct brcm_pcie *pcie,
> 
> What is the leading underscore telling me?  There's no
> brcm_pcie_dump_err() that we need to distinguish from.
> 
> > +			       const char *type)
> > +{
> > +	void __iomem *base = pcie->base;
> > +	int i, is_cfg_err, is_mem_err, lanes;
> > +	char *width_str, *direction_str, lanes_str[9];
> > +	u32 info, cfg_addr, cfg_cause, mem_cause, lo, hi;
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&pcie->bridge_lock, flags);
> > +	/* Don't access registers when the bridge is off */
> > +	if (pcie->bridge_in_reset || readl(base + PCIE_OUTB_ERR_VALID) == 0) {
> > +		spin_unlock_irqrestore(&pcie->bridge_lock, flags);
> > +		return NOTIFY_DONE;
> > +	}
> > +
> > +	/* Read all necessary registers so we can release the spinlock ASAP */
> > +	info = readl(base + PCIE_OUTB_ERR_ACC_INFO);
> > +	is_cfg_err = !!(info & PCIE_OUTB_ERR_ACC_INFO_CFG_ERR_MASK);
> > +	is_mem_err = !!(info & PCIE_OUTB_ERR_ACC_INFO_MEM_ERR_MASK);
> > +	if (is_cfg_err) {
> > +		cfg_addr = readl(base + PCIE_OUTB_ERR_ACC_ADDR);
> > +		cfg_cause = readl(base + PCIE_OUTB_ERR_CFG_CAUSE);
> > +	}
> > +	if (is_mem_err) {
> > +		mem_cause = readl(base + PCIE_OUTB_ERR_MEM_CAUSE);
> > +		lo = readl(base + PCIE_OUTB_ERR_MEM_ADDR_LO);
> > +		hi = readl(base + PCIE_OUTB_ERR_MEM_ADDR_HI);
> > +	}
> > +	/* We've got all of the info, clear the error */
> > +	writel(1, base + PCIE_OUTB_ERR_CLEAR);
> > +	spin_unlock_irqrestore(&pcie->bridge_lock, flags);
> > +
> > +	dev_err(pcie->dev, "reporting data on PCIe %s error\n", type);
> 
> Looks like this isn't included in the example error output.  Not a big
> deal in itself, but logging this:
> 
>   brcm-pcie 8b20000.pcie: reporting data on PCIe Panic error
> 
> suggests that we know this panic was directly *caused* by PCIe, and
> I'm not sure the fact that somebody called panic() and
> PCIE_OUTB_ERR_VALID was non-zero is convincing evidence of that.
> 
> I think this relies on the assumptions that (a) the controller
> triggers an abort and (b) the abort handler calls panic().  So I think
> this logs useful information that *might* be related to the panic.
> 
> I'd rather phrase this with a little less certainty, to convey the
> idea that "here's some PCIe error information that might be related to
> the panic/die".
> 
> > +	width_str = (info & PCIE_OUTB_ERR_ACC_INFO_TYPE_64_MASK) ? "64bit" : "32bit";
> > +	direction_str = (info & PCIE_OUTB_ERR_ACC_INFO_DIR_WRITE_MASK) ? "Write" : "Read";

Please use str_read_write() + don't forget it's include.

It might be also worth to add str_64bit_32bit() in the form with the
dash ("64-bit") as there a couple of other drivers print the same choice.


> > +	lanes = FIELD_GET(PCIE_OUTB_ERR_ACC_INFO_BYTE_LANES_MASK, info);
> > +	for (i = 0, lanes_str[8] = 0; i < 8; i++)
> > +		lanes_str[i] = (lanes & (1 << i)) ? '1' : '0';
> > +
> > +	if (is_cfg_err) {
> > +		int bus = FIELD_GET(PCIE_OUTB_ERR_ACC_ADDR_BUS_MASK, cfg_addr);
> > +		int dev = FIELD_GET(PCIE_OUTB_ERR_ACC_ADDR_DEV_MASK, cfg_addr);
> > +		int func = FIELD_GET(PCIE_OUTB_ERR_ACC_ADDR_FUNC_MASK, cfg_addr);
> > +		int reg = FIELD_GET(PCIE_OUTB_ERR_ACC_ADDR_REG_MASK, cfg_addr);
> > +
> > +		dev_err(pcie->dev, "Error: CFG Acc, %s, %s, Bus=%d, Dev=%d, Fun=%d, Reg=0x%x, lanes=%s\n",
> 
> Why are we printing bus and dev with %d?  Can we use the usual format
> ("%04x:%02x:%02x.%d") so it matches other logging?
> 
> > +			width_str, direction_str, bus, dev, func, reg, lanes_str);
> > +		dev_err(pcie->dev, " Type: TO=%d Abt=%d UnsupReq=%d AccTO=%d AccDsbld=%d Acc64bit=%d\n",
> > +			!!(cfg_cause & PCIE_OUTB_ERR_CFG_CAUSE_TIMEOUT_MASK),
> > +			!!(cfg_cause & PCIE_OUTB_ERR_CFG_CAUSE_ABORT_MASK),
> > +			!!(cfg_cause & PCIE_OUTB_ERR_CFG_CAUSE_UNSUPP_REQ_MASK),
> > +			!!(cfg_cause & PCIE_OUTB_ERR_CFG_CAUSE_ACC_TIMEOUT_MASK),
> > +			!!(cfg_cause & PCIE_OUTB_ERR_CFG_CAUSE_ACC_DISABLED_MASK),
> > +			!!(cfg_cause & PCIE_OUTB_ERR_CFG_CAUSE_ACC_64BIT__MASK));
> > +	}
> > +
> > +	if (is_mem_err) {
> > +		u64 addr = ((u64)hi << 32) | (u64)lo;
> > +
> > +		dev_err(pcie->dev, "Error: Mem Acc, %s, %s, @0x%llx, lanes=%s\n",
> > +			width_str, direction_str, addr, lanes_str);
> > +		dev_err(pcie->dev, " Type: TO=%d Abt=%d UnsupReq=%d AccDsble=%d BadAddr=%d\n",
> > +			!!(mem_cause & PCIE_OUTB_ERR_MEM_CAUSE_TIMEOUT_MASK),
> > +			!!(mem_cause & PCIE_OUTB_ERR_MEM_CAUSE_ABORT_MASK),
> > +			!!(mem_cause & PCIE_OUTB_ERR_MEM_CAUSE_UNSUPP_REQ_MASK),
> > +			!!(mem_cause & PCIE_OUTB_ERR_MEM_CAUSE_ACC_DISABLED_MASK),
> > +			!!(mem_cause & PCIE_OUTB_ERR_MEM_CAUSE_BAD_ADDR_MASK));
> > +	}
> > +
> > +	return NOTIFY_OK;
> 
> What is the difference between NOTIFY_DONE and NOTIFY_OK?  Can the
> caller do anything useful based on the difference?
> 
> This seems like opportunistic error information that isn't definitely
> definitely connected to anything, so I'm not sure returning different
> values is really reliable.
> 

