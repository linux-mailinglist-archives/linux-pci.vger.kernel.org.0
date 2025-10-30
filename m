Return-Path: <linux-pci+bounces-39863-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD226C2288A
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 23:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB7ED3A3E4F
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 22:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB7720C00C;
	Thu, 30 Oct 2025 22:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="okzWpxog"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8E417AE11;
	Thu, 30 Oct 2025 22:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761862614; cv=none; b=Wu1SBb7f3/EkfdsRmCtB1h02SqcO1339zokyQtPuwFKCByhB4UBN916XIqVVfeN8mPDqye4KaLsArzjQwXAUoBNnv7urof8p5kRu2z+PCHe5p0XOnFk1yEeVkQXmKr99oO3tbgOFFwkcrm+DxRMrZAXSnL2aNh+mREcCQKEaiB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761862614; c=relaxed/simple;
	bh=glCVcGLFQBSKyyJFybiUkySADmiDy0gRrrAwvlbTnMg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=XWwoGR+FxmjRSg5JD2VC+mjNDZVvRw8FMxNgCbBEzUhnSfvAW2LQtjkEAV75xlYJ13sGIuagjvVFS30s/ITI2uKncDZWKdsGXT2ogdDhEnSr66Tuv2mz1EI+i9TrWVL+f7IM8BebMPMcjVUzxyIJmLTLcRr5YWiPxAvuirRH9HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=okzWpxog; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE7DC4CEF1;
	Thu, 30 Oct 2025 22:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761862613;
	bh=glCVcGLFQBSKyyJFybiUkySADmiDy0gRrrAwvlbTnMg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=okzWpxognmzGxUeKMCV3D5M+5y0UPIAQr4u1VIetxBnKOm+Kuid3m0INohpKiTiX8
	 RwFFDBiYcClrZUQW+8XSMloGKRVbA1V7vzYPE8Oq0J3AECkw1OuxSuR8VMKR1re1Go
	 uJ6gMAwewgum5uMgftfDhImoREG0stcfJEb3Wck50LxidzXcAZ6GVvZTFa/hA8o0/k
	 1ZyGcopQ+BOb4zoPDoOyOJ5aq9Lr1bxHBshOnDdJhcjuhduJ8g+IYQ1M5wBcKzUlOl
	 1kw8iz6EX2fh2/tBqsT6vhCarfKF6Z4d4sUiZNrF0a3/8dinTuLAqZvvm+RlMWVHjT
	 PH9skftx3wcDg==
Date: Thu, 30 Oct 2025 17:16:51 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: FUKAUMI Naoki <naoki@radxa.com>
Cc: manivannan.sadhasivam@oss.qualcomm.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	"David E. Box" <david.e.box@linux.intel.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Chia-Lin Kao <acelan.kao@canonical.com>,
	Dragan Simic <dsimic@manjaro.org>,
	linux-rockchip@lists.infradead.org, regressions@lists.linux.dev
Subject: Re: [PATCH v2 1/2] PCI/ASPM: Override the ASPM and Clock PM states
 set by BIOS for devicetree platforms
Message-ID: <20251030221651.GA1656577@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030221404.GA1656495@bhelgaas>

On Thu, Oct 30, 2025 at 05:14:05PM -0500, Bjorn Helgaas wrote:
> On Tue, Oct 14, 2025 at 01:49:05PM -0500, Bjorn Helgaas wrote:

> > #regzbot introduced: f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree platforms")
> > #regzbot dup-of: https://github.com/chzigotzky/kernels/issues/17
> 
> #regzbot report: https://lore.kernel.org/r/22594781424C5C98+22cb5d61-19b1-4353-9818-3bb2b311da0b@radxa.com

Sorry for the noise; I'm trying to figure out how to use regzbot and
making lots of mistakes.

#regzbot fix: df5192d9bb0e

df5192d9bb0e ("PCI/ASPM: Enable only L0s and L1 for devicetree platforms")

