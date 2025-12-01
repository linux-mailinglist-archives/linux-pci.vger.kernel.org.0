Return-Path: <linux-pci+bounces-42336-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05861C95AE3
	for <lists+linux-pci@lfdr.de>; Mon, 01 Dec 2025 04:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96BE13A1C18
	for <lists+linux-pci@lfdr.de>; Mon,  1 Dec 2025 03:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BA51A3179;
	Mon,  1 Dec 2025 03:55:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0F07081F;
	Mon,  1 Dec 2025 03:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764561300; cv=none; b=WsRklvsu+zK4WKBrS/8rkECtTZKzz2rvNWDqhmYNG7jg9EMRN/GLT8Kdf3ApR6FFxTBtXuY1S0mk71AgeGILd3lryXfqKeHDFXvJ1DDqOkGxzikteArqBahypZBCZTooYSeac4A3YrZgAEOPV2tJvO6+szyWsS6O4Sr2hJ/r/q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764561300; c=relaxed/simple;
	bh=SgvSydZmOtxlJUgPSJeXTvUYWIV8Q+0yBOxEd7EhJ0U=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=L8AB9oDpUtl+0Pvc+Tn6cS3jJJgiYxT0QJwHVl5oaSyWrRf63xYQkMS2rftiX38+0P+spQ6OIpdhLozSDi0urcbzGl8VlTNxQxt8/Z7Hr8dRTDKNOrCJWFD+hRjXfM5JaodnYdTgpuQCTXBktQOUTHyeNOO6zwWlS1JVwNa9qfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 8D6C492009E; Mon,  1 Dec 2025 04:54:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 8691092009B;
	Mon,  1 Dec 2025 03:54:57 +0000 (GMT)
Date: Mon, 1 Dec 2025 03:54:57 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
cc: Lukas Wunner <lukas@wunner.de>, 
    =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, Jiwei <jiwei.sun.bj@qq.com>, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    guojinhui.liam@bytedance.com, Bjorn Helgaas <helgaas@kernel.org>, 
    ahuang12@lenovo.com, sunjw10@lenovo.com
Subject: Re: [External] : Re: [PATCH 2/2] PCI: Fix the PCIe bridge decreasing
 to Gen 1 during hotplug testing
In-Reply-To: <d4e5b6d8-c69f-4fbc-8da6-bc2c2fb2a550@oracle.com>
Message-ID: <alpine.DEB.2.21.2511290112150.36486@angie.orcam.me.uk>
References: <tencent_B9290375427BDF73A2DC855F50397CC9FA08@qq.com> <3fe7b527-5030-c916-79fe-241bf37e4bab@linux.intel.com> <tencent_4514111F8A3EF9408C50D9379FE847610206@qq.com> <3d7c3904-a52e-9602-3ad2-29b5981729c7@linux.intel.com> <Z4eLh24IkDrAm6cm@wunner.de>
 <d4e5b6d8-c69f-4fbc-8da6-bc2c2fb2a550@oracle.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 26 Nov 2025, ALOK TIWARI wrote:

> We are testing hot-add/hot-remove behavior and observed the same issue as,
> mentioned where the PCIe bridge link speed drops from 32 GT/s to 2.5 GT/s.
> 
> My understanding is that pcie_failed_link_retrain should only apply to devices
> matched by PCI_VDEVICE(ASMEDIA, 0x2824),
> but the current implementation appears to affect all devices that take longer
> to establish a link.

 Thank you for your report.

 No, there seems nothing wrong with said device by itself and the problem 
is either with the downstream device (which obviously cannot be discovered 
until a link has been actually established), or the particular device pair 
or setup.  I've originally implemented matching for this particular device 
out of the abundance of caution, in case the removal of speed restriction 
for other upstream devices (in case the quirk triggered there) would cause 
the link to go back into the infinite retraining loop.

> We are unsure if this is intentional, but it effectively allows such
> devices to continue operating at a reduced speed.

 It was intentional, but didn't take into account noisy hot-plug scenarios 
which are not a part of my lab setup.

> If we extend PCIE_LINK_RETRAIN_TIMEOUT_MS to 3000 ms, these slower devices are
> able to complete link training,
> and the problem is no longer observed in our testing. Therefore, increasing
> PCIE_LINK_RETRAIN_TIMEOUT_MS to 3000 ms seems to resolve the issue for us.
> 
> Would it be acceptable to increase PCIE_LINK_RETRAIN_TIMEOUT_MS, from 1000 to
> 3000 ms in this case?

 FWIW my understanding is this goes beyond the spec actually.

 However given other reports I've given more thought to my idea previously 
shared, which has sadly received no feedback to motivate me further, and 
implemented yet more simplified an approach, where the 2.5GT/s speed clamp 
is always removed regardless of the link state and if that fails, then any 
original clamp as at the entry to the quirk is restored.  This I hope will 
prove robust enough not to cause further issues with hot-plug scenarios.

 Please give it a try and let me know if it's fixed your issue:

<https://lore.kernel.org/r/alpine.DEB.2.21.2511290245460.36486@angie.orcam.me.uk/>

  Maciej

