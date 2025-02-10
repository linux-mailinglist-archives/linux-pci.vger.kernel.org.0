Return-Path: <linux-pci+bounces-21088-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2643CA2F136
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 16:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EE203A56DF
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 15:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EC135963;
	Mon, 10 Feb 2025 15:16:06 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACC72528F5
	for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2025 15:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739200566; cv=none; b=dPPcnCQGHpLxkl/nvGXjyMCGZebyqkbPRpCV0TbEkIQMVi0gNUUnIXMz/cAK4ADjRJYOiFiT0Ap1pUy7w29C+u0sRzLP95bA2mLv92a0O/IqSEuRkRQRPNpw/GEe2TSEzgs5PgGbJdvdF74U+Em5TBt6kSFlxlMcNSRuOA4hMys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739200566; c=relaxed/simple;
	bh=F+/Aa5tXiYMFWtT7XQ3xiOWyLEwDmilsImKub1VYDg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDlF1w8WEsMM7wm/p8hD5pN2J0KFpkwu63ne6PdEvEmvewQ70j+Z+T/+Cci6vHjWBsAugIC1UamTZo3d+zDstZKpCOOdt+Svcskfnq3MZcZd83E9jvyRWzRNYSLSWIBcQ7Hj+VVMjIj4+OsNjMd5Kl5z6asDcoGDHur/zmuv8+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id E5DE52800C96F;
	Mon, 10 Feb 2025 16:15:54 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id D363B12D3B7; Mon, 10 Feb 2025 16:15:54 +0100 (CET)
Date: Mon, 10 Feb 2025 16:15:54 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, bhelgaas@google.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci: allow user specifiy a reset wait timeout
Message-ID: <Z6oYKnX9HHPDoCU2@wunner.de>
References: <20250207204310.2546091-1-kbusch@meta.com>
 <Z6bifFBdh-jfEiXQ@wunner.de>
 <Z6oUNYyPzAFkDOSR@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6oUNYyPzAFkDOSR@kbusch-mbp>

On Mon, Feb 10, 2025 at 07:59:01AM -0700, Keith Busch wrote:
> On Sat, Feb 08, 2025 at 05:50:04AM +0100, Lukas Wunner wrote:
> > On Fri, Feb 07, 2025 at 12:43:10PM -0800, Keith Busch wrote:
> > > The spec does not provide any upper limit to how long a device may
> > > return Request Retry Status. It just says "Some devices require a
> > > lengthy self-initialization sequence to complete". The kernel
> > > arbitrarily chose 60 seconds since that really ought to be enough. But
> > > there are devices where this turns out not to be enough.
> > > 
> > > Since any timeout choice would be arbitrary, and 60 seconds is generally
> > > more than enough for the majority of hardware, let's make this a
> > > parameter so an admin can adjust it specifically to their needs if the
> > > default timeout isn't appropriate.
> > 
> > There are d3hot_delay and d3cold_delay members in struct pci_dev.
> > How about adding a reset_delay which can be set in a device-specific
> > quirk?  I think I'd prefer that over a command line parameter.
> > 
> > A D3cold -> D0 transition implies a reset, but I'm not sure it's
> > appropriate to (ab)use d3cold_delay as a reset_delay.
> 
> My concern with quirking it is that we'd have to settle on what we think
> is the worst case timeout, then it becomes compiled into that kernel for
> that device. The devices I'm dealing with are actively under
> development, and the time to ready gets bigger or smaller as updates
> occur, or some new worst case scenario is discovered. Making this a boot
> time decicion really helps with experimentation here.

I understand, but honestly this doesn't sound like something which
needs to be in the upstream kernel.  If it's for experimentation only,
I'd keep it in the downstream kernel used for experimentation
and if it turns out that 60 sec is insufficient for the final
production device, I'd submit a quirk for that.

Thanks,

Lukas

