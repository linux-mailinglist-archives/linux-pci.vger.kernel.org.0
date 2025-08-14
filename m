Return-Path: <linux-pci+bounces-34087-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C273B27347
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 01:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74DEC1C8852B
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 23:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD88288500;
	Thu, 14 Aug 2025 23:58:10 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073172571C9;
	Thu, 14 Aug 2025 23:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755215890; cv=none; b=gG/zGCUBSJ0X/Bj+CD297/Rsq5htmqct7bwYGmOYs/Kmj8zo5Q8g8nwrKTT4HZBwW6ZfxR/EPBqqTdlXzCC885NjokAJozAUduG2D8B451Uv8fVwa+I5rpPrlJvu39cyL7Wev1iFdnHjvDVDYs0ApfNgG5tddwz5XnFLmGNdVYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755215890; c=relaxed/simple;
	bh=nDbdx1dbklMLZVAzHMFiD14e2brnIis1ZANuht8kPVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQhj5e6PMXxUWG+N8DK/+mk20DguMsXfdJd1aw8nciH7XIx5IrHJRflmZKqUXsJcGOOvWbrsBM6xcX/NstOGCY7YqBzcTg2uI31gHmyGMo9Sp/643Z6ZlnVaaXVE8XFin4jvEf16O6z5TB4L7FVEFv1SmCQOlTxOA6d7N0ANauw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [180.158.240.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 9610033E3A9;
	Thu, 14 Aug 2025 23:58:07 +0000 (UTC)
Date: Fri, 15 Aug 2025 07:57:57 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Alex Elder <elder@riscstar.com>
Cc: Inochi Amaoto <inochiama@gmail.com>, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	vkoul@kernel.org, kishon@kernel.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	p.zabel@pengutronix.de, tglx@linutronix.de, johan+linaro@kernel.org,
	thippeswamy.havalige@amd.com, namcao@linutronix.de,
	mayank.rana@oss.qualcomm.com, shradha.t@samsung.com,
	quic_schintav@quicinc.com, fan.ni@samsung.com,
	devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-pci@vger.kernel.org, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Junzhong Pan <panjunzhong@linux.spacemit.com>
Subject: Re: [PATCH 4/6] phy: spacemit: introduce PCIe/combo PHY
Message-ID: <20250814235757-GYA1008367@gentoo>
References: <20250813184701.2444372-1-elder@riscstar.com>
 <20250813184701.2444372-5-elder@riscstar.com>
 <valmrbddij2dn4fjxefr46zud2u6eco2isyaa62sd66d27foyl@4hrhafqftgb5>
 <4eaa30bc-9a25-4fe0-b685-1d0d8fa503c2@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4eaa30bc-9a25-4fe0-b685-1d0d8fa503c2@riscstar.com>

Hi Alex,

On 07:15 Thu 14 Aug     , Alex Elder wrote:
> On 8/13/25 6:42 PM, Inochi Amaoto wrote:
> > On Wed, Aug 13, 2025 at 01:46:58PM -0500, Alex Elder wrote:
> >> Introduce a driver that supports three PHYs found on the SpacemiT
> >> K1 SoC.  The first PHY is a combo PHY that can be configured for
> >> use for either USB 3 or PCIe.  The other two PHYs support PCIe
> >> only.
> >>
> >> All three PHYs must be programmed with an 8 bit receiver termination
> >> value, which must be determined dynamically; only the combo PHY is
> >> able to determine this value.  The combo PHY performs a special
> >> calibration step at probe time to discover this, and that value is
> >> used to program each PHY that operates in PCIe mode.  The combo
> >> PHY must therefore be probed--first--if either of the PCIe-only
> >> PHYs will be used.
> >>
> >> During normal operation, the USB or PCIe driver using the PHY must
> >> ensure clocks and resets are set up properly.  However clocks are
> >> enabled and resets are de-asserted temporarily by this driver to
> >> perform the calibration step on the combo PHY.
> >>
> >> Tested-by: Junzhong Pan <panjunzhong@linux.spacemit.com>
> >> Signed-off-by: Alex Elder <elder@riscstar.com>
> >> ---
> >>   drivers/phy/Kconfig                |  11 +
> >>   drivers/phy/Makefile               |   1 +
> >>   drivers/phy/phy-spacemit-k1-pcie.c | 639 +++++++++++++++++++++++++++++
> >>   3 files changed, 651 insertions(+)
> >>   create mode 100644 drivers/phy/phy-spacemit-k1-pcie.c
> 
> . . .
> 
> >> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> >> index c670a8dac4680..20f0078e543c7 100644
> >> --- a/drivers/phy/Makefile
> >> +++ b/drivers/phy/Makefile
> 
> . . .
> 
> >> +static int k1_pcie_pll_lock(struct k1_pcie_phy *k1_phy, bool pcie)
> >> +{
> >> +	u32 val = pcie ? CFG_FORCE_RCV_RETRY : 0;
> >> +	void __iomem *virt;
> >> +
> >> +	writel(val, k1_phy->regs + PCIE_RC_DONE_STATUS);
> >> +
> >> +	/*
> >> +	 * Wait for indication the PHY PLL is locked.  Lanes for ports
> >> +	 * B and C share a PLL, so it's enough to sample just lane 0.
> >> +	 */
> >> +	virt = k1_phy->regs + PCIE_PU_ADDR_CLK_CFG;	/* Lane 0 */
> >> +
> >> +	return readl_poll_timeout(virt, val, val & PLL_READY,
> >> +				  POLL_DELAY, PLL_TIMEOUT);
> >> +}
> >> +
> > 
> > Can we use standard clk_ops and clk_mux to normalize this process?
> 
> I understand you're suggesting that we represent this as a clock.
> 
> Can you be more specific about how you suggest I do that?
> 
> For example, are you suggesting I create a separate clock driver
> for this one PLL (in each PCIe register space)?
> 
> Or do you mean use clock structures and callbacks within this
> driver to represent this?
> 
> I'm just not sure what you have in mind, and the two options I
> mention seem a lot more complicated than this one function.
> 
> Thanks.
you can take a look at k1's i2c patch that Troy just sent which has similar case

https://lore.kernel.org/all/20250814-k1-i2c-ilcr-v3-1-317723e74bcd@linux.spacemit.com/

> 
> 					-Alex
> 
> > Regards,
> > Inochi
> 

-- 
Yixun Lan (dlan)

