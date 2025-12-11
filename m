Return-Path: <linux-pci+bounces-42966-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B990CB66C3
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 17:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F3543010982
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 16:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261AE303A3B;
	Thu, 11 Dec 2025 16:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CX4bUVA3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC72629BDB3;
	Thu, 11 Dec 2025 16:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765469274; cv=none; b=LUmw0DkexHzZKAwGE60fxMGBxdy56iRyavpOLGdtOh75v2OoREIg2hSr2S4ac3XifYiBS49VxN8mRN77DgoOlpohn9m0w12tqqQlwl3tysioxuMTorveAVuAuibQ08v3nmCBWktBHDNArcPu5/QGYtA7mc3gh34xNpJ75NuznYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765469274; c=relaxed/simple;
	bh=N98WoACJ/uJsQv2tfbWthp3jiUs/8Mi+M4KpGmdwZj0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uuOL2BMk0rQF5o9xtRqdLNKx/yLjujmIuDA6cZSjVezfzkBdYBn4cgxFyFOfHJU38s4Xpug3dIjt+DYess0jwVOQ54vq0/J3RrgvdSDRJuvGn5vVLY6MTGQB9l0u89/DryX46d8pz/fZqttGvQp7e/IlMRNEfZdEQQKldzbJetk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CX4bUVA3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B1DC4CEF7;
	Thu, 11 Dec 2025 16:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765469273;
	bh=N98WoACJ/uJsQv2tfbWthp3jiUs/8Mi+M4KpGmdwZj0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=CX4bUVA3WXyVGAWRazsLSLdsCOwj4rIjG0WnBbUdl1j8Y9UGIXcpQKVmu3gbJ3lqX
	 ZUfYU5qJMMrHQO1mGYUliAB0Af80G1z+5RkHOci76V/DcjfI4NGVQ1fZkLTsmY+AfG
	 gluV1gElqkKrXuU4DNJ84vcP2JgoyfpZcfgvJpMnTPhiUuYVi5WUy2InoR5ngXpvf1
	 dOkdXOTBoagUGyXVnwwZ2nre4vyzIbOzrC/Za5PibcVgC+QpSXMcKlU6UZ54LHtsZf
	 I3+f3Bf8DRVgB0FTK6yBBtJ9s4bTfD7zy/9l3Yu4j99tB5FcsnvmRAVkdDlNjg+wCw
	 B5xfin8/tPtkA==
Date: Thu, 11 Dec 2025 10:07:52 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: zhangsenchuan <zhangsenchuan@eswincomputing.com>
Cc: bhelgaas@google.com, mani@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
	robh@kernel.org, p.zabel@pengutronix.de, jingoohan1@gmail.com,
	gustavo.pimentel@synopsys.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	christian.bruel@foss.st.com, mayank.rana@oss.qualcomm.com,
	shradha.t@samsung.com, krishna.chundru@oss.qualcomm.com,
	thippeswamy.havalige@amd.com, inochiama@gmail.com, Frank.li@nxp.com,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com, ouyanghui@eswincomputing.com
Subject: Re: Re: [PATCH v7 2/3] PCI: eic7700: Add Eswin PCIe host controller
 driver
Message-ID: <20251211160752.GA3594705@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68c6494b.1244.19b0d4d2b8c.Coremail.zhangsenchuan@eswincomputing.com>

On Thu, Dec 11, 2025 at 08:05:19PM +0800, zhangsenchuan wrote:
> > -----Original Messages-----
> > From: "Bjorn Helgaas" <helgaas@kernel.org>
> > Send time:Thursday, 11/12/2025 00:43:27
> > To: zhangsenchuan@eswincomputing.com
> > Cc: bhelgaas@google.com, mani@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, p.zabel@pengutronix.de, jingoohan1@gmail.com, gustavo.pimentel@synopsys.com, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, christian.bruel@foss.st.com, mayank.rana@oss.qualcomm.com, shradha.t@samsung.com, krishna.chundru@oss.qualcomm.com, thippeswamy.havalige@amd.com, inochiama@gmail.com, Frank.li@nxp.com, ningyu@eswincomputing.com, linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com, ouyanghui@eswincomputing.com
> > Subject: Re: [PATCH v7 2/3] PCI: eic7700: Add Eswin PCIe host controller driver

Please avoid the pointless quote of all the headers (above) if you
can.  That just clutters the thread.  Also trim context that is not
relevant.  More hints here: https://subspace.kernel.org/etiquette.html

> > On Tue, Dec 02, 2025 at 05:04:06PM +0800, zhangsenchuan@eswincomputing.com wrote:
> > > From: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> > > 
> > > Add driver for the Eswin EIC7700 PCIe host controller, which is based on
> > > the DesignWare PCIe core, IP revision 5.96a. The PCIe Gen.3 controller
> > > supports a data rate of 8 GT/s and 4 channels, support INTx and MSI
> > > interrupts.

> > > +static int eic7700_pcie_probe(struct platform_device *pdev)
> > > ...
> > > +	pci->no_pme_handshake = pcie->data->no_pme_handshake;
> > 
> > This needs to go in the 3/3 "PCI: dwc: Add no_pme_handshake flag and
> > skip PME_Turn_Off broadcast" patch because "no_pme_handshake" doesn't
> > exist yet so this patch doesn't build by itself.
> 
> Do I need to adjust the order of the patches?
> 3/2 "PCI: dwc: Add no_pme_handshake flag and skip PME_Turn_Off broadcast"
> 3/3 "PCI: eic7700: Add Eswin PCIe host controller driver"
> 
> Or merge Patch 2/3 and Patch 3/3?

I think the best thing would be to leave dw_pcie_suspend_noirq() along
and implement eic7700_pcie_suspend_noirq() without calling it.

dw_pcie_suspend_noirq() is already problematic [1], and we don't need
more complication there.  Even without calling
dw_pcie_suspend_noirq(), your eic7700_pcie_suspend_noirq() will be
pretty simple.  Just add a comment about why you don't use
dw_pcie_suspend_noirq().

[1] https://lore.kernel.org/linux-pci/20251114213540.GA2335845@bhelgaas/

