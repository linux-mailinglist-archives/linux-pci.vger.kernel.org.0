Return-Path: <linux-pci+bounces-7838-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0122D8CFC95
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 11:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0FB0282B26
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 09:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09411DFE4;
	Mon, 27 May 2024 09:16:06 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AE1139D19;
	Mon, 27 May 2024 09:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716801366; cv=none; b=s05GTmtsBFxQG6031gcZBfN3QaX5H46ZxUI6KUZe9BqEA2LthGg8clpekryN2m5H8zSaK28gd70tIKtFGuthvMLQKjKV5VUIUJJVT2LY2GqIMvqTcsh8vj2sb8+wHRtj28jTn84d/GyvLdfHyZNX+QGv/Pu7dAZV3r+AiMkWfRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716801366; c=relaxed/simple;
	bh=d3uQngngBfNufpxglkK1GJu8oc6gX6vT4+Q0gAUGrYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aw3f2/rQ9sXK7f5ffEYR0q6XKnevQaKcAwVxQjNE7kdxLIPCMjHKOJygG6u/tdreqPCzph6uBN1DBep7E4WB2dLPbvyXvBF4i3+RtB4BjVFDcy0oDtfInTsDpXCpqvbKSX/1MKv1IFigeAmDOL+SRegtJEPq8/AkFQeHDoR55l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 6D22D3000A383;
	Mon, 27 May 2024 11:15:55 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 55F962F5E1; Mon, 27 May 2024 11:15:55 +0200 (CEST)
Date: Mon, 27 May 2024 11:15:55 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Nam Cao <namcao@linutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Yinghai Lu <yinghai@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2 2/2] PCI: pciehp: Abort hot-plug if
 pci_hp_add_bridge() fails
Message-ID: <ZlRPS9TCYjccpNLr@wunner.de>
References: <cover.1714838173.git.namcao@linutronix.de>
 <f3db713f4a737756782be6e94fcea3eda352e39f.1714838173.git.namcao@linutronix.de>
 <Zjcc6Suf5HmmZVM9@wunner.de>
 <20240505071451.df3l6mdK@linutronix.de>
 <20240506083701.NZNifFGn@linutronix.de>
 <ZjkxTGaAc48jPzqC@wunner.de>
 <20240507142738.wyj19VVh@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507142738.wyj19VVh@linutronix.de>

On Tue, May 07, 2024 at 04:27:38PM +0200, Nam Cao wrote:
> On Mon, May 06, 2024 at 09:36:44PM +0200, Lukas Wunner wrote:
> > Remind me, how exactly does the NULL pointer deref occur?  I think it's
> > because no struct pci_bus was allocated for the subordinate bus of the
> > hot-plugged bridge, right?  Because AFAICS that would happen in
> > 
> > pci_hp_add_bridge()
> >   pci_can_bridge_extend()
> >     pci_add_new_bus()
> >       pci_alloc_child_bus()
> > 
> > but we never get that far because pci_hp_add_bridge() bails out with -1.
> > So the subordinate pointer remains a NULL pointer.
> 
> This is correct. NULL deference happens due to subordinate pointer being
> NULL.
> 
> > Or check for a NULL subordinate pointer instead of crashing.
> 
> I think this is a possible solution, but it is a bit complicated: all usage
> of subordinate pointers will need to be looked at.

We already check for a NULL subordinate pointer in various places.
See e.g. commit 62e4492c3063 ("PCI: Prevent NULL dereference during
pciehp probe").

If we're missing such checks, I'd suggest to add those.

If you believe having a NULL subordinate pointer is wrong and the
bridge should be de-enumerated altogether, I think you would have
to remove these NULL pointer checks as they'd otherwise become
pointless with your change.

Just adding missing NULL pointer checks seems to be the most
straightforward solution to me.

Thanks,

Lukas

