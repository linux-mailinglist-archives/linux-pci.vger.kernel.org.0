Return-Path: <linux-pci+bounces-385-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2131802616
	for <lists+linux-pci@lfdr.de>; Sun,  3 Dec 2023 18:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 469DA1F20F96
	for <lists+linux-pci@lfdr.de>; Sun,  3 Dec 2023 17:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DFC1772D;
	Sun,  3 Dec 2023 17:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XQgnr1Cr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661A4168DC
	for <linux-pci@vger.kernel.org>; Sun,  3 Dec 2023 17:59:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FEB7C433C8;
	Sun,  3 Dec 2023 17:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701626348;
	bh=J3twRl4XxNuaVvsz4IZOORnl97JE03DVpSOJqQMMnrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XQgnr1CrIXhnmdf9B1ROCZ9SjUSLl9+DBa2byKGWxWoerXSH4yridtiCYIyr0fPfx
	 LDdI/KOIEQIoNN+b45DUi+HZ9CQzBhIqGKwzSZi5gaIsadPkU+ooBj6MD79pJbuZYB
	 a06YP76fOKoZU4QpSPQAkucgBZJ4vpgGlKkBDcxE=
Date: Sun, 3 Dec 2023 18:59:04 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	Wasim Khan <wasim.khan@nxp.com>, Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>
Subject: Re: [PATCH pci] PCI: remove the PCI_VENDOR_ID_NXP alias
Message-ID: <2023120318-creme-cold-206b@gregkh>
References: <20231122154241.1371647-1-vladimir.oltean@nxp.com>
 <20231129233827.GA444332@bhelgaas>
 <2023113014-preflight-roundish-d796@gregkh>
 <20231203151654.nh4ta7vtzwpwg4ss@skbuf>
 <2023120354-expansion-frequency-f991@gregkh>
 <20231203174841.uj6ixj7ap2hzlvey@skbuf>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231203174841.uj6ixj7ap2hzlvey@skbuf>

On Sun, Dec 03, 2023 at 07:48:41PM +0200, Vladimir Oltean wrote:
> On Sun, Dec 03, 2023 at 06:30:13PM +0100, Greg Kroah-Hartman wrote:
> > On Sun, Dec 03, 2023 at 05:16:54PM +0200, Vladimir Oltean wrote:
> > > On Thu, Nov 30, 2023 at 11:10:19AM +0000, Greg Kroah-Hartman wrote:
> > > > > Why would we remove name of the current company and use the name of a
> > > > > company that doesn't exist any more?
> > > > 
> > > > Yes, this seems very odd.  What is the reason for any of this other than
> > > > marketing?  Kernel code doesn't do marketing :)
> > > 
> > > I'm not sure who is doing the marketing; not me, that's for sure.
> > > The patch that I'm proposing undoes these strange aliases.
> > 
> > Why?
> 
> Why am I undoing the aliases? It's in my commit message.

Which is long gone from this email thread, sorry.

> NXP now
> produces PCI devices with a different vendor ID.

"Different" from what, the old one?

> If aliasing is the way
> to go, then are we supposed to add a new PCI_VENDOR_ID_NXP2,
> PCI_VENDOR_ID_NXP3 etc?
> 
> Mellanox was bought by Nvidia and I don't see its PCI ID aliased to
> Nvidia. There are probably countless of other examples.

I'm not asking why anything is being aliased, I'm asking why change the
existing names.

> > Who did it originally in what commit id and what was wrong with them
> > then?
> 
> Does it really matter? "Git blame" on the line with #define PCI_VENDOR_ID_NXP
> will point to a random commit by Wasim Khan (also CCed). The usage of
> PCI_VENDOR_ID_NXP is not widespread, it's only that commit.

So does your change here just revert the change in that commit, or does
it do it in other places?

thanks,

greg k-h

