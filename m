Return-Path: <linux-pci+bounces-3271-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F18F584F16C
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 09:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 738A91F23717
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 08:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EA3657C1;
	Fri,  9 Feb 2024 08:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="V8Y5ZyTG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED91437142
	for <linux-pci@vger.kernel.org>; Fri,  9 Feb 2024 08:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707467820; cv=none; b=hgyR2B8N9aoWK/VKWA3C9070S9HtHHXfJeo/rauJ2YkXnBkN733g1AuCKY4XPU/jsA48bEHCp9wh2H1pBA16o2YbYTjKsgV2JsnhuqUmqX00RZkVUg4PIyBAxxspLUeO1rGDnfBbpum6C3qDzIAsGJ9GDUhr5laQ0Rc2hsl3z2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707467820; c=relaxed/simple;
	bh=YkM7XkxxQUU4wgsaFp1Ru4C8Ad/DXfHja7UGPQFATmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nayokqbEi1ptQfKTUg6tlaT5TEDuw9Qq2lYYhaih/Kftso/wnAyiFi1B5+YUe+Q8Al9V8MONh1Db0VKHJ5FciK2m9iaQFAswqKXQwExuIlsYGhZ2BY5DE2PtlRfoTWWaPVvBSF2huTVKdMNUVnnX1RzITnmudHfduO1jI/kf6ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=V8Y5ZyTG; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc6dbac5fd1so216846276.0
        for <linux-pci@vger.kernel.org>; Fri, 09 Feb 2024 00:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1707467818; x=1708072618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eI47/fx9ow1vC1sUGCcwJnyIBfBKB89h23AbwyigvjY=;
        b=V8Y5ZyTGngd55bfog0hktxEPh9oEPGQy0kp/Q5AxWUdMj0/NKugetNdm4Mlo8i81qS
         xFrBaYG52Q6RI4Dc3j32DbobQ0q1Nf44oMOa3sUwAUrV7aN65jA2mQpck8rtMCsWbqU9
         UOGeAb7dtcXp5+n4HoxREeQV0+vUjagM57MdWS4Mrgt9Y6jGtkbqWm9B0TLYAyhNPwzP
         6/2UhuQ0FN9I5rgxyudPxOQ6xejMVFKu6FBF23lFGNngO09KeZ2DqEf9K502WzFq10+T
         VjGgRQ27ylefUS2YyvEbPfaZA86ct++ZDqrG+kyeiHHT1N6LsluXGDvJc7L8lUUT0GdX
         UOEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707467818; x=1708072618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eI47/fx9ow1vC1sUGCcwJnyIBfBKB89h23AbwyigvjY=;
        b=c+d/lkB9eTXCTHlbkEB3dl13Cp0kszWIxpXulLgf3hFucpSdOjpkx/fmRTtS+TKO8O
         1bm4hAkctxmvnqJpsNrJj/ChkgNVnuiKVLQTqzMf+OIdVwvjU27lDrFXrm4SPtCur+aD
         qQiPu34NkZ/qzdIewwmIWpkMpLJhT/Q5OD3q1Eko4fcvT3zdeQfKPCmK5PYfvJxkkFOF
         IIfrf3XL69sYnzPSGHZHIFqtHUNHYBt5PuB43S4lsPg09hGrZvXpcAxIl1NLiZleb9x7
         Zmn0/aKYtw2RkoABvetfKbS1YLOsVTzaSv2uLKU5OAmJ43zVGv+JIfKVtxEG4xxaIZk4
         oajA==
X-Forwarded-Encrypted: i=1; AJvYcCUHk9hcalHzDpR0z1oAzLNKpBm1wVd3d25DizBkL6G8sLB4yDSuL/mYl4XaihWKWpEmKVs20NKV6MtOsKwtbaazwJd9h9jlsdAL
X-Gm-Message-State: AOJu0YyGRHRacGsx27mkekcwv8D3TXw7x0XC81czYFpbL9h5fEF81P1w
	eLpjpxZcNEZiqT83ZtLfIwdFTJxsdtiE/Sari1OeK1U/rJqesDtgiYSoyBxJ3wZ5glWaHj6BZYd
	eanGnOjhHUOP9dc2VZ3S4uTvT00U41i+U24W3ZA==
X-Google-Smtp-Source: AGHT+IFyzQdG9DistRjnRvwz4WLIag+2m19rvMlQ6GWG2QGZED5XnuwRnnltFokP5TWQssO8STo4ErN60HN0TZ0xZhg=
X-Received: by 2002:a25:680f:0:b0:dbc:d44e:4ba5 with SMTP id
 d15-20020a25680f000000b00dbcd44e4ba5mr425283ybc.3.1707467817808; Fri, 09 Feb
 2024 00:36:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207084452.9597-1-drake@endlessos.org> <20240207200538.GA912749@bhelgaas>
 <CAD8Lp47DjuAAxqwt+yKD22UNMyvqE00x0u+JeM74KO2OC+Otrg@mail.gmail.com>
 <CAD8Lp44-8WhPyOrd2dCWyG3rRuCqzJ-aZCH6b1r0kyhfcXJ8xg@mail.gmail.com> <9654146ac849bb00faf2fe963d3da94ad65003b8.camel@linux.intel.com>
In-Reply-To: <9654146ac849bb00faf2fe963d3da94ad65003b8.camel@linux.intel.com>
From: Daniel Drake <drake@endlessos.org>
Date: Fri, 9 Feb 2024 09:36:21 +0100
Message-ID: <CAD8Lp44tO_pz_HZmPOKUQ-LEQT=c856eH52xWL9nBtAtJwjL1g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PCI: Disable D3cold on Asus B1400 PCI-NVMe bridge
To: david.e.box@linux.intel.com
Cc: Bjorn Helgaas <helgaas@kernel.org>, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com, 
	mario.limonciello@amd.com, rafael@kernel.org, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, linux@endlessos.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 5:57=E2=80=AFPM David E. Box <david.e.box@linux.inte=
l.com> wrote:
> This does look like a firmware bug. We've had reports of D3cold support m=
issing
> when running in non-VMD mode on systems that were designed with VMD for W=
indows.
> These issues have been caught and addressed by OEMs during enabling of Li=
nux
> systems. Does D3cold work in VMD mode?

On Windows for the VMD=3Don case, we only tested this on a BIOS with
StorageD3Enable=3D0. The NVMe device and parent bridge stayed in D0 over
suspend, but that's exactly what the BIOS asked for, so it doesn't
really answer your question.

On Linux with VMD=3Don and StorageD3Enable=3D1, the NVMe storage device
and the VMD parent bridge are staying in D0 over suspend. I don't know
why this is, I would have expected at least D3hot.  However, given
that the NVMe device has no firmware_node under the VMD=3Don setup, I
believe there is no way it would enter D3cold because there's no
linkage to an ACPI device, so no available _PS3 or _PR0 or whatever is
the precise definition of D3cold.

I also realise I may have made a bad assumption in my previous mail
when looking at the Dell device: I was assuming that a parent PCI
bridge cannot go into D3cold if its child devices only got as far as
D3hot, but I now realise I'm not sure if that constraint actually
exists.

Not sure if these questions are relevant for the consideration of this
patch, but I'll try to find some time to answer them next week.

Daniel

