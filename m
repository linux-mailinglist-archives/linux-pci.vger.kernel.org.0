Return-Path: <linux-pci+bounces-4014-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0724F8675A8
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 13:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 977171F25E00
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 12:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC9C7F7F9;
	Mon, 26 Feb 2024 12:53:40 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958277F7F7;
	Mon, 26 Feb 2024 12:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708952020; cv=none; b=lgmsgApJjvWHsMJIIUQheaA22GpNChnx3k26icXn7Va8pJyWUZpalKIrH/6qEg+R6qJOvRX1gDBdhPpXkmVOEatKssiny2gsl4bYncZJYgSuTx0oXS5305kVv8xKjSE0eBpkPx8aRa7nn8iUpqectqccBcnTKOO6z6Dp0WMlD/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708952020; c=relaxed/simple;
	bh=Gsgrek5j/nuxF+nkZ4KjgNLnQjF4kHuZRghjzPTMR/Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=iKI+0IlRpTO5Wzs3tJ9zI7vKIDF2RQnCmj8hK9VURdYx495/QLO5MvIbZmFFmYutNfo3yX5C8G5oviNnAi4UKdo8Sysm/+LqKN1l6aGm8SusjSyggnYTgeVqQSoxpYRR1sjewIKF11MPj4IALx+Vp4PB/8L/x03ANzcOEUlEUW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id B08A492009D; Mon, 26 Feb 2024 13:53:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id A96C792009C;
	Mon, 26 Feb 2024 12:53:35 +0000 (GMT)
Date: Mon, 26 Feb 2024 12:53:35 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/1] PCI: Cleanup link activation wait logic
In-Reply-To: <alpine.DEB.2.21.2402100118350.2376@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2402261244030.60326@angie.orcam.me.uk>
References: <20240202134108.4096-1-ilpo.jarvinen@linux.intel.com> <alpine.DEB.2.21.2402021359450.15781@angie.orcam.me.uk> <a0e8ae37-cc11-2219-201e-d6740028b735@linux.intel.com> <alpine.DEB.2.21.2402100118350.2376@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 10 Feb 2024, Maciej W. Rozycki wrote:

> > >  You change the logic here in that the second conditional isn't run if the 
> > > first has not.  This is wrong, unclamping is not supposed to rely on LBMS. 
> > > It is supposed to be always run and any failure has to be reported too, as 
> > > a retraining error.  I'll send an update according to what I have outlined 
> > > before then, with some testing done first.
> > 
> > Oh I see now, I'm sorry, I didn't read all the way to the last paragraph 
> > of the commit message because the earlier one in the commit message hinted 
> > the restriction is removed afterwards so I thought it was only linked to 
> > the first part of the quirk.
> 
>  No worries.  I have submitted the changes now: 
> <https://lore.kernel.org/r/alpine.DEB.2.21.2402092125070.2376@angie.orcam.me.uk/>.
> 
>  Unfortunately due to a sudden hardware failure I wasn't able to do any
> non-trivial verification, as explained in the cover letter.  I'll try to 
> get back to it as soon as reasonably possible, hopefully next month.

 I have the failure sorted now, simply reseating one of the connections 
made all the option modules work again as previously.  I'm not impressed 
by this lack of reliability, but maybe it was just bad lack, as things 
used to work just fine for over 2 years before I replaced the mainboard.

 I'll see if I can do some verification this week.

  Maciej

