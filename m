Return-Path: <linux-pci+bounces-2417-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5A58364A3
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 14:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73BBD1C23A19
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 13:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934F63CF59;
	Mon, 22 Jan 2024 13:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Er2/XKps"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82683D0A6
	for <linux-pci@vger.kernel.org>; Mon, 22 Jan 2024 13:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705931129; cv=none; b=B7UypDXmuul7+wwqL4eIkPjUBM1crzsUmNQL6ipU45mi5FyFrCCvmwtqXditu+Xyzjrr5ZsYgzPmdJkQUcRppLv84gOo3A2RJgb0xhb4oKsP/7Xhk+XuDw+nAxYww8GSerM8lQ18m0pS+TY8ZiET6BTv2dLKZHFDdoBf77GA4e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705931129; c=relaxed/simple;
	bh=62ZhC5mqr9RBuCK9jG8GmvqBbYnxdQrY0MAU1FvJgr4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mVvjnYdcvuCMMEjqvLfAxhmvPKwWyhQ3Zk6WZ4BMeRenu8l6HmkHWhzAWpvNwqJpgUv3QvaxOq+vv2MQZtC123FevqirAQIYFVcI1sKrkuUjw8eUlRZBXE+qOqfWamJirsVIY/GvnzVjWRJXB4FPqqltLIeuqFqBUUBoC7RGHW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Er2/XKps; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705931126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aGte1nj2Xg7xyxTb9U5nQhjBYqHyShy5jOhjJkIf0CY=;
	b=Er2/XKpsAN2qrDXoAF6ZOGzTMciKwBFWMpUpuggY3lyVl76mMhve2dTeX/Xj3WALswhzJV
	ZX4kVGZcYysrD6/D2KuEGuV+A6Rjl7mKpB9YROr9ub3JQz16xEfTksGYZMDr0Wr++fc4Ze
	WEXB7P3XOmiwuAR8eo/pUNX96VpSd7s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-nn1lqh9yON-GOHYNvyZObQ-1; Mon, 22 Jan 2024 08:45:24 -0500
X-MC-Unique: nn1lqh9yON-GOHYNvyZObQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-337d2ccaab0so1903160f8f.0
        for <linux-pci@vger.kernel.org>; Mon, 22 Jan 2024 05:45:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705931123; x=1706535923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aGte1nj2Xg7xyxTb9U5nQhjBYqHyShy5jOhjJkIf0CY=;
        b=DFTS/XZOh2FXmPXpFo/RZT7zIY6LEd+I1GqX4agng4LCICog3cOGibkk30VyAaBsjO
         zRHrw+Ih6w6zN0biLC9m8Cm6Acah/OoF06jNlmeorw3rHew4YSUR46hEwdgBCxmJ7vmY
         X8hOEkpMB0tcu3twU7R1Xv5XhcSvXgFooTzZfh0Fgjl9WUcTNeC7JvMQa2ysakunAN0v
         r9cmdmSbhXWFZEQnapTgNtV8c+sMwev+FpuPOf+Eg6b05XcP2rp1iHj7oscBnDG+AfSc
         AcRP9mruoaFHD0J5/JbhnjQlq6PBDE44SaOroIAfn3pHu78KRE55VzEC6tnob6pPvpa3
         HHpw==
X-Gm-Message-State: AOJu0YwjPxiSm470L8MJ2+w9lk0O+s/SrPuJc90b2Qxzpix9c3Bf67YW
	D4bSL6tpdfS8+fC8OaTjxTq61Nsj6m7dfrBFx+JedhFFkw2gl3W5tSdxZb0M6Foy1TgHw9f037q
	Pf4/mbufwBNDfMRcWzihAQ+J2G6JMlIgr+yDnWKk0bzXZdA+dwt2TzdUE6Q==
X-Received: by 2002:a5d:64e6:0:b0:337:d81:a356 with SMTP id g6-20020a5d64e6000000b003370d81a356mr2940562wri.92.1705931123616;
        Mon, 22 Jan 2024 05:45:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3eh53wLbnOHmFkQVweBFc9Y0BQ95eV5CQSVMGesf46oEvw/FoLx1nesdGkQRo74S9F3boQg==
X-Received: by 2002:a5d:64e6:0:b0:337:d81:a356 with SMTP id g6-20020a5d64e6000000b003370d81a356mr2940551wri.92.1705931123231;
        Mon, 22 Jan 2024 05:45:23 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id i18-20020adffdd2000000b003393249d5dbsm3742403wrs.4.2024.01.22.05.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 05:45:22 -0800 (PST)
Date: Mon, 22 Jan 2024 14:45:20 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Ilpo =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Jonathan Woithe <jwoithe@just42.net>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, linux-pci@vger.kernel.org, Bjorn Helgaas
 <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob
 Herring <robh@kernel.org>, Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?=
 <kw@linux.com>, Lukas Wunner <lukas@wunner.de>, Mika Westerberg
 <mika.westerberg@linux.intel.com>, "Rafael J . Wysocki"
 <rafael@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/7] PCI: Solve two bridge window sizing issues
Message-ID: <20240122144520.7761c5a6@imammedo.users.ipa.redhat.com>
In-Reply-To: <62b66d58-7824-3650-6a73-12068a22563e@linux.intel.com>
References: <20231228165707.3447-1-ilpo.jarvinen@linux.intel.com>
	<20240104131210.71f44d4b@imammedo.users.ipa.redhat.com>
	<ZZaiLOR4aO84CG2S@marvin.atrad.com.au>
	<ZZ+gEmxI/TxdbmyQ@marvin.atrad.com.au>
	<ZajJzcquyvRebAFN@marvin.atrad.com.au>
	<Za0T_siv79qz1jkk@smile.fi.intel.com>
	<Za2YtnwLKKeMquv6@marvin.atrad.com.au>
	<62b66d58-7824-3650-6a73-12068a22563e@linux.intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Jan 2024 14:37:32 +0200 (EET)
Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

> On Mon, 22 Jan 2024, Jonathan Woithe wrote:
>=20
> > On Sun, Jan 21, 2024 at 02:54:22PM +0200, Andy Shevchenko wrote: =20
> > > On Thu, Jan 18, 2024 at 05:18:45PM +1030, Jonathan Woithe wrote: =20
> > > > On Thu, Jan 11, 2024 at 06:30:22PM +1030, Jonathan Woithe wrote: =20
> > > > > On Thu, Jan 04, 2024 at 10:48:53PM +1030, Jonathan Woithe wrote: =
=20
> > > > > > On Thu, Jan 04, 2024 at 01:12:10PM +0100, Igor Mammedov wrote: =
=20
> > > > > > > On Thu, 28 Dec 2023 18:57:00 +0200
> > > > > > > Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> wrote:
> > > > > > >  =20
> > > > > > > > Hi all,
> > > > > > > >=20
> > > > > > > > Here's a series that contains two fixes to PCI bridge windo=
w sizing
> > > > > > > > algorithm. Together, they should enable remove & rescan cyc=
le to work
> > > > > > > > for a PCI bus that has PCI devices with optional resources =
and/or
> > > > > > > > disparity in BAR sizes.
> > > > > > > >=20
> > > > > > > > For the second fix, I chose to expose find_empty_resource_s=
lot() from
> > > > > > > > kernel/resource.c because it should increase accuracy of th=
e cannot-fit
> > > > > > > > decision (currently that function is called find_resource()=
). In order
> > > > > > > > to do that sensibly, a few improvements seemed in order to =
make its
> > > > > > > > interface and name of the function sane before exposing it.=
 Thus, the
> > > > > > > > few extra patches on resource side.
> > > > > > > >=20
> > > > > > > > Unfortunately I don't have a reason to suspect these would =
help with
> > > > > > > > the issues related to the currently ongoing resource regres=
sion
> > > > > > > > thread [1]. =20
> > > > > > >=20
> > > > > > > Jonathan,
> > > > > > > can you test this series on affected machine with broken kern=
el to see if
> > > > > > > it's of any help in your case? =20
> > > > > >=20
> > > > > > Certainly, but it will have to wait until next Thursday (11 Jan=
 2024).  I'm
> > > > > > still on leave this week, and when at work I only have physical=
 access to
> > > > > > the machine concerned on Thursdays at present.
> > > > > >=20
> > > > > > Which kernel would you prefer I apply the series to? =20
> > > > >=20
> > > > > I was very short of time today but I did apply the above series t=
o the
> > > > > 5.15.y branch (since I had this source available), resulting in v=
ersion
> > > > > 5.15.141+.  Unfortunately, in the rush I forgot to do a clean aft=
er the
> > > > > bisect reset, so the resulting kernel was not correctly built.  I=
t booted
> > > > > but thought it was a different version and therefore none of the =
modules
> > > > > could be found.  As a result, the test is invalid.
> > > > >=20
> > > > > I will try again in a week when I next have physical access to th=
e system.=20
> > > > > Apologies for the delay.  In the meantime, if there's a specific =
kernel I
> > > > > should apply the patch series against please let me know.  As I u=
nderstand
> > > > > it, you want it applied to one of the kernels which failed, makin=
g 5.15.y
> > > > > (for y < 145) a reasonable choice. =20
> > > >=20
> > > > I did a "make clean" to reset the source tree and recompiled.  Howe=
ver, it
> > > > errored out:
> > > >=20
> > > >   drivers/pci/setup-bus.c:988:24: error: =E2=80=98RESOURCE_SIZE_MAX=
=E2=80=99 undeclared
> > > >   drivers/pci/setup-bus.c:998:17: error: =E2=80=98pci_bus_for_each_=
resource=E2=80=99 undeclared
> > > >=20
> > > > This was with the patch series applied against 5.15.141.  It seems =
the patch
> > > > targets a kernel that's too far removed from 5.15.x.
> > > >=20
> > > > Which kernel would you like me to apply the patch series to and tes=
t? =20
> > >=20
> > > The rule of thumb is to test against latest vanilla (as of today v6.7=
).
> > > Also makes sense to test against Linux Next. The v5.15 is way too old=
 for
> > > a new code. =20
> >=20
> > Thanks, and understood.  In this case the request from Igor was=20
> >=20
> >     can you test this series on affected machine with broken kernel to =
see if
> >     it's of any help in your case?
> >=20
> > The latest vanilla kernel (6.7) has (AFAIK) had the offending commit
> > reverted, so it's not a "broken" kernel in this respect.  Therefore, if=
 I've
> > understood the request correctly, working with that kernel won't produc=
e the
> > desired test. =20
>=20
> Well, you can revert the revert again to get back to the broken state.

either this or just a hand patching as Ilpo has suggested earlier
would do.

There is non zero chance that this series might fix issues
Jonathan is facing. i.e. failed resource reallocation which
offending patches trigger. There are 2 different issues here,
 * 1st unwanted reallocation - it should happen but well that how current c=
ode works
 * 2nd failed reallocation - seemingly matches what this series  is trying =
to fix
   and if it doesn't help we would need to dig some more in this direction
   as well to figure out why it fails.


