Return-Path: <linux-pci+bounces-25588-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A24CFA82C82
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 18:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA3B8881F36
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 16:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262B21C5D7D;
	Wed,  9 Apr 2025 16:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwQMiAA2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38DB1BF33F;
	Wed,  9 Apr 2025 16:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744216122; cv=none; b=Vk+xeHfeXfK52PzoWTAZDqjPRygO8TIIYfINL80bUlcq39M3VItYXC1VijxXZGkj8J/sN26RuYekwKvw/X+8zWWh9vTApcKxYMgWX1t+I/6va1sQfss2Vv3iarTqKoywtODO4B1NPVIkTJSUUZWsDOB7x5clfyEU3h3UdpV77S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744216122; c=relaxed/simple;
	bh=VK4BjMnzoTWDQZXyaQBP4pf+O4CP85YbyKM0qMOet9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fUzbEn5+kzl/aqp9agwZkOfbgouUFArCDoDWL5P2ffZy8RJRgL8Ft2NKq0wKhuNv/nPLxzreE6SRb2CI06jIkk23StK6LtzLTzyVV7+FrCs70x3dxOmApnfDpa2OgbhC5Qm52MV0XtFAZ6+LEYOOnvoc0or2W4sZbMhh+cziBTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwQMiAA2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97D7C4CEE9;
	Wed,  9 Apr 2025 16:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744216121;
	bh=VK4BjMnzoTWDQZXyaQBP4pf+O4CP85YbyKM0qMOet9A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bwQMiAA2kwT/8O/TGBDOpJE9ks5B85AB+KjePfyWtGTJqroSZqM7jS8XLdecU7TJi
	 abrA7wtOm8Mu3fsQyHj5Cq5Nd0CHWAzaWYyG0u+0j4cBOx3Lb0/YGYU1mfVmHgXtc8
	 oMU9QoKVNoCruYRYXmvXXULgzJrvM4NxEWpF5pdcIWj4zl3Va0IddwTfiPs9mJiwz/
	 hmHG2ZC4s5BXVXZlXNNxNZa4BKGhhcSBAwDt6KQioUiO9aBQSxnGw1LCURAyrJR2ed
	 hBtsffhU0yFSiTIvAr4Wd4N5nCWllHyXafof8hfaT1JXTsAFJHzk2X3puskJ1jYAjc
	 ltTa7U7qrX8TQ==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2c769da02b0so4317473fac.3;
        Wed, 09 Apr 2025 09:28:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUmfhYJwsKV4fV6bxvqQOxxTIpIvzCEI6XESEK6Ci/GWDZWKkRxRxBf6i8HAwhnfody7Js0uxg8i4R+@vger.kernel.org, AJvYcCWzZKeVPvBDFhsr0hhZq6t8u2GJLpbOcLlvASSe32OBnSZJgVZkOqsT+6lS3oPEW/vRnThk4JcVUqEi@vger.kernel.org
X-Gm-Message-State: AOJu0YwiJoqTjTQzulu4S1YkXNCxfsWOcVN/PKUJAVMefanDmIGBdKn3
	OIxv/Yy9CPMi24YkOg9nWwCHbG2cRCzj+lJfRtm/t2WPgyZ86toAGvjCzbrELg/dB5ARKQmmTgu
	sc5yKLiup6br53wr7yOy8dM0Z8Rs=
X-Google-Smtp-Source: AGHT+IHeaXl+LbmiH+Auy3YuTYnvLhsRISpmq7QcIzP22EM4jX+UyYCq2tTBqwUXp67EYHS49SXSttIS6ps3Cz4Hqx0=
X-Received: by 2002:a05:6871:d201:b0:2c1:5fe3:22eb with SMTP id
 586e51a60fabf-2d08dd799eamr2149857fac.15.1744216121025; Wed, 09 Apr 2025
 09:28:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0hK9m6-F5V+VWqsVPfr+WGLruHkP7ZvQsmwp21W9PHs_A@mail.gmail.com>
 <20250409144715.GA281314@bhelgaas>
In-Reply-To: <20250409144715.GA281314@bhelgaas>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 9 Apr 2025 18:28:28 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gsZrzX=uJ-WMZ9UW+arvavrsUBuEEs4rF3=QYW92KFtw@mail.gmail.com>
X-Gm-Features: ATxdqUHVHv7xHVqKQfQ-yvwZE_QM2hC7G6Idy3lTD7qDYeGVuw6DvnhSO1hzmTc
Message-ID: <CAJZ5v0gsZrzX=uJ-WMZ9UW+arvavrsUBuEEs4rF3=QYW92KFtw@mail.gmail.com>
Subject: Re: [PATCH 02/12] PCI/ACPI: Add PERST# Assertion Delay _DSM method
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Anshuman Gupta <anshuman.gupta@intel.com>, 
	intel-xe@lists.freedesktop.org, linux-acpi@vger.kernel.org, 
	linux-pci@vger.kernel.org, lenb@kernel.org, bhelgaas@google.com, 
	ilpo.jarvinen@linux.intel.com, lucas.demarchi@intel.com, 
	rodrigo.vivi@intel.com, badal.nilawar@intel.com, varun.gupta@intel.com, 
	ville.syrjala@linux.intel.com, uma.shankar@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 4:47=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> On Wed, Apr 09, 2025 at 02:30:31PM +0200, Rafael J. Wysocki wrote:
> > On Tue, Apr 8, 2025 at 10:48=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.o=
rg> wrote:
> > > On Wed, Apr 02, 2025 at 09:36:01PM +0200, Rafael J. Wysocki wrote:
> > > > On Wed, Apr 2, 2025 at 8:48=E2=80=AFPM Bjorn Helgaas <helgaas@kerne=
l.org> wrote:
> > >
> > > > > I don't *expect* rev 5 to be different.  But as a user of it,
> > > > > why would I change working, tested code that is not broken?
> > > > >
> > > > > The PCI DPC function 0xc is an example where rev 5 (per ECN)
> > > > > and rev 6 (per r3.3) are not compatible.
> > > > >
> > > > > If the OS implemented rev 5, then learns via function 0 that
> > > > > function 0xc is also supported at rev 6, and starts using the
> > > > > same OS code with rev 6, the OS is broken.
> > > >
> > > > Yes, in this case the backward compatibility language in the
> > > > _DSM definition is obviously not followed.
> > >
> > > Rev 5 in the ECN isn't compatible with rev 6 in the PCI FW r3.3
> > > spec, so it doesn't follow the ACPI compatibility requirement.
> > > And this is documented in PCI FW, which says "Fn 0xC was added
> > > with rev 5 (see ECN for rev 5 details); here is how rev 6 works."
> > >
> > > An OS implemented to the ECN doesn't know that rev 6 is different
> > > from rev 5; it assumes they're the same because ACPI says we can
> > > assume that, and PCI FW r3.3 even says the OS should use the same
> > > rev for all functions.
> >
> > OK (and this is important because PCI FW r3.3 is the spec defining
> > the interface)
> >
> > > If OS adds support for rev 6 of a some other function, it is
> > > supposed to use rev 6 of Fn 0xC, which doesn't work as the OS
> > > expects.
> >
> > IMV with respect to _DSM, the spec that has defined the interface
> > (PCI FW r3.3) takes precedence over the ACPI spec regardless of what
> > the latter is saying.  In this case ACPI provides a framework the
> > interface can be based on, but the actual interface is not defined
> > by it.
> >
> > Also, I think that the OS should use rev 6 if it is supported by the
> > firmware (for all functions) and it should literally follow the
> > definition of rev 6.
>
> I think you interpret rev 6 as a global revision of the platform,
> i.e., the platform supports rev 6 for every function it implements in
> this UUID (which is clearly the intent of the ACPI ASL example).

Yes, I do.

> I suggest that it would be better to interpret the revision
> individually for each function because it removes the backwards
> compatibility assumption and reduces the testing burden.
>
> Most functions would be specified and implemented with rev 0, and
> would never have a rev 1.  There would only be a rev 1 of a function
> if we made a non backwards compatible change to it.
>
> Any other functions would be untouched, and they would still only
> support rev 0, not rev 1.

I think that it would just be confusing because both the OS and the
firmware would now have to remember which function is defined at which
revision.

Also the industry practice in this respect has been different so far, AFAIC=
S.

And PCI FW r3.3 wants the OS to use the same rev for all functions
which doesn't leave too much room for interpretation.

> > > I guess one could argue that "OS didn't add rev 6 support for
> > > anything until PCI FW r3.3 added a function at rev 6, r3.3 did
> > > mention the difference between Fn 0xC rev 5 and 6, and OS should
> > > have looked at all the already-implemented unrelated functions for
> > > possible changes between rev 5 and rev 6."
> >
> > Yes, it should.
>
> I don't think it's reasonable to require the person adding support for
> Fn 0xE rev 6 (TLP Processing Hints) to go back and add Fn 0xC rev 6
> (Downstream Port Containment) at the same time.

Well, if you know that the function is supposed to work the same in
the new rev, it only is a matter of changing the rev passed to
acpi_evaluate_dsm*().

> Assuming that "rev X works the same as rev X-1 and therefore rev X
> doesn't need to be tested" seems unwise to me.

So say you've only changed the rev passed to acpi_evaluate_dsm*() as
per the above.  The only reason why it may not work is when there is a
bug in the firmware.

Now, suppose that you don't change anything and stick to rev X-1, but
there is a new version of the firmware that contains a bug in the
given _DSM implementation.  Same thing.

I get the "only the tested code is trustable" argument, but its
applicability here is naturally limited.

> But even if we normally rely on that assumption, in this case Fn 0xC rev =
5 and rev 6
> are different, so we'd be adding new code that would require testing
> on every platform that supports rev 6 of any function.

Unfortunately, as far as OS-firmware interfaces are concerned, you
need to trust the other end to do the right thing because you cannot
test all of the possible combinations.

> > What if the functions on the firmware side depend on each other
> > interfally and the firmware gets confused if revisions are mixed up
> > on the OS side?
>
> In such a case, the backwards compatibility assumption doesn't apply
> to those functions, so the spec would have to document multiple
> revisions of them, and IMO that's the natural place to document
> a requirement to use the same revision for the set.

I'm not talking about the definition of the interface, but about
dependencies at the implementation level.

Given the PCI FW r3.3 provisions, firmware may assume that the OS will
use the same rev for all functions and it may depend on that.

