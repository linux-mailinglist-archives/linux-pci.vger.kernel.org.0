Return-Path: <linux-pci+bounces-43440-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CD8CD1364
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 18:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EFBF03009FC7
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 17:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B659F3587BB;
	Fri, 19 Dec 2025 17:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZYHhrOe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913083587B4
	for <linux-pci@vger.kernel.org>; Fri, 19 Dec 2025 17:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766166550; cv=none; b=GjPK5gpBIJ98V2fhbHOW/lsvT2agT1CjRm3bzrkaEf/NMTbNbj+Eo2JRaZe+02lOS28YRVWu4vACSwCi1iH+h3Gcs08PPfc1qo98qASCunVxgiLaGPdWVAxakZ+mqXi/3tloMOUdyul1n73zbayZOGAvqMzgv89TyntlXdxO0bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766166550; c=relaxed/simple;
	bh=aTxhZjW/4+N0Y6yWx5qNa+TytCzWq5aRUStqK2cn/vE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xbn5L+cnTbLT0oxgdE2LwlJgJ0/vS0eqo5lSyBM0D7UWUBWnoppOJMA5bqL1AuC+QHTL7FOlt610kwRGR44z+eQh7A8ydybjneDappo41u2O/xR4ISNfyEsUQYLKwbAaoulzSmJ344R83l5y+gkRVZ3yMWLdbqDGXwklVtSVX34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZYHhrOe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9FDC16AAE
	for <linux-pci@vger.kernel.org>; Fri, 19 Dec 2025 17:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766166550;
	bh=aTxhZjW/4+N0Y6yWx5qNa+TytCzWq5aRUStqK2cn/vE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YZYHhrOeAW4gXzY2n2Lg/elv1b+gLH5KvsPNAjCwrZxcOUGzasymPTFH/rE4vwGTs
	 vt9c4fNe5BSO2LEfeqxrWUt3012kZU7GrkdjFFw3RbJTtVvUMlrZhRkNZRgYoW8+6Q
	 k2ph2HRbKV4NOOmVPSzc4t07O5KvR2zBbCN9B5kcDC4TsONiyM7v2rFPFHvyhbr9TW
	 izMSqxPixoTHedmT6N/2p4fAoLZAZOvpOBgIqH9wpv5siDkEyBldHWErwsbwSARNR9
	 T+kmgH14VxxztmaiD3mlolwWMxrjYc6E22szZ9dyrEZ70X1SdBYVb5oczWhY7UqRqC
	 CbPEx5BuDpwWg==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-3e80c483a13so1385841fac.2
        for <linux-pci@vger.kernel.org>; Fri, 19 Dec 2025 09:49:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWbHVFn4b9VP7ElqmmZ6EUk3Fy+XgTaUPlXLJkr2boTSXVy9XkJ/afN6r1qZXN0taGesige9HmHbJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxurztxnvFEOEHqry+KeTXRBvs1zP6ClkOXlBRB8GeXL4Ddx/Wl
	/9NvlfhitTzoRK2RHP1U19TrahYIyxTi5ja315+Rc2O/lWilIGR39stB5Z51UASvLkK7N9WuPGT
	7zjl1A5E88cqKsC2HcdC6yMMwcg07Fi0=
X-Google-Smtp-Source: AGHT+IG7LvXCWUDje4oSuwKcRFrbMG9Sz2lzB1NswwYpJMwp418mlz+HvDX6SS3+lwO2l9tsESjJIRsFxhkLIQcbfBo=
X-Received: by 2002:a05:6820:611:b0:65c:fd25:f430 with SMTP id
 006d021491bc7-65d0e9b72cfmr1594117eaf.20.1766166549302; Fri, 19 Dec 2025
 09:49:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5049211.GXAFRqVoOG@rafael.j.wysocki> <3933560.kQq0lBPeGt@rafael.j.wysocki>
 <20251219125613.00000e0e@huawei.com>
In-Reply-To: <20251219125613.00000e0e@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 19 Dec 2025 18:48:57 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gp8E9_P3n5126F9YD72oyimCOHt1Z0cv_s_rUuipLY+Q@mail.gmail.com>
X-Gm-Features: AQt7F2ohDtuYDYVl58Kk4cbG47C-8mz_sR58gLzdX0BqlhjECElyZ0C93itBp78
Message-ID: <CAJZ5v0gp8E9_P3n5126F9YD72oyimCOHt1Z0cv_s_rUuipLY+Q@mail.gmail.com>
Subject: Re: [PATCH v1 6/8] ACPI: bus: Rework the handling of \_SB._OSC
 platform features
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, 
	Bjorn Helgaas <helgaas@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Hans de Goede <hansg@kernel.org>, 
	Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 1:56=E2=80=AFPM Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
>
> On Thu, 18 Dec 2025 21:39:43 +0100
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > The current handling of \_SB._OSC is susceptible to problems with
>
> Maybe state 'firmware bug workaround' a bit more clearly in this descript=
ion.
> I briefly wondered if there was a non buggy path to this case.

The main point to me is that the new code should work if the platform
firmware messes things up somewhat (but not too much) while the old
code fails in those cases.

There is also an assumption in the current code that setting error
bits in the return buffer means hard failures while it follows from
the spec (although not really clearly, which is a problem by itself)
that what matters is what bits are set in the return feature masks.
I'll add some information related to this to the changelog.

> > setting error bits in the output buffer by mistake if the platform
> > firmware is supplied with a feature mask previously acknowledged
> > by the analogous _OSC call with OSC_QUERY_ENABLE set.  If that
> > happens, acpi_run_osc() will return an error and the kernel will
> > assume that it cannot control any of the features it has asked
> > for.  If an error bit has been set by mistake, however, the platform
> > firmware may expect the kernel to actually take over the control of
> > those features and nobody will take care of them going forward.
>
> This 'may expect' seems like a nasty opening. I get that there is an oddi=
ty
> if a firmware says it can do something and then when we try to ask
> for that says no, but I'd be concerned that someone might have a bug
> in the query instead so it promises more that is actually possible
> and we grab control of things the firmware is still using with
> may eat babies result.

That of course is also possible.

> At very least I think we should scream about any firmware that
> does return an error in these cases.  You do that so I guess this
> is making the best of a bad situation.

Well, it doesn't actually scream, but that would be a matter of
changing the log level.

> Otherwise one comment inline.
> >
> > If the given feature mask has been already acknowledged once though,
> > the kernel may reasonably expect the _OSC evaluation to succeed and
> > acknowledge all of the features in the current mask again, but that
> > is not generally guaranteed to happen, so it is actually good to
> > verify the return buffer.  Still, it is sufficient to check the
> > feature bits in the return buffer for this purpose.
> >
> > Namely, the OSC_INVALID_UUID_ERROR and OSC_INVALID_REVISION_ERROR bits
> > should not be set then because they were not set during the previous
> > _OSC evaluation that has acknowledged the feature mask.  Moreover,
> > if all of the feature bits that are set in the capabilities buffer
> > are also set in the return buffer, the OSC_CAPABILITIES_MASK_ERROR
> > should not be set either and the OSC_REQUEST_ERROR bit doesn't matter
> > even if set.  Thus if that is the case, the kernel may regard the
> > entire feature mask as acknowledged and take over the control of the
> > given features as per Section 6.2.12 of ACPI 6.6 [1].
> >
> > If the feature masks in the capabilities buffer and in the return
> > buffer are different, the bits that are set in both masks may still
> > be regarded as acknowledged and the corresponding features may be
> > controlled by the kernel.
> >
> > Introduce a new function carrying out an _OSC handshake along the
> > lines of the above description and make the \_SB._OSC handling code
> > use it to avoid failing in some cases in which it may succeed
> > regardless of platform firmware deficiencies.
> >
> > Link: https://uefi.org/specs/ACPI/6.6/06_Device_Configuration.html#osc-=
operating-system-capabilities
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/acpi/bus.c |  128 ++++++++++++++++++++++++++++++++++++--------=
---------
> >  1 file changed, 88 insertions(+), 40 deletions(-)
> >
> > --- a/drivers/acpi/bus.c
> > +++ b/drivers/acpi/bus.c
> > @@ -311,6 +311,79 @@ out:
> >  }
> >  EXPORT_SYMBOL(acpi_run_osc);
> >
> > +static int acpi_osc_handshake(acpi_handle handle, const char *uuid_str=
,
> > +                           int rev, struct acpi_buffer *cap)
> > +{
> > +     union acpi_object in_params[4], *out_obj;
> > +     size_t bufsize =3D cap->length / sizeof(u32);
> > +     struct acpi_object_list input;
> > +     struct acpi_buffer output;
> > +     u32 *capbuf, *retbuf, test;
> > +     guid_t guid;
> > +     int ret, i;
> > +
> > +     if (!cap || cap->length < 2 * sizeof(32) || guid_parse(uuid_str, =
&guid))
> > +             return -EINVAL;
> > +
> > +     /* First evaluate _OSC with OSC_QUERY_ENABLE set. */
> > +     capbuf =3D cap->pointer;
> > +     capbuf[OSC_QUERY_DWORD] =3D OSC_QUERY_ENABLE;
> > +
> > +     ret =3D acpi_eval_osc(handle, &guid, rev, cap, in_params, &output=
);
> > +     if (ret)
> > +             return ret;
> > +
> > +     out_obj =3D output.pointer;
> > +     retbuf =3D (u32 *)out_obj->buffer.pointer;
> > +
> > +     if (acpi_osc_error_check(handle, &guid, rev, cap, retbuf)) {
> > +             ret =3D -ENODATA;
> > +             goto out;
> > +     }
> > +
> > +     /*
> > +      * Clear the feature bits in the capabilities buffer that have no=
t been
> > +      * acknowledged and clear the return buffer.
> > +      */
> > +     for (i =3D OSC_QUERY_DWORD + 1, test =3D 0; i < bufsize; i++) {
> > +             capbuf[i] &=3D retbuf[i];
> > +             test |=3D capbuf[i];
> > +             retbuf[i] =3D 0;
> > +     }
> > +     /*
> > +      * If none of the feature bits have been acknowledged, there's no=
thing
> > +      * more to do.
> > +      */
> > +     if (!test)
> > +             goto out;
> > +
> > +     retbuf[OSC_QUERY_DWORD] =3D 0;
> > +     /*
> > +      * Now evaluate _OSC again (directly) with OSC_QUERY_ENABLE clear=
 and
> > +      * the updated input and output buffers used before.
> > +      */
> > +     capbuf[OSC_QUERY_DWORD] =3D 0;
> > +     /* Reuse in_params[] populated by acpi_eval_osc(). */
> > +     input.pointer =3D in_params;
> > +     input.count =3D 4;
> > +
> > +     if (ACPI_FAILURE(acpi_evaluate_object(handle, "_OSC", &input, &ou=
tput))) {
> > +             ret =3D -ENODATA;
> > +             goto out;
> > +     }
> > +
> > +     /* Clear the feature bits that have not been acknowledged in capb=
uf[]. */
> > +     for (i =3D OSC_QUERY_DWORD + 1; i < bufsize; i++)
> > +             capbuf[i] &=3D retbuf[i];
> > +
> > +     /* Check _OSC errors to print debug messages if any. */
> > +     acpi_osc_error_check(acpi_osc_error_checkhandle, &guid, rev, cap,=
 retbuf);
>
> Maybe it's worth a 'Muddling on anyway' message to say that we are ignori=
ng those
> errors?

Sure, I'll add one, thanks!

> > +
> > +out:
> > +     ACPI_FREE(out_obj);
> > +     return ret;
> > +}
> > +

