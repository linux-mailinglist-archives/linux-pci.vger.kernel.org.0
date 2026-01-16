Return-Path: <linux-pci+bounces-45079-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0AAD38828
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 22:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 102C8302034C
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 21:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183EB2E11C7;
	Fri, 16 Jan 2026 21:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdPUB6Xb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A5521FF35;
	Fri, 16 Jan 2026 21:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768597897; cv=none; b=YdD/WCEUfItIinCfFaWgI61WT8LsQRES6M38NgYL1PqqH4Lk4QXAeNnKQTJNbHLxTZZsDTmgxaqrUTWzf9VZ12jgW+BZF7LPvyJOqLHvGcodv9/xeoi6giccO7bmoFbPQ+OZMA/Xzv64p6v184DTELEBpZY1w/2BySDGizCpw7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768597897; c=relaxed/simple;
	bh=NsKBUHMXzQZudW4w1+fFqs0D1q0g8p8txPu9CuWqzv0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bgD3wuZempOLos/7eR6REpfu28B7Nl09U7WU0zaWPwMlsqnzPfpEo77muaPnFRJMKENqcNYoi1+l3dOE+3qKlog6rwPPPcvcm+aUijYp7UWzgU35QfKxNxDrKN24LKyqhtq9Cx4fj01TpZOslD4SvVRmxGwWSe11ovhnubXb6Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdPUB6Xb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B3F9C116C6;
	Fri, 16 Jan 2026 21:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768597896;
	bh=NsKBUHMXzQZudW4w1+fFqs0D1q0g8p8txPu9CuWqzv0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=WdPUB6XbxiQAHnoPprWcsp/g44OQRsKBXT/TPmWJT+JXirEsRLtILIppu6tQ9LIKL
	 MpF8OoozMSdsrj191yeGP5EDrJ7FLiDxGDwXeCjOrwSzCiwh3hK53YGnmCTgMTFLOm
	 Riwvru60Rtv8YqicxJ407w1x+tXbuSEIFxYVEYn1TA6BjEQ5AdtE7eJRSIH2a7A3Us
	 DMrKOOdUv/IeyBi+xFJRYDE8K9T4tTxHUFOY3LwJE7BlSgRtJrrUcUttIaokKK6SmA
	 puVeKlKaboN1YMfiCIzIwS4IZwljbczP/bRPVJfmY1kDuBisJQv7kMJYA6cR6/7jX/
	 Lz9s1QgqWWfJA==
Date: Fri, 16 Jan 2026 15:11:35 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Haakon Bugge <haakon.bugge@oracle.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Johannes Thumshirn <jth@kernel.org>,
	Myron Stowe <myron.stowe@redhat.com>
Subject: Re: [PATCH] PCI/ACPI: Confine program_hpx_type2 to the AER bits
Message-ID: <20260116211135.GA959225@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A6A85012-A9E5-46D8-8BB5-EEC20898B6C6@oracle.com>

[+cc Johannes (author of e42010d8207f ("PCI: Set Read Completion
Boundary to 128 iff Root Port supports it (_HPX)"), Myron; start of
thread:
https://lore.kernel.org/r/20260113171522.3446407-1-haakon.bugge@oracle.com]

On Fri, Jan 16, 2026 at 10:10:43AM +0000, Haakon Bugge wrote:
> > On Thu, Jan 15, 2026 at 03:39:21PM +0000, Haakon Bugge wrote:
> >> Thanks for the review, Bjørn!
> >> ...

I should have mentioned this earlier, but I think the commit log
should include something about the problem this change fixes.  I
assume that the current code changes ExtTag and/or RO, and that causes
something bad.  That's what is motivating this change.

> >>>> if (pcie_cap_has_lnkctl(dev)) {
> >>>> + u16 lnkctl;
> >>>> 
> >>>> - /*
> >>>> -  * If the Root Port supports Read Completion Boundary of
> >>>> -  * 128, set RCB to 128.  Otherwise, clear it.
> >>>> -  */
> >>>> - hpx->pci_exp_lnkctl_and |= PCI_EXP_LNKCTL_RCB;
> >>>> - hpx->pci_exp_lnkctl_or &= ~PCI_EXP_LNKCTL_RCB;
> >>>> - if (pcie_root_rcb_set(dev))
> >>>> - hpx->pci_exp_lnkctl_or |= PCI_EXP_LNKCTL_RCB;
> >>>> -
> >>>> - pcie_capability_clear_and_set_word(dev, PCI_EXP_LNKCTL,
> >>>> - ~hpx->pci_exp_lnkctl_and, hpx->pci_exp_lnkctl_or);
> >>>> + pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &lnkctl);
> >>>> + if (lnkctl)
> >>>> + pci_warn(dev, "Some bits in PCIe Link Control are set: 0x%04x\n",
> >>>> +  lnkctl);
> >>>> 
> >>> Sorry, I wasn't clear about this.  I meant that we could log the
> >>> LNKCTL AND/OR values from _HPX, not the values from
> >>> PCI_EXP_LNKCTL itself.  There will definitely be bits set in
> >>> PCI_EXP_LNKCTL in normal operation, which is perfectly fine.
> >>> 
> >>> But if pci_exp_lnkctl_and or pci_exp_lnkctl_or are non-zero, the
> >>> platform is telling us to do something, and we're ignoring it.
> >>> *That's* what I think we might want to know about.  pci_info()
> >>> is probably sufficient; the user doesn't need to *do* anything
> >>> with it, I just want it in case we need to debug an issue.
> >> 
> >> My bad, Yes, that makes more sense to me. And, you're OK with
> >> removing the RCB tweaking as well?
> > 
> > Good question.  My hope is that the code here is just to make sure
> > that we don't *clear* PCI_EXP_LNKCTL_RCB when we want it set but a
> > type 2 record might clear it by mistake.
> 
> Commit e42010d8207f ("PCI: Set Read Completion Boundary to 128 iff
> Root Port supports it (_HPX)") fixes the "opposite" case, where _HPX
> sets the RCB even though the RC does not support it. That commit
> removes any RCB setting from the type 2 record from the equation,
> and sets RCB if the RC has the bit set. And to me, that seems to be
> the correct behaviour.

Thanks for digging into that.  You're right that it looks like
e42010d8207f ("PCI: Set Read Completion Boundary to 128 iff Root Port
supports it (_HPX)") was motivated by a machine with a Root Port with
PCI_EXP_LNKCTL_RCB cleared, but an _HPX record telling us to set
PCI_EXP_LNKCTL_RCB.

If we had realized at the time that _HPX Type 2 records are only for
the specific case of an OS that owns PCIe native hotplug but not AER,
we likely could have dropped the PCI_EXP_LNKCTL update completely.

The current behavior is that *if* there is an _HPX Type 2 record, we
set RCB to match the Root Port's RCB, regardless of what the Type 2
record is telling us.  Removing that PCI_EXP_LNKCTL update could
conceivably break something if:

  - Platform has an _HPX Type 2 record, and 

  - Root Port has PCI_EXP_LNKCTL_RCB cleared (only supports 64-byte
    Completions), and

  - Endpoint has PCI_EXP_LNKCTL_RCB set (may return 128-byte
    Completions), which would probably be a configuration error by
    BIOS

Removing it would also give up a little performance if there's a Type
2 record, the Root Port has PCI_EXP_LNKCTL_RCB set (supports 128-byte
Completions), but the Endpoint has PCI_EXP_LNKCTL_RCB cleared (may
only return 64-byte Completions).

> > We should audit PCI_EXP_LNKCTL_RCB usage to be sure that if we
> > remove this code, PCI_EXP_LNKCTL_RCB will still be set whenever it
> > needs to be set.  If we rely on the existence of an _HPX type 2
> > record for it to be set, that would be completely wrong.
> 
> I'll keep the RCB tweaking as is and add the pci_info() logging if
> the type 2 record attempts to change any bits in the Link Control
> register.

I think the fact that we only tweak RCB when an _HPX Type 2 record
exists is bogus.  As far as I can tell, RCB has nothing to do with AER
or hotplug.

I think we probably should add a pci_configure_rcb() called from
pci_configure_device() to always configure RCB to match the Root Port
RCB.  I would do this in a separate patch before removing the update
from program_hpx_type2().

Bjorn

