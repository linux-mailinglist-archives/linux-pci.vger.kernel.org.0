Return-Path: <linux-pci+bounces-26147-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6A2A92BE6
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 21:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AB567A70EC
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 19:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A58C1FE469;
	Thu, 17 Apr 2025 19:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOJjxaqO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DCA1EF38F
	for <linux-pci@vger.kernel.org>; Thu, 17 Apr 2025 19:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744918754; cv=none; b=cuBtI7pa3IupmV84RQY2/2G+tnkSP7usq9s7vDzQXQ8ovsuYWWY/yhlrufYExwhISbiiWVwU20rcIo1K5WKYnplmhmfCKrtX5foE9AK7AR+BM7/u5i2oCyhixqMfyfUg4WEXxBlZ4jVNqii67LXaX7FXFuVQSnNy7MUX0TRIFrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744918754; c=relaxed/simple;
	bh=sm7e06Z+1BnSsMmxF6X8hxnIDffMAJl7CQ9A/o9P8n4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bCPIrCcVMt2KwPW9+hwWlArmSgOjj+w8ymhzzJn8QcE53KB7XzPmVO6f4DoI/+WipfmAuhCcg48UIp0ke8UosQhubil35+87b7ATqdaV63rR/NFTQtmOzPETXqX5c76YcES5f8m3u0HJY37KsUTPo2gCK+N9YqffHG9I0Hn4jyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOJjxaqO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 518C7C4CEE4;
	Thu, 17 Apr 2025 19:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744918753;
	bh=sm7e06Z+1BnSsMmxF6X8hxnIDffMAJl7CQ9A/o9P8n4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=eOJjxaqO/+k9KGe9AYNLRP6C7e+ummFAw3A/QCQqIdaIvrYpqeUuqPBseV9AMgWHC
	 z057r7p23ncSS4wVO8AGsu5GfSFlgkLIn05xkLpYA9ZyBRwQFGrBtqdrjEUS2velkY
	 xFyoBlvu5hDoKx2To17fPzWcH8fG4mfFFd655TrLslQHcRd99bySASOzhThju8DoTw
	 I391H3xxArVJlHEH/ixMBoEl5I7Q6Vj4pV/gLBG8OYqQJo105QjAodZ0zrWrzX/Tvj
	 1x3ZZQQF4q4aHxpnaEAPEMQcCuAVr/K2iz6RGGP0O8H5+fosqNdTNgFiBlULTCNqsn
	 +r2UXf392BbRg==
Date: Thu, 17 Apr 2025 14:39:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: hotplug: Drop superfluous #include directives
Message-ID: <20250417193911.GA124285@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAFW4Bsgl8JLnjog@wunner.de>

On Thu, Apr 17, 2025 at 09:30:40PM +0200, Lukas Wunner wrote:
> On Tue, Apr 15, 2025 at 03:33:54PM -0500, Bjorn Helgaas wrote:
> > On Mon, Apr 14, 2025 at 04:25:21PM +0200, Lukas Wunner wrote:
> > > In February 2003, historic commit
> > > 
> > >   https://git.kernel.org/tglx/history/c/280c1c9a0ea4
> > >   ("[PATCH] PCI Hotplug: Replace pcihpfs with sysfs.")
> > > 
> > > removed all invocations of __get_free_page() and free_page() from the
> > > PCI hotplug core without also removing the #include <linux/pagemap.h>
> > > directive.
> > > 
> > > It removed all invocations of kern_mount(), mntget() and mntput()
> > > without also removing the #include <linux/mount.h> directive.
> > > 
> > > It removed all invocations of lookup_hash()
> > > without also removing the #include <linux/namei.h> directive.
> > > 
> > > It removed all invocations of copy_to_user() and copy_from_user()
> > > without also removing the #include <linux/uaccess.h> directive.
> > > 
> > > These #include directives are still unnecessary today, so drop them.
> > > 
> > > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > 
> > Applied to pci/hotplug for v6.16, thanks!
> 
> A small issue snuck into the commit message while applying:
> 
> There's a sentence which ends abruptly:
> 
>     It removed all invocations of lookup_hash() without also removing the
> 
> The remainder of the sentence should have been:
> 
>     #include <linux/namei.h> directive.
> 
> While rewrapping the paragraph, the word "#ifdef" ended up at the
> beginning of the line and "git commit" interpreted that as a comment
> and stripped the line from the commit message.

Wow, thanks for noticing that.  That's new to me.  I this I restored
it.

