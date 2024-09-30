Return-Path: <linux-pci+bounces-13664-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 550B698AD04
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2024 21:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF714B20CBC
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2024 19:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4A61991B1;
	Mon, 30 Sep 2024 19:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bj5fAJyX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD59198E84
	for <linux-pci@vger.kernel.org>; Mon, 30 Sep 2024 19:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727725078; cv=none; b=ioQf5Y1hgZEt1AI/RRUvBFjh+Toa07Dz5Cq1OFUNYycdWOq1RprHZhKzNm2ASu6jH54Y8NPLsDNjaRlvHSB4oD5Io5i3OoydpzkSpCL8+vp50NwEZzhwt1gtXks6yPgO77hqpLvhnVzxaMPybVBatiyrMQ2VbSLk4XDeeZjaKIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727725078; c=relaxed/simple;
	bh=bd1W1edyxyIMzyL2oVwBIlRMv4WpY7BdgJEv7EeGadU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=SBWzqvM787mWpxgzr8Zs1hHzVOXzUfRxsQKnLU2PsOU5LcCaF2/7RCZEwYS81/Aay3dK38Y+HfjTb3xchGH9Oj9GehW1V6wU8qvByuaqoOosc3b81UdsGVuz8YC646hUt2T9VWYvFdqzfkGitAWuLOQQ5wPDFAmN6iwoswvHKn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bj5fAJyX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA59C4CEC7;
	Mon, 30 Sep 2024 19:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727725078;
	bh=bd1W1edyxyIMzyL2oVwBIlRMv4WpY7BdgJEv7EeGadU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Bj5fAJyXTmlHX0a4DRvSQuSyLlHOQXv4RSMwtiCTmAKV4ifAt0Cy3jB3IVi5N7NqX
	 juZkVo9JxoiHBdA8ynQTQaiKOmZk+y9W3Bpm036nNJqIJOlt9ScFiRBblEUv62GkqX
	 60MhMh2HSYCoz3tT0MmMALx4gTBZjJg+/TTDfhcQA+2UKxMPf3m/HXJz8pynmwSSXK
	 8eglbwfrGxOHYOC7T/QfAtG5+e8+gEpeudcSExGwhGejwdojBWzuiY5gT70m63m6Kz
	 niXI0iq95UQxVnC7QOKBxAsBrOO1Do+P19DXKjDY9gCvH1hjSrOSeO+Z9IkwHyk+/G
	 294KSdkwmdVVA==
Date: Mon, 30 Sep 2024 14:37:56 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>, linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, upstream@airoha.com,
	Hui Ma <hui.ma@airoha.com>
Subject: Re: [PATCH] PCI: mediatek-gen3: Avoid PCIe resetting for Airoha
 EN7581 SoC
Message-ID: <20240930193756.GA187798@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8941149-9125-4fe2-a1c0-ab29223a0c87@collabora.com>

On Mon, Sep 23, 2024 at 11:41:41AM +0200, AngeloGioacchino Del Regno wrote:
> Il 20/09/24 10:26, Lorenzo Bianconi ha scritto:
> > The PCIe controller available on the EN7581 SoC does not support reset
> > via the following lines:
> > - PCIE_MAC_RSTB
> > - PCIE_PHY_RSTB
> > - PCIE_BRG_RSTB
> > - PCIE_PE_RSTB
> > 
> > Introduce the reset callback in order to avoid resetting the PCIe port
> > for Airoha EN7581 SoC.
> 
> EN7581 doesn't support pulling up/down PERST#?!  That looks
> definitely odd, as that signal is part of the PCI-Express CEM spec.
> 
> Besides, there's another PERST# assertion at
> mtk_pcie_suspend_noirq()...

I agree, it doesn't smell right that this SoC doesn't have a way to
assert PERST#.

The response at
https://lore.kernel.org/r/SG2PR03MB63415DB5791C58C7EA69FF01FF682@SG2PR03MB6341.apcprd03.prod.outlook.com
suggests that maybe there's a hardware defect that means asserting
PERST# doesn't work correctly?  But surely firmware must have a way of
asserting PERST#, at least at boot time.

If this is truly a hardware defect and we really can't assert PERST#,
please say that this is a defect in the commit log so people don't
think that lack of PERST# is an acceptable thing.

Bjorn

