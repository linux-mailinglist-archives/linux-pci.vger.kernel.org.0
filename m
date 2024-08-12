Return-Path: <linux-pci+bounces-11593-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B090E94EF68
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2024 16:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C67DB23C0C
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2024 14:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E16417E8E5;
	Mon, 12 Aug 2024 14:21:13 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD057174EEB;
	Mon, 12 Aug 2024 14:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723472473; cv=none; b=HRpVYq+9KP7sjVtHPiJz+mTkzZnzomh9Ok7U4vkgkBOCiqBT1E3NalSFWsJfUzVIRzngInPranIZxLH1Oe4CE5ANqUwuqJ8cawT8l0Hfx42ARzP1NjnF8EWVRU06M5XTuD+SqJHRdUVifXFpRyYzQIZYPMOeOuHe8VosGSjgAqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723472473; c=relaxed/simple;
	bh=+5Q38mBhprnxYHHY6OMgjl43f/cmnXUyv0JL6z/6Yb8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BkgFhOSl5FFep0HhAUC58y7wMjXe/uLiVTmAuHfFuwrtGUF3aQflqnXWE7XnVFXgqtR00+7gKxSB+QWAsMPaX0Y/nj1VXmF24XwQJj1qSHjNGKa1IWzFviuVKLHtlekvdfE2l8u5dhzsJmx0qs54XX8rtIQzCoEOwKmRtk/kbmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 8C72892009C; Mon, 12 Aug 2024 16:21:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 86B2B92009B;
	Mon, 12 Aug 2024 15:21:08 +0100 (BST)
Date: Mon, 12 Aug 2024 15:21:08 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, 
    Matthew W Carlis <mattc@purestorage.com>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    Oliver O'Halloran <oohall@gmail.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] PCI: Clear the LBMS bit after a link retrain
In-Reply-To: <26c94eb5-06b6-8064-acdb-67975bded982@linux.intel.com>
Message-ID: <alpine.DEB.2.21.2408121505260.59022@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2408091017050.61955@angie.orcam.me.uk> <alpine.DEB.2.21.2408091133140.61955@angie.orcam.me.uk> <26c94eb5-06b6-8064-acdb-67975bded982@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 12 Aug 2024, Ilpo Järvinen wrote:

> I'm slightly worried this particular change could interfere with the 
> intent of pcie_failed_link_retrain() because LBMS is cleared also in the 
> failure cases.

 I think it doesn't really matter, because in a correctly operating system 
LBMS is not supposed to be set at the point `pcie_failed_link_retrain' is 
called in the first place.  We don't want to respond to LBMS being set 
just as a consequence of writing 1 to the Retrain Link bit, because it is 
always set in this scenario even for open links and we know we've did the 
retraining anyway, so we can communicate it via other means if we need to.

> In the case of your HW, there's retraining loop by HW so LBMS gets set 
> again but if the HW would not retrain in a loop and needs similar gen1 
> bootstrap, it's very non-obvious to me how things will end up interacting 
> with pcie_retrain_link() call from pcie_aspm_configure_common_clock(). 
> That is, this could clear the LBMS indication and another is not going to 
> be asserted (and even in case of with the retraining loop, it would be 
> racy to get LBMS re-asserted soon enough).

 Yes, and it is an intended effect.  We only want to trigger for LBMS set 
by hardware in an attempt to correct unreliable link operation.

> My impression is that things seem to work with the current ordering of the 
> code but it seems quite fragile (however, the callchains are quite 
> complicated to track so I might have missed something). Perhaps that won't 
> matter much in the end with the bandwidth controller coming to rework all 
> this anyway but wanted to note this may have caveats.

 I look forward to the outcome of your effort.  I expect you'll remove 
this part then and handle the clearing of the LBMS bit in the bandwidth 
controller interrupt handler.

  Maciej

