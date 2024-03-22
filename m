Return-Path: <linux-pci+bounces-5000-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9D2886DC2
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 14:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 722351F212BB
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 13:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5805145BED;
	Fri, 22 Mar 2024 13:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GE+vXlar"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150021E522;
	Fri, 22 Mar 2024 13:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711115294; cv=none; b=SiFvpslf8wzadfnWzCHBeNVJXx7imroI1Mu/UFnBswIDYXHPu2X0PTBBdUxiaci1hvxF+jTB11YbofAKdFwuv+6w4KoV/vSCStqQvXuo/YuQ1oAqB8wg6691dP4KVYgwUngRU53Bj85JWY0C253mvXcQj8YKFw/8soiYiIgOAYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711115294; c=relaxed/simple;
	bh=yAqs6k7CJPGwrhFOqcbBcKT5BMwacTGQwa+/4jfCTog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KgBC4Tkgw6GpQuauMTPaAVuHE0sTmLEaJgTgZeZn//iR2Wj/LtmedEefIUBxs8xdQ5mxg9y4MJAjZFVLv8sESmdUoumQj+1MLqikAYz6Gt9DEYSDWT/o5/CMFK1ff/pC3wXKX5XgVJ89k0eVipC/aPPGKQemd8/tDTYWj/xG9YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GE+vXlar; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C13C433C7;
	Fri, 22 Mar 2024 13:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711115293;
	bh=yAqs6k7CJPGwrhFOqcbBcKT5BMwacTGQwa+/4jfCTog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GE+vXlarH6VfHHxUq1E37b8ORsXgcqY5v8ITccO9qaX5tSFL++addXv9zGgVKzrvC
	 N2wp4AczFsex8Hk+u0Pt335sQrWiBTC63o4Rgy0gXuHNn4AgFsFVn8CH4vsbZbnWE9
	 Rw8EtV2RqnNPRAE8riAxGV7t40ve6zl3tGw8YTdM=
Date: Fri, 22 Mar 2024 14:48:11 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Lukas Wunner <lukas.wunner@intel.com>
Subject: Re: [PATCH] cleanup: Add usage and style documentation
Message-ID: <2024032200-outage-tribute-b630@gregkh>
References: <171097196970.1011049.9726486429680041876.stgit@dwillia2-xfh.jf.intel.com>
 <8a1adff2-eb83-4dec-b8d0-1e523245de65@web.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8a1adff2-eb83-4dec-b8d0-1e523245de65@web.de>

On Fri, Mar 22, 2024 at 02:00:42PM +0100, Markus Elfring wrote:
> …
> > +++ b/include/linux/cleanup.h
> > @@ -4,6 +4,118 @@
> >
> >  #include <linux/compiler.h>
> >
> > +/**
> > + * DOC: scope-based cleanup helpers
> > + *
> > + * The "goto error" pattern is notorious for introducing …
> 
> Will any other label become more helpful for this description approach?
> 
> 
> > + * this tedium and can aid in maintaining FILO (first in last out)
>              ⬆
> Would an other word be more appropriate here?
> 

Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot

