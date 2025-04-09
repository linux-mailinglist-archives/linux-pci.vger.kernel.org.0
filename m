Return-Path: <linux-pci+bounces-25560-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 335ABA824EB
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 14:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86BA1172465
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 12:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A347261579;
	Wed,  9 Apr 2025 12:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrbhA0jD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4151B255E4E;
	Wed,  9 Apr 2025 12:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744201846; cv=none; b=V81lIn4UAQGO3B7p/iaFmzcfmaByMEIUF8kO4BT/hEPoGowjpFCno9mOH2iRMrSNhlIJ8VwH8ZvGdQhS8OP2EXwBZu8feYiSSt9C+OBQ05uNDd4t8fbWRYzRZEKwIbBNVRP/vn3B+KVLCqFmQ9tP1UVLqvTZLbgGZXiZ/17d/nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744201846; c=relaxed/simple;
	bh=7iWC9nEYPCpToQA6iXtDC2J6qxfgzfIxDLa2qvD02YI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QPOcvZ7MuVoVvvvTSU77pudHH9y0YPGMdtuOa0Jbo0IiZQj7SoOoBSWANvNEkHw0c++TIo/rDlHgF7VUMFR+pFTNbv41GHWdr4h3gHVWlpWlKoc1ZRgozaIjH5KkgAo0UivwbEgZzAPZGjL/XxTVnP49a1BXMKCbumgvN22MKH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrbhA0jD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF38C4CEE3;
	Wed,  9 Apr 2025 12:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744201843;
	bh=7iWC9nEYPCpToQA6iXtDC2J6qxfgzfIxDLa2qvD02YI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hrbhA0jDXRUasOkh9ibVwIRncyKtPVO//uAP3LWCeceCSvt7PmKYeOAKhkV1n9Gri
	 cYuZYfrWCIy/9KMUT9ZV44thAD0DKfCKHVzsc7GtypWHkGXV+DsmFrOsrc5YQBca5n
	 ZMVqczGUkIWYaacL70ZJbeZ+8XB8NEHQQx7oOISRsHEpH8RojybvquD+cAf+oKid4q
	 ArOZbTQM+Wr8WPT9IEAKXuVKbwdnaxgcdtTOQHEQ9QSiXNkyW4An561x8ZfXDtKzjp
	 HK0ApmhR2yJO2QdOxasUnmLEKpsrj/bvYB7yL2CeZaKUSuCt36pdbPDz065wmwzxo0
	 NgjnsgOpb+XbQ==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2c7f876b321so2080568fac.1;
        Wed, 09 Apr 2025 05:30:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV2Gj/LFCwbSWQmN8vDKyxnuFQFaDziVdroE7oWXARLs0qa2eDcK3Nh/FnCJJ480eMqpA9LIeyRpgX4@vger.kernel.org, AJvYcCWfVsYm1iU//WJwlbFRgWot2wPcvsGnZYSr0Zu0gstMIGINR7OxhlqoIfD11nhi9X4EhTPo7tvYnT9M@vger.kernel.org
X-Gm-Message-State: AOJu0Yx46rVIbVSEcvj6uj90wBlHSZS4B7yk/OEvbZno0+MBumf4UdeM
	W352NDF9C5N7u4ThmFy3WGKRUFBiQ5ZA7Bu7pP00Bjfrj5Bbbhs07iSz8QqkmxhD/ZxI8Nc4QBS
	bYGDJx4hyif5aSSosrxSR6xTTQRs=
X-Google-Smtp-Source: AGHT+IHcigN37i8FsTsXewh3/4UfKT/Xs0sUYY7pjtrGMPdG3td+ZNaYaKAPU1EGyXQinmIM6G2uSQkkt+3HipdOmrk=
X-Received: by 2002:a05:6870:ab0d:b0:2c2:2f08:5e5b with SMTP id
 586e51a60fabf-2d0917bb20cmr1122200fac.13.1744201842771; Wed, 09 Apr 2025
 05:30:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0hQjtTCu1wXgKvBWBBegbj-VD+Z0yBspt1uFes8Xun7Cw@mail.gmail.com>
 <20250408204832.GA64565@bhelgaas>
In-Reply-To: <20250408204832.GA64565@bhelgaas>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 9 Apr 2025 14:30:31 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hK9m6-F5V+VWqsVPfr+WGLruHkP7ZvQsmwp21W9PHs_A@mail.gmail.com>
X-Gm-Features: ATxdqUGKD2JHDyrAo8RFry5xmYLdgmdP89xHc8xnZ975hSW-tjI79tXKHQvfHdY
Message-ID: <CAJZ5v0hK9m6-F5V+VWqsVPfr+WGLruHkP7ZvQsmwp21W9PHs_A@mail.gmail.com>
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

On Tue, Apr 8, 2025 at 10:48=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Wed, Apr 02, 2025 at 09:36:01PM +0200, Rafael J. Wysocki wrote:
> > On Wed, Apr 2, 2025 at 8:48=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.or=
g> wrote:
>
> > > I don't *expect* rev 5 to be different.  But as a user of it, why
> > > would I change working, tested code that is not broken?
> > >
> > > The PCI DPC function 0xc is an example where rev 5 (per ECN) and rev =
6
> > > (per r3.3) are not compatible.
> > >
> > > If the OS implemented rev 5, then learns via function 0 that function
> > > 0xc is also supported at rev 6, and starts using the same OS code wit=
h
> > > rev 6, the OS is broken.
> >
> > Yes, in this case the backward compatibility language in the _DSM
> > definition is obviously not followed.
>
> Rev 5 in the ECN isn't compatible with rev 6 in the PCI FW r3.3 spec,
> so it doesn't follow the ACPI compatibility requirement.  And this is
> documented in PCI FW, which says "Fn 0xC was added with rev 5 (see ECN
> for rev 5 details); here is how rev 6 works."
>
> An OS implemented to the ECN doesn't know that rev 6 is different from
> rev 5; it assumes they're the same because ACPI says we can assume
> that, and PCI FW r3.3 even says the OS should use the same rev for all
> functions.

OK (and this is important because PCI FW r3.3 is the spec defining the
interface)

> If OS adds support for rev 6 of a some other function, it is supposed to =
use
> rev 6 of Fn 0xC, which doesn't work as the OS expects.

IMV with respect to _DSM, the spec that has defined the interface (PCI
FW r3.3) takes precedence over the ACPI spec regardless of what the
latter is saying.  In this case ACPI provides a framework the
interface can be based on, but the actual interface is not defined by
it.

Also, I think that the OS should use rev 6 if it is supported by the
firmware (for all functions) and it should literally follow the
definition of rev 6.

If rev 6 is not supported (or some functions needed by the OS are not
implemented by the firmware), it should fall back to rev 5 and in this
case it should literally follow the definition of rev 5.

And so on.

> I guess one could argue that "OS didn't add rev 6 support for anything
> until PCI FW r3.3 added a function at rev 6, r3.3 did mention the
> difference between Fn 0xC rev 5 and 6, and OS should have looked at
> all the already-implemented unrelated functions for possible changes
> between rev 5 and rev 6."

Yes, it should.

> I think that causes unnecessary changes in unrelated code.  The OS can
> avoid the problem by *always* using Fn 0xC rev 5, regardless of what
> rev it uses for other functions.

What if the functions on the firmware side depend on each other
interfally and the firmware gets confused if revisions are mixed up on
the OS side?

Since PCI FW r3.3 says that the OS should use the same rev for all
functions, that's what it should do because the firmware may
reasonably assume that it will.

> Of course, the OS can include support for multiple revs, e.g., it
> could add support for Fn 0xC rev 6 and use that when available.  And
> it could retain support for Fn 0xC rev 5 and use that if rev 6 isn't
> available.

That's what I mean basically.

In practice, the OS needs to assume that the firmware may not
implement a certain rev and so it needs to support other revisions
anyway.

