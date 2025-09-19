Return-Path: <linux-pci+bounces-36531-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B49B8AE86
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 20:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F65E16ED5D
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 18:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771FC25B31D;
	Fri, 19 Sep 2025 18:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pk7eWoom"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F7760B8A;
	Fri, 19 Sep 2025 18:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758306293; cv=none; b=d/gbNQnrTI55cFEBFXjmVPSTP34abIxguQAaMW5GbhiOSF0lDpdR0EEa3t2IlAsCFSmjACoPeljyi2sii6nLeIkOM4p1yR0Lx8zbw4mt7ESKmg/PRwfiSDaG9yqg8axBQbAl+AM3hcU3GYbEoWNoBFeGuhgKrjAVB48OrnyyYQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758306293; c=relaxed/simple;
	bh=1IVG3kWb+ICcP1ix8L0I8381OKaoshV+1ehyxxb90qI=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=i//BbN8IVHS6aZ69IY8ByXOQ5K2ord3gE65Np+ubCslwYJm62cRZ7UVZeU/QmgkedhQ7AgmTyLz+WK09oCaYoUAqJuaZmi1nHapeZeaY7DJhTussaepPyqOSnOhgLyfPL6CGxby2KeSqGQ3BwWdv/nP9fMliPTDqmGla2CECGmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pk7eWoom; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08A5EC4CEF7;
	Fri, 19 Sep 2025 18:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758306292;
	bh=1IVG3kWb+ICcP1ix8L0I8381OKaoshV+1ehyxxb90qI=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=Pk7eWoomJsWIx9HJ6D+Y6bg4qhA4bCOdOkCqIjVW9FyxhSyS2alujMBAzhHKQVgcD
	 bbgJl43wjtGflgVAwQbn6dJ/HhYuug/632sNIh1jOrApA56Xff3HZVCtesk57OqnV+
	 gR4ADg8CbPI231jRgHPSxaoDkaT8wK+s6oLXLM77Or06aNdj5AiVRQ6//tge4ML3Lg
	 P3eM1UvAVPyTMmgZaZolBKKmMINhHvhcIoxOKuUk/mutNKsqO54QIK7IFWHw1mhDs2
	 QozwvHCyIGiJmBHsQIf5OXgdAowSs/7hIfJCA+8UE0mYR2i27LYaOlgYbPdX7aHDQm
	 mFkpvoagxU6lA==
From: Manivannan Sadhasivam <mani@kernel.org>
To: kwilczynski@kernel.org, u.kleine-koenig@baylibre.com, 
 aou@eecs.berkeley.edu, alex@ghiti.fr, arnd@arndb.de, bwawrzyn@cisco.com, 
 bhelgaas@google.com, unicorn_wang@outlook.com, conor+dt@kernel.org, 
 18255117159@163.com, inochiama@gmail.com, kishon@kernel.org, 
 krzk+dt@kernel.org, lpieralisi@kernel.org, palmer@dabbelt.com, 
 paul.walmsley@sifive.com, robh@kernel.org, s-vadapalli@ti.com, 
 tglx@linutronix.de, thomas.richard@bootlin.com, sycamoremoon376@gmail.com, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org, 
 sophgo@lists.linux.dev, rabenda.cn@gmail.com, chao.wei@sophgo.com, 
 xiaoguang.xing@sophgo.com, fengchun.li@sophgo.com, jeffbai@aosc.io, 
 Chen Wang <unicornxw@gmail.com>
In-Reply-To: <cover.1757643388.git.unicorn_wang@outlook.com>
References: <cover.1757643388.git.unicorn_wang@outlook.com>
Subject: Re: (subset) [PATCH v3 0/7] Add PCIe support to Sophgo SG2042 SoC
Message-Id: <175830628258.24420.13208135130254060127.b4-ty@kernel.org>
Date: Fri, 19 Sep 2025 23:54:42 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 12 Sep 2025 10:35:10 +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> Sophgo's SG2042 SoC uses Cadence PCIe core to implement RC mode.
> 
> This is a completely rewritten PCIe driver for SG2042. It inherits
> some previously submitted patch codes (not merged into the upstream
> mainline), but the biggest difference is that the support for
> compatibility with old 32-bit PCIe devices has been removed in this
> new version. This is because after discussing with community users,
> we felt that there was not much demand for support for old devices,
> so we made a new design based on the simplified design and practical
> needs. If someone really needs to play with old devices, we can provide
> them with some necessary hack patches in the downstream repository.
> 
> [...]

Applied, thanks!

[1/7] dt-bindings: pci: Add Sophgo SG2042 PCIe host
      commit: 4e4a4f58bed19e1a3a5a7c3a18ce3b927b76fcd3
[2/7] PCI: cadence: Check pcie-ops before using it
      commit: 49a6c160ad4812476f8ae1a8f4ed6d15adfa6c09
[3/7] PCI: sg2042: Add Sophgo SG2042 PCIe driver
      commit: 1c72774df028429836eec3394212f2921bb830fc

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


