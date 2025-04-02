Return-Path: <linux-pci+bounces-25195-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC3AA7956B
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 20:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4BFD7A326C
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 18:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD1219C54A;
	Wed,  2 Apr 2025 18:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rVa5JJDz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E745F5C96;
	Wed,  2 Apr 2025 18:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743619729; cv=none; b=krGB/TaCnaL3Snmrg9cY+PCAllI4Zp6DBm8J13vDoZQKFE0OVLGE3kAMrHaIPckNKDfBUZnTPnBLDOUEE7CEDjKSuOYLl8foUx9xHhTwrSvEERSDMv8lhyv5ckM0buM724oMllmM2GGpWpLBgVkFLAa9/VhB1aNwNhb3inKhGvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743619729; c=relaxed/simple;
	bh=9n+nahJDE/U1RQG5JyQjbtq0snxTgb1Z/IfOzLAX1bk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=aeVLllGvu5k8eaM9qGpdF3RNl49s7i+fYHTLV63IaWR35FbnTdXG2I6MkqrFWH7B+J1Ys7qyw2svfJMmOsCiXIv7dFIo4VtEBebX/N3nucV20icdry/5AMn8uWfFpy2Et2JKhaobLIeSX8DYIuV0zPxM4ETVoB6b2+5C1GvbgOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rVa5JJDz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA4DC4CEDD;
	Wed,  2 Apr 2025 18:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743619728;
	bh=9n+nahJDE/U1RQG5JyQjbtq0snxTgb1Z/IfOzLAX1bk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rVa5JJDzpVwSKYnz03saVOFl0CreqGqb9yKZ8Vsm+TxUyXdWfzzvCEUovr9kprDou
	 G4twRthSXLB9LKNyWC10G07q9hlw7QQ9u4z3i5TolnkYcswSLXnOWQZ6KHpTvXzYH5
	 Yf9W/05TCnw5mH74S3fUIckcXjPVdANll5idffeeEl4mIvHQ0OQa+AAMWpsCFW3/QX
	 S6jU5t+ShZvU6X+GdmJanq+oRF8L6lRB5H12Z0qTtBR+wkLFjel1+qamT+b8y4QJvb
	 jhbw1hQC+hq5Ey/3P92djiKBsaxFfCiYVODv6mHwWOaRWmOiSfJDcwkgHSJUsB3Dc8
	 q0aUw4x/bfOtg==
Date: Wed, 2 Apr 2025 13:48:47 -0500
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
Message-ID: <20250402184847.GA1737363@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0h+oaw48B4EcrbNTtcKKY=1BwLdTcXoS0CkKFypnOs3cA@mail.gmail.com>

On Wed, Apr 02, 2025 at 07:51:29PM +0200, Rafael J. Wysocki wrote:
> On Wed, Apr 2, 2025 at 5:50 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Wed, Apr 02, 2025 at 04:52:55PM +0200, Rafael J. Wysocki wrote:
> > > On Wed, Apr 2, 2025 at 4:21 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Wed, Apr 02, 2025 at 01:06:42PM +0200, Rafael J. Wysocki wrote:
> > > > > On Tue, Apr 1, 2025 at 5:36 PM Anshuman Gupta <anshuman.gupta@intel.com> wrote:
> > > > > >
> > > > > > Implement _DSM Method 11 as per PCI firmware specs
> > > > > > section 4.6.11 Rev 3.3.
> > > >
> > > > > > +int pci_acpi_add_perst_assertion_delay(struct pci_dev *dev, u32 delay_us)
> > > > > > +{
> > > > > > +       union acpi_object in_obj = {
> > > > > > +               .integer.type = ACPI_TYPE_INTEGER,
> > > > > > +               .integer.value = delay_us,
> > > > > > +       };
> > > > > > +
> > > > > > +       union acpi_object *out_obj;
> > > > > > +       acpi_handle handle;
> > > > > > +       int result, ret = -EINVAL;
> > > > > > +
> > > > > > +       if (!dev || !ACPI_HANDLE(&dev->dev))
> > > > > > +               return -EINVAL;
> > > > > > +
> > > > > > +       handle = ACPI_HANDLE(&dev->dev);
> > > > > > +
> > > > > > +       out_obj = acpi_evaluate_dsm_typed(handle, &pci_acpi_dsm_guid, 4,
> > > > >
> > > > > This is something I haven't noticed in the previous patch, but also
> > > > > applies to it.
> > > > >
> > > > > Why is rev 4 of the interface hard-coded here?
> > > >
> > > > Thanks for asking this because it's related to the whole _DSM revision
> > > > question that I don't understand.
> > > >
> > > > If we didn't use rev 4 here, what should we use?  The PCI Firmware
> > > > spec, r3.3, sec 4.6.11, documents this interface and says "lowest
> > > > valid Revision ID value is 4", so that's the source of the 4.
> > >
> > > Well, the "lowest valid Revision ID" does not generally mean the "only
> > > valid Revision ID".
> >
> > True, but why should the kernel change from using the tested revision
> > ID to some other revision ID?  What would be the benefit of using rev
> > 5?
> 
> TBH I'm not exactly buying the "tested revision ID" concept because
> what does it really mean?
> 
> If a given _DSM interface has been tested on one platform, does it
> necessarily mean that it will work on all of the other platforms
> implementing it?

No, all we can say is that this OS rev 4 code works on the platforms
we've tested.  Other platforms might have their own defects.

My point is that this OS code was written to the rev 4 spec and has
been tested, and we shouldn't change the code or the revision it uses
unless we're fixing something.

> > > Now, I'm not sure how likely it is for the PCI Firmware spec to
> > > bump up the revision of this interface (I suppose that it will
> > > do so if a new function is defined), but even if it does so, the
> > > kernel will have to check both the new revision and rev 4
> > > anyway, in case the firmware doesn't know about the new
> > > revision.
> >
> > I guess the reason the OS would check both rev 5 and rev 4 would
> > be that a new platform might implement
> > DSM_PCI_PERST_ASSERTION_DELAY only at rev 5?  I think this would
> > be a real mistake in terms of implementing something to the spec.
> 
> This is a real possibility, however, because there's nothing to
> prevent this kind of spec interpretation.
> 
> I didn't mean this, though.
> 
> Say the kernel wants to use a function that is only defined at rev
> 5.  It will invoke function 0 at rev 5 to see if this function is
> available, but then it may as well see if the other functions it
> wants to use are available at rev 5 because it will get this
> information from the same _DSM call.  If the platform firmware
> responds that they all are implemented, why won't the kernel use
> them all at rev 5?

This is an unnecessary change, since the OS tested its rev 4 code and
now we're saying the OS should use rev 5 instead, which the OS did not
test.  The reason rev 5 exists at all is probably that some completely
unrelated new function was added, and somebody decided it should be
rev 5.

I guess function 0 *could* have been defined to answer "yes/no" about
whether a single (function, revision) is implemented.  Then we
probably wouldn't be having this conversation.

But we do get an entire bitmask of implemented functions back from
function 0, which allows the possibility of using the same revision
for all the functions.  I suppose we could have a boot-time function
that calls function 0 with rev 0, 1, 2, ..., until it gets an empty
bitmask, and saves the highest rev with a non-empty mask.

In PCI we don't do that; instead, we call acpi_check_dsm() before
every acpi_evaluate_dsm().  The main reason is that I don't think it's
safe to change the function X rev just because function Y was added
later with a higher revision.

> > The spec documents DSM_PCI_PERST_ASSERTION_DELAY rev 4.  Some
> > platforms implemented and tested DSM_PCI_PERST_ASSERTION_DELAY rev
> > 4.  Linux added and tested support for
> > DSM_PCI_PERST_ASSERTION_DELAY rev 4.  I propose new platforms
> > should also implement and test DSM_PCI_PERST_ASSERTION_DELAY rev
> > 4.
> >
> > If a new platform implements only DSM_PCI_PERST_ASSERTION_DELAY
> > rev 5, there is no actual documentation for that rev other than
> > the spec assertion that "rev 5 must support all functions defined
> > by previous revs of the UUID."  IMO this is nonsense.  The
> > platform might have no need to implement all the functions defined
> > for the UUID.
> 
> Sure.  That's why function 0 should always be used.

Yes.  But the requirement that rev 5 must support all functions ever
previously documented for the UUID still makes no sense to me.  I
don't think there's any requirement that a platform implement ALL of
the documented PCI functions.

Maybe the intent is that this only applies to a given platform, i.e.,
that new firmware for that platform must continue to support all
functions and revisions that were ever supported on that platform?
That seems obvious to me and hardly worth mentioning.

> > Even if the platform makes all its functions valid for "the lowest
> > valid Revision ID" through the "current Revision ID", there's
> > nothing other than the spec assertion to guarantee that they all
> > behave the same.  And dealing with multiple revisions that are
> > "supposed" to be the same just makes work and risk for the OS.
> 
> You seem to be questioning the interface versioning at large by
> saying that there is no real guarantee of backwards compatibility
> between consecutive interface revisions on the same platform.

That's exactly what I'm saying, although I think problems are more
likely across different platforms.  There's the requirement in the
spec, but that's just words on a page.  There's no way to enforce or
validate it.

> Presumably, though, the interface is adhering to some specification
> which defines the behavior of the functions (and the set of
> available functions in the first place) for all of the valid
> revisions of it.  The OS and the platform firmware both follow the
> same spec and so they should be mutually compatible.  If this
> particular spec defines rev 5 to be an exact superset of rev 4,
> there is no reason to expect anything else.

I don't *expect* rev 5 to be different.  But as a user of it, why
would I change working, tested code that is not broken?

The PCI DPC function 0xc is an example where rev 5 (per ECN) and rev 6
(per r3.3) are not compatible.

If the OS implemented rev 5, then learns via function 0 that function
0xc is also supported at rev 6, and starts using the same OS code with
rev 6, the OS is broken.

Bjorn

