Return-Path: <linux-pci+bounces-37019-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC38BA1216
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 21:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E959119C2A55
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 19:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA02288C2A;
	Thu, 25 Sep 2025 19:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LcD8AaqX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B757C1DA23;
	Thu, 25 Sep 2025 19:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758827722; cv=none; b=C1xBomLiZFkmayiIM6auYofh5PW2jbgs90BCop+ZP0/9/9wUep1obZOjucJRtlpvPHtqrPZhXfJ30zJ3NIEPKiylQEw7e1GcrGRzo/+drg2ZAxnxU6qYy09tniNimw9rlEFyooy6fJtTkmAg/0dM0/okdQmwWCqerr3iU6mlA9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758827722; c=relaxed/simple;
	bh=7MCu9WAn1XhTifdzDhG1kliHkb7fivInIPRnmRZyBcI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=EB4GYqqkwTz2tPNzfkI4EnTYIngfQL8EujMGbvknIz28aCwEJoicwLyC/zZACxMORcATbN6aG6i2stxPJx3bMlcQ1OcQZWhMlhuMJKZzHJllKTpDsEM/RbAEbAM0uJhVp+DSfInmIn4OHmAuP2Avrk9/rSK/CPR5vRDl8FKf3Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LcD8AaqX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C103DC4CEF0;
	Thu, 25 Sep 2025 19:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758827722;
	bh=7MCu9WAn1XhTifdzDhG1kliHkb7fivInIPRnmRZyBcI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=LcD8AaqXB/BQZIvkaRLcXzSCaP3SbfWtQadWYo5Amvi8SAxPZKOlNHJYI2RX/kRTl
	 YH8388EkQAd1KOQFD3vaVuso5ricLSBDYfBApSyfBg0doQNULBFHA0fjCrpJEIVx66
	 9xVzPhP0//4EETfvnP7/Pyy/wK7LGEQT4jrJZ/UBI+81zCV/7hlT0s8dfQnH8O2wh9
	 QS6JDsQXkw4fMJVjy1jnqK2ltXMSMEElAxzFidZhzaK1J4qm+7U3LKPyq0qBAsqlmc
	 /BbcSA/ESWpoKcrBnD3zlyktSnBV52expi0auAW4Gxbcrpu9ICd0drRFNqejZHOvOr
	 Ahna0RK7Sf37Q==
Date: Thu, 25 Sep 2025 14:15:20 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, chester62515@gmail.com,
	mbrugger@suse.com, ghennadi.procopciuc@oss.nxp.com, s32@nxp.com,
	bhelgaas@google.com, jingoohan1@gmail.com, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, Ionut.Vicovan@nxp.com, larisa.grigore@nxp.com,
	Ghennadi.Procopciuc@nxp.com, ciprianmarian.costea@nxp.com,
	bogdan.hamciuc@nxp.com, Frank.li@nxp.com,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, cassel@kernel.org
Subject: Re: [PATCH 2/3 v2] PCI: s32g: Add initial PCIe support (RC)
Message-ID: <20250925191520.GA2175949@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqJMibSgsEFeUvHswVy6zsHMn7ZXkpbhch06oQxPY9NocQ@mail.gmail.com>

On Mon, Sep 22, 2025 at 09:52:21AM -0500, Rob Herring wrote:
> On Fri, Sep 19, 2025 at 10:58 AM Vincent Guittot
> > Add initial support of the PCIe controller for S32G Soc family. Only
> > host mode is supported.

> > +++ b/drivers/pci/controller/dwc/Kconfig
> > @@ -255,6 +255,17 @@ config PCIE_TEGRA194_EP
> >           in order to enable device-specific features PCIE_TEGRA194_EP must be
> >           selected. This uses the DesignWare core.
> >
> > +config PCIE_S32G
> > +       bool "NXP S32G PCIe controller (host mode)"
> > +       depends on ARCH_S32 || (OF && COMPILE_TEST)
> 
> Why the OF dependency? All the DT API should be available with !CONFIG_OF.

We have lots of similar OF dependencies.  Do we really want it to be
possible to build a non-working driver in the !COMPILE_TEST case?

Maybe we should retain the OF dependency but only for !COMPILE_TEST,
like this:

  config PCIE_S32G
         depends on (ARCH_S32 && OF) || COMPILE_TEST

