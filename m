Return-Path: <linux-pci+bounces-41208-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF0EC5B64D
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 06:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 476F4355C7C
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 05:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CE92C2343;
	Fri, 14 Nov 2025 05:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="lI0dcTUf"
X-Original-To: linux-pci@vger.kernel.org
Received: from hall.aurel32.net (hall.aurel32.net [195.154.119.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A6D29DB6C;
	Fri, 14 Nov 2025 05:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.119.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763098496; cv=none; b=d3ZH60srHt+J1fBrO4nuJaVZXPl5NfvImxGJPX2Qmk+OKz5D/FTkNVBcP+41reAjcZu/OG8BPk9FmAOVnBfCrWB1JSjonr88k2bwL3uiSU6GcicSSdBVnCv/a4YP0UQGqgzm+BFrg8D+wbcFy9+PYRrdwZHubmc7hz9Lhy7AGuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763098496; c=relaxed/simple;
	bh=8mimKyEX68od4d10NlzqRF1O4O4nn2d7AoWzVT2MAxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7nxhrdiMfh5wH5cUkIkA1atBXnHH/IwtQZqMyImF3DGPsMgfQXK/vfE/2oLvlfDMol0r6D1zjinPqDP2odPOefLb1TNhnWuo3C+1tg6EaTFU3P4pOHpBIJ2h3X329wkjjOMBKTBRgHpj6c2ALTY7UIfr2yTPRhTAxABleLJnwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=lI0dcTUf; arc=none smtp.client-ip=195.154.119.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=j4/5GhlPjkb3zB4cmvsOflk7TfcTfmyfgTcfGeeRs10=; b=lI0dcTUfaAd8Slc7QsDEWoAZ6g
	Dlbl/u69jN6L0rlAQEnPt3zmA+rPZJ2Oj9wHFnprNkxA0/35otRGnCHgmFd8bwaXQd/iMX1tM0F4O
	hY7u9kxZterFev5cVc4Kw1flPzGBaTW0rB8a8dFJPE5KxQ0IhlO/MOjuCJLC23b4ZE+19NQIMAWlN
	CoS6FCWXjCV1enVK7lF0PK2ObdthRAX8Tyx65swkDZeRxzMy1wXHlFJ6S33tsuTH0VR53TScD4MQ0
	y73EpBaooHgcCSginztVmBrpwUG+2pPUim9YBUXdVXGX2OB2OKNQZJ4rLwAkgtFUfy4aksVDZA6s7
	tLR97Kkw==;
Received: from [2a01:e34:ec5d:a741:1ee1:92ff:feb4:5ec0] (helo=ohm.rr44.fr)
	by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <aurelien@aurel32.net>)
	id 1vJmSA-00000003JgB-1aXy;
	Fri, 14 Nov 2025 06:34:34 +0100
Date: Fri, 14 Nov 2025 06:34:33 +0100
From: Aurelien Jarno <aurelien@aurel32.net>
To: Alex Elder <elder@riscstar.com>
Cc: dlan@gentoo.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, vkoul@kernel.org, kishon@kernel.org,
	bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, ziyao@disroot.org, johannes@erdfelt.com,
	mayank.rana@oss.qualcomm.com, qiang.yu@oss.qualcomm.com,
	shradha.t@samsung.com, inochiama@gmail.com, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	p.zabel@pengutronix.de, christian.bruel@foss.st.com,
	thippeswamy.havalige@amd.com, krishna.chundru@oss.qualcomm.com,
	guodong@riscstar.com, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
	spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/7] Introduce SpacemiT K1 PCIe phy and host controller
Message-ID: <aRa_aQB4d8-miKac@aurel32.net>
Mail-Followup-To: Alex Elder <elder@riscstar.com>, dlan@gentoo.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	vkoul@kernel.org, kishon@kernel.org, bhelgaas@google.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	ziyao@disroot.org, johannes@erdfelt.com,
	mayank.rana@oss.qualcomm.com, qiang.yu@oss.qualcomm.com,
	shradha.t@samsung.com, inochiama@gmail.com, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	p.zabel@pengutronix.de, christian.bruel@foss.st.com,
	thippeswamy.havalige@amd.com, krishna.chundru@oss.qualcomm.com,
	guodong@riscstar.com, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
	spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
References: <20251113214540.2623070-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113214540.2623070-1-elder@riscstar.com>
User-Agent: Mutt/2.2.13 (2024-03-09)

On 2025-11-13 15:45, Alex Elder wrote:
> This series introduces a PHY driver and a PCIe driver to support PCIe
> on the SpacemiT K1 SoC.  The PCIe implementation is derived from a
> Synopsys DesignWare PCIe IP.  The PHY driver supports one combination
> PCIe/USB PHY as well as two PCIe-only PHYs.  The combo PHY port uses
> one PCIe lane, and the other two ports each have two lanes.  All PCIe
> ports operate at 5 GT/second.
> 
> The PCIe PHYs must be configured using a value that can only be
> determined using the combo PHY, operating in PCIe mode.  To allow
> that PHY to be used for USB, the needed calibration step is performed
> by the PHY driver automatically at probe time.  Once this step is done,
> the PHY can be used for either PCIe or USB.
> 
> The driver supports 256 MSIs, and initially does not support PCI INTx
> interrupts.  The hardware does not support MSI-X.
> 
> Version 6 of this series addresses a few comments from Christophe
> Jaillet, and improves a workaround that disables ASPM L1.  The two
> people who had reported errors on earlier versions of this code have
> confirmed their NVMe devices now work when configured with the default
> RISC-V kernel configuration.

Thanks for this new version. I confirm it works fine on the various NVME 
devices for which I reported issues with the previous versions of this 
patchset.

Tested-by: Aurelien Jarno <aurelien@aurel32.net>

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net

