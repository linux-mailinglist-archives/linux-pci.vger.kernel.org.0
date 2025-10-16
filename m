Return-Path: <linux-pci+bounces-38389-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EB7BE52D9
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 21:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3A27481F57
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 19:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3433F245032;
	Thu, 16 Oct 2025 19:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dd3WmlMk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001F5242D70;
	Thu, 16 Oct 2025 19:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760641632; cv=none; b=XcgMxlee7nBSak0YEuZ43LInpd66CABBOu/ppv3GK5chttu/PzvmZ0YCB+W/ZMuFy+vAaw7usL4CUat6lBl3tLFX3Cbd1h9nPAof4WK0hpky+T5ucFvUhBKGGZG/ONMnfm4kvbnP481XhrewxZiyXFD5LB/Ur2YqDLF+CkTnUDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760641632; c=relaxed/simple;
	bh=I5GFQ9CYsjyd1tjZWlXho/z0XBSLZ3hEh4t+498uLAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=in5PwXRbgEAr2q0vavUpcjd3S7wnjWkcCNh+9z7+CZKmHC6rTKBCfIc45hMvaT6Na3XsykUIHeFiGA1EMSDe9SCBmWLdSgkdKjG/X3d6x2/LZneE/bwvxDglVSQIWnc0W/bQkF6M9qIq/JGnzVPxiPPtkLsTZoPJWkUbXTR8ZYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dd3WmlMk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 301F4C4CEF1;
	Thu, 16 Oct 2025 19:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760641630;
	bh=I5GFQ9CYsjyd1tjZWlXho/z0XBSLZ3hEh4t+498uLAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dd3WmlMkkO3VWVk5MbsO9dj6dUzoIhC8D7UqawEPIjJRDdju/KOCzOhajRqb4hoIU
	 QSVsYnGa2wbx4ed59Zzk8JB1x9VpQ958ft5YCMInAP0doNztEwQbC62erjiWefuxRQ
	 zoat/ZyIuKU+ODTXjZCEY3rkmauQYvpvE+6OrXKT8dYCbOACRnrU1dzvRZEsEEFpeG
	 8TUv6Rw7aB+IHTG9JTRydveMrAjdqboaKo1VUJB6Qm9bSsYPs6r2X7NGKZjpRMx7Y4
	 9G5FwrvYvGkcdxrykSMc4LVTKYkRmwTpgY+dl+FRvB7BgkFmVJhQQjshaRfyAbmF4F
	 2nA/nm/M1xAnQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: David Lechner <dlechner@baylibre.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Zhang Qilong <zhangqilong3@huawei.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Frank Li <Frank.Li@nxp.com>,
 Dhruva Gole <d-gole@ti.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Dan Williams <dan.j.williams@intel.com>,
 "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
Subject:
 Re: [PATCH v1 1/3] PM: runtime: Introduce PM_RUNTIME_ACQUIRE_OR_FAIL() macro
Date: Thu, 16 Oct 2025 21:07:03 +0200
Message-ID: <12765144.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <875xce7m11.wl-tiwai@suse.de>
References:
 <3925484.kQq0lBPeGt@rafael.j.wysocki>
 <cc21a74c-905f-4223-95a8-d747ef763081@baylibre.com>
 <875xce7m11.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Thursday, October 16, 2025 8:13:14 PM CEST Takashi Iwai wrote:
> On Thu, 16 Oct 2025 18:46:56 +0200,
> David Lechner wrote:
> >=20
> > On 10/16/25 9:59 AM, Takashi Iwai wrote:
> > > On Thu, 16 Oct 2025 15:46:08 +0200,
> > > Rafael J. Wysocki wrote:
> > >>
> > >> On Thu, Oct 16, 2025 at 2:39=E2=80=AFPM Jonathan Cameron
> > >> <jonathan.cameron@huawei.com> wrote:
> > >>>
> > >>> On Wed, 15 Oct 2025 16:02:02 +0200
> > >>> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > >>>
> > >>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >>>>
> > >>>> There appears to be an emerging pattern in which guard
> > >>>> pm_runtime_active_try is used for resuming the given device and
> > >>>> incrementing its runtime PM usage counter if the resume has been
> > >>>> successful, that is followed by an ACQUIRE_ERR() check on the guard
> > >>>> variable and if that triggers, a specific error code is returned, =
for
> > >>>> example:
> > >>>>
> > >>>>       ACQUIRE(pm_runtime_active_try, pm)(dev);
> > >>>>       if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
> > >>>>               return -ENXIO
> > >>>>
> > >>>> Introduce a macro called PM_RUNTIME_ACQUIRE_OR_FAIL() representing=
 the
> > >>>> above sequence of statements that can be used to avoid code duplic=
ation
> > >>>> wherever that sequence would be used.
> > >>>>
> > >>>> Use this macro right away in the PCI sysfs code where the above pa=
ttern
> > >>>> is already present.
> > >>>>
> > >>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >>>> ---
> > >>>>
> > >>>> Admittedly, the new macro is slightly on the edge, but it really h=
elps
> > >>>> reduce code duplication, so here it goes.
> > >>>
> > >>> Fully agree with the 'on the edge'.
> > >>>
> > >>> This looks somewhat like the some of the earlier attempts to come u=
p with
> > >>> a general solution before ACQUIRE().  Linus was fairly clear on his=
 opinion of
> > >>> a proposal that looked a bit similar to this
> > >>> cond_guard(mutex_intr, return -EINTR, &mutex);
> > >>>
> > >>> https://lore.kernel.org/all/CAHk-=3Dwin7bwWhPJ=3DiuW4h-sDTqbX6v9_LJ=
nMaO3KxVfPSs81bQ@mail.gmail.com/
> > >>>
> > >>> +CC a few people who might have better memories of where things wen=
t than I do.
> > >>>
> > >>> The solution you have here has the benefit of clarity that all it c=
an do is
> > >>> return the error code.
> > >>
> > >> Well, I could call the macro PM_RUNTIME_ACQUIRE_OR_RETURN_ERROR(), b=
ut
> > >> FAIL is just shorter. :-)
> > >>
> > >> Seriously though, the odd syntax bothers me, but it has come from
> > >> looking at the multiple pieces of code that otherwise would have
> > >> repeated exactly the same code pattern including the guard name in t=
wo
> > >> places and the pm variable that has no role beyond guarding.
> > >=20
> > > While I see the benefit of simplification, IMO, embedding a code
> > > flow control inside the macro argument makes it really harder to
> > > follow.
> > >=20
> > > Is the problem about the messy ACQUIRE_ERR() invocation?  If so, it
> > > could be replaced with something shorter (and without extra type),
> > > e.g. replace=20
> > > 	ret =3D ACQUIRE_ERR(pm_runtime_active_try, &pm);
> > > with
> > > 	ret =3D PM_RUNTIME_ACQUIRE_ERR(&pm);
> > >=20
> > > Since all runtime PM guard usage is to the same object, we can have a
> > > common macro.
> > >=20
> > > Also, in the past, I thought of a macro like below that stores the
> > > error code in the given variable ret:
> > >=20
> > > #define __guard_cond_ret(_name, _var, _ret, _args)	\
> > > 	CLASS(_name, _var)(_args);			\
> > > 	(_ret) =3D __guard_err(_name)(&_var)
> > > #define guard_cond_ret(_name, _ret, _args) \
> > > 	__guard_cond_ret(_name, __UNIQUE_ID(guard), _ret, _args)
> > >=20
> > > ... so that it'd work for runtime PM like:
> > >=20
> > > 	int ret;
> > >=20
> > > 	guard_cond_ret(pm_runtime_active, ret)(dev);
> > > 	if (ret)
> > > 		return ret;
> > > =09
> > > Of course, a clear drawback is that the assignment of ret isn't
> > > obvious, but the code flow isn't skewed much in this way.
> > >=20
> > >=20
> > > thanks,
> > >=20
> > > Takashi
> >=20
> > FWIW, a while back, I suggested something like this where ret was
> > a parameter rather than a return value [1]. Linus did not seem to
> > be a fan (said it was "disgusting syntax").
> >=20
> > [1]: https://lore.kernel.org/all/CAHk-=3Dwhn07tnDosPfn+UcAtWHBcLg=3DKqA=
16SHVv0GV4t8P1fHw@mail.gmail.com/
>=20
> Yeah, I myself also find it suboptimal, hence it wasn't really
> proposed...  It's a limit of macro, unfortunately.

The macro from the $subject patch can be split along the lines of the appen=
ded
patch to avoid the "disgusting syntax" issue, although it then becomes less
attractive as far as I'm concerned.  It still allows the details unrelated =
to
the rest of the code to be hidden though.

=2D--
 drivers/acpi/acpi_tad.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

=2D-- a/drivers/acpi/acpi_tad.c
+++ b/drivers/acpi/acpi_tad.c
@@ -31,6 +31,12 @@ MODULE_DESCRIPTION("ACPI Time and Alarm
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Rafael J. Wysocki");
=20
+#define PM_RUNTIME_ACQUIRE_ACTIVE(dev)	\
+	ACQUIRE(pm_runtime_active_try, pm_runtime_active_guard_var)(dev)
+
+#define PM_RUNTIME_ACQUIRE_ACTIVE_ERR	\
+	ACQUIRE_ERR(pm_runtime_active_try, &pm_runtime_active_guard_var)
+
 /* ACPI TAD capability flags (ACPI 6.2, Section 9.18.2) */
 #define ACPI_TAD_AC_WAKE	BIT(0)
 #define ACPI_TAD_DC_WAKE	BIT(1)
@@ -264,8 +270,8 @@ static int acpi_tad_wake_set(struct devi
 	args[0].integer.value =3D timer_id;
 	args[1].integer.value =3D value;
=20
=2D	ACQUIRE(pm_runtime_active_try, pm)(dev);
=2D	if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
+	PM_RUNTIME_ACQUIRE_ACTIVE(dev);
+	if (PM_RUNTIME_ACQUIRE_ACTIVE_ERR)
 		return -ENXIO;
=20
 	status =3D acpi_evaluate_integer(handle, method, &arg_list, &retval);




