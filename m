Return-Path: <linux-pci+bounces-43447-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF21CD1F58
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 22:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F061303B2F7
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 21:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA28332D443;
	Fri, 19 Dec 2025 21:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPjel0Dk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC41B3242AC;
	Fri, 19 Dec 2025 21:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766179687; cv=none; b=b6VBPNnxiqDOBTkEh3V2L6mJAOH1/h5MDD9Qq3VAW+TxfsDgdtCUXfEEEaKoMwYAD8h/MfdU3dDHrJaQ8X6gfzActYRWjciPmu6nY9B/D9i/lrviIjP4siFqpZN8Q/S17xL9Cff2wL/IdnkxsVSxQXvxIpXKHZb/MFVK1W3h4bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766179687; c=relaxed/simple;
	bh=nNAe7kYDbW9AIdmKv4Ap5BzVRHVfIUyt0aoxrmUdK98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JqHBTR1IKWCRTnvgh046WQU5wnTDUziLI3gKe83w/icx+1t4m8RD2DLELcUAwEjJvJ+dySkhtWgGWHXnWVko0gGYPdnIFpjA/cF5/WtD259bB9Pcn2IqWLuNy1kyZReylyoKGqt2yeo8OwCv/0Mk3gf4vQHYdFuuci4w+a0+jeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPjel0Dk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5538C4CEF1;
	Fri, 19 Dec 2025 21:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766179685;
	bh=nNAe7kYDbW9AIdmKv4Ap5BzVRHVfIUyt0aoxrmUdK98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YPjel0Dk7ck0TDiRlcNLJViPHtOt107ixvutukjbDd+aJikB4GNEh6cJL+RE4tT7Z
	 Y2JfNfbMfyWUvWeVqaj8xISEBqocFK4OxXUd9rvHyG6o0PvTZHigKOnph6KuE3Zf5z
	 OLgArOJRDu1x1qvPE4JGFWXoEhy4+pNo54HZzGoMFndB+Naicv/CuGOJSQ2q8vj+Z8
	 JrGU5BnrDMnvzRiZ99afPvyLvU1rHCJDgnoI8dVMfQuz7mid/v+HlngWsEacV1x0Pd
	 WubUslv3D3WIj0oyS8KQphQaFx9pw5yL+lv1TgZOK0AWVUc2t65TheeYff52jVvUP6
	 fWA3sSAg37Ijw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2] ACPI: bus: Fix handling of _OSC errors in acpi_run_osc()
Date: Fri, 19 Dec 2025 22:28:02 +0100
Message-ID: <5967663.DvuYhMxLoT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To:
 <CAJZ5v0hnyBCv-=nq5XbimupJ5T9DS9f4eCgDEC2SiH1gw3zH-A@mail.gmail.com>
References:
 <5049211.GXAFRqVoOG@rafael.j.wysocki> <20251219122620.00002049@huawei.com>
 <CAJZ5v0hnyBCv-=nq5XbimupJ5T9DS9f4eCgDEC2SiH1gw3zH-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Friday, December 19, 2025 9:38:44 PM CET Rafael J. Wysocki wrote:
> On Fri, Dec 19, 2025 at 1:26=E2=80=AFPM Jonathan Cameron
> <jonathan.cameron@huawei.com> wrote:
> >
> > On Thu, 18 Dec 2025 21:34:26 +0100
> > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> >
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > The handling of _OSC errors in acpi_run_osc() is inconsistent.
> >
> > I wonder if this would be easier to follow with a brief statement
> > of why we threat OSC_CAPABILITIES_MASK_ERROR as an error in the first
> > place for non query cases?  It took me a brief think and spec read
> > to figure that out, but maybe more coffee needed.
>=20
> Well, this is a good question and it is not obvious IMV.
>=20
> The current code treats it as an error, but arguably it is not really an =
error.
>=20
> If it is a query, it doesn't even make sense to print a debug message
> for it, but if it is not a query, the feature mask in the _OSC return
> buffer still represents the feature that the OS is expected to
> control.  So print the debug messages, but do not fail in that case.
>=20
> I'll update the patch.

I have come to the conclusion that the underlying issue can be addressed in
this patch and it basically boils down to the compliance with the spec.

Please see below.  If we can agree that this is the way to go, I'll rework
the rest of the patch series as a follow-up on top of this one.

Thanks!

=2D--
=46rom: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH v2] ACPI: bus: Fix handling of _OSC errors in acpi_run_osc()

The handling of _OSC errors in acpi_run_osc() is inconsistent and
arguably not compliant with the _OSC definition (cf. Section 6.2.12 of
ACPI 6.6 [1]).

Namely, if OSC_QUERY_ENABLE is not set in the capabilities buffer and
any of the error bits are set in the _OSC return buffer, acpi_run_osc()
returns an error code and the _OSC return buffer is discarded.  However,
in that case, depending on what error bits are set, the return buffer
may contain acknowledged bits for features that need to be controlled by
the kernel going forward.

If the OSC_INVALID_UUID_ERROR bit is set, the request could not be
processed at all and so in that particular case discarding the _OSC
return buffer and returning an error is the right thing to do regardless
of whether or not OSC_QUERY_ENABLE is set in the capabilities buffer.

If OSC_QUERY_ENABLE is set in the capabilities buffer and the
OSC_REQUEST_ERROR or OSC_INVALID_REVISION_ERROR bits are set in the
return buffer, acpi_run_osc() may return an error and discard the _OSC
return buffer because in that case the platform configuration does not
change.  However, if any of them is set in the return buffer when
OSC_QUERY_ENABLE is not set in the capabilities buffer, the feature
mask in the _OSC return buffer still representes a set of acknowleded
features as per the _OSC definition:

 The platform acknowledges the Capabilities Buffer by returning a
 buffer of DWORDs of the same length. Set bits indicate acknowledgment
 that OSPM may take control of the capability and cleared bits indicate
 that the platform either does not support the capability or that OSPM
 may not assume control.

which is not conditional on the error bits being clear, so in that case,
discarding the _OSC return buffer is questionable.  There is also no
reason to return an error and discard the _OSC return buffer if the
OSC_CAPABILITIES_MASK_ERROR bit is set in it, but printing diagnostic
messages is not unreasonable when that happens with OSC_QUERY_ENABLE
clear in the capabilities buffer.

Adress this issue by making acpi_run_osc() follow the rules outlined
above.

Moreover, make acpi_run_osc() only take the defined _OSC error bits into
account when checking _OSC errors.

Link: https://uefi.org/specs/ACPI/6.6/06_Device_Configuration.html#osc-oper=
ating-system-capabilities
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
=2D--
 drivers/acpi/bus.c |   50 ++++++++++++++++++++++++++++++++++++------------=
=2D-
 1 file changed, 36 insertions(+), 14 deletions(-)

=2D-- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -194,14 +194,18 @@ static void acpi_print_osc_error(acpi_ha
 	pr_debug("\n");
 }
=20
+#define OSC_ERROR_MASK 	(OSC_REQUEST_ERROR | OSC_INVALID_UUID_ERROR | \
+			 OSC_INVALID_REVISION_ERROR | \
+			 OSC_CAPABILITIES_MASK_ERROR)
+
 acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *cont=
ext)
 {
+	u32 errors, *capbuf =3D context->cap.pointer;
 	acpi_status status;
 	struct acpi_object_list input;
 	union acpi_object in_params[4];
 	union acpi_object *out_obj;
 	guid_t guid;
=2D	u32 errors;
 	struct acpi_buffer output =3D {ACPI_ALLOCATE_BUFFER, NULL};
=20
 	if (!context)
@@ -240,29 +244,47 @@ acpi_status acpi_run_osc(acpi_handle han
 		status =3D AE_TYPE;
 		goto out_kfree;
 	}
=2D	/* Need to ignore the bit0 in result code */
=2D	errors =3D *((u32 *)out_obj->buffer.pointer) & ~(1 << 0);
+	/* Only take defined error bits into account. */
+	errors =3D *((u32 *)out_obj->buffer.pointer) & OSC_ERROR_MASK;
+	/*
+	 * If OSC_QUERY_ENABLE is set, ignore the "capabilities masked"
+	 * bit because it merely means that some features have not been
+	 * acknowledged which is not unexpected.
+	 */
+	if (capbuf[OSC_QUERY_DWORD] & OSC_QUERY_ENABLE)
+		errors &=3D ~OSC_CAPABILITIES_MASK_ERROR;
+
 	if (errors) {
+		if (errors & OSC_INVALID_UUID_ERROR) {
+			acpi_print_osc_error(handle, context,
+				"_OSC invalid UUID");
+			/*
+			 * Always fail if this bit is set because it means that
+			 * the request could not be processed.
+			 */
+			status =3D AE_ERROR;
+			goto out_kfree;
+		}
 		if (errors & OSC_REQUEST_ERROR)
 			acpi_print_osc_error(handle, context,
 				"_OSC request failed");
=2D		if (errors & OSC_INVALID_UUID_ERROR)
=2D			acpi_print_osc_error(handle, context,
=2D				"_OSC invalid UUID");
 		if (errors & OSC_INVALID_REVISION_ERROR)
 			acpi_print_osc_error(handle, context,
 				"_OSC invalid revision");
=2D		if (errors & OSC_CAPABILITIES_MASK_ERROR) {
=2D			if (((u32 *)context->cap.pointer)[OSC_QUERY_DWORD]
=2D			    & OSC_QUERY_ENABLE)
=2D				goto out_success;
=2D			status =3D AE_SUPPORT;
+		if (errors & OSC_CAPABILITIES_MASK_ERROR)
+			acpi_print_osc_error(handle, context,
+				"_OSC capability bits masked");
+
+		/*
+		 * Fail only if OSC_QUERY_ENABLE is set because otherwise the
+		 * acknowledged features need to be controlled.
+		 */
+		if (capbuf[OSC_QUERY_DWORD] & OSC_QUERY_ENABLE) {
+			status =3D AE_ERROR;
 			goto out_kfree;
 		}
=2D		status =3D AE_ERROR;
=2D		goto out_kfree;
 	}
=2Dout_success:
+
 	context->ret.length =3D out_obj->buffer.length;
 	context->ret.pointer =3D kmemdup(out_obj->buffer.pointer,
 				       context->ret.length, GFP_KERNEL);




