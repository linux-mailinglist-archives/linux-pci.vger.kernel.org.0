Return-Path: <linux-pci+bounces-42520-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9A1C9CA52
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 19:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F84C4E3E2C
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 18:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420DF2D6E42;
	Tue,  2 Dec 2025 18:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b="TpcFTgyr"
X-Original-To: linux-pci@vger.kernel.org
Received: from exactco.de (exactco.de [176.9.10.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100122D6E53;
	Tue,  2 Dec 2025 18:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.10.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764700152; cv=none; b=ckOPjfFUv3TcuVHyRMnR+MAVc36BULRsZ5TN48p2XSaM0TYUJF2eBc/ihpTTfvlyi/t3ZDnnQ+3s+1po1t7ieZXbsPAhso7jRolWDcUxRCA0g5i5rWInG1VbToqItBvo5RDnnP5Uy4xsJpap0eMhsV/gtzfbG8UG2FjBu/mKukI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764700152; c=relaxed/simple;
	bh=wk4yxGr0/+pyZT+wL0wqcmszXVOhAoyGdxG+jVn9Vuw=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=AWOY4DmFYCGmo23N8o8nkd1Qeia7Lf1fDiJ21nqbkB74FY3bN9jhfdlCWGwQh4GuFq1Haviv9UOaFwNgmZuKWdUeyfygnUTbrOwUZv0cFcVHWp+Ai5MmXC3AIEyAfrJohBeDym01mty3urOZsQSfwf6vR7B041JnL9EuluCQgr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de; spf=pass smtp.mailfrom=exactco.de; dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b=TpcFTgyr; arc=none smtp.client-ip=176.9.10.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exactco.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de;
	s=x; h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:
	In-Reply-To:From:Subject:Cc:To:Message-Id:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=tXLj+f1VRI7R92WJGrEm3i50jVYICvoJ+ng9AQ5CjDc=; b=TpcFTgyrfXW+0h49uIBTcA9xnf
	N9edIZLgAh3Lkb5oCe37iDvKhPKCkR5MQqlIVoVhTbJiX18pXx4Fgve9mMrG82xSt0yUAWf6Y2B4D
	2zm6KtUjQ92wJ0blCWlw4B7mRNVQ0rgeaY5QzlkFvqNkLzLPUnjryouvIydzey4U4zLtVySwh+1Hc
	BQymeJBielq/lPHYsE0ziACGuhpBGOJ8bei02X/NXHaUStsxHEjx+FJmtStFnmZACe5MtYYE+AfXe
	PMCRut+p3gop5jnDiLKLZYvMMPyEq9YI94gn/Fn97N7iWP0U865KsX2PGTme0qXocYdRvouL6rENs
	KQkvTXsg==;
Date: Tue, 02 Dec 2025 19:29:07 +0100 (CET)
Message-Id: <20251202.192907.1946164892504460809.rene@exactco.de>
To: ilpo.jarvinen@linux.intel.com
Cc: glaubitz@physik.fu-berlin.de, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, bhelgaas@google.com,
 riccardo.mottola@libero.it
Subject: Re: PCI bridge window issue
From: =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactco.de>
In-Reply-To: <9c120cee-dadf-e5e4-3e27-f817499d27ec@linux.intel.com>
References: <05c588754dcb83badaec6930499392fdd26be539.camel@physik.fu-berlin.de>
	<20251202.180451.409161725628042305.rene@exactco.de>
	<9c120cee-dadf-e5e4-3e27-f817499d27ec@linux.intel.com>
X-Mailer: Mew version 6.10 on Emacs 30.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Ilpo,

On Tue, 2 Dec 2025 20:20:09 +0200 (EET), Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> wrote:

> On Tue, 2 Dec 2025, René Rebe wrote:
> 
> > s390x. Maybe users of those want to allow list after testing? Now that
> > I think about it I was wondering why ALSA RAD1 audio is not longer
> > working in my Sgi Octane with the PCI window not being enabled. Would
> > not suprise me it was some change like this, too. Should bisect next
> 
> Hi René,
> 
> Could you please send me a dmesg and contents of the /proc/iomem (taken 
> with root right so it shows the real addresses) so I can look at this PCI 
> bridge window issue. If you know a working kernel, having logs from 
> working and broken case would be very helpful to easily locate the 
> differences.

Thank you so much for offering help with that different
issue. Sgi/Octane IP30 only went upstream some years ago. I only have
the likewise not upstream snd-rad1 working with much older out of tree
kernels. Thanks you for the hints, I'll try to find some time to to
further debug this soon to bring the snd-rad1 ALSA driver upstream,
too.

> At this point, no need to bisect as I might be able to figure it out even 
> without pinpointing the commit. To avoid spending on issues that are 
> already know and have a fix, please check you're not running somewhat old 
> kernel as I've already fixed a few things that have gotten broken due to 
> recent made PCI bridge window fitting and assignment algorithm changes.

I can not easily bisect mips64 sgi-ip30 anyway. As it was out of tree
for 20y and the uptreamed code changed a lot during cleanup for
merging.

Good to have a contact to look into this next.

Thanks!
	René

-- 
René Rebe, ExactCODE GmbH, Berlin, Germany
https://exactco.de • https://t2linux.com • https://patreon.com/renerebe

