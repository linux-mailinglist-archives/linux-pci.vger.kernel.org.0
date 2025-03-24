Return-Path: <linux-pci+bounces-24572-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 824A9A6E3E6
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 21:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 272321890126
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 20:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFDD192D77;
	Mon, 24 Mar 2025 20:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ir4HnYiT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C05157A46;
	Mon, 24 Mar 2025 20:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742846679; cv=none; b=aDwsUg6VWyTCO3T5ZPKYXneB2eklRY+nHdRqCtZ9n8yud5m8Rr7zRalhgh11vex4kWXgAiWRkWKSTJB/LS17ituIWRtt6/egukVSvKyfHSS09Xa0ZtGewPqFUtb9hTzDlxl2lMU2fgBdZysVL2KzJWYeDSSSjLGVR07yYzGfUw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742846679; c=relaxed/simple;
	bh=zxmtxJA+3RpFU/Hf5MWAcrc6kL1d19pYvJFVOyd3j58=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hO20TK5eBe9DyqS05rU5abWifAuXkaszMxbn76AHyBJWjswqYY9dbAQZjLrVG3ZyVJLfbkCCmU+kAdp3Okj9PpdA+7WvxcNzDDAwpM8ONzSjpsdASh7lOWpkehQE7KcBqI0SdHhaYHRIb4k4Abtkwe2hYr7fI4+4j5XrRB8HlgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ir4HnYiT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15781C4CEDD;
	Mon, 24 Mar 2025 20:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742846679;
	bh=zxmtxJA+3RpFU/Hf5MWAcrc6kL1d19pYvJFVOyd3j58=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ir4HnYiTuYT/ai0rJIcleFJsWExMp9ZpWaRwj7+63VVwCK46PgXa0be18Ci1eIm49
	 bYu3M/v62UAR2hjJJn+ykZOhnfRBVDvrhSwOzCR2nOW4x9NNPqwpsLIcviOBXzjZwz
	 1I6rdOWMyasnuyjoCCp36hSVh83Ho8A3oNkpNk5TA0yJnSUwQZdMIVj1QxgrYmvsvr
	 VypkSNJq2c5mqRzX1u65o80YA15c9fZGU1F75/gC9EjKlq5N23A08mdLtQsBM+HdQ1
	 ukkv7RV93Jl9n7VU2yIjPXwzPUMkEjYIpunR/1jJdKvCEvXD5hdOzmATu+1ZLxuQ37
	 VrANkVTI8xK0Q==
Date: Mon, 24 Mar 2025 15:04:37 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v12 06/13] PCI: dwc: Add dw_pcie_parent_bus_offset()
 checking and debug
Message-ID: <20250324200437.GA1257874@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x2r2xfxrnkihvpoqiamgjmvppverjugp5r4we7lcfpz6jloxzy@7kdfzxiwv2po>

On Mon, Mar 24, 2025 at 11:00:24PM +0530, Manivannan Sadhasivam wrote:
> On Sat, Mar 15, 2025 at 03:15:41PM -0500, Bjorn Helgaas wrote:
> > From: Frank Li <Frank.Li@nxp.com>
> > 
> > dw_pcie_parent_bus_offset() looks up the parent bus address of a PCI
> > controller 'reg' property in devicetree.  If implemented, .cpu_addr_fixup()
> > is a hard-coded way to get the parent bus address corresponding to a CPU
> > physical address.
> > 
> > Add debug code to compare the address from .cpu_addr_fixup() with the
> > address from devicetree.  If they match, warn that .cpu_addr_fixup() is
> > redundant and should be removed; if they differ, warn that something is
> > wrong with the devicetree.
> > 
> > If .cpu_addr_fixup() is not implemented, the parent bus address should be
> > identical to the CPU physical address because we previously ignored the
> > parent bus address from devicetree.  If the devicetree has a different
> > parent bus address, warn about it being broken.
> > 
> > [bhelgaas: split debug to separate patch for easier future revert, commit
> > log]
> > Link: https://lore.kernel.org/r/20250313-pci_fixup_addr-v11-5-01d2313502ab@nxp.com
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware.c | 26 +++++++++++++++++++-
> >  drivers/pci/controller/dwc/pcie-designware.h | 13 ++++++++++
> >  2 files changed, 38 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > index 0a35e36da703..985264c88b92 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -1114,7 +1114,8 @@ resource_size_t dw_pcie_parent_bus_offset(struct dw_pcie *pci,
> >  	struct device *dev = pci->dev;
> >  	struct device_node *np = dev->of_node;
> >  	int index;
> > -	u64 reg_addr;
> > +	u64 reg_addr, fixup_addr;
> > +	u64 (*fixup)(struct dw_pcie *pcie, u64 cpu_addr);
> >  
> >  	/* Look up reg_name address on parent bus */
> >  	index = of_property_match_string(np, "reg-names", reg_name);
> > @@ -1126,5 +1127,28 @@ resource_size_t dw_pcie_parent_bus_offset(struct dw_pcie *pci,
> >  
> >  	of_property_read_reg(np, index, &reg_addr, NULL);
> >  
> > +	fixup = pci->ops->cpu_addr_fixup;
> > +	if (fixup) {
> > +		fixup_addr = fixup(pci, cpu_phy_addr);
> > +		if (reg_addr == fixup_addr) {
> > +			dev_warn(dev, "%#010llx %s reg[%d] == %#010llx; %ps is redundant\n",
> > +				 cpu_phy_addr, reg_name, index,
> > +				 fixup_addr, fixup);
> > +		} else {
> > +			dev_warn(dev, "%#010llx %s reg[%d] != %#010llx fixed up addr; devicetree is broken\n",
> > +				 cpu_phy_addr, reg_name,
> > +				 index, fixup_addr);
> > +			reg_addr = fixup_addr;
> > +		}
> > +	} else if (!pci->use_parent_dt_ranges) {
> 
> Is this check still valid? 'use_parent_dt_ranges' is only used here for
> validation. Moreover, if the fixup is not available, we should be able to
> safely return 'cpu_phy_addr - reg_addr' unconditionally.

Yes, that's true IF the devicetree has the correct 'ranges'
translation.  This is to avoid breaking platforms with broken
devicetrees.

> > +		if (reg_addr != cpu_phy_addr) {
> > +			dev_warn(dev, "devicetree has incorrect translation; please check parent \"ranges\" property. CPU physical addr %#010llx, parent bus addr %#010llx\n",
> > +				 cpu_phy_addr, reg_addr);
> > +			return 0;
> > +		}
> > +	}
> > +
> > +	dev_info(dev, "%s parent bus offset is %#010llx\n",
> > +		 reg_name, cpu_phy_addr - reg_addr);
> 
> This info is useless on platforms having no translation between CPU and PCI
> controller. The offset will always be 0.

You're right.  This was probably an overzealous message for any
possible issues.

What would you think of the below as a replacement?  It should emit at
most one message, and none for platforms where devicetree describes no
translation and there never was a .cpu_addr_fixup().

It's still pretty aggressive logging, but I'm just concerned about
being able to quickly debug and fix any regressions.  Ideally we can
revert the whole thing eventually.


diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 27b464a405a4..4b442d1aa55b 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -1114,7 +1114,8 @@ resource_size_t dw_pcie_parent_bus_offset(struct dw_pcie *pci,
 	struct device *dev = pci->dev;
 	struct device_node *np = dev->of_node;
 	int index;
-	u64 reg_addr;
+	u64 reg_addr, fixup_addr;
+	u64 (*fixup)(struct dw_pcie *pcie, u64 cpu_addr);
 
 	/* Look up reg_name address on parent bus */
 	index = of_property_match_string(np, "reg-names", reg_name);
@@ -1126,5 +1127,42 @@ resource_size_t dw_pcie_parent_bus_offset(struct dw_pcie *pci,
 
 	of_property_read_reg(np, index, &reg_addr, NULL);
 
+	fixup = pci->ops ? pci->ops->cpu_addr_fixup : NULL;
+	if (fixup) {
+		fixup_addr = fixup(pci, cpu_phys_addr);
+		if (reg_addr == fixup_addr) {
+			dev_info(dev, "%s reg[%d] %#010llx == %#010llx == fixup(cpu %#010llx); %ps is redundant with this devicetree\n",
+				 reg_name, index, reg_addr, fixup_addr,
+				 (unsigned long long) cpu_phys_addr, fixup);
+		} else {
+			dev_warn(dev, "%s reg[%d] %#010llx != %#010llx == fixup(cpu %#010llx); devicetree is broken\n",
+				 reg_name, index, reg_addr, fixup_addr,
+				 (unsigned long long) cpu_phys_addr);
+			reg_addr = fixup_addr;
+		}
+
+		return cpu_phys_addr - reg_addr;
+	}
+
+	if (pci->use_parent_dt_ranges) {
+
+		/*
+		 * This platform once had a fixup, presumably because it
+		 * translates between CPU and PCI controller addresses.
+		 * Log a note if devicetree didn't describe a translation.
+		 */
+		if (reg_addr == cpu_phys_addr)
+			dev_info(dev, "%s reg[%d] %#010llx == cpu %#010llx\n; no fixup was ever needed for this devicetree\n",
+				 reg_name, index, reg_addr,
+				 (unsigned long long) cpu_phys_addr);
+	} else {
+		if (reg_addr != cpu_phys_addr) {
+			dev_warn(dev, "%s reg[%d] %#010llx != cpu %#010llx; no fixup and devicetree \"ranges\" is broken, assuming no translation\n",
+				 reg_name, index, reg_addr,
+				 (unsigned long long) cpu_phys_addr);
+			return 0;
+		}
+	}
+
 	return cpu_phys_addr - reg_addr;
 }
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 16548b01347d..f08d2852cfd5 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -465,6 +465,19 @@ struct dw_pcie {
 	struct reset_control_bulk_data	core_rsts[DW_PCIE_NUM_CORE_RSTS];
 	struct gpio_desc		*pe_rst;
 	bool			suspended;
+
+	/*
+	 * If iATU input addresses are offset from CPU physical addresses,
+	 * we previously required .cpu_addr_fixup() to convert them.  We
+	 * now rely on the devicetree instead.  If .cpu_addr_fixup()
+	 * exists, we compare its results with devicetree.
+	 *
+	 * If .cpu_addr_fixup() does not exist, we assume the offset is
+	 * zero and warn if devicetree claims otherwise.  If we know all
+	 * devicetrees correctly describe the offset, set
+	 * use_parent_dt_ranges to true to avoid this warning.
+	 */
+	bool			use_parent_dt_ranges;
 };
 
 #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)

