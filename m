Return-Path: <linux-pci+bounces-24388-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B3DA6C21D
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 19:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C135A1897F08
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 18:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7520722DF9E;
	Fri, 21 Mar 2025 18:07:58 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2ED22DF96;
	Fri, 21 Mar 2025 18:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742580478; cv=none; b=CSdaO+O85CQ4z3BBPGU8FHwvvink/1DL6HXG3WOxcH5IKnS8RcyyA/r1JN6gOGlBAdFBF/1Q0xsg1aLr6s15Dgmnktyw13vDCR70x6pjaw/EUADRTbiuEUff7Kc7uIM1KVkLNtkYWqq5LVh9Qldz//ZfBri7ZMId4JUppl9FJjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742580478; c=relaxed/simple;
	bh=Fhfz8OLbMJGn2RhXYgEr4QUyo4HEVfdIWVl+nUy8CXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LcU7rH89cZFsAicYJcAwyqujdgxrZyF1WDLNXpwZILuRIHAaim4ODNyolqle2jUDNqf+bvYUl3hQujPeSMrzoQfV/hU6Apn4vNYZmKTjWVcsUtsygYRerbDp7eZBirzOFC4BpxtrFNM7qMOGy5HG8HqSxwkcUtwTrvG5TJChdXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 64B9028041578;
	Fri, 21 Mar 2025 19:07:47 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 45E432CDCD; Fri, 21 Mar 2025 19:07:47 +0100 (CET)
Date: Fri, 21 Mar 2025 19:07:47 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] PCI/hotplug: Don't enable HPIE in poll mode
Message-ID: <Z92q84PdWVtftxI4@wunner.de>
References: <20250321162114.3939-1-ilpo.jarvinen@linux.intel.com>
 <20250321170919.GA1130592@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321170919.GA1130592@bhelgaas>

On Fri, Mar 21, 2025 at 12:09:19PM -0500, Bjorn Helgaas wrote:
>   - It does make me wonder why we have both pcie_enable_interrupt()
>     and pcie_enable_notification().  Apparently we don't need to
>     restore the other PCI_EXP_SLTCTL bits when resuming?  Maybe we
>     depend on some other restoration, e.g., pci_restore_pcie_state(),
>     that happens first?

Yes and yes.

> 
>     That makes me worry that there's a window between
>     pci_restore_pcie_state() and pcie_enable_interrupt().  I suppose
>     we probably saved the pcie state after pcie_disable_interrupt(),
>     so HPIE would be disabled in the saved state.

Yes.

> 
>   - I also wonder about the fact that pci_restore_pcie_state() doesn't
>     account for Command Completed events, so we might write to Slot
>     Control too fast.

We don't. :)  See commit 469e764c4a3c ("PCI: pciehp: Obey compulsory
command delay after resume").

So this is all a bit subtle and perhaps restoring the Slot Control
registers should not be done in pci_restore_pcie_state() but rather
in pciehp and pnv (which are the only hotplug drivers touching
PCI_EXP_SLTCTL).

In particular, if hotplug control was not granted by the platform,
I don't think the kernel is supposed to touch the Slot Control
registers at all.  So it probably shouldn't restore them either.

We've been doing this since 2006 with commit b56a5a23bfec ("PCI:
Restore PCI Express capability registers after PM event").
Negotiation of _OSC wasn't added until 2010 with 75fb60f26bef
("ACPI/PCI: Negotiate _OSC control bits before requesting them").
But the OSC_PCI_EXPRESS_NATIVE_HP_CONTROL predates the introduction
of git.  I guess noone ever realized that restoring Slot Control
shouldn't be done if hotplug control wasn't granted.  I can't
remember anyone ever reporting issues because of that though.

On the other hand, changing something like this always risks
regressions.

>   - It's annoying that pcie_enable_interrupt() and
>     pcie_disable_interrupt() are global symbols, a consequence of
>     pciehp being split across five files instead of being one, which
>     is also a nuisance for code browsing.

Roughly,
pciehp_core.c contains the interface to the PCI hotplug core
  (registering the hotplug_slot_ops etc),
pciehp_hpc.c contains the interaction with hardware registers,
pciehp_core.c contains the state machine,
pciehp_pci.c contains the interaction with the PCI core
  (enumeration / de-enumeration of devices on slot bringup / bringdown).

The only reason I've refrained from making major adjustments to this
structure in the past was that it would make "git blame" a little more
difficult and applying fixes to stable kernels would also become somewhat
more painful as it would require backporting.

>     Also annoying that they are generically named, with no pciehp
>     connection (probably another consequence of being split into
>     several files).

They can be renamed.  There's no good reason for using the "pcie_"
prefix, it just appears to be a historic artifact.

>   - The eb34da60edee commit log hints at the reason for testing
>     pme_is_native().  Would be nice if there were also a comment in
>     the code about this because it's not 100% obvious why we test PME
>     support in the PCIe native hotplug driver.
> 
>   - Also slightly weird that eb34da60edee added the pme_is_native()
>     tests in pciehp_suspend() and pciehp_resume(), but somewhere along
>     the line the suspend-side one got moved to
>     pciehp_disable_interrupt(), so they're no longer parallel for no
>     obvious reason.
> 
>   - I forgot why we have both pcie_write_cmd() and
>     pcie_write_cmd_nowait() and how to decide which to use.

pcie_write_cmd_nowait() is the "fire and forget" variant,
whereas pcie_write_cmd() can be thought of as the "_sync" variant,
i.e. the control flow doesn't continue until the command has been
processed by the slot.

E.g. pciehp_power_on_slot() waits for the slot command to complete
before making sure the Link Disable bit is clear.  It wouldn't make
much sense to do the latter when the former hasn't been completed yet.

Thanks,

Lukas

