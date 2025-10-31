Return-Path: <linux-pci+bounces-39983-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 304A3C2720E
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 23:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D05A188406B
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 22:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51F81494CC;
	Fri, 31 Oct 2025 22:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="M39vuJwq"
X-Original-To: linux-pci@vger.kernel.org
Received: from hall.aurel32.net (hall.aurel32.net [195.154.113.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F85354763;
	Fri, 31 Oct 2025 22:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.113.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761949899; cv=none; b=O+BszwkMxwU+nurRWoEfO1ZHBha00VzX8hyqW+9idhV+btW8hAjYl/QyDARzkIDQPrIySXIVHK3GpgQJyc7UB7gixmq8hbbJB22oeW329/ShaIPkQLfc0z2Mwtni5v/xY0og1zJzmzT10v+Js/2X1ibPQo1XYM8Vjr1GiDp0lZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761949899; c=relaxed/simple;
	bh=mcCYU2DZEgm22G7FtYX6PZDwrQtk7eir+wADAhNPInA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjRdNQdidNZAtVeT7OMy0GZm5T/+FYtI16MWJIw+cxYVHsBaZSXNlL+zJ6z5kgzUzClkgMdbxzeA0VhlQU/gFdKjwsBaLeFeGpFwcuXDb9c/M/lazcoazzFidTbbtLoE2wHYor9QXIyNz3jCP8p73mln/9YzXTt3euI+JOV0v9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=M39vuJwq; arc=none smtp.client-ip=195.154.113.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=rD2JIdANTZru7tnoty78FxFPBqnheT+Ouf2ZxL1AylI=; b=M39vuJwqwXyMI1cEG79o39S3fV
	pg3hdjeCchwqLht2MWcV2mPu9yi571rh04hAjJBtVHTRwz+ndwhBcvUwctdsVo+LVCWFV5CVcDxPA
	+aMHDZutukWkSVr8VUGA5LLK2ikEdv8XVCzbdKuVT4edJCJAhAB3AXzCW4XkY4BvwNqljKfJPxas2
	QX0c1OiOYgGKMgdc3u+KGc7JyepotbXrOh5W+G1rktQvwSPSkimoir7GpDpdVWBgnw9MCxegxQ25p
	Bpz9faVEn4JuIHYjrX+H0GOarFyZj5aMQ90Emhjl7ThdwqKvI0Q8gghX3CPx1ioC+5IRtbvo/v+my
	4DmCI6aw==;
Received: from [2a01:e34:ec5d:a741:1ee1:92ff:feb4:5ec0] (helo=ohm.rr44.fr)
	by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <aurelien@aurel32.net>)
	id 1vExeJ-000000049Fl-0m2N;
	Fri, 31 Oct 2025 23:31:11 +0100
Date: Fri, 31 Oct 2025 23:31:08 +0100
From: Aurelien Jarno <aurelien@aurel32.net>
To: Alex Elder <elder@riscstar.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, bhelgaas@google.com, dlan@gentoo.org,
	johannes@erdfelt.com, p.zabel@pengutronix.de,
	christian.bruel@foss.st.com, thippeswamy.havalige@amd.com,
	krishna.chundru@oss.qualcomm.com, mayank.rana@oss.qualcomm.com,
	qiang.yu@oss.qualcomm.com, shradha.t@samsung.com,
	inochiama@gmail.com, guodong@riscstar.com,
	linux-pci@vger.kernel.org, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/7] PCI: spacemit: introduce SpacemiT PCIe host driver
Message-ID: <aQU4rGzrB1-Vu7C6@aurel32.net>
Mail-Followup-To: Alex Elder <elder@riscstar.com>, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	bhelgaas@google.com, dlan@gentoo.org, johannes@erdfelt.com,
	p.zabel@pengutronix.de, christian.bruel@foss.st.com,
	thippeswamy.havalige@amd.com, krishna.chundru@oss.qualcomm.com,
	mayank.rana@oss.qualcomm.com, qiang.yu@oss.qualcomm.com,
	shradha.t@samsung.com, inochiama@gmail.com, guodong@riscstar.com,
	linux-pci@vger.kernel.org, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251030220259.1063792-1-elder@riscstar.com>
 <20251030220259.1063792-6-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030220259.1063792-6-elder@riscstar.com>
User-Agent: Mutt/2.2.13 (2024-03-09)

Hi Alex,

On 2025-10-30 17:02, Alex Elder wrote:
> +/* Disable ASPM L1 for now, until reported errors can be reproduced */

Thanks for adding this function.

> +static void k1_pcie_post_init(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	u8 offset;
> +	u32 val;
> +
> +	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +
> +	dw_pcie_dbi_ro_wr_en(pci);
> +
> +	/* Turn off ASPM L1 for the link */
> +	val = readl(pci->dbi_base + offset + PCI_EXP_LNKCAP);

Why not using dw_pcie_readl_dbi() instead?

> +	val &= ~PCI_EXP_LNKCAP_ASPM_L1;
> +	writel(val, pci->dbi_base + offset + PCI_EXP_LNKCAP);

And here dw_pcie_writel_dbi()?

> +
> +	dw_pcie_dbi_ro_wr_dis(pci);
> +}
> +
> +static void k1_pcie_deinit(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct k1_pcie *k1 = to_k1_pcie(pci);
> +
> +	/* Assert fundamental reset (drive PERST# low) */
> +	regmap_set_bits(k1->pmu, k1->pmu_off + PCIE_CLK_RESET_CONTROL,
> +			PCIE_RC_PERST);
> +
> +	phy_exit(k1->phy);
> +
> +	k1_pcie_disable_resources(k1);
> +}
> +
> +static const struct dw_pcie_host_ops k1_pcie_host_ops = {
> +	.init		= k1_pcie_init,
> +	.post_init	= k1_pcie_post_init,

Unfortunately, while I can see the effect of the change with for 
instance lspci -vvv, this happens way too late in the device scan 
process, i.e. after pcie_aspm_override_default_link_state() and causes 
L1 to still be enabled.

I have tried to move it earlier, in k1_pcie_init() after writing the 
vendor and device IDs. This works as long as "nvme scan" is run in 
U-Boot. But if I don't run this command, it seems that the change is 
ignored or lost (i.e. I can still see L1 enabled with lspci -vvv).

Moving it at the end of k1_pcie_init() works fine, like moving it at the 
beginning of k1_pcie_start_link(). But my knowledge is too limited to 
know where is the correct place.

Regards
Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net

