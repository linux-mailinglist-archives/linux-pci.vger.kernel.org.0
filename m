Return-Path: <linux-pci+bounces-19479-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09488A04D2B
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 00:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1039B7A27B2
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 23:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7660C1E47A6;
	Tue,  7 Jan 2025 23:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lbv4lvYy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B26E1A83E1;
	Tue,  7 Jan 2025 23:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736291264; cv=none; b=O6kXvaqMt4wKPyvhcQHG1Y9BDZ59yWabkgs+QZhYReftofsgRTAXwy0Irj7ELleSDBdjX6O3b4hO62iVgNuo/TrO92y1JHCqYxgHlSEJFzVC3CVn8sFlNyAJojGO6lFnEaVMwjWzZwAa8ED/3voSnbrjBPcMVsHahHqpPBX/If4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736291264; c=relaxed/simple;
	bh=qCOsJ/wKHOi3SAkDBRYfIUDYbFC/ozgvyeH4knr/FXA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qtT/qwq4XH3XxRwzbMkwAk2tmVSGqdRK/MVISVA54utImG5rd9HxRZLMo32ahHLb5kmikDXceU64aDZKTRhUOJoFojw4dLuqMjnosX1+1Xk5i7eSvq4bO1SXBUDOfs+HNC2CBVwHZ7XGttTx4qnbUZX5ClMOjiY3Clb6fjTIc+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lbv4lvYy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99020C4CEDF;
	Tue,  7 Jan 2025 23:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736291263;
	bh=qCOsJ/wKHOi3SAkDBRYfIUDYbFC/ozgvyeH4knr/FXA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Lbv4lvYyU3hdnUYszWRuxX22YRUZGI6KXGwtAZ0QayGT7PHOTKKa0IPoqG2EmSchl
	 3Pk0IAVh3ynu5a8qsvbVQP++4PaPE443CgJi9TVTTWGQzlKlrGgvo4osLY/vyk+2Ae
	 s5krWEJBDP+TCUCS1YTlph1APAIQQ61PXi4BCdyPtzWJzAvC2Uta6zK6MzxXxwCr6C
	 EAPGePwBBXgrMCetp9aLHjjMHQgqLXnt1AGjcrr9nInknI5OvElB86o160HIRO2cA/
	 Tngd46xXYTVXCCH2EcaYrvWGXqVztxxk+xxl5jSodUU/D0RvS8VeWoGF49vYkMeQVg
	 1mvrlRa1FVllA==
Date: Tue, 7 Jan 2025 17:07:42 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Jianjun Wang =?utf-8?B?KOeOi+W7uuWGmyk=?= <Jianjun.Wang@mediatek.com>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	Ryder Lee <Ryder.Lee@mediatek.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Xavier Chang =?utf-8?B?KOW8teeNu+aWhyk=?= <Xavier.Chang@mediatek.com>
Subject: Re: [PATCH 3/5] PCI: mediatek-gen3: Disable ASPM L0s
Message-ID: <20250107230742.GA189563@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1a48feae-f55f-4df8-b165-84c1cb2f6658@collabora.com>

On Tue, Jan 07, 2025 at 12:44:43PM +0100, AngeloGioacchino Del Regno wrote:
> Il 07/01/25 03:18, Jianjun Wang (王建军) ha scritto:
> > On Fri, 2025-01-03 at 10:16 +0100, AngeloGioacchino Del Regno wrote:
> > > Il 03/01/25 07:00, Jianjun Wang ha scritto:
> > > > Disable ASPM L0s support because it does not significantly save
> > > > power
> > > > but impacts performance.
> > > 
> > > That may be a good idea but, without numbers to support your
> > > statement, it's a bit
> > > difficult to say.
> > > 
> > > How much power does ASPM L0s save on MediaTek SoCs, in microwatts?
> > > How is the performance impacted, and on which specific device(s) on
> > > the PCIe bus?
> > 
> > It's hard to tell the exact number because it is difficult to measure,
> > and the number of entries into the L0s state may vary even in the same
> > test scenario.
> > 
> > However, we have encountered some compatibility issues when connected
> > with some PCIe EPs, and disabling the L0s can fix it. I think disabling
> > L0s might be the better way, since we usually use L1ss for power-saving
> > when the link is idle.
> 
> To actually decide, we should know what's actually broken, then.
> 
> Is the MediaTek controller broken, or is the device broken?
> So, is it a MTK quirk, or a device quirk?
> 
> If the problem is actually device-related, then this should be handled as
> a device-specific quirk, as not just MediaTek platforms would be affected
> by compatibility issues.
> 
> If the MediaTek PCIe controller is at fault, instead, I agree about just
> disabling L0s at the controller level - but then this shall be mentioned
> in the commit message, and should have a Fixes tag as well.

100% agreed, sorry for repeating what you just said before I finished
reading the thread!

Bjorn

