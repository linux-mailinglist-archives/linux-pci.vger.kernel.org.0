Return-Path: <linux-pci+bounces-437-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEA48040F9
	for <lists+linux-pci@lfdr.de>; Mon,  4 Dec 2023 22:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70373281280
	for <lists+linux-pci@lfdr.de>; Mon,  4 Dec 2023 21:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E45937170;
	Mon,  4 Dec 2023 21:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/J7lopG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC2A364CC;
	Mon,  4 Dec 2023 21:28:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F5AC433C8;
	Mon,  4 Dec 2023 21:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701725289;
	bh=GrS6re0Pnw+uBm1V2qdt1ie4VrYb1sT11XMmUaB1pJo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=H/J7lopGl2zOh80yIab32Hw2C21PBA9XV4prHzPUMF1TwgbcoRR2/AMyokVQ/WhhK
	 +Sz1zOkMRXEtMdG3piW0ZaK77Iew3pWvoZAuQn7G/0yxh9I1t/Y7VqLWSeQEgcN8mQ
	 TaHqdg5/yqMAVWNdBGgK9jX98z2cmqTVCR/qUEM6PYLhPC67HaLL2I4OAk3mSajXIi
	 7ymuNm1HL5nquwdwPfvJHdckLcZZlJ6VYgompaD+aM/PU79N2QdRRIDSPxZc4um7s9
	 K/GvYgYEAOfjFuk/ndFVC8h7ULdXR7jrH8RNexCSfMHtQNm2XJGa3HYlHneNsTtvaH
	 2Le+5VdZDX1Ig==
Date: Mon, 4 Dec 2023 15:28:07 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Conor Dooley <conor@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Mason Huo <mason.huo@starfivetech.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Kevin Xie <kevin.xie@starfivetech.com>
Subject: Re: [PATCH v11 0/20] Refactoring Microchip PCIe driver and add
 StarFive PCIe
Message-ID: <20231204212807.GA629695@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4154501-5b93-4eaf-8d2d-690809d26c57@starfivetech.com>

On Sat, Dec 02, 2023 at 09:17:24PM +0800, Minda Chen wrote:
> ...
> Please check this configuation.
> CONFIG_PHY_STARFIVE_JH7110_PCIE=y
> CONFIG_PINCTRL_STARFIVE_JH7110=y
> CONFIG_PINCTRL_STARFIVE_JH7110_SYS=y
> CONFIG_PINCTRL_STARFIVE_JH7110_AON=y
> 
> BTW, Maybe you can reply e-mail to me only.

There's usually no benefit to replying off-list.  The list archives
are very valuable for future maintenance because they help us
understand the reason things were done a certain way.

Bjorn

