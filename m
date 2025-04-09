Return-Path: <linux-pci+bounces-25565-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE18A828DB
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 16:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 131C27B992D
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 14:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BA0267B8C;
	Wed,  9 Apr 2025 14:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYg0UsXf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6FF267B89;
	Wed,  9 Apr 2025 14:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744210037; cv=none; b=ps/2y5kqSa37yls+JXUNa5JKrpOP5Y0aJGxVZipwh0S+mB3YuLV7UZal/mhbrSQIRXRUkytapEowYktRWFGtyLuNsI+yAMOOVbpgNMWb6ZdeXraR9UnJAz7j+zpQ7p+cmq+2RRbtZrlzvG5f7gNF0XtilEL5CTgftZPe9arClTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744210037; c=relaxed/simple;
	bh=C8Vj+cO2+6SCJKLP04VbSM0u2J9a1Ayonscv94QCWhU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NV/FmUwp4kJgBCjIognum0qIwV5wkxCqPWjCRO9EB+ruadoBsxnnv+YubqNUsTfHuxmgIS/Mgxo32Pz6aU61n/AWucWII4sLqzPcdbhIk2rr4tyH3c2NrDrrrlzO7I8kRlKtYRWqYTqAUdZLYzFCW6hqePPxz6VDX55X63/YskQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IYg0UsXf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6670C4CEE2;
	Wed,  9 Apr 2025 14:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744210036;
	bh=C8Vj+cO2+6SCJKLP04VbSM0u2J9a1Ayonscv94QCWhU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=IYg0UsXfpomGXW7EWyYjtv4CXs1wws+z2a1+/4K9Uac3rYofw0SCsSi1Okve9XXrX
	 yhdtsIsi73PpZAxHVr2GviCk78PKWRnbG9qUXarWoBi40ZyKvm7/k48G5RZgE26nx5
	 acbFa8n9y0PUdxc8eBntozb/qnJiTWCGxJT25pe3mo5GhrSsf8MIvd+imh2+o2hATH
	 skW0ryDNo6bqT+1zRW3igbjXmazKyc6gpj9q/ekA2XbGut1VG2Jt2rzu6z+CMdr2GO
	 MEQZk7xQnvt+kQ2oJ2P4Wvy5RW/dcB88scjuxAMmVsG6Y/BuOH0LHz7rUIbGcRonmI
	 EBJk1wLetsjYg==
Date: Wed, 9 Apr 2025 09:47:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Anshuman Gupta <anshuman.gupta@intel.com>,
	intel-xe@lists.freedesktop.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, lenb@kernel.org, bhelgaas@google.com,
	ilpo.jarvinen@linux.intel.com, lucas.demarchi@intel.com,
	rodrigo.vivi@intel.com, badal.nilawar@intel.com,
	varun.gupta@intel.com, ville.syrjala@linux.intel.com,
	uma.shankar@intel.com
Subject: Re: [PATCH 02/12] PCI/ACPI: Add PERST# Assertion Delay _DSM method
Message-ID: <20250409144715.GA281314@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hK9m6-F5V+VWqsVPfr+WGLruHkP7ZvQsmwp21W9PHs_A@mail.gmail.com>

On Wed, Apr 09, 2025 at 02:30:31PM +0200, Rafael J. Wysocki wrote:
> On Tue, Apr 8, 2025 at 10:48 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Wed, Apr 02, 2025 at 09:36:01PM +0200, Rafael J. Wysocki wrote:
> > > On Wed, Apr 2, 2025 at 8:48 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > > > I don't *expect* rev 5 to be different.  But as a user of it,
> > > > why would I change working, tested code that is not broken?
> > > >
> > > > The PCI DPC function 0xc is an example where rev 5 (per ECN)
> > > > and rev 6 (per r3.3) are not compatible.
> > > >
> > > > If the OS implemented rev 5, then learns via function 0 that
> > > > function 0xc is also supported at rev 6, and starts using the
> > > > same OS code with rev 6, the OS is broken.
> > >
> > > Yes, in this case the backward compatibility language in the
> > > _DSM definition is obviously not followed.
> >
> > Rev 5 in the ECN isn't compatible with rev 6 in the PCI FW r3.3
> > spec, so it doesn't follow the ACPI compatibility requirement.
> > And this is documented in PCI FW, which says "Fn 0xC was added
> > with rev 5 (see ECN for rev 5 details); here is how rev 6 works."
> >
> > An OS implemented to the ECN doesn't know that rev 6 is different
> > from rev 5; it assumes they're the same because ACPI says we can
> > assume that, and PCI FW r3.3 even says the OS should use the same
> > rev for all functions.
> 
> OK (and this is important because PCI FW r3.3 is the spec defining
> the interface)
> 
> > If OS adds support for rev 6 of a some other function, it is
> > supposed to use rev 6 of Fn 0xC, which doesn't work as the OS
> > expects.
> 
> IMV with respect to _DSM, the spec that has defined the interface
> (PCI FW r3.3) takes precedence over the ACPI spec regardless of what
> the latter is saying.  In this case ACPI provides a framework the
> interface can be based on, but the actual interface is not defined
> by it.
> 
> Also, I think that the OS should use rev 6 if it is supported by the
> firmware (for all functions) and it should literally follow the
> definition of rev 6.

I think you interpret rev 6 as a global revision of the platform,
i.e., the platform supports rev 6 for every function it implements in
this UUID (which is clearly the intent of the ACPI ASL example).

I suggest that it would be better to interpret the revision
individually for each function because it removes the backwards
compatibility assumption and reduces the testing burden.

Most functions would be specified and implemented with rev 0, and
would never have a rev 1.  There would only be a rev 1 of a function
if we made a non backwards compatible change to it.

Any other functions would be untouched, and they would still only
support rev 0, not rev 1.

> > I guess one could argue that "OS didn't add rev 6 support for
> > anything until PCI FW r3.3 added a function at rev 6, r3.3 did
> > mention the difference between Fn 0xC rev 5 and 6, and OS should
> > have looked at all the already-implemented unrelated functions for
> > possible changes between rev 5 and rev 6."
> 
> Yes, it should.

I don't think it's reasonable to require the person adding support for
Fn 0xE rev 6 (TLP Processing Hints) to go back and add Fn 0xC rev 6
(Downstream Port Containment) at the same time.

Assuming that "rev X works the same as rev X-1 and therefore rev X
doesn't need to be tested" seems unwise to me.  But even if we
normally rely on that assumption, in this case Fn 0xC rev 5 and rev 6
are different, so we'd be adding new code that would require testing
on every platform that supports rev 6 of any function.

> What if the functions on the firmware side depend on each other
> interfally and the firmware gets confused if revisions are mixed up
> on the OS side?

In such a case, the backwards compatibility assumption doesn't apply
to those functions, so the spec would have to document multiple
revisions of them, and IMO that's the natural place to document
a requirement to use the same revision for the set.

Bjorn

