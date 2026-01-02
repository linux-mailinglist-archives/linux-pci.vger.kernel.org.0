Return-Path: <linux-pci+bounces-43933-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D53CCEE738
	for <lists+linux-pci@lfdr.de>; Fri, 02 Jan 2026 13:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAB01300CB9E
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jan 2026 12:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383A32D2488;
	Fri,  2 Jan 2026 12:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LuessNNV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1358327BF6C
	for <linux-pci@vger.kernel.org>; Fri,  2 Jan 2026 12:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767355622; cv=none; b=C7ZGAFZA1dyonWAqZe+ePWz9WPYK47EoQF/IzD0HVvQN6sbjvcyB/RezWpBC/EPgtRKgMT7xgbKVpd2U71N9ql4rH/kqDBiEaiVgcQMpsjaGd+MeCAW28nR6ZduMh94DYn0IPoSCWU2lKQBhbQ5HPnJBDYtQYKmtGMAnTzxcAqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767355622; c=relaxed/simple;
	bh=qXBIOm5KkAYKUGNiZ6O6ibZVGNVRF00e/pJ0nejqlx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WJbj8kv6aPt8njpkmdY0HwGrUSk4VQ1SfLlYtFHmItAcUNzaMHt5eUz5k8bLol2VzBG23ex8vGTuhfSZS/18/MNHHAYfu7AijS47KEHelkq9XCAcp5W+YxnkuOvfHt1y+3dNPVnireqN8b8vNBwU+k0sE0C6uDBZ6f2mHD7wba0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LuessNNV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C44C4AF09
	for <linux-pci@vger.kernel.org>; Fri,  2 Jan 2026 12:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767355621;
	bh=qXBIOm5KkAYKUGNiZ6O6ibZVGNVRF00e/pJ0nejqlx8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LuessNNVCSJZMAB5VUG9Vv8v8c99+QhIYzQslCfuc2Td1kmsumO/Ejty9a6hHvNAK
	 bb/3O+ertgjmNxH066jO/mO05LJUHSjFyrElHf9zko4qWGTFCEWCH+m2wHObAqz6p5
	 hZ1Yn9QKQ6wlh5frnjBpSOi8EtNRmJivd7PR7wFtbnvcPdqRJbPp6RnpeP11S8Ic8M
	 ltI6gtsg3Tf2y+WAnpZTXjeJGic8k3Vk9VLR+LqpMgz+Ysh6fL42U2dCALyx3q4zVd
	 N8SuZPpTgKW12Sv0g+q0gs1I+TTsQvhaPWZqWnLN1oxpioHGbZ/50gZreq0YbwbpCE
	 HPQWCoDjlPhag==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-3f551ad50d1so4341443fac.0
        for <linux-pci@vger.kernel.org>; Fri, 02 Jan 2026 04:07:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUf2CtD4QP2vK1B9Z6dumJcJzJEbNYDGQgO7sAp4paIg2dMoM+Zpd+7R44CxZxPJAVqAF7ldqTMldc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwztK2yzoqRxhr8+2TzZgT0WJEz8Tn+7b+3xZHCCYDezVViweVi
	MC1+1SaRJopIcY2pxwX4GP7qfHwLSbDLR4I0rpUzZcQvSRwvY/N8SKrw9U9o2kNlaPB/VDPVUI3
	Qn0zZNHhUtCXZN2Tj0WTN6X95oQ/EpKo=
X-Google-Smtp-Source: AGHT+IHFohW7YlEL0VMcsEtCVqwWLfIR3y2rU8je7NNk6ylHkEc2nbEHp6pL8g8A4hfDGaEH5jXTQyHMBX3bDiImVgU=
X-Received: by 2002:a05:6820:f028:b0:65d:62d:b6a8 with SMTP id
 006d021491bc7-65d0e963dc2mr15073532eaf.17.1767355620881; Fri, 02 Jan 2026
 04:07:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12833187.O9o76ZdvQC@rafael.j.wysocki> <20260102115250.0000045c@huawei.com>
In-Reply-To: <20260102115250.0000045c@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 2 Jan 2026 13:06:48 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jCyRLpEA0Fmbjx8cNuden3sgqWvVO6_wmvCTHXVwb1LA@mail.gmail.com>
X-Gm-Features: AQt7F2p68BloL0iOguHBHO5v1Ds7X2xOEwvyzIry1zAV_g6N5KSH8Ymeeu1hLMQ
Message-ID: <CAJZ5v0jCyRLpEA0Fmbjx8cNuden3sgqWvVO6_wmvCTHXVwb1LA@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI: bus: Adjust acpi_osc_handshake() parameter list
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Hans de Goede <hansg@kernel.org>, 
	Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 2, 2026 at 12:53=E2=80=AFPM Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
>
> On Fri, 26 Dec 2025 14:48:45 +0100
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > For the sake of interface cleanliness, it is better to avoid using
> > ACPICA data types in the parameter lists of helper functions that
> > don't belong to ACPICA, so adjust the parameter list of recently
> > introduced acpi_osc_handshake() to take a capabilities buffer pointer
> > and the size of the buffer (in u32 size units) as parameters directly
> > instead of a struct acpi_buffer pointer.
> >
> > This is also somewhat more straightforward on the caller side because
> > they won't need to create struct acpi_buffer objects themselves to pass
> > them to the helper function and it guarantees that the size of the
> > buffer in bytes will always be a multiple of 4 (the size of u32).
> >
> > Moreover, it addresses a premature cap pointer dereference and
> > eliminates a sizeof(32) that should have been sizeof(u32) [1].
> >
> > Fixes: e5322888e6bf ("ACPI: bus: Rework the handling of \_SB._OSC platf=
orm features")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Closes: https://lore.kernel.org/linux-acpi/202512242052.W4GhDauV-lkp@in=
tel.com/
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> A couple of minor comments inline.  I see you have it queued up already,

Yeah, mostly to address build warnings in linux-next.

> but FWIW nothing here major enough to warrant reverting that.
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>
> > ---
> >  drivers/acpi/bus.c |   30 ++++++++++++------------------
> >  1 file changed, 12 insertions(+), 18 deletions(-)
> >
> > --- a/drivers/acpi/bus.c
> > +++ b/drivers/acpi/bus.c
> > @@ -326,31 +326,33 @@ out:
> >  EXPORT_SYMBOL(acpi_run_osc);
> >
> >  static int acpi_osc_handshake(acpi_handle handle, const char *uuid_str=
,
> > -                           int rev, struct acpi_buffer *cap)
> > +                           int rev, u32 *capbuf, size_t bufsize)
>
> Size parameters in number of u32s is to me a little confusing but
> I guess this is only used locally so that's probably fine.
> I'd have been tempted to call it dwords or something like that.

Well, this technically is the number of elements in the capbuf[]
array, so I guess it could be called capbuf_size or something like
that.

> >  {
> >       union acpi_object in_params[4], *out_obj;
> > -     size_t bufsize =3D cap->length / sizeof(u32);
> >       struct acpi_object_list input;
> > +     struct acpi_buffer cap =3D {
> > +             .pointer =3D capbuf,
> > +             .length =3D bufsize * sizeof(32),
>
> You fixed this up already but just for completeness.
> sizeof(u32)

Yup.

> > +     };
> >       struct acpi_buffer output;
> > -     u32 *capbuf, *retbuf, test;
> > +     u32 *retbuf, test;
> >       guid_t guid;
> >       int ret, i;
> >
> > -     if (!cap || cap->length < 2 * sizeof(32) || guid_parse(uuid_str, =
&guid))
> > +     if (!capbuf || bufsize < 2 || guid_parse(uuid_str, &guid))
> >               return -EINVAL;
> >
> >       /* First evaluate _OSC with OSC_QUERY_ENABLE set. */
> > -     capbuf =3D cap->pointer;
> >       capbuf[OSC_QUERY_DWORD] =3D OSC_QUERY_ENABLE;
> >
> > -     ret =3D acpi_eval_osc(handle, &guid, rev, cap, in_params, &output=
);
> > +     ret =3D acpi_eval_osc(handle, &guid, rev, &cap, in_params, &outpu=
t);
> >       if (ret)
> >               return ret;
> >
> >       out_obj =3D output.pointer;
> >       retbuf =3D (u32 *)out_obj->buffer.pointer;
> >
> > -     if (acpi_osc_error_check(handle, &guid, rev, cap, retbuf)) {
> > +     if (acpi_osc_error_check(handle, &guid, rev, &cap, retbuf)) {
> >               ret =3D -ENODATA;
> >               goto out;
> >       }
> > @@ -403,7 +405,7 @@ static int acpi_osc_handshake(acpi_handl
> >                */
> >               acpi_handle_err(handle, "_OSC: errors while processing co=
ntrol request\n");
> >               acpi_handle_err(handle, "_OSC: some features may be missi=
ng\n");
> > -             acpi_osc_error_check(handle, &guid, rev, cap, retbuf);
> > +             acpi_osc_error_check(handle, &guid, rev, &cap, retbuf);
> >       }
> >
> >  out:
> > @@ -446,10 +448,6 @@ static void acpi_bus_osc_negotiate_platf
> >  {
> >       static const u8 sb_uuid_str[] =3D "0811B06E-4A27-44F9-8D60-3CBBC2=
2E7B48";
> >       u32 capbuf[2], feature_mask;
> > -     struct acpi_buffer cap =3D {
> > -             .pointer =3D capbuf,
> > -             .length =3D sizeof(capbuf),
> > -     };
> >       acpi_handle handle;
> >
> >       feature_mask =3D OSC_SB_PR3_SUPPORT | OSC_SB_HOTPLUG_OST_SUPPORT =
|
> > @@ -497,7 +495,7 @@ static void acpi_bus_osc_negotiate_platf
> >
> >       acpi_handle_info(handle, "platform _OSC: OS support mask [%08x]\n=
", feature_mask);
> >
> > -     if (acpi_osc_handshake(handle, sb_uuid_str, 1, &cap))
> > +     if (acpi_osc_handshake(handle, sb_uuid_str, 1, capbuf, 2))
>
> As below. Maybe ARRAY_SIZE(capbuf) instead of that 2.

That's a good idea, I'll change it in the patch.

> >               return;
> >
> >       feature_mask =3D capbuf[OSC_SUPPORT_DWORD];
> > @@ -532,10 +530,6 @@ static void acpi_bus_osc_negotiate_usb_c
> >  {
> >       static const u8 sb_usb_uuid_str[] =3D "23A0D13A-26AB-486C-9C5F-0F=
FA525A575A";
> >       u32 capbuf[3], control;
> > -     struct acpi_buffer cap =3D {
> > -             .pointer =3D capbuf,
> > -             .length =3D sizeof(capbuf),
> > -     };
> >       acpi_handle handle;
> >
> >       if (!osc_sb_native_usb4_support_confirmed)
> > @@ -550,7 +544,7 @@ static void acpi_bus_osc_negotiate_usb_c
> >       capbuf[OSC_SUPPORT_DWORD] =3D 0;
> >       capbuf[OSC_CONTROL_DWORD] =3D control;
> >
> > -     if (acpi_osc_handshake(handle, sb_usb_uuid_str, 1, &cap))
> > +     if (acpi_osc_handshake(handle, sb_usb_uuid_str, 1, capbuf, 3))
>
> Maybe ARRAY_SIZE(capbuf) just to avoid any chance they get out of sync?
>
> >               return;
> >
> >       osc_sb_native_usb4_control =3D capbuf[OSC_CONTROL_DWORD];
> >
> >
> >
> >

Thanks!

