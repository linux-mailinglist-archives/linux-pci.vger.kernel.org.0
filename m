Return-Path: <linux-pci+bounces-516-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9383F805AA2
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 18:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54384281B43
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 17:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A161363DF8;
	Tue,  5 Dec 2023 17:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rrYEZ6mD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AB563DDB;
	Tue,  5 Dec 2023 17:02:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE16FC433C7;
	Tue,  5 Dec 2023 17:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701795740;
	bh=6eqzdlbd2wRbilXyM8br8k9jCk9NPFOASbrV1lTKof0=;
	h=Date:From:To:Subject:In-Reply-To:From;
	b=rrYEZ6mDeh47zil4efVVC3txYOSi3rtzc6BqQyBLELxK0D/OYbcop4/aMyi9qyW/f
	 8jxcOmxzxRzfvPxNByuPLgS/aZI8iJ7htUrK96g5D6/KFghAQTzPvMuAZaC0/E8RK+
	 I+bWsBKRNSQMZjLsUPpE4C8b+/FE38MZ6Jn9GaOBN5UvMt0qMIVarFGu/pQNUjIF+B
	 S4vlHyGARZ1IssLp0lh2IAZVHWHG8VhcQwlSjBucgsUhWjWrre/J6zG6A+2RGPwCoK
	 EHBa1CSNYQnFrXoZ/gtIChK7DVQBBFQiQKGJVn64K5xD7y78QFCWZjsl2OeozApwgS
	 qVGFWeFfjIScg==
Date: Tue, 5 Dec 2023 11:02:18 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Minda Chen <minda.chen@starfivetech.com>,
	Conor Dooley <conor@kernel.org>,
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
Message-ID: <20231205170218.GA679691@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZW7q1LEvEpVxoI4l@fedora>

On Tue, Dec 05, 2023 at 10:18:12AM +0100, Damian Tometzki wrote:
> > On Sat, Dec 02, 2023 at 09:17:24PM +0800, Minda Chen wrote:
> > > ...
> > > Please check this configuation.
> > > CONFIG_PHY_STARFIVE_JH7110_PCIE=y
> > > CONFIG_PINCTRL_STARFIVE_JH7110=y
> > > CONFIG_PINCTRL_STARFIVE_JH7110_SYS=y
> > > CONFIG_PINCTRL_STARFIVE_JH7110_AON=y
> ...

> Hello together,
> the main problemwas was  to find the rquired CONFIG_* options for StarFive
> Board. It would be great to have an CONFIG_ Options with all required
> Dependencies.

I didn't follow all the discussion here so I don't know all the
symptoms and what the resulting working config was, but it sounds like
the Kconfig needs to be simplified somehow so other users don't have
to repeat this struggle.

Bjorn

