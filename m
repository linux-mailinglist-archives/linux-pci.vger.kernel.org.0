Return-Path: <linux-pci+bounces-38247-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D190CBDFBFC
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 18:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3275C4F111D
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 16:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2D72C11D4;
	Wed, 15 Oct 2025 16:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTGKrP8k"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D551A253F14;
	Wed, 15 Oct 2025 16:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760547032; cv=none; b=DS45XVXanA6SuJs1y82BChHcPGVBwxIygELOHqU5/AsZG/9Chu2e1pb1QCaPylthVV/84GOSD1TWZshzGHF5Bi8Ze4OiWQlU8sui3jALr4m2QQlHGUCNGTVNtY9co+O2ZKx53mcAUdECDJsUKJEWeZf6i+oUuaaz7wTlru6gb2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760547032; c=relaxed/simple;
	bh=W2YQOFJDU6EhswCniAUJ6nsXXJo0OSK5lKR9QlTpx9k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=UzHtW4mJlbJyuPNgx3LP1gJ8kuxaVzI6yg04BOXbg1zVy13uBIJpShc/0bOQk/UtAI7LWG5E6WTzNSVMWugpHEshvjFjf+ObuiKbEFhoWG+5my5EbjIrdUGEyMAFH5h/+LMUBZ3NXL3t/wbfZasN9T054rqm3QOGKRoybKbKBfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTGKrP8k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4387EC4CEF8;
	Wed, 15 Oct 2025 16:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760547032;
	bh=W2YQOFJDU6EhswCniAUJ6nsXXJo0OSK5lKR9QlTpx9k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=PTGKrP8ky0N5uho9RLHOHr4AkzuExjInCzfCOMLJes6F57AaGEKso/qFxziYJJQfm
	 y7vTZ+2DTps+sz2qgFTHqP7NvhfBy+LYzi9Ee/JtV3sT6NkT2DrC5y7QB0/LE3zoZs
	 Jg7PgqnElY7Az2is6iEvCIMzvuflao6KO/IfVQt/svk3TiW7dQpAzrF2wpCya042Kr
	 zXPleFXO4ea43TDXqPZ1sub4OlvuZsUPX7f06wiGp9XeAS3lRC+IY8+XZP0Pnb6Gug
	 aeRbWnhaWNsk1k2NtYF+d6WuEjsK7vhEztDqIu5xYEk4iZ2ylhSz+OlfOuBlLmXSpP
	 okVgFisIOhv9g==
Date: Wed, 15 Oct 2025 11:50:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, upstream@airoha.com
Subject: Re: [PATCH v5 0/5] PCI: mediatek: add support AN7583 + YAML rework
Message-ID: <20251015165030.GA945420@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251012205900.5948-1-ansuelsmth@gmail.com>

On Sun, Oct 12, 2025 at 10:56:54PM +0200, Christian Marangi wrote:
> This little series convert the PCIe GEN2 Documentation to YAML schema
> and adds support for Airoha AN7583 GEN2 PCIe Controller.

> Christian Marangi (5):
>   ARM: dts: mediatek: drop wrong syscon hifsys compatible for
>     MT2701/7623
>   dt-bindings: PCI: mediatek: Convert to YAML schema
>   dt-bindings: PCI: mediatek: Add support for Airoha AN7583
>   PCI: mediatek: convert bool to single flags entry and bitmap
>   PCI: mediatek: add support for Airoha AN7583 SoC

If you repost,

s/convert bool/Convert bool/
s/add support/Add support/

to match the history (use "git log --oneline
drivers/pci/controller/pcie-mediatek.c" to see it).

