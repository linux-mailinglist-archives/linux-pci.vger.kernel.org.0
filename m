Return-Path: <linux-pci+bounces-38281-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCBCBE0F49
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 00:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B94791A24B05
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 22:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF9A30F540;
	Wed, 15 Oct 2025 22:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="xbUyOAdB"
X-Original-To: linux-pci@vger.kernel.org
Received: from hall.aurel32.net (hall.aurel32.net [195.154.113.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F139226D18;
	Wed, 15 Oct 2025 22:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.113.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567737; cv=none; b=AagYvL4jypRlHaywwiYTuiS30SEH6ClNC3s3y4+qGxNkdC0ydyw0IcQo1M+zgfUkAKaDLqUgzRS4MnyDBjsSO7NvOYM9WGLV3Blx0n4e1gnLyNZEc4ro4BbcLTPSdz4ZwfDzN83i4fLd6SHHyP03jn25EcoFSHEl3JDVyOOcu3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567737; c=relaxed/simple;
	bh=Uy50svceI1+XWgm3Zns9sEedIGjXkuM329JuRdlJIaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZ7NJPC5SnCUDKvt2hHPh6IfBduCHE7Px997hGh8PkLJ9EczalcoE5m6SndARpgs75AIne21a2kYvdcZTEmRk5dTWzIqFWjCrHuS/D+nqmNC8QFUhvMALelTy6yCGK0Qpm0d2GeyCvQe0B4kNp3MZGNffFATak+yrUyUjAASYrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=xbUyOAdB; arc=none smtp.client-ip=195.154.113.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=DlM+vgyHxfCOK+MuMNUGW61IU4Xna6U487K0RDUqQe4=; b=xbUyOAdBBo2/nc7toUSs5yUUu7
	rrywRKq3bwPL5MUpl3nfnqscz+VW2P7YIZw7P87ayXPkqYOdOI0wMeIwqHM9Q3wfgrcfup1KukCVV
	Di+1/rMvOeV3JtVrnD9rsGLNtDUhJXDqF8l9StRGufgFPXVJPSbHaAHTpPF6G/Kz1VWnblNMoU4DI
	ni8/PBy/C1boyp49iSxDSakkNc/4wFgeJmCgjBMQlIgH+skWhAQMG6P5Rf2zpcufO56a0FAPV3AV2
	OGf6igGMKov8tchzG1s9jf1g81OdIgJwqsRJ2SHNeZj7ZnhFdS5EgnosqPol41MrjGy++j4iGYALG
	fXQ3zGpA==;
Received: from [2a01:e34:ec5d:a741:1ee1:92ff:feb4:5ec0] (helo=ohm.rr44.fr)
	by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aurelien@aurel32.net>)
	id 1v99Oh-0081CU-19;
	Wed, 15 Oct 2025 23:51:03 +0200
Date: Wed, 15 Oct 2025 23:51:02 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: Alex Elder <elder@riscstar.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, vkoul@kernel.org, kishon@kernel.org,
	dlan@gentoo.org, guodong@riscstar.com, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	p.zabel@pengutronix.de, christian.bruel@foss.st.com,
	shradha.t@samsung.com, krishna.chundru@oss.qualcomm.com,
	qiang.yu@oss.qualcomm.com, namcao@linutronix.de,
	thippeswamy.havalige@amd.com, inochiama@gmail.com,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Junzhong Pan <panjunzhong@linux.spacemit.com>
Subject: Re: [PATCH v2 4/7] phy: spacemit: introduce PCIe/combo PHY
Message-ID: <aPAXRiGA8aTZCNTm@aurel32.net>
Mail-Followup-To: Alex Elder <elder@riscstar.com>, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, bhelgaas@google.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	vkoul@kernel.org, kishon@kernel.org, dlan@gentoo.org,
	guodong@riscstar.com, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, p.zabel@pengutronix.de,
	christian.bruel@foss.st.com, shradha.t@samsung.com,
	krishna.chundru@oss.qualcomm.com, qiang.yu@oss.qualcomm.com,
	namcao@linutronix.de, thippeswamy.havalige@amd.com,
	inochiama@gmail.com, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
	spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Junzhong Pan <panjunzhong@linux.spacemit.com>
References: <20251013153526.2276556-1-elder@riscstar.com>
 <20251013153526.2276556-5-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013153526.2276556-5-elder@riscstar.com>
User-Agent: Mutt/2.2.13 (2024-03-09)

Hi,

On 2025-10-13 10:35, Alex Elder wrote:
> Introduce a driver that supports three PHYs found on the SpacemiT
> K1 SoC.  The first PHY is a combo PHY that can be configured for
> use for either USB 3 or PCIe.  The other two PHYs support PCIe
> only.
> 
> All three PHYs must be programmed with an 8 bit receiver termination
> value, which must be determined dynamically.  Only the combo PHY is
> able to determine this value.  The combo PHY performs a special
> calibration step at probe time to discover this, and that value is
> used to program each PHY that operates in PCIe mode.  The combo
> PHY must therefore be probed before either of the PCIe-only PHYs
> will be used.
> 
> Each PHY has an internal PLL driven from an external oscillator.
> This PLL started when the PHY is first initialized, and stays
> on thereafter.
> 
> During normal operation, the USB or PCIe driver using the PHY must
> ensure (other) clocks and resets are set up properly.
> 
> However PCIe mode clocks are enabled and resets are de-asserted
> temporarily by this driver to perform the calibration step on the
> combo PHY.
> 
> Tested-by: Junzhong Pan <panjunzhong@linux.spacemit.com>
> Signed-off-by: Alex Elder <elder@riscstar.com>

Thanks for this new version. I have tried it on top of v6.18-rc1 + 
spacemit DTS commits from next on a BPI-F3, and it fails calibrating the 
PHY with:

[    2.748405] spacemit-k1-pcie-phy c0b10000.phy: error -ENOENT: calibration failed
[    2.755300] spacemit-k1-pcie-phy c0b10000.phy: error -ENOENT: error probing combo phy
[    2.763088] spacemit-k1-pcie-phy c0b10000.phy: probe with driver spacemit-k1-pcie-phy failed with error -2
[   14.309031] platform c0d10000.phy: deferred probe pending: (reason unknown)
[   14.313426] platform c0c10000.phy: deferred probe pending: (reason unknown)
[   14.320347] platform ca400000.pcie: deferred probe pending: platform: supplier c0c10000.phy not ready
[   14.329542] platform ca800000.pcie: deferred probe pending: platform: supplier c0d10000.phy not ready

Note that version 1 was working fine on the same board.

[ snip ]

> diff --git a/drivers/phy/phy-spacemit-k1-pcie.c b/drivers/phy/phy-spacemit-k1-pcie.c
> new file mode 100644
> index 0000000000000..81bc05823d080
> --- /dev/null
> +++ b/drivers/phy/phy-spacemit-k1-pcie.c

[ snip ]

> +static int k1_pcie_combo_phy_calibrate(struct k1_pcie_phy *k1_phy)
> +{
> +	struct reset_control_bulk_data resets[] = {
> +		{ .id = "dbi", },
> +		{ .id = "mstr", },
> +		{ .id = "slv", },
> +	};
> +	struct clk_bulk_data clocks[] = {
> +		{ .id = "dbi", },
> +		{ .id = "mstr", },
> +		{ .id = "slv", },
> +	};
> +	struct device *dev = k1_phy->dev;
> +	struct reset_control *phy_reset;
> +	int ret = 0;
> +	int val;
> +
> +	/* Nothing to do if we already set the receiver termination value */
> +	if (k1_phy_rterm_valid())
> +		return 0;
> +
> +	/* De-assert the PHY (global) reset and leave it that way for USB */
> +	phy_reset = devm_reset_control_get_exclusive_deasserted(dev, "phy");
> +	if (IS_ERR(phy_reset))
> +		return PTR_ERR(phy_reset);
> +
> +	/*
> +	 * We also guarantee the APP_HOLD_PHY_RESET bit is clear.  We can
> +	 * leave this bit clear even if an error happens below.
> +	 */
> +	regmap_assign_bits(k1_phy->pmu, PCIE_CLK_RES_CTRL,
> +			   PCIE_APP_HOLD_PHY_RST, false);
> +
> +	/* If the calibration already completed (e.g. by U-Boot), we're done */
> +	val = readl(k1_phy->regs + PCIE_RCAL_RESULT);
> +	if (val & R_TUNE_DONE)
> +		goto out_tune_done;
> +
> +	/* Put the PHY into PCIe mode */
> +	k1_combo_phy_sel(k1_phy, false);
> +
> +	/* Get and enable the PCIe app clocks */
> +	ret = clk_bulk_get(dev, ARRAY_SIZE(clocks), clocks);
> +	if (ret <= 0) {
> +		if (!ret)
> +			ret = -ENOENT;
> +		goto out_tune_done;
> +	}

This part doesn't look correct. The documentation says this function 
"returns 0 if all clocks specified in clk_bulk_data table are obtained
successfully, or valid IS_ERR() condition containing errno."

To me, it seems the code should only be:

	ret = clk_bulk_get(dev, ARRAY_SIZE(clocks), clocks);
	if (ret)
		goto out_tune_done;

[snip]

> +out_put_clocks:
> +	clk_bulk_put_all(ARRAY_SIZE(clocks), clocks);

When fixing the above bug, this then crashes with:

[    2.776109] Unable to handle kernel paging request at virtual address ffffffc41a0110c8
[    2.783958] Current kworker/u36:0 pgtable: 4K pagesize, 39-bit VAs, pgdp=0x00000000022a7000
[    2.792302] [ffffffc41a0110c8] pgd=0000000000000000, p4d=0000000000000000, pud=0000000000000000
[    2.800980] Oops [#1]
[    2.803217] Modules linked in:
[    2.806261] CPU: 3 UID: 0 PID: 58 Comm: kworker/u36:0 Not tainted 6.18.0-rc1+ #4 PREEMPTLAZY 
[    2.814763] Hardware name: Banana Pi BPI-F3 (DT)
[    2.819366] Workqueue: events_unbound deferred_probe_work_func
[    2.825180] epc : virt_to_folio+0x5e/0xb8
[    2.829172]  ra : kfree+0x3a/0x528
[    2.832558] epc : ffffffff8034e12e ra : ffffffff8035557a sp : ffffffc600243980
[    2.839762]  gp : ffffffff82074258 tp : ffffffd700994d80 t0 : ffffffff80021540
[    2.846967]  t1 : 0000000000000018 t2 : 2d74696d65636170 s0 : ffffffc600243990
[    2.854172]  s1 : ffffffc600243ab8 a0 : 03ffffc41a0110c0 a1 : ffffffff82123bd0
[    2.861377]  a2 : 7c137c69131cec36 a3 : ffffffff816606d8 a4 : 0000000000000000
[    2.868583]  a5 : ffffffc500000000 a6 : 0000000000000004 a7 : 0000000000000004
[    2.875787]  s2 : ffffffd700b98410 s3 : ffffffc600243ab8 s4 : 0000000000000000
[    2.882991]  s5 : ffffffff80828f1c s6 : 0000000000008437 s7 : ffffffd700b98410
[    2.890197]  s8 : ffffffd700b98410 s9 : ffffffd700900240 s10: ffffffff81fc4100
[    2.897401]  s11: ffffffd700987400 t3 : 0000000000000004 t4 : 0000000000000001
[    2.904607]  t5 : 000000000000001f t6 : 0000000000000003
[    2.909902] status: 0000000200000120 badaddr: ffffffc41a0110c8 cause: 000000000000000d
[    2.917802] [<ffffffff8034e12e>] virt_to_folio+0x5e/0xb8
[    2.923097] [<ffffffff8035557a>] kfree+0x3a/0x528
[    2.927784] [<ffffffff80828f1c>] clk_bulk_put_all+0x64/0x78
[    2.933340] [<ffffffff807249d6>] k1_pcie_phy_probe+0x4ee/0x618
[    2.939155] [<ffffffff808e35e6>] platform_probe+0x56/0x98
[    2.944538] [<ffffffff808e0328>] really_probe+0xa0/0x348
[    2.949832] [<ffffffff808e064c>] __driver_probe_device+0x7c/0x140
[    2.955909] [<ffffffff808e07f8>] driver_probe_device+0x38/0xd0
[    2.961724] [<ffffffff808e0912>] __device_attach_driver+0x82/0xf0
[    2.967801] [<ffffffff808dde6a>] bus_for_each_drv+0x72/0xd0
[    2.973356] [<ffffffff808e0cac>] __device_attach+0x94/0x198
[    2.978912] [<ffffffff808e0fca>] device_initial_probe+0x1a/0x30
[    2.984815] [<ffffffff808defee>] bus_probe_device+0x96/0xa0
[    2.990370] [<ffffffff808dff0e>] deferred_probe_work_func+0xa6/0x110
[    2.996707] [<ffffffff8005cb66>] process_one_work+0x15e/0x340
[    3.002436] [<ffffffff8005d58c>] worker_thread+0x22c/0x348
[    3.007905] [<ffffffff80066b7c>] kthread+0x10c/0x208
[    3.012853] [<ffffffff80014de0>] ret_from_fork_kernel+0x18/0x1c0
[    3.018843] [<ffffffff80c917d6>] ret_from_fork_kernel_asm+0x16/0x18
[    3.025098] Code: 7a98 8d19 2717 0131 3703 5fa7 8131 8d19 051a 953e (651c) f713 
[    3.032497] ---[ end trace 0000000000000000 ]---

It seems that we want clk_bulk_put() and not clk_bulk_put_all(). The 
latter free the clocks, while they have been allocated on the stack.

Regards,
Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net

