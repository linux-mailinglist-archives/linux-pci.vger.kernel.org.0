Return-Path: <linux-pci+bounces-37003-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1A3BA0A1E
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 18:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97E731C23250
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 16:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483E23064B8;
	Thu, 25 Sep 2025 16:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMX4sQGD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042D4302CA3;
	Thu, 25 Sep 2025 16:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758818177; cv=none; b=sF6lr3m0Xwhb4ulaUA5aoFOnUnWVBKMvqBvRJpW822PkSeYvJfIWm+Lx7szT/ZlE1elfueOu7Ijw3TUUZFuN15v3DFAX3LUFXwTM83TzoswUzdX/kBG96d5Kih3zBZYOOTEI05+6ktjkKgwF8P/eiCPjRCWtygl6x7eNDBFddLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758818177; c=relaxed/simple;
	bh=C9cSys9hAIrGC2z13rb2eIYG4WV7MuVdsAFwalT5/HQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dNfXyPmLz1opj6MX4pC+ZxLOBuhhD9EmP1hRXKnLbOenWoSp19L2yD6wc1vjjvDbeFR5cC9nWP8gNuK4MiUNNkWMmd9Hzap5GMcHhEBFq18wNNgJi9Ox/IgBvavPMM6/q3RSk7lTueeFSPOZSW1Cbvh91zsi9BL+OsdQHOXdfYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMX4sQGD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4458C4CEF0;
	Thu, 25 Sep 2025 16:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758818174;
	bh=C9cSys9hAIrGC2z13rb2eIYG4WV7MuVdsAFwalT5/HQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jMX4sQGDWPUW439xX8UUepzrFDkU5p1FsDwAS5mQibijisC1OWuvmkx0Ez6/u8gOv
	 XOcVDrWayHvRsNEV/3WORF9YYM706TlT6IGPbukQBEPonTsOHZPdmZffEh6hDDTWrh
	 8Ka+RtW2+T3k2vgodIeYahAHajhwweOsuScwHurKLmmoxRykFCndZ+nQc5/1eznl7/
	 laSiysO2kA5LURE36tUZmT5tT7gxX+wYBVpQF45rcapxw49pYj5t0gjYhP1ZytSuTQ
	 Tqhe17ox+sPrFrkpfisf5P0fpB7ladA1iWyVKs4v3mOQFP9oIGW7NBRawE3F+OQ/dH
	 qd1m8sU9goYgg==
From: Manivannan Sadhasivam <mani@kernel.org>
To: linux-pci@vger.kernel.org, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 linux-renesas-soc@vger.kernel.org
In-Reply-To: <20250915235910.47768-1-marek.vasut+renesas@mailbox.org>
References: <20250915235910.47768-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] PCI: rcar-gen4: Fix inverted break condition in PHY
 initialization
Message-Id: <175881817052.390261.13246190993626330141.b4-ty@kernel.org>
Date: Thu, 25 Sep 2025 22:06:10 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 16 Sep 2025 01:58:40 +0200, Marek Vasut wrote:
> R-Car V4H Reference Manual R19UH0186EJ0130 Rev.1.30 Apr. 21, 2025 page 4581
> Figure 104.3b Initial Setting of PCIEC(example), third quarter of the figure
> indicates that register 0xf8 should be polled until bit 18 becomes set to 1.
> 
> Register 0xf8 bit 18 is 0 immediately after write to PCIERSTCTRL1 and is set
> to 1 in less than 1 ms afterward. The current readl_poll_timeout() break
> condition is inverted and returns when register 0xf8 bit 18 is set to 0,
> which in most cases means immediately. In case CONFIG_DEBUG_LOCK_ALLOC=y ,
> the timing changes just enough for the first readl_poll_timeout() poll to
> already read register 0xf8 bit 18 as 1 and afterward never read register
> 0xf8 bit 18 as 0, which leads to timeout and failure to start the PCIe
> controller.
> 
> [...]

Applied, thanks!

[1/1] PCI: rcar-gen4: Fix inverted break condition in PHY initialization
      commit: d0bf8864a2fe2120a5da51e4bca3e11747a8e797

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


