Return-Path: <linux-pci+bounces-25191-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E80A79275
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 17:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AEC4171CF8
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 15:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E8818A93F;
	Wed,  2 Apr 2025 15:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E++gUSbO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB4E175D39;
	Wed,  2 Apr 2025 15:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743609023; cv=none; b=f7dyNHcXyKCFgvk5lRnNJB4Gr/iDgnWExiWDtMei2ozohvplJrqAs6S8ZAV7m9Bw3SQBPEIUJ6ZLRCa4tD42HTIY31rfpm+I5vghjFEjrRPfdIT0liJRt8R5e/vaX50T3pTgYlA8ZBYJS+1ZUJo0R1sBBii8X4jV3sESh/fX6QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743609023; c=relaxed/simple;
	bh=SCEOqVr9EF2j+AiLynbiJ+Gwbt/SG0e48t4O5jgA6W0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gHZFRTg65V+NzWEVovhsK6zaECX0oWe9AtmWgE1T2Bw9kcSswRibo/NOeWu9AXv6NbB22Qk5iz+5b+vDiCBBmae8XLn5WEBLzuIKHxAkRI5BXORXaNQq93nrr8zwKOSK3WpgAqkV/Prjdn6KM5h+lb7hwDbrovM53i9Odok3pg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E++gUSbO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C3DBC4CEEA;
	Wed,  2 Apr 2025 15:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743609022;
	bh=SCEOqVr9EF2j+AiLynbiJ+Gwbt/SG0e48t4O5jgA6W0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=E++gUSbOYZf1eQY5v1Jm3tVgXfc1YmPhXQ3fwRMUgRvq4Fhq8bL2A/jO/jBTEinrX
	 EnNuBYWqOmMKAf0bTuMWRsplN4hGn2u8lZv7+3r7inJhprJqev1FNNZ09gy190YSIP
	 tHssKkTuJLIvPlnGXDjBgPoiiC1HH764S4H3VaWArIM5SMTb3tK7Jubz0cT3Cc6Svn
	 qSkxJzrPUqzxEucdZ6rxJEogcRJ+/6BFsYcmcPWi5T50Ft5RLKFUqdaoidjvgvnBIr
	 eekKaxgFmA/SDCQ9EpirgV9ERkvyYdYbOQC1JA5cjd3jq0Opc1yEKwlNcKUzMBdJ8D
	 tO4NKtA6qlCwg==
Date: Wed, 2 Apr 2025 10:50:20 -0500
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
Message-ID: <20250402155020.GA1725452@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0juJFTbPJh2rTmFe4gF9LzXsfao0k3ne2eXd5OqubtwCw@mail.gmail.com>

On Wed, Apr 02, 2025 at 04:52:55PM +0200, Rafael J. Wysocki wrote:
> On Wed, Apr 2, 2025 at 4:21 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Wed, Apr 02, 2025 at 01:06:42PM +0200, Rafael J. Wysocki wrote:
> > > On Tue, Apr 1, 2025 at 5:36 PM Anshuman Gupta <anshuman.gupta@intel.com> wrote:
> > > >
> > > > Implement _DSM Method 11 as per PCI firmware specs
> > > > section 4.6.11 Rev 3.3.
> >
> > > > +int pci_acpi_add_perst_assertion_delay(struct pci_dev *dev, u32 delay_us)
> > > > +{
> > > > +       union acpi_object in_obj = {
> > > > +               .integer.type = ACPI_TYPE_INTEGER,
> > > > +               .integer.value = delay_us,
> > > > +       };
> > > > +
> > > > +       union acpi_object *out_obj;
> > > > +       acpi_handle handle;
> > > > +       int result, ret = -EINVAL;
> > > > +
> > > > +       if (!dev || !ACPI_HANDLE(&dev->dev))
> > > > +               return -EINVAL;
> > > > +
> > > > +       handle = ACPI_HANDLE(&dev->dev);
> > > > +
> > > > +       out_obj = acpi_evaluate_dsm_typed(handle, &pci_acpi_dsm_guid, 4,
> > >
> > > This is something I haven't noticed in the previous patch, but also
> > > applies to it.
> > >
> > > Why is rev 4 of the interface hard-coded here?
> >
> > Thanks for asking this because it's related to the whole _DSM revision
> > question that I don't understand.
> >
> > If we didn't use rev 4 here, what should we use?  The PCI Firmware
> > spec, r3.3, sec 4.6.11, documents this interface and says "lowest
> > valid Revision ID value is 4", so that's the source of the 4.
> 
> Well, the "lowest valid Revision ID" does not generally mean the "only
> valid Revision ID".

True, but why should the kernel change from using the tested revision
ID to some other revision ID?  What would be the benefit of using rev
5?

PCI Firmware r3.3 does contain a statement that "OSPM must invoke all
Functions other than Function 0 with the same Revision ID value," but
IMO that was a mistake, and we just approved an ECR to remove it.

> > My argument is that the spec documents rev 4, the kernel code was
> > tested with rev 4, so what would be the benefit of using a different
> > revision here?
> 
> I'm talking about using a symbol to represent the number 4, not about
> possibly using a different number, along the lines of using, say,
> ACPI_FADT_LOW_POWER_S0 instead of putting BIT(21) directly into the
> code.
>
> The value is not likely to change, but using a symbol for representing
> it has merit (it can be meaningfully used in searches, it can be
> documented etc.).

DSM_PCI_PERST_ASSERTION_DELAY (the function number) is a great thing
to search for.  I doubt a symbol for "4" would really add anything.
At least in PCI, changes to a particular _DSM function are relatively
rare.

> Now, I'm not sure how likely it is for the PCI Firmware spec to bump
> up the revision of this interface (I suppose that it will do so if a
> new function is defined), but even if it does so, the kernel will have
> to check both the new revision and rev 4 anyway, in case the firmware
> doesn't know about the new revision.

I guess the reason the OS would check both rev 5 and rev 4 would be
that a new platform might implement DSM_PCI_PERST_ASSERTION_DELAY only
at rev 5?  I think this would be a real mistake in terms of
implementing something to the spec.  

The spec documents DSM_PCI_PERST_ASSERTION_DELAY rev 4.  Some
platforms implemented and tested DSM_PCI_PERST_ASSERTION_DELAY rev 4.
Linux added and tested support for DSM_PCI_PERST_ASSERTION_DELAY rev
4.  I propose new platforms should also implement and test
DSM_PCI_PERST_ASSERTION_DELAY rev 4.

If a new platform implements only DSM_PCI_PERST_ASSERTION_DELAY rev 5,
there is no actual documentation for that rev other than the spec
assertion that "rev 5 must support all functions defined by previous
revs of the UUID."  IMO this is nonsense.  The platform might have no
need to implement all the functions defined for the UUID.

Even if the platform makes all its functions valid for "the lowest
valid Revision ID" through the "current Revision ID", there's nothing
other than the spec assertion to guarantee that they all behave the
same.  And dealing with multiple revisions that are "supposed" to be
the same just makes work and risk for the OS.

Bjorn

