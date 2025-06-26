Return-Path: <linux-pci+bounces-30741-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C94AE9B94
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 12:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB4851C419FC
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 10:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F287124678E;
	Thu, 26 Jun 2025 10:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QU2g5u8F"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4171DE2DC;
	Thu, 26 Jun 2025 10:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750934092; cv=none; b=AMI7MfDZI2M9FcXoyt+jsZhnP+h30ch0MO4PGQyYj5CUowIy9LEtIaezq9Krjq3bYSEkmAEKD9OCu623529kATymWpyK8tsDyvs2qSJOmrKv8/WjCUgBndsQJQ5AVMahjBVJUJQD2WNOZXoQtzl8MomAUqV1FsL4XlxluufTJFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750934092; c=relaxed/simple;
	bh=fQ/XbLvD72nwOUfQaPR2P/p2TKLVGSXc50fMucTNdag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L8dEJPYFNFdMZJRkzf+XlL8y/hhatQXwEZpb67nbTzmtj/rZlEDTHcKWtLUO0aeKD1LTGtx8eCSzOoe91A0PAlNdGxNcRhFbYR68fS0TBIRD326/5iqfV2d3FTAbIIAFyyrolQF3oBVTI01XiY9w+DhdP4drCfXovZxj7KJH0Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QU2g5u8F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 509D2C4CEF2;
	Thu, 26 Jun 2025 10:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750934092;
	bh=fQ/XbLvD72nwOUfQaPR2P/p2TKLVGSXc50fMucTNdag=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QU2g5u8FGumzsmgsyH0udDDJkdWEH2IjLSP8ahmTd2a3QIV42+xyFu5V7dbpFmmr4
	 wZo59XyqVrJSwihUAAs+2Hye8ZCukN7wU6cyId6zAVvqN+/yB6WsJsfoN2HpcTu278
	 ZZUF8hk764o6aR7MGfk7p9Lhp99/uIjBW4kpCLg4lUPz2/P2cNAmhv6TbKorY12vuE
	 HPzhkAQt6PAmj/pgvzw1A03n6WA16rm/oZfgQoBM/x+74mJ9XjyOpFoma1Prkd69Qc
	 YEzKS8gLhm2s7MXJmYycrmpLPychzU61A5ZKsqsCJq6fNSBTvA4Dro5pkCUu0fquSj
	 6TE6A0C5iAXyQ==
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-735b2699d5dso428149a34.0;
        Thu, 26 Jun 2025 03:34:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUYtFQM2wGbClhaVd25zbzHsA3YZMsbwk9Q/QP44jAGbz634oz2G4lQvVRROO02tgxSdyMTBbXGT4k=@vger.kernel.org, AJvYcCWQ8DsBG4tOONuUAkMVFM4OHssccbI/GHJIv2/GY7t5iPiz8n/YMOFhEzdLlelYpf6lsqbdhaMiKdE4I7Sc@vger.kernel.org, AJvYcCWfmWbRkZGb5Mys2fxkNQWEGJdLw92dqJNxmpLwmrsDdAm4tpMtNY9Czd/R73Zlq7xMJ1qP1/P6nWlA@vger.kernel.org, AJvYcCWiweZdkXJon61N9vwUWKxWcLL81wYvbvRHW3Qs0XHD6vmBOnd9t6dwkuzgdFTDS/MsH953OQKDVxMz@vger.kernel.org
X-Gm-Message-State: AOJu0YwYTCArJTy19McSBTLfqPZYZj/b1FFS88JX02/CxRlniDDppB2d
	SgcHfIl6EOd2WS+qNJxv/FOdBcufd1jXjr0P6nTOejZq4YUDxfiIjXaCqxwAeDIaL8PHZyP+GMk
	sXId13kxYiFD/WkzTDHIlSYc9hOerWNs=
X-Google-Smtp-Source: AGHT+IF/iWU0o68x6cZFZd7gsXItqIYob+JGTWj341oWXWNuZH1p9Bx23klyYar2h1tAxBLPKDeRh8LxAvTOgk0Jx70=
X-Received: by 2002:a05:6830:700f:b0:739:fe86:9dfc with SMTP id
 46e09a7af769-73adc88c2aemr3976885a34.23.1750934091510; Thu, 26 Jun 2025
 03:34:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <22759968.EfDdHjke4D@rjwysocki.net> <CAPDyKFpZVdf2EnZE_u1xDKB7=Nd98a_ajYimQhLBu6jYwJhJFA@mail.gmail.com>
In-Reply-To: <CAPDyKFpZVdf2EnZE_u1xDKB7=Nd98a_ajYimQhLBu6jYwJhJFA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 26 Jun 2025 12:34:40 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0irk8n0MzRm=u8k=+Mtq84r7JsazS10DsvHO4ktgW=AMQ@mail.gmail.com>
X-Gm-Features: Ac12FXzeLUnMKr4aqmOzzSM5O2l38MZgj4oviZI0kCWjAqe7ClG9HIZZxSLibKA
Message-ID: <CAJZ5v0irk8n0MzRm=u8k=+Mtq84r7JsazS10DsvHO4ktgW=AMQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/9] PM: Reconcile different driver options for runtime
 PM integration with system sleep
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Linux PCI <linux-pci@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 12:31=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:
>
> On Wed, 25 Jun 2025 at 21:25, Rafael J. Wysocki <rjw@rjwysocki.net> wrote=
:
> >
> > Hi Everyone,
> >
> > This series addresses a couple of issues related to the integration of =
runtime
> > PM with system sleep I was talking about at the OSMP-summit 2025:
> >
> > https://lwn.net/Articles/1021332/
> >
> > Most importantly, DPM_FLAG_SMART_SUSPEND cannot be used along with
> > pm_runtime_force_suspend/resume() due to some conflicting expectations
> > about the handling of device runtime PM status between these functions
> > and the PM core.
> >
> > Also pm_runtime_force_suspend/resume() currently cannot be used in PCI
> > drivers and in drivers that collaborate with the general ACPI PM domain
> > because they both don't expect their mid-layer runtime PM callbacks to
> > be invoked during system-wide suspend and resume.
> >
> > Patch [1/9] is a preparatory cleanup changing the code to use 'true' an=
d
> > 'false' as needs_force_resume flag values for consistency.
> >
> > Patch [2/9] makes pm_runtime_force_suspend() check needs_force_resume a=
long
> > with the device's runtime PM status upfront, and bail out if it is set,
> > which allows runtime PM status updates to be eliminated from both that =
function
> > and pm_runtime_force_resume().
> >
> > Patch [3/9] causes the smart_suspend flag to be taken into account by
> > pm_runtime_force_resume() which allows it to resume devices with smart_=
suspend
> > set whose runtime PM status has been changed to RPM_ACTIVE by the PM co=
re at
> > the beginning of system resume.  After this patch, drivers that use
> > pm_runtime_force_suspend/resume() can also set DPM_FLAG_SMART_SUSPEND w=
hich
> > may be useful, for example, if devices handled by them are involved in
> > dependency chains with other devices setting DPM_FLAG_SMART_SUSPEND.
> >
> > The next two patches, [4-5/9], put pm_runtime_force_suspend/resume()
> > and needs_force_resume under CONFIG_PM_SLEEP for consistency and also
> > because using them outside system-wide PM transitions really doesn't ma=
ke
> > sense.
> >
> > Patch [6/9] makes the code for getting a runtime PM callback for a devi=
ce
> > a bit more straightforward in preparation for the subsequent changes.
>
> I can't find this one. Seems like you did not submit it.
>
> Perhaps make a resend and fixup the patch-numbering too?

I'm going to send a v2, but the patch in question is here (wrong number):

https://lore.kernel.org/linux-acpi/3306233.5fSG56mABF@rjwysocki.net/

