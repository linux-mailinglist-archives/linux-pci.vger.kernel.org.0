Return-Path: <linux-pci+bounces-37125-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA326BA4F7C
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 21:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64F962A6AA3
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 19:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285FB278170;
	Fri, 26 Sep 2025 19:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QeQnzs57"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1164244671;
	Fri, 26 Sep 2025 19:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758915031; cv=none; b=MIgumDbs1Jh2Dx75qFWmVc9+wUb4N0Kzk4e+VPeEEUp+i6IWKAjubr96gfENBpig5TI2vkBvR+m18yijYzfv6xBem+UOPiN0JN/3NJNJcTxwqxPFJhw0vutxmATqU6gYvtutT+HxQp94tr/w74vrA2tzfqBDr6IlKEl7TTb6dKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758915031; c=relaxed/simple;
	bh=mnTVzD+4SmlciTZJzx2zkfZKFjwvOqhiOC5WAFmeHTU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Vm0UdVhOhnxbd8QuBPJgNbYT6mLmXvWjVpO6I8GnllfvQkmTp9pVC2wfbnMPyqfUNe5Le0y4ncgaOiaCIU/SvmMa50FBLqgZW+6CuEfjDRZXTeBuBn6Ndp+WNiltVSSM1MfrmcUxaDkZ0NiKOmdWLxc0YYZp7/QK61ICs5opJss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QeQnzs57; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B93C4CEF4;
	Fri, 26 Sep 2025 19:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758915030;
	bh=mnTVzD+4SmlciTZJzx2zkfZKFjwvOqhiOC5WAFmeHTU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=QeQnzs57nCtQd9o7xBb+o/OrBz4MJ58lfv4u5vqgqzbvs7lPwErtDyHyXBCKQz+2M
	 hkDVqWYwHkMg0gD3XqBHd0EFR62Dovx1FpAIE/v5Ii8O++8SZpc0LvjDUpwW5dZLm8
	 qXBt3I1DykcLM1Co/mjOSf+fpIRD2InXz9WSU+E5NmDLC0ENtn1ijhzyx4rU3RygBK
	 1mv4vWYq6wCpYFI11OxfnrQrUOcWOoROzW/VwhY6BXianDY7VARTELckDP37JHhw6o
	 f4uuoAQeFyM4dKDbEPuwxtCOdQxoK82exHxMjmYw6X43ZUbV4YinX+p30UV+m1DKWa
	 O1ez2p+kDRB3A==
Date: Fri, 26 Sep 2025 14:30:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: Re: [PATCH 2/2] PCI: Resources outside their window must set
 IORESOURCE_UNSET
Message-ID: <20250926193029.GA2254976@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2493cba7-151d-5ce6-5f33-e56966baac7a@linux.intel.com>

On Fri, Sep 26, 2025 at 03:21:17PM +0300, Ilpo Järvinen wrote:
> On Thu, 25 Sep 2025, Bjorn Helgaas wrote:
> > On Wed, Sep 24, 2025 at 04:42:28PM +0300, Ilpo Järvinen wrote:
> > > PNP resources are checked for conflicts with the other resource in the
> > > system by quirk_system_pci_resources() that walks through all PCI
> > > resources. quirk_system_pci_resources() correctly filters out resource
> > > with IORESOURCE_UNSET.
> > > 
> > > Resources that do not reside within their bridge window, however, are
> > > not properly initialized with IORESOURCE_UNSET resulting in bogus
> > > conflicts detected in quirk_system_pci_resources():

> > > @@ -329,6 +349,18 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
> > >  			 res_name, (unsigned long long)region.start);
> > >  	}
> > >  
> > > +	if (!(res->flags & IORESOURCE_UNSET)) {
> > > +		struct resource *b_res;
> > > +
> > > +		b_res = pbus_select_window_for_res_addr(dev->bus, res);
> > > +		if (!b_res ||
> > > +		    b_res->flags & (IORESOURCE_UNSET | IORESOURCE_DISABLED)) {
> > > +			pci_dbg(dev, "%s %pR: no initial claim (no window)\n",
> > > +				res_name, res);
> > 
> > Should this be pci_info()?  Or is there somewhere else that we
> > complain about a child resource that's not contained in a bridge
> > window?
> 
> AFAIK, there's no other print. The kernel didn't even recognize this case 
> until now so how could there have been one?!

> They'd generally show up as failures later in resource assignment if the 
> resource doesn't fit to the bridge window [1], which should also set 
> IORESOURCE_UNSET, but good luck for inferring things from that. It's 
> tedious, I know. :-) If the bridge window is large enough, the base 
> address would just change where the resource fits (I think).
> 
> It can be pci_info() if you think that's better. I just picked the level 
> which is the least noisy. We can go with pci_info() now and if the logging 
> turns out excessive when we start to see dmesgs with it, we can of course 
> adjust it later so it's not permanent either way.
> 
> In any case, there's not much user can do for these as it's the setup FW 
> gave us.
> 
> > I recently got an internal report of child BARs being reassigned, I
> > think because they weren't inside a bridge window, and the dmesg log
> > (from an older kernel) showed the BAR reassignments, but didn't say
> > anything about the *reason* for the reassignment.
> 
> Resource reassignment is only done after the resource was initially 
> assigned so I'm not sure if that inferring chain is sound.
> 
> Admittedly, you didn't exactly specify how you picked up that it was 
> "reassigned" so it could be just terminology that doesn't match what 
> setup-bus/res.c considers as resource reassignment. That is, if BAR's 
> address was simply changed from the initial, that's not "reassignment" in 
> the sense used by the kernel.

Here's the case I saw (a v6.1 kernel, so old log messages):

  pci 0000:00:00.0: bridge window [mem 0x80000000-0x97fffffff 64bit pref] to [bus 01-05] add_size 80000000 add_align 80000000
  pci 0000:00:00.0: BAR 15: assigned [mem 0x380000000-0xcffffffff 64bit pref]
  pci 0000:01:01.0: BAR 0: [mem 0xb00000000-0xbffffffff 64bit pref]
  ...
  pci 0000:01:01.7: BAR 0: [mem 0x400000000-0x4ffffffff 64bit pref]
  pci 0000:01:01.0: BAR 0: assigned [mem 0x400000000-0x4ffffffff 64bit pref]

Obviously these initial BAR 0 values don't fit in the
[0x80000000-0x97fffffff] bridge window, so I think we moved and
expanded it and then assigned the BARs to be inside.

I was thinking might get the "can't claim; no compatible bridge
window" message in pci_claim_resource() as a clue, but we didn't.

This *seems* like a firmware defect: why would firmware bother to
program these BARs at all unless it also made a bridge window that
could reach them.

Bjorn

