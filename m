Return-Path: <linux-pci+bounces-25518-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C07A81720
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 22:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AAEC4E21E4
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 20:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2453721A931;
	Tue,  8 Apr 2025 20:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZeerjqIt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED9813CFB6;
	Tue,  8 Apr 2025 20:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744145316; cv=none; b=g7kAJ1tejJPCqS+FYi8zqL7y7uNScAErAwpLVI+GzrhYFSGxwwAeyc1NnQwByqe/XJyVSjGpZ+JWGEQcnwYrQLJnnCYvPH5qizvfwzIV9CzYx06YSAbCuKM5uqss34xBQ7vCrve2hs6AZ4DdwiPXaAKLx5NjxchZOG37HCXKe4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744145316; c=relaxed/simple;
	bh=zAvEvlzAln/TlRU8vv7yAddue9mFYC9Fd0ZT0VyLmDw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NluX8LK9UEglRpGeuncMoY8AeHvx20BOtnhNRshUc1h4lNHGPKGuPaIZTAI9HNd1Rd851gCnZhSEa8ucxxDkt3PO/QnGSGjjQT1SzlN/h2oAgbh+3dqk9uvgAuQlR8jMi+OJD7wXuhiK8vU4oBEZyZ0plx1uba74olE1CznwHTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZeerjqIt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5477FC4CEE5;
	Tue,  8 Apr 2025 20:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744145314;
	bh=zAvEvlzAln/TlRU8vv7yAddue9mFYC9Fd0ZT0VyLmDw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ZeerjqItVG+XzKiXVjEV3+a9A4z9SmvYa36d/vvVodFOpQeet67+HnRiQEfYnfPZt
	 AkNrjZQ2aIUus8osASPhych7Wtiw8F/AU2b4iJAjpnvS1omNVRfeXmiLqkawtGU5Ef
	 0DiLd882sIJ9NUcV+WJ/ePfxZHnogkjG37UvTWwUwwp14xOJk5pEzyt5+p/K5Byz0i
	 DFAQmTEwcB/wq02v+YZskwvvvy+Q9MP+PpIb4y/8mbrQbuoIQxI+F8Pzs5hlvBGBxt
	 T8YHVBHPXWk2iL0XhvXPTfkFhVBtpNQszU4nV6EBD65QuFuYQn3zBJChJoYCBgxczr
	 qowTh2+/K4GGQ==
Date: Tue, 8 Apr 2025 15:48:32 -0500
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
Message-ID: <20250408204832.GA64565@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hQjtTCu1wXgKvBWBBegbj-VD+Z0yBspt1uFes8Xun7Cw@mail.gmail.com>

On Wed, Apr 02, 2025 at 09:36:01PM +0200, Rafael J. Wysocki wrote:
> On Wed, Apr 2, 2025 at 8:48 PM Bjorn Helgaas <helgaas@kernel.org> wrote:

> > I don't *expect* rev 5 to be different.  But as a user of it, why
> > would I change working, tested code that is not broken?
> >
> > The PCI DPC function 0xc is an example where rev 5 (per ECN) and rev 6
> > (per r3.3) are not compatible.
> >
> > If the OS implemented rev 5, then learns via function 0 that function
> > 0xc is also supported at rev 6, and starts using the same OS code with
> > rev 6, the OS is broken.
> 
> Yes, in this case the backward compatibility language in the _DSM
> definition is obviously not followed.

Rev 5 in the ECN isn't compatible with rev 6 in the PCI FW r3.3 spec,
so it doesn't follow the ACPI compatibility requirement.  And this is
documented in PCI FW, which says "Fn 0xC was added with rev 5 (see ECN
for rev 5 details); here is how rev 6 works."

An OS implemented to the ECN doesn't know that rev 6 is different from
rev 5; it assumes they're the same because ACPI says we can assume
that, and PCI FW r3.3 even says the OS should use the same rev for all
functions.  If OS adds support for rev 6 of a some other function, it
is supposed to use rev 6 of Fn 0xC, which doesn't work as the OS
expects.

I guess one could argue that "OS didn't add rev 6 support for anything
until PCI FW r3.3 added a function at rev 6, r3.3 did mention the
difference between Fn 0xC rev 5 and 6, and OS should have looked at
all the already-implemented unrelated functions for possible changes
between rev 5 and rev 6."

I think that causes unnecessary changes in unrelated code.  The OS can
avoid the problem by *always* using Fn 0xC rev 5, regardless of what
rev it uses for other functions.

Of course, the OS can include support for multiple revs, e.g., it
could add support for Fn 0xC rev 6 and use that when available.  And
it could retain support for Fn 0xC rev 5 and use that if rev 6 isn't
available.

Bjorn

