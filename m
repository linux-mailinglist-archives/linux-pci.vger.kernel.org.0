Return-Path: <linux-pci+bounces-44390-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4854D0B590
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 17:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AD6331058DD
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 16:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A43364043;
	Fri,  9 Jan 2026 16:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qfAsMkHM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F408329E7B;
	Fri,  9 Jan 2026 16:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767976794; cv=none; b=MM3PaylNw2pP67aOt2pCzm+gYhmmUgLsmGx2RMBnMcbQMzUG4zcyEhJ5uHFoxmraTzsMH2Sbat8BveaGQwsr27hnjpl3U2rUm/Ln8qZCnVehdfciJyDVzqeR4ooJtMWRX639Yv+uv72Fr8oCuOnfZyd25D1759Q5xi5ts6ISPfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767976794; c=relaxed/simple;
	bh=4pHzRzYLlVGZT5+3MyeXWYF8d7dTW6RCYV07QofgAUI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hdp4Mih7YobxUSdFMtq0i8Qm+Kb7Isls9liZ/1RFOTF0Ald64C+0U5ELZq1Q4SVNzXsYraTwCynY/Hln8W+XpmiL/XbrzcwNVbx7c22abQrvLafuIaxUb8cza3hrtJ0Ilv9BY0Q4UfHqgioHeAay2FMcTpNL50R9AkBN92bTzv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qfAsMkHM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C25EC19422;
	Fri,  9 Jan 2026 16:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767976794;
	bh=4pHzRzYLlVGZT5+3MyeXWYF8d7dTW6RCYV07QofgAUI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=qfAsMkHMuiAnVYdkcdey0zzyX5NHLnLAo1ig1djXEu9Uv2Mj7tRCp6+aHqJ9Q4qGz
	 Njyur2T3I4tBAhciIYrTCwWIxCG5NaThdTCUPztpf/ByAEZo+tdaoNV8Z2DRdzSKsQ
	 ha3R6uOTKmcJEl6cI3R8+bXE90FV1M62S/yG6ZWDQcDnwZLAjJT+6K9f2HPh6FOS3M
	 QsiELMT/qY0psR8nyxpXTZb/oyLHm6eeKOeriNOlAlRT4/mwnCXrrZOFezp63YWTPs
	 1nTAljOv+mlO5FqUIAbVMygUCtV99c9mebdx2BrkPPRDllCDm+VRoIyEwXpzOBDM7c
	 PaipDlz2ZYQvg==
Date: Fri, 9 Jan 2026 10:39:52 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Bjorn Helgaas <bhelgaas@google.com>, sparclinux@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Nathaniel Roach <nroach44@gmail.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: [PATCH RESEND 1/1] SPARC/PCI: Correct 64-bit non-pref -> pref
 BAR resources
Message-ID: <20260109163952.GA548925@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <381abcc3-d6c3-ba57-4e69-1e65083f1b6c@linux.intel.com>

On Thu, Jan 08, 2026 at 03:13:18PM +0200, Ilpo Järvinen wrote:
> On Wed, 7 Jan 2026, Bjorn Helgaas wrote:
> > On Mon, Nov 24, 2025 at 07:04:11PM +0200, Ilpo Järvinen wrote:
> > > SPARC T5-2 dts describes some PCI BARs as 64-bit resources without
> > > pref(etchable) bit (0x83... vs 0xc3... in assigned-addresses) for
> > > address ranges above the 4G threshold. Such resources cannot be placed
> > > into a non-prefetchable PCI bridge window that is capable only to
> > > 32-bit addressing. As such, it looks the platform is improperly
> > > describe by dts.
> > > 
> > > Kernel detect this problem (see the IORESOURCE_PREFETCH check in
> > > pci_find_parent_resource()) and fails to assign these BAR resources to
> > > the resource tree due to lack of a compatible bridge window.
> > > 
> > > Prior to the commit 754babaaf333 ("sparc/PCI: Remove
> > > pcibios_enable_device() as they do nothing extra") SPARC arch code did
> > > not test whether device resources were successfully in the resource
> > > tree when enabling a device, effectively hiding the problem. After
> > > removing the arch specific enable code, PCI core's
> > > pci_enable_resources() refuses to enable the device when it finds not
> > > all mem resources are assigned, and therefore mpt3sas can't be enabled:
> > > 
> > > pci 0001:04:00.0: reg 0x14: [mem 0x801110000000-0x80111000ffff 64bit]
> > > pci 0001:04:00.0: reg 0x1c: [mem 0x801110040000-0x80111007ffff 64bit]
> > > pci 0001:04:00.0: BAR 1 [mem 0x801110000000-0x80111000ffff 64bit]: can't claim; no compatible bridge window
> > > pci 0001:04:00.0: BAR 3 [mem 0x801110040000-0x80111007ffff 64bit]: can't claim; no compatible bridge window
> > > mpt3sas 0001:04:00.0: BAR 1 [mem size 0x00010000 64bit]: not assigned; can't enable device
> > > 
> > > For clarity, this filtered log only shows failures for one mpt3sas
> > > device but other devices fail similarly. In the reported case, the end
> > > result with all the failures is an unbootable system.
> > > 
> > > Things appeared to "work" before the commit 754babaaf333 ("sparc/PCI:
> > > Remove pcibios_enable_device() as they do nothing extra") because the
> > > resource tree is agnostic to whether PCI BAR resources are properly in
> > > the tree or not. So as long as there was a parent resource (e.g. a root
> > > bus resource) that contains the address range, the resource tree code
> > > just places resource request underneath it without any consideration to
> > > the intermediate BAR resource. While it worked, it's incorrect setup
> > > still.
> > > 
> > > Add of fixup to set IORESOURCE_PREFETCH flag for a 64-bit PCI resource
> > > that has the end address above 4G requiring placement into the
> > > prefetchable window. Also log the issue.
> > > 
> > > Fixes: 754babaaf333 ("sparc/PCI: Remove pcibios_enable_device() as they do nothing extra")
> > > Reported-by: Nathaniel Roach <nroach44@gmail.com>
> > > Tested-by: Nathaniel Roach <nroach44@gmail.com>
> > > Closes: https://github.com/sparclinux/issues/issues/22
> > > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > 
> > Originally posted as attachment in response to Adrian's pointer to
> > Nathaniel's regression report:
> > 
> >   https://lore.kernel.org/r/d221be13-f652-cc75-90d1-92cf38e0110e@linux.intel.com
> > 
> > This seems reasonable to me and addresses a v6.18 regression, so I put
> > this on pci/for-linus for v6.19.
> > 
> > > ---
> > > 
> > > Resending with linux-pci@ ML.
> > > 
> > > Any comments on the approach are welcome. E.g., is the fixup done at a
> > > correct level? Should it be targeted specifically to the known failures
> > > (how?) to avoid hiding more platform description problems?
> > > 
> > > It seems VF BARs still have 64-bit non-pref despite this change, AFAICT,
> > > those are read directly from the device's config space so would require
> > > ordinary quirks. None of them result in device enable failing though so the
> > > issue is orthogonal to the one being fixed here.
> > 
> > The VF BARs that don't have PCI_BASE_ADDRESS_MEM_PREFETCH set is a
> > generic question, not anything sparc-specific, right?
> 
> What I tried to say is that on this platform, we have such cases, but that 
> being said they do not cause regression (and they cannot be "fixed" by the 
> same means either).
> 
> None of these BARs (non-VF and VF ones) would not get assigned because of 
> the IORESOURCE_PREFETCH check in pci_find_parent_resource() but 
> post-754babaaf333 ("sparc/PCI: Remove pcibios_enable_device() as they do 
> nothing extra"), enable device just doesn't like that. But because VF 
> BARs are treated "optional", only non-VF BARs cause enable fail 
> (unrelated to this issue, I got asked this week why VF resources are 
> optional and realized I don't know the answer myself).

I don't know either.  I think we currently try to assign the max
possible VF resources based on TotalVFs.  If that allocation fails,
none of the VFs are usable, even if we could have allocated smaller
areas and at least used *some* of the VFs.

That seems like it might be a little too aggressive because it makes
a device that supports a huge number of VFs completely unusable on a
platform with limited MMIO space, when we could in principle make it
usable with fewer VFs.

Bjorn

