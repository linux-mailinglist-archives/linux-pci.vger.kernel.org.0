Return-Path: <linux-pci+bounces-32286-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8E3B07AA2
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 18:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDB9F169B21
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 16:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1452F5326;
	Wed, 16 Jul 2025 16:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+4LYtbo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73062F5320;
	Wed, 16 Jul 2025 16:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752681952; cv=none; b=LMRb4iB1uu1JtM0Iou2cuZymQlz6kPsnas6eSXp6pSgSNrZQZ2emy/rhY7CVXZTdtv20qUk1slzYOVVosN3AR2/oyZv7aWAPNRMl7jvlbbSzHg5mn7Il9cizln+eXxG9QC+GBLFPGlkqbJOZ3kBHrYtvLL0GedKtGesy5bdHJzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752681952; c=relaxed/simple;
	bh=/MhihUW++EwBOy0UJ+JK83L22f2nuhBC2KGtBROWzo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uk6GyAV3wTtqIpkfs8tyRuHBgxlyAVRGQyWQGC7wzV8Oo0rC2gcM8qMLeKHIuB+3gDuWcy9UC1qFLOs3MS+Kjyy8//FvR6IIf//ThEVW2zh8nF52dr/o+dlOxRmhKUFDmuHSh1Vywd8yp3jCiaxyVT8MH+df8s0MOpuJp81heiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+4LYtbo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A99C4CEE7;
	Wed, 16 Jul 2025 16:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752681951;
	bh=/MhihUW++EwBOy0UJ+JK83L22f2nuhBC2KGtBROWzo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C+4LYtboaTdQ4jjBRMX/cM0Bh5j4l7TvmN4D5Kakd6YwOJJvFF9CWrzC1GcOIJID7
	 7eVpEfm+T0gI1TYuwhetgR6q7QgXOodjLHiVhm2ROdKTF/nlffMR/qkvv580FxbzrO
	 0+P0vfxYhsN/GTG7bT3GRs7znvJjpffJClTTCaFcUMqTemKGIJsRi3IQVKXN+jJkRr
	 I+Rixb6dDuB9qFai0pdQlWM2DnIVmpuO4/qSi3h1qdtejz4NayGii4ZiZmKb+/XDSg
	 8GoWn80sWKUTRAOwVAep06KQt7JPZEYEAPHc1Hb2BRvyiHMqug8cHWhW7WyVzTwDWE
	 1cJ04enwQ/btw==
Date: Wed, 16 Jul 2025 21:35:38 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Frank Li <Frank.li@nxp.com>, Bjorn Helgaas <helgaas@kernel.org>, 
	Minghuan Lian <minghuan.Lian@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>, 
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Rob Herring <robh+dt@kernel.org>, imx@lists.linux.dev, 
	linux-pci@vger.kernel.org
Subject: Re: Does dwc/pci-layerscape.c support AER?
Message-ID: <vatnozecxmzh5bwrapkjcucnfusjz7ugpx2upbwihoioxbf2ko@ydwd65l4peju>
References: <20250702223841.GA1905230@bhelgaas>
 <aGW8NnHUlfv1NO3g@lizhi-Precision-Tower-5810>
 <aGXEcHTfT2k2ayAj@google.com>
 <tikcdb63ti6hbpypusxdiaoattpuez5rgpsglzllagnqfm5voa@5eornv77pl4i>
 <aHfDRm2S8N8Qus_m@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aHfDRm2S8N8Qus_m@google.com>

On Wed, Jul 16, 2025 at 08:20:38AM GMT, Brian Norris wrote:
> On Wed, Jul 16, 2025 at 12:47:10PM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Jul 02, 2025 at 04:44:48PM GMT, Brian Norris wrote:
> > > On Wed, Jul 02, 2025 at 07:09:42PM -0400, Frank Li wrote:
> > > OTOH, I do also believe there are SoCs where DWC PCIe is available, but
> > > there is no external MSI controller, and so that same problem still may
> > > exist. I may even have such SoCs available...
> > > 
> > 
> > Yes, pretty much all Qcom SoCs without GIC-v3 ITS suffer from this limitation.
> > And the same should be true for other vendors also.
> > 
> > Interestingly, the Qcom SoCs route the AER/PME via 'global' SPI interrupt, which
> > is only handled by the controller driver. This is similar to the 'aer' SPI
> > interrupt in layerscape platforms.
> 
> Yeah, I have some SoCs like this as well. But I also believe that I have
> INTx available, and that even when MSI doesn't work for AER/PME, INTx
> might.
> 
> Do Qcom SoCs route INTx?
> 

Yes, they do. But currently, we can only use it by booting with pcie_pme=nomsi
cmdline parameter.

> > So I think there is an incentive in allowing the AER driver to work with vendor
> > specific IRQs.
> 
> Yeah, I suppose even if my SoC (and Qcom, depending on the above answer)
> might work with INTx, it really does seem like an arbitrary decision
> about what SoC makers connected which DWC signals, so I suspect this is
> true.
> 

Maybe we should be able to extend the dmi quirk in portdrv.c to allow Root Ports
or host bridge to use INT-X instead of forcing them to use cmdline params.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

