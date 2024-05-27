Return-Path: <linux-pci+bounces-7839-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 864CB8CFCBB
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 11:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1814D1F21074
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 09:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A431139D18;
	Mon, 27 May 2024 09:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rqxftRC1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MudiAr7B"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E230B139D1A;
	Mon, 27 May 2024 09:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716801810; cv=none; b=gyZZ9GwZbugAcqip97zM7M4X65+eP/Cvw/agji5GivjdnyAczJf2Inxhbhph77kGOBQC0WfW+vWPNgqzk+lmuSOmirUdIDnmMPOs4NIw4MjIgq26oQ6nd7dPzbAxWEwZo6bbeD678+7qd3gKgHlPdKEJwNqfSBQ0YEzRYOcY0GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716801810; c=relaxed/simple;
	bh=Q5gLcnKgDuIZzTn3G2COwGwQPZzpH83qoE+C9QBEXyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=spIoo4qd9te1Nr2cPXZj5w0aIaQbFTGhb4QyRmBDt3AncC0G+45SLE6YRrffk5QqLJcU9aderaBRqP6fpU7sa6x6qgt4iVJxnVCh/KbMS6Fc3P+dFA2pahkdgNUD7otxBLF2NVe/2wqWdaE7PK1ex/d5kRkSjnWtmfYnGdWGmCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rqxftRC1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MudiAr7B; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 27 May 2024 11:23:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716801807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DynqLe7rrfT6pDcjUFZu3h+ra6dcsErZ0u0TiuBUA/E=;
	b=rqxftRC1+gRCqRjRFM8vNUN5MlWthAPkNopghaSQtcNFTHgQkaNTU5VRUXyPlCEYNulzkn
	DFKpw6rDokRkRlllruxLtbd96W+TrNgzPP7UWyOEvcUB/phcpd6zhxstra0LaHxEJbZI2y
	2ax2LC5jGHTewt2MG1uKvVv5xUJXb9/K8zsuWNNvlc99x/OvIUVhGyTIb2W7VNs4qvznnK
	P2LHmfSqV3xyybIHbbVDq6RILj9n/MlQRntxAElZqDZlvOf7SRIf1eFQ+R3RrH5u5Ye7EU
	xmTL9hUAkK/y/lOovSLm2OJF/rlJ3P3sv0Sx2r9TBNk03vyWBwteIv+fclwiRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716801807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DynqLe7rrfT6pDcjUFZu3h+ra6dcsErZ0u0TiuBUA/E=;
	b=MudiAr7B2Nydgwl8BdU1iOO6KZUx+yn6iHOrk5hBq1jplEu317nZDfjTq/BuuWIyXO0oSn
	ZyORJ/Ot5q6KxXBA==
From: Nam Cao <namcao@linutronix.de>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Yinghai Lu <yinghai@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2 2/2] PCI: pciehp: Abort hot-plug if
 pci_hp_add_bridge() fails
Message-ID: <20240527092322.N8nbxYAL@linutronix.de>
References: <cover.1714838173.git.namcao@linutronix.de>
 <f3db713f4a737756782be6e94fcea3eda352e39f.1714838173.git.namcao@linutronix.de>
 <Zjcc6Suf5HmmZVM9@wunner.de>
 <20240505071451.df3l6mdK@linutronix.de>
 <20240506083701.NZNifFGn@linutronix.de>
 <ZjkxTGaAc48jPzqC@wunner.de>
 <20240507142738.wyj19VVh@linutronix.de>
 <ZlRPS9TCYjccpNLr@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlRPS9TCYjccpNLr@wunner.de>

On Mon, May 27, 2024 at 11:15:55AM +0200, Lukas Wunner wrote:
> On Tue, May 07, 2024 at 04:27:38PM +0200, Nam Cao wrote:
> > On Mon, May 06, 2024 at 09:36:44PM +0200, Lukas Wunner wrote:
> > > Remind me, how exactly does the NULL pointer deref occur?  I think it's
> > > because no struct pci_bus was allocated for the subordinate bus of the
> > > hot-plugged bridge, right?  Because AFAICS that would happen in
> > > 
> > > pci_hp_add_bridge()
> > >   pci_can_bridge_extend()
> > >     pci_add_new_bus()
> > >       pci_alloc_child_bus()
> > > 
> > > but we never get that far because pci_hp_add_bridge() bails out with -1.
> > > So the subordinate pointer remains a NULL pointer.
> > 
> > This is correct. NULL deference happens due to subordinate pointer being
> > NULL.
> > 
> > > Or check for a NULL subordinate pointer instead of crashing.
> > 
> > I think this is a possible solution, but it is a bit complicated: all usage
> > of subordinate pointers will need to be looked at.
> 
> We already check for a NULL subordinate pointer in various places.
> See e.g. commit 62e4492c3063 ("PCI: Prevent NULL dereference during
> pciehp probe").

Ah, so bridge without subordinate bus is allowed in the kernel.

> If we're missing such checks, I'd suggest to add those.
> 
> If you believe having a NULL subordinate pointer is wrong and the
> bridge should be de-enumerated altogether, I think you would have
> to remove these NULL pointer checks as they'd otherwise become
> pointless with your change.
> 
> Just adding missing NULL pointer checks seems to be the most
> straightforward solution to me.

If the kernel do permits bridges without subordinate bus number, I am
happy to go this direction. I expect going this way will require many more
patches, I will dig into it and come back later.

Thanks for your patience providing me advices & information.

Best regards,
Nam




