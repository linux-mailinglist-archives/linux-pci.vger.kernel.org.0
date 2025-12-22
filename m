Return-Path: <linux-pci+bounces-43518-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D32A8CD5C9B
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 12:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A9F2303434B
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 11:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F366313285;
	Mon, 22 Dec 2025 11:18:40 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA60D3161A8;
	Mon, 22 Dec 2025 11:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766402319; cv=none; b=dPpqBqU4KleHpcPX1YPSAusQvVoJ53UVtLy53ZGwYde/Q7yLx9g36tbgx5I2z7QnMnemAWFVUUtIjK2VtUJJbIhAuQg2tPXNvzk98oXG0PfryUwqqXmMy8rAud0uaqtQEWfVrOB4Wfk3sajYoKzSlJ6P3EiG9xtKkm/qe3AkH/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766402319; c=relaxed/simple;
	bh=OC7l8jcV8eCGVt6qiVUJr/MCmG5z1Usv9bRRakEcM2Q=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MTqomlgWYwq+7Qx92joeVK94VHx3i6NjhcmCl7EbHEro/7IC+6halTgrZAV7yMyBlauFeQdarUVLf04Qn/LL8PWGbKRO/AbGdhffLAYdOSblAjdbhKLvb9SGuIQHcJfz4wJ0CK1JJ4YCLgzy80yI6UxDarv3qPT+0LCQiLNYx0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dZbGM4vZlzJ467k;
	Mon, 22 Dec 2025 19:17:47 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 18AD34056A;
	Mon, 22 Dec 2025 19:18:25 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 22 Dec
 2025 11:18:10 +0000
Date: Mon, 22 Dec 2025 11:18:08 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Linux ACPI <linux-acpi@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Bjorn
 Helgaas <helgaas@kernel.org>, Srinivas Pandruvada
	<srinivas.pandruvada@linux.intel.com>, Hans de Goede <hansg@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2] ACPI: bus: Fix handling of _OSC errors in
 acpi_run_osc()
Message-ID: <20251222111808.00007b3c@huawei.com>
In-Reply-To: <5967663.DvuYhMxLoT@rafael.j.wysocki>
References: <5049211.GXAFRqVoOG@rafael.j.wysocki>
	<20251219122620.00002049@huawei.com>
	<CAJZ5v0hnyBCv-=nq5XbimupJ5T9DS9f4eCgDEC2SiH1gw3zH-A@mail.gmail.com>
	<5967663.DvuYhMxLoT@rafael.j.wysocki>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 19 Dec 2025 22:28:02 +0100
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Friday, December 19, 2025 9:38:44 PM CET Rafael J. Wysocki wrote:
> > On Fri, Dec 19, 2025 at 1:26=E2=80=AFPM Jonathan Cameron
> > <jonathan.cameron@huawei.com> wrote: =20
> > >
> > > On Thu, 18 Dec 2025 21:34:26 +0100
> > > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > > =20
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > The handling of _OSC errors in acpi_run_osc() is inconsistent. =20
> > >
> > > I wonder if this would be easier to follow with a brief statement
> > > of why we threat OSC_CAPABILITIES_MASK_ERROR as an error in the first
> > > place for non query cases?  It took me a brief think and spec read
> > > to figure that out, but maybe more coffee needed. =20
> >=20
> > Well, this is a good question and it is not obvious IMV.
> >=20
> > The current code treats it as an error, but arguably it is not really a=
n error.
> >=20
> > If it is a query, it doesn't even make sense to print a debug message
> > for it, but if it is not a query, the feature mask in the _OSC return
> > buffer still represents the feature that the OS is expected to
> > control.  So print the debug messages, but do not fail in that case.
> >=20
> > I'll update the patch. =20
>=20
> I have come to the conclusion that the underlying issue can be addressed =
in
> this patch and it basically boils down to the compliance with the spec.
>=20
> Please see below.  If we can agree that this is the way to go, I'll rework
> the rest of the patch series as a follow-up on top of this one.
>=20
> Thanks!
>=20
> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH v2] ACPI: bus: Fix handling of _OSC errors in acpi_run_os=
c()
>=20
> The handling of _OSC errors in acpi_run_osc() is inconsistent and
> arguably not compliant with the _OSC definition (cf. Section 6.2.12 of
> ACPI 6.6 [1]).
>=20
> Namely, if OSC_QUERY_ENABLE is not set in the capabilities buffer and
> any of the error bits are set in the _OSC return buffer, acpi_run_osc()
> returns an error code and the _OSC return buffer is discarded.  However,
> in that case, depending on what error bits are set, the return buffer
> may contain acknowledged bits for features that need to be controlled by
> the kernel going forward.
>=20
> If the OSC_INVALID_UUID_ERROR bit is set, the request could not be
> processed at all and so in that particular case discarding the _OSC
> return buffer and returning an error is the right thing to do regardless
> of whether or not OSC_QUERY_ENABLE is set in the capabilities buffer.
>=20
> If OSC_QUERY_ENABLE is set in the capabilities buffer and the
> OSC_REQUEST_ERROR or OSC_INVALID_REVISION_ERROR bits are set in the

For the _OSC Failure =3D OSC_REQUEST_ERROR the 'capabilities bits may have =
been
masked' bothers me a little but other that that vagueness I think your
interpretation is correct.  The spec could definitely have been more tightly
written though so I suspect there may be implementations out there that
get this wrong in the corner cases.  Mind you we shouldn't see them anyway
assuming correct negotiation and nothing unexpected!=20

> return buffer, acpi_run_osc() may return an error and discard the _OSC
> return buffer because in that case the platform configuration does not
> change.  However, if any of them is set in the return buffer when
> OSC_QUERY_ENABLE is not set in the capabilities buffer, the feature
> mask in the _OSC return buffer still representes a set of acknowleded
> features as per the _OSC definition:
>=20
>  The platform acknowledges the Capabilities Buffer by returning a
>  buffer of DWORDs of the same length. Set bits indicate acknowledgment
>  that OSPM may take control of the capability and cleared bits indicate
>  that the platform either does not support the capability or that OSPM
>  may not assume control.
>=20
> which is not conditional on the error bits being clear, so in that case,
> discarding the _OSC return buffer is questionable.  There is also no
> reason to return an error and discard the _OSC return buffer if the
> OSC_CAPABILITIES_MASK_ERROR bit is set in it, but printing diagnostic
> messages is not unreasonable when that happens with OSC_QUERY_ENABLE
> clear in the capabilities buffer.
I'd got further and say "printing diagnostic messages is appropriate"
given this happening is indicating something we don't expect to see.

Other than that this looks good to me.

Thanks

Jonathan

>=20
> Adress this issue by making acpi_run_osc() follow the rules outlined
> above.
>=20
> Moreover, make acpi_run_osc() only take the defined _OSC error bits into
> account when checking _OSC errors.
>=20
> Link: https://uefi.org/specs/ACPI/6.6/06_Device_Configuration.html#osc-op=
erating-system-capabilities
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/bus.c |   50 ++++++++++++++++++++++++++++++++++++----------=
----
>  1 file changed, 36 insertions(+), 14 deletions(-)
>=20
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -194,14 +194,18 @@ static void acpi_print_osc_error(acpi_ha
>  	pr_debug("\n");
>  }
> =20
> +#define OSC_ERROR_MASK 	(OSC_REQUEST_ERROR | OSC_INVALID_UUID_ERROR | \
> +			 OSC_INVALID_REVISION_ERROR | \
> +			 OSC_CAPABILITIES_MASK_ERROR)
> +
>  acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *co=
ntext)
>  {
> +	u32 errors, *capbuf =3D context->cap.pointer;
>  	acpi_status status;
>  	struct acpi_object_list input;
>  	union acpi_object in_params[4];
>  	union acpi_object *out_obj;
>  	guid_t guid;
> -	u32 errors;
>  	struct acpi_buffer output =3D {ACPI_ALLOCATE_BUFFER, NULL};
> =20
>  	if (!context)
> @@ -240,29 +244,47 @@ acpi_status acpi_run_osc(acpi_handle han
>  		status =3D AE_TYPE;
>  		goto out_kfree;
>  	}
> -	/* Need to ignore the bit0 in result code */
> -	errors =3D *((u32 *)out_obj->buffer.pointer) & ~(1 << 0);
> +	/* Only take defined error bits into account. */
> +	errors =3D *((u32 *)out_obj->buffer.pointer) & OSC_ERROR_MASK;
> +	/*
> +	 * If OSC_QUERY_ENABLE is set, ignore the "capabilities masked"
> +	 * bit because it merely means that some features have not been
> +	 * acknowledged which is not unexpected.
> +	 */
> +	if (capbuf[OSC_QUERY_DWORD] & OSC_QUERY_ENABLE)
> +		errors &=3D ~OSC_CAPABILITIES_MASK_ERROR;
> +
>  	if (errors) {
> +		if (errors & OSC_INVALID_UUID_ERROR) {
> +			acpi_print_osc_error(handle, context,
> +				"_OSC invalid UUID");
> +			/*
> +			 * Always fail if this bit is set because it means that
> +			 * the request could not be processed.
> +			 */
> +			status =3D AE_ERROR;
> +			goto out_kfree;
> +		}
>  		if (errors & OSC_REQUEST_ERROR)
>  			acpi_print_osc_error(handle, context,
>  				"_OSC request failed");
> -		if (errors & OSC_INVALID_UUID_ERROR)
> -			acpi_print_osc_error(handle, context,
> -				"_OSC invalid UUID");
>  		if (errors & OSC_INVALID_REVISION_ERROR)
>  			acpi_print_osc_error(handle, context,
>  				"_OSC invalid revision");
> -		if (errors & OSC_CAPABILITIES_MASK_ERROR) {
> -			if (((u32 *)context->cap.pointer)[OSC_QUERY_DWORD]
> -			    & OSC_QUERY_ENABLE)
> -				goto out_success;
> -			status =3D AE_SUPPORT;
> +		if (errors & OSC_CAPABILITIES_MASK_ERROR)
> +			acpi_print_osc_error(handle, context,
> +				"_OSC capability bits masked");
> +
> +		/*
> +		 * Fail only if OSC_QUERY_ENABLE is set because otherwise the
> +		 * acknowledged features need to be controlled.
> +		 */
> +		if (capbuf[OSC_QUERY_DWORD] & OSC_QUERY_ENABLE) {
> +			status =3D AE_ERROR;
>  			goto out_kfree;
>  		}
> -		status =3D AE_ERROR;
> -		goto out_kfree;
>  	}
> -out_success:
> +
>  	context->ret.length =3D out_obj->buffer.length;
>  	context->ret.pointer =3D kmemdup(out_obj->buffer.pointer,
>  				       context->ret.length, GFP_KERNEL);
>=20
>=20
>=20
>=20
>=20


