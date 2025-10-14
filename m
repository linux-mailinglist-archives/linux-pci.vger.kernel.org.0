Return-Path: <linux-pci+bounces-38041-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB0EBD918C
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 13:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 39B2C4FA7FF
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 11:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903E530E849;
	Tue, 14 Oct 2025 11:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pVxqN0wP"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D462FD1A1;
	Tue, 14 Oct 2025 11:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760442456; cv=none; b=n6KGrKVJCfzGKZ3ucBOrkWddqJE+VLvE69xqQt/UbdRukGoNxp8o6BFwYijPomBwZTeS9O0garRd/leSyLKUmvksNdeYhp7MBVz7i637zwYnt1OGvk+pWmsZTCAvZoYh8g/8I4VNfzFfOHksXe0DEzzQ+icZK1GTyKFj2aqej7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760442456; c=relaxed/simple;
	bh=V9yoqwxESdZwxltRllnlJkbdQXUNmo1TpE4ddW0bRYo=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LpKlUJjLm+dqucO8ho0sXViEmPmHPfNENo5i1pCh0MWMuY42JPGsVsW8l9f40axDeGV7tkHvKG2Q9fK1BUtEAMSpgBjdgTqjwifA1umzexvRoYUl+PDaeds1ywd79HMDHDokL9J1PlhMw30wMDaKkG2c4E/P6RMBDeKPPryCz2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pVxqN0wP; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760442452;
	bh=V9yoqwxESdZwxltRllnlJkbdQXUNmo1TpE4ddW0bRYo=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=pVxqN0wPKBKaeJhkbaLkohXFCzia/ZgKznHPt9ULdyZ0+kDJSbe65XnV1f260+orS
	 BC6ZKkJYG/M+dqwRVWiVnerOm2HZIYw5PSi0JIZGO01FUfTd8mPhrgCeWtjxSHwnuT
	 RoYVrZbfJ46dEwddj1r/ryHtiMiZA0nHZd2kAIxOyldoahBy9jUu9A3vB7VqkwBjwr
	 pdwLsI06AwXoCcNMW2gkxXQ65IVj/cK7Eq1o1LR3IjutCebOV5Jodg7TXcBjGZmuIp
	 SnwShRldBluFHmBSUjVrv7zNItDL4qYq6IQK3kn3HG+tIqpcxTV3D5LtUQS9dV0Ur7
	 62vyaIO71vA0w==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3254417E013C;
	Tue, 14 Oct 2025 13:47:32 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Ryder Lee <ryder.lee@mediatek.com>, 
 Jianjun Wang <jianjun.wang@mediatek.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, linux-pci@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 upstream@airoha.com, Christian Marangi <ansuelsmth@gmail.com>
In-Reply-To: <20251012205900.5948-1-ansuelsmth@gmail.com>
References: <20251012205900.5948-1-ansuelsmth@gmail.com>
Subject: Re: (subset) [PATCH v5 0/5] PCI: mediatek: add support AN7583 +
 YAML rework
Message-Id: <176044245213.17852.7184723529222407322.b4-ty@collabora.com>
Date: Tue, 14 Oct 2025 13:47:32 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Sun, 12 Oct 2025 22:56:54 +0200, Christian Marangi wrote:
> This little series convert the PCIe GEN2 Documentation to YAML schema
> and adds support for Airoha AN7583 GEN2 PCIe Controller.
> 
> Changes v5:
> - Drop redudant entry from AN7583 patch
> - Fix YAML error for AN7583 patch (sorry)
> Changes v4:
> - Additional fix/improvement for YAML conversion
> - Add review tag
> - Fix wording on hifsys patch
> - Rework PCI driver to flags and improve PBus logic
> Changes v3:
> - Rework patch 1 to drop syscon compatible
> Changes v2:
> - Add cover letter
> - Describe skip_pcie_rstb variable
> - Fix hifsys schema (missing syscon)
> - Address comments on the YAML schema for PCIe GEN2
> - Keep alphabetical order for AN7583
> 
> [...]

Applied to v6.18-next/dts32, thanks!

[1/5] ARM: dts: mediatek: drop wrong syscon hifsys compatible for MT2701/7623
      commit: 5416aeee4ef761b79d2e1c35f6d9a35bf3104709

Cheers,
Angelo



