Return-Path: <linux-pci+bounces-7274-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D068C07A9
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 01:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46E7E1F22F18
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 23:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54AB8626D;
	Wed,  8 May 2024 23:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CxhTdRwk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFF728387;
	Wed,  8 May 2024 23:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715211184; cv=none; b=R/flGOXWLd1H+bcl36bSe2hySg2GGFSkZnF8K7NlDm5a9PCi2HLIB5DdA08idHm12e610V5JLm5ALfdAAZbTQaHOs+YRYZSSOA/GX0WcARjqVGnW5gRhuhZZp64OqDH8xQFaUb+ISZZUxSXAnaUp0H90IVIYA4OwdVT9mdsWlqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715211184; c=relaxed/simple;
	bh=rymFRL9RenzD7dHMXH9iTV136lK+n6YZqLAw1D9IOc8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Q8tp2p/EKI90FMk+xWyk7sbWfEd7EINrCzbcGXmnEBsXCMvorb4inypj8U1WoTkqdW7BNeVkx684Hbz/NSGj0Md7rIbRs1OqDaQSe3AzWTEuN1sfVaABjipFlx24GSoH+ESiKqWiab3KmghCJTkmDvhrWoWI0T9/RdG5GGRWv5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CxhTdRwk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF799C113CC;
	Wed,  8 May 2024 23:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715211184;
	bh=rymFRL9RenzD7dHMXH9iTV136lK+n6YZqLAw1D9IOc8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=CxhTdRwkIoIHjNCan0EzKcUVMCxw2dMCjbzheFWQvigKFzGghLCSSOemAlAC6Dxud
	 nAUdQmMOva5iragqXcCT1EAjDe/Pav1c+wCI7LgXhsMbNw4PCZZViYm11GvPQgxHQK
	 D7qkFBVzHRof0oRjK/vPCsAJ7bKUqr6pCvTnVlKtwi86s7qOfzUcD83Er0C2omZGFT
	 y2JQKTGOnFJr+eyZp4BFMVUmUVoCgca9SdCGzU77Dkopr+6PvgysAvQZr+++Zg2umX
	 neNtqGlXZ/E5+JeX73T2EactCiUOM4/f7eBwAGUFtvK8LdEbPPbPI+ZYtVrIinc5v3
	 oZ3FthdxurO3A==
Date: Wed, 8 May 2024 18:33:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Phil Elwell <phil@raspberrypi.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 4/4] PCI: brcmstb: Configure HW CLKREQ# mode
 appropriate for downstream device
Message-ID: <20240508233302.GA1792067@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+-6iNxEZm=axRAeeAKwxemjEdjjmJYTUs8nThp_NDohXcV5Jg@mail.gmail.com>

On Wed, May 08, 2024 at 01:55:24PM -0400, Jim Quinlan wrote:
> On Mon, May 6, 2024 at 7:20 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> ...

> > As a user, how do I determine which setting to use?
>
> Using the "safe" mode will always work.  In fact I considered making
> this the default mode.

> As I said, I cannot enumerate all of the reasons why one mode works
> and one does not for a particular device+board+connector combo.  The
> HW folks have not really been forthcoming on the reasons as well.
> 
> > Trial and error?  If so, how do I identify the errors?
>
> Either PCIe link-up is not happening, or it is happening but the
> device driver is non-functional and boot typically  hangs.

What I'm hearing is that it's trial and error. 

If we can't tell users how to figure out which mode to use, I think we
have to explicitly say "try the modes in this order until you find one
that works."

That sucks, but if it's all we can do, I guess we don't have much
choice, and we should just own up to it.

There's no point in telling users "if your card drives CLKREQ# use X,
but if not and it can tolerate out-of-spec T_CLRon timing, use Y"
because nobody knows how to figure that out.

And we can say which features are enabled in each mode so they aren't
surprised, e.g., something like this:

  "default" -- The Root Port supports ASPM L0s, L1, L1 Substates, and
    Clock Power Management.  This provides the best power savings but
    some devices may not work correctly because the Root Port doesn't
    comply with T_CLRon timing required for PCIe Mini Cards [1].

  "no-l1ss" -- The Root Port supports ASPM L0s, L1 (but not L1
    Substates), and Clock Power Management.  [I assume there's some
    other Root Port defect that causes issues with some devices in
    this mode; I dunno.  If we don't know exactly what it is, I guess
    we can't really say anything.]

  "safe" -- The Root Port supports ASPM L0, L1, L1 Substates, but not
    Clock Power Management.  All devices should work in this mode.

[1] PCIe Mini CEM r2.1, sec 3.2.5.2.2

(I'm not sure which features are *actually* enabled in each mode, I
just guessed.)

Bjorn

