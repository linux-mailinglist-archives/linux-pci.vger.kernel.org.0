Return-Path: <linux-pci+bounces-42667-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73767CA5B3F
	for <lists+linux-pci@lfdr.de>; Fri, 05 Dec 2025 00:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2756830A0330
	for <lists+linux-pci@lfdr.de>; Thu,  4 Dec 2025 23:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA1A2F691E;
	Thu,  4 Dec 2025 23:44:11 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04144A32;
	Thu,  4 Dec 2025 23:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764891851; cv=none; b=JIN4nl1owuQ2LNtFojzGQvsFIS5T4X/dAUq/BA6MKB3Qt1hBJ/U7m6q2wT5joLpEHQNwFiiYPoWtd3Cm7Vms5xZ9l1Q62UZBlYQadNZLmyhY6epg7H5ekIX7cyh9PNQlLwPj48To2YQxZeezVAET9LmtoKJFBYbxcQ9+GSBi2Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764891851; c=relaxed/simple;
	bh=8G47eGwtb/mvPyx7AV1SGzhMos1ExaUoxon07JQrLeY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=aLHFcZ10MRsZMt11o/invo0pX7vJ7yTBERJQcG+wSxNsXixlmL/esf8I66sZFjqAnsjJK8HQvUMrnIhAsGwPubkFVAzNtFotM0/PYgn8EVsHHvCGZ4qUkiCQ8N5vBEZKMYTIdRDJqJnNTSEtviK4JXnPQEeSC+kISCrO1zZV4g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 0A38792009C; Fri,  5 Dec 2025 00:43:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 039AB92009B;
	Thu,  4 Dec 2025 23:43:58 +0000 (GMT)
Date: Thu, 4 Dec 2025 23:43:58 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Matthew W Carlis <mattc@purestorage.com>
cc: ahuang12@lenovo.com, alok.a.tiwari@oracle.com, ashishk@purestorage.com, 
    Bjorn Helgaas <bhelgaas@google.com>, guojinhui.liam@bytedance.com, 
    =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    jiwei.sun.bj@qq.com, linux-kernel@vger.kernel.org, 
    linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
    msaggi@purestorage.com, sconnor@purestorage.com, sunjw10@lenovo.com
Subject: Re: [PATCH 2/2] PCI: Fix the PCIe bridge decreasing to Gen 1 during
 hotplug testing
In-Reply-To: <20251204014020.1426-1-mattc@purestorage.com>
Message-ID: <alpine.DEB.2.21.2512041314050.49654@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2511290245460.36486@angie.orcam.me.uk> <20251204014020.1426-1-mattc@purestorage.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 3 Dec 2025, Matthew W Carlis wrote:

> > Discard Vendor:Device ID matching in the PCIe failed link retraining 
> > quirk and ignore the link status for the removal of the 2.5GT/s speed 
> > clamp, whether applied by the quirk itself or the firmware earlier on.  
> > Revert to the original target link speed if this final link retraining 
> > has failed.
> 
> I think we should either remove the quirk or only execute the quirk when the
> downstream port is the specific ASMedia 0x2824. Hardware companies that
> develop PCIe devices rely on the linux kernel for a significant amount of
> their testing & the action taken by this quirk is going to introduce
> noise into those tests by initiating unexpected speed changes etc.

 Conversely, ISTM this could be good motivation for hardware designers to 
reduce hot-plug noise.  After all LBMS is only supposed to be ever set for 
links in the active state and not while training, so perhaps debouncing is 
needed for the transient state?

> As long as we have this quirk messing with link speeds we'll just
> continue to see issue reports over time in my opinion.

 Well, the issues happened because I made an unfortunate design decision 
with the original implementation which did not clean up after itself, just 
because I have no use for hot-plug scenarios and didn't envisage it could 
be causing issues.

 The most recent update brings the device back to its original state 
whether retraining succeeded or not, so it should now be transparent to 
your noisy hot-plug scenarios, while helping stubborn devices at the same 
time.  You might have not noticed this code existed if it had been in its 
currently proposed shape right from the beginning.

 It's only those who do nothing that make no mistakes.

  Maciej

