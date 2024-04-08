Return-Path: <linux-pci+bounces-5897-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 350BD89CC60
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 21:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D312C1F23565
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 19:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BD2145321;
	Mon,  8 Apr 2024 19:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3QsaudN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C62145320;
	Mon,  8 Apr 2024 19:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712604302; cv=none; b=jAiy10uQ52Og5mI0MENRNNBy7QlS0K7R8IwZdpCEyDJQgwsjFrvXp2EZSG6q1nKKF7h0k8J/wV8sm82BC/NWJbgkdVeNfjUFzNIqDl7di6AxX0HXfEKi3MXIkPm92UA+33g/NtbmjQlu6LpaURJ5PysAV451Q1MSmP+P1CZZ7Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712604302; c=relaxed/simple;
	bh=a9D0uk0Qedve0Ll3vO3jl2yVBSXkeqcxwBkYczAKJMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RcdnY3SJ/FSp0x2SVDv6lRQL5vELyNBYDZayweKHqwD37pSubWSyjXKX8t3jklFUl94T0OB5dAke/RIxqKJscSRrsd6y5yFvAErzTCQHFqklGsDXE3vJqrx1sw0JacfPZu8VZsaYtJdHXTg/02R8tFam4bukgV0SOTjnWjrx4lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3QsaudN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F9D9C43399;
	Mon,  8 Apr 2024 19:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712604302;
	bh=a9D0uk0Qedve0Ll3vO3jl2yVBSXkeqcxwBkYczAKJMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G3QsaudNhmzWTjozx/3Q/wNd9957Q3jUlQ5zwYr1FaFh2qyOhURaYexVf1gQJ1iIz
	 DTfr0CjRs0r9A43qAEDPK5hh4qSVSDE3pTzWbt5wPcSMqp3SSFAlc1n/V79kZRyuXl
	 NdLfEZXTz0tN/hFRQMb4zBrqtQ2zp7436vmg7iifvy2W+1enUm4ADjbJJp4EYjpq+J
	 wKnI7MgyMIYuczlch6mc0EZPwZoNNV9BAqZrectjjNC8VKriF/mR6c1ldHHwbldszD
	 krNx9dq77SK/EV8zXiyUowwVdH1CBd0rEmxxJHYkLQMqN8m2hpnexsxWVNzf9v6bht
	 nRGcgaRKP9EpQ==
Date: Mon, 8 Apr 2024 12:25:00 -0700
From: PJ Waskiewicz <ppwaskie@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] cxl/acpi.c: Add buggy BIOS hint for CXL ACPI lookup
 failure
Message-ID: <ZhREjBQuCCqS00sb@snoopy>
References: <20240407210526.8500-1-ppwaskie@kernel.org>
 <661421574048c_2583ad294d0@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <661421574048c_2583ad294d0@dwillia2-xfh.jf.intel.com.notmuch>

On 24/04/08 09:54AM, Dan Williams wrote:
> ppwaskie@ wrote:
> > From: PJ Waskiewicz <ppwaskie@kernel.org>
> > 
> > Currently, Type 3 CXL devices (CXL.mem) can train using host CXL
> > drivers on Emerald Rapids systems.  However, on some production
> > systems from some vendors, a buggy BIOS exists that improperly
> > populates the ACPI => PCI mappings.  This leads to the cxl_acpi
> > driver to fail probe when it cannot find the root port's _UID, in
> > order to look up the device's CXL attributes in the CEDT.
> > 
> > Add a bit more of a descriptive message that the lookup failure
> > could be a bad BIOS, rather than just "failed."
> 
> Makes sense, but is the goal here to name and shame the BIOS, or find a
> potential quirk workaround? Presumably we could fall back to parsing
> _UID instead of a string and then get some guidance from said BIOS about
> how to lookup the corresponding ACPI0016 device from that identifier.

In this particular case, I tried making sense of what was the _UID
value, and what was actually in the CEDT.  There was no sense to be
made.

For this device, it was ACPI0016:02 with a _UID of CX02.  For this
particular vendor BIOS, all ACPI0016:* devices' _UID's counted up from
CX01 => CX* sequentially.  But what was actually in the CEDT in this
particular case for ACPI0016:02 was 49.  I attempted hex, octal, atoi(),
literal string interpretation per-character, etc.  It was just plain
wrong.
 
> In other words, I see this patch as a warning shot of, "hey,
> $platform_vendor if you
> don't want folks to RMA these platforms please tell us how to do the
> association Linux expects per the spec". Otherwise, this can escalate to
> a loud WARN_TAINT(TAINT_FIRMWARE_WORKAROUND...), but I first want more
> details from this platform like an acpidump and the exact error code
> acpi_evaluate_integer() is returning.

Pasting an acpidump is difficult...  It'll be tricky since this particular
host is walled off from the world.  And moving data in and out of this
environment is quite challenging due to regulatory reasons.

acpi_evaluate_integer() in this case was returning AE_BUFFER_OVERFLOW.

In the meantime, I'm fine either fixing up the commit message per
Jonathan's review, or I'm fine shelving it in favor of a broader effort
to fix the underlying BIOS's with the vendors.  I don't have a strong
preference.  I've been in the weeds with this for awhile, so I know why
it's breaking.  But someone new to CXL with shiny new hardware may be
left scratching their heads.

-PJ

