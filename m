Return-Path: <linux-pci+bounces-21828-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38722A3C710
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 19:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24C1316B31A
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 18:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378712147F4;
	Wed, 19 Feb 2025 18:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZ02JXKJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDE12147E8;
	Wed, 19 Feb 2025 18:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739988581; cv=none; b=VdPt9cVkwUW75U8/7q7BAk27kn4tU8BaXF6cAKTE3NCD38E4I6QP/2+3ziTqMeL/tB+x1tthsQCAbqlUtA91UGHrSd5swUDhsM1cMllf2sPhydzboHxwYwFzAqD9OwDjpfDQjiXeO50HCaPBRJX5UK+UCJCDJ/qTSsPaJRUwj4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739988581; c=relaxed/simple;
	bh=4CxYRZkWyD6Ejg4xLiukBqtsPa11yzy8EicFjLzbH3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLqpSKyTUWflgsIzZS0MQX7HkFGYuCMsk8rM7dY1Sa+cziVeSBuXecF0/bAUIK4LWGA0Ux0dYzR77Xqn7ciqoSnDsFZSPtp5c9bmMlSlDZV/pPJR2nD5y98VgRRY2f/Ze8AVoKEYLCaAGbDi4v9EXU2WIweXJMwx6PJ+kSxfSmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZ02JXKJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A78FC4CED1;
	Wed, 19 Feb 2025 18:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739988579;
	bh=4CxYRZkWyD6Ejg4xLiukBqtsPa11yzy8EicFjLzbH3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CZ02JXKJVjeAgrdas8ShzzUrpGobXk99E7iY+Qlc9mZl04+0iuFgAUb247SAdgYgG
	 snK2YZGaQer1p6c1rJgpmvu7mvmpZWcQxXyDvY7gq3a8aPAgoPOAUpwnpQNlOmPap9
	 OzFjvB1QdTKa5hkK81hU/1Xej6yew2eFjF0T0YNgLAI+61NrnbJTPcLRLzlBzQsOPd
	 oGfDvbI0KoF2Gxz/BCi2FKrlcM2HptPVzUs3t0FrkfWkMzEZdimQwOHAUOm3LjVgD/
	 oHybYmi/5fYPI35GhROlVDWTWN2rPHuTjAkYzDQLD/2cl1J5syTy6NOlVYQuZyzDCj
	 d5b/ovfPHhfFg==
Date: Wed, 19 Feb 2025 23:39:31 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Brian Norris <briannorris@chromium.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Tsai Sung-Fu <danielsftsai@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Chant <achant@google.com>, Sajid Dalvi <sdalvi@google.com>
Subject: Re: [PATCH] PCI: dwc: Separate MSI out to different controller
Message-ID: <20250219180931.mjhvibbq3xyppv5g@thinkpad>
References: <20250115083215.2781310-1-danielsftsai@google.com>
 <20250127100740.fqvg2bflu4fpqbr5@thinkpad>
 <CAK7fddC6eivmD0-CbK5bbwCUGUKv2m9a75=iL3db=CRZy+A5sg@mail.gmail.com>
 <20250211075654.zxjownqe5guwzdlf@thinkpad>
 <CAK7fddDkQX1aj5ZyTjh1_Pk+XME3AY=m5ouEFRgmLuJjBJytbA@mail.gmail.com>
 <20250214071552.l4fufap6q5latcit@thinkpad>
 <Z6-fjJv3LXTir1Yj@google.com>
 <20250219175119.vjfdgvltutpzyyp5@thinkpad>
 <8634g9sthr.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8634g9sthr.wl-maz@kernel.org>

On Wed, Feb 19, 2025 at 06:02:24PM +0000, Marc Zyngier wrote:
> On Wed, 19 Feb 2025 17:51:19 +0000,
> Manivannan Sadhasivam <mani@kernel.org> wrote:
> > 
> > On Fri, Feb 14, 2025 at 11:54:52AM -0800, Brian Norris wrote:
> > > On Fri, Feb 14, 2025 at 12:45:52PM +0530, Manivannan Sadhasivam wrote:
> > > > On Tue, Feb 11, 2025 at 04:23:53PM +0800, Tsai Sung-Fu wrote:
> > > > > >Because you cannot set affinity for chained MSIs as these MSIs are muxed to
> > > > > >another parent interrupt. Since the IRQ affinity is all about changing which CPU
> > > > > >gets the IRQ, affinity setting is only possible for the MSI parent.
> > > > > 
> > > > > So if we can find the MSI parent by making use of chained
> > > > > relationships (32 MSI vectors muxed to 1 parent),
> > > > > is it possible that we can add that implementation back ?
> > > > > We have another patch that would like to add the
> > > > > dw_pci_msi_set_affinity feature.
> > > > > Would it be a possible try from your perspective ?
> > > > > 
> > > > 
> > > > This question was brought up plenty of times and the concern from the irqchip
> > > > maintainer Marc was that if you change the affinity of the parent when the child
> > > > MSI affinity changes, it tends to break the userspace ABI of the parent.
> > > > 
> > > > See below links:
> > > > 
> > > > https://lore.kernel.org/all/87mtg0i8m8.wl-maz@kernel.org/
> > > > https://lore.kernel.org/all/874k0bf7f7.wl-maz@kernel.org/
> > > 
> > > It's hard to meaningfully talk about a patch that hasn't been posted
> > > yet, but the implementation we have at least attempts to make *some*
> > > kind of resolution to those ABI questions. For one, it rejects affinity
> > > changes that are incompatible (by some definition) with affinities
> > > requested by other virqs shared on the same parent line. It also updates
> > > their effective affinities upon changes.
> > > 
> > > Those replies seem to over-focus on dynamic, user-space initiated
> > > changes too. But how about for "managed-affinity" interrupts? Those are
> > > requested by drivers internally to the kernel (a la
> > > pci_alloc_irq_vectors_affinity()), and can't be changed by user space
> > > afterward. It seems like there'd be room for supporting that, provided
> > > we don't allow conflicting/non-overlapping configurations.
> > > 
> > > I do see that Marc sketched out a complex sysfs/hierarchy API in some of
> > > his replies. I'm not sure that would provide too much value to the
> > > managed-affinity cases we're interested in, but I get the appeal for
> > > user-managed affinity.
> > > 
> > 
> > Whatever your proposal is, please get it reviewed by Marc.
> 
> Please see b673fe1a6229a and avoid dragging me into discussion I have
> purposely removed myself from. I'd also appreciate if you didn't
> volunteer me for review tasks I have no intention to perform (this is
> the second time you are doing it, and that's not on).
> 

Apologies for not catching up with the MAINTAINERS update. Since you were pretty
much involved in the affinity discussion, I thought about asking your help.

Regarding looping you in, I thought you only wanted to avoid reviewing the new
driver changes that were deviating from the spec too much.

But anyway, now it is clear to me that you are not maintaining the irqchip
drivers, so I will not bother you anymore. Sorry about that.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

