Return-Path: <linux-pci+bounces-7850-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABED38D0046
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 14:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45C06B2225F
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 12:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AE315DBD1;
	Mon, 27 May 2024 12:42:10 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E266339B1;
	Mon, 27 May 2024 12:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716813730; cv=none; b=thmv7lp2oxhiF+gLBsz78UZSohGRPotmxd4ILfQ1QxrT8hfrulYUTBIvWS/j2QfI5SaHw+aSEFiBEcTSaq8KhgPhumFUuCRaihgsrj2gUeH0+GDim8vOd7w1cX1cfBOxL6MzITPWHXyKPbjPdvskcaQBRoOqjbDl4OrUV4McnrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716813730; c=relaxed/simple;
	bh=DYhkxv+4qslfB3GCZb5USw9Yc4GNuRSlvX8gOfRsEKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DNFIMO+zHs4AQfMuuOZPSquRKQC+q/mzEPDTjDbSN4XpZapTbqte63Im/fN2//5awR3fj4YFQaygcRYKzoGzRHbVlP+32b5BqmH6TNAMsSX1Wmnh61HZYJPdcNFcB+tx18wRHePRdwjHBm3UAO0w5T/zTtRRMUzCvBuBjS9hnOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id DB3752800DC37;
	Mon, 27 May 2024 14:33:22 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id C414A9926AC; Mon, 27 May 2024 14:33:22 +0200 (CEST)
Date: Mon, 27 May 2024 14:33:22 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Nam Cao <namcao@linutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Yinghai Lu <yinghai@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2 2/2] PCI: pciehp: Abort hot-plug if
 pci_hp_add_bridge() fails
Message-ID: <ZlR9kg-SEshXvBEP@wunner.de>
References: <cover.1714838173.git.namcao@linutronix.de>
 <f3db713f4a737756782be6e94fcea3eda352e39f.1714838173.git.namcao@linutronix.de>
 <Zjcc6Suf5HmmZVM9@wunner.de>
 <20240505071451.df3l6mdK@linutronix.de>
 <20240506083701.NZNifFGn@linutronix.de>
 <ZjkxTGaAc48jPzqC@wunner.de>
 <20240507142738.wyj19VVh@linutronix.de>
 <ZlRPS9TCYjccpNLr@wunner.de>
 <20240527092322.N8nbxYAL@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527092322.N8nbxYAL@linutronix.de>

On Mon, May 27, 2024 at 11:23:22AM +0200, Nam Cao wrote:
> On Mon, May 27, 2024 at 11:15:55AM +0200, Lukas Wunner wrote:
> > We already check for a NULL subordinate pointer in various places.
> > See e.g. commit 62e4492c3063 ("PCI: Prevent NULL dereference during
> > pciehp probe").
> 
> Ah, so bridge without subordinate bus is allowed in the kernel.
> 
> > If we're missing such checks, I'd suggest to add those.
> > 
> > If you believe having a NULL subordinate pointer is wrong and the
> > bridge should be de-enumerated altogether, I think you would have
> > to remove these NULL pointer checks as they'd otherwise become
> > pointless with your change.
> > 
> > Just adding missing NULL pointer checks seems to be the most
> > straightforward solution to me.
> 
> If the kernel do permits bridges without subordinate bus number, I am
> happy to go this direction. I expect going this way will require many more
> patches, I will dig into it and come back later.

It seems a lot of functions use a "if (dev->subordinate)" check
to distinguish between bridges and endpoints.

A bridge with a NULL subordinate pointer is then basically treated
like an endpoint.

There are places which use other ways to recognize bridges, e.g.
by looking at dev->hdr_type.  Only these code paths will have to
check for a NULL subordinate pointer.  In the case of pciehp,
portdrv binds to anything with class PCI_CLASS_BRIDGE_PCI_NORMAL,
without consideration for the subordinate pointer, hence a check
was needed in pciehp.

pciehp is used a lot by Thunderbolt/USB4, SD 7.0 and for NVMe drives.
I think shpchp isn't used as much, so its code paths aren't exercised
as heavily and bugs aren't found and fixed as quickly.  So chances are
that more checks are missing in shpchp than in pciehp.

Thanks,

Lukas

