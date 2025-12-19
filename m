Return-Path: <linux-pci+bounces-43395-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 74688CCFEB2
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 13:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 318EA30378BB
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 12:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A83312816;
	Fri, 19 Dec 2025 12:56:21 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0653126ED33;
	Fri, 19 Dec 2025 12:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766148981; cv=none; b=n6l7+RT/NMzoH1s8097FmpryN9TMhm/b9rywr24Bxm2ERrTbclhGL82nFSp9MRn6s2y0rQlvWzLIVk0Lbf7zt3fVG96JuO9GuYNi+ErO6MdiVp1FcHGTdtT6iqsGGdjbwGGGyQ6hfxkinegtR0HmBfPnpXJ+Ct3x+UHlVty9e2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766148981; c=relaxed/simple;
	bh=vTr9kutEmrv65fyo4qE4R9losF7wzO+3EgALaX7lK2k=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pTE6EbE3px1T6Y9mYyVU7kHZi667j+iqPudr/wz61amcD5XogpheQAqQffu44hJ04s/CJebQ2sXbMjiMnT144pSlweiECzhfZtPZ5xmPLyhYta059cU5RsMA2EGEVBNZDJ13LpGRVTZ3ushw320V1+nZcGbuvljWRP1FVfOJscI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dXnZp08vmzHnGh8;
	Fri, 19 Dec 2025 20:55:46 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 2B7B240571;
	Fri, 19 Dec 2025 20:56:15 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 19 Dec
 2025 12:56:14 +0000
Date: Fri, 19 Dec 2025 12:56:13 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Linux ACPI <linux-acpi@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Bjorn
 Helgaas <helgaas@kernel.org>, Srinivas Pandruvada
	<srinivas.pandruvada@linux.intel.com>, Hans de Goede <hansg@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v1 6/8] ACPI: bus: Rework the handling of \_SB._OSC
 platform features
Message-ID: <20251219125613.00000e0e@huawei.com>
In-Reply-To: <3933560.kQq0lBPeGt@rafael.j.wysocki>
References: <5049211.GXAFRqVoOG@rafael.j.wysocki>
	<3933560.kQq0lBPeGt@rafael.j.wysocki>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 18 Dec 2025 21:39:43 +0100
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The current handling of \_SB._OSC is susceptible to problems with

Maybe state 'firmware bug workaround' a bit more clearly in this description.
I briefly wondered if there was a non buggy path to this case.

> setting error bits in the output buffer by mistake if the platform
> firmware is supplied with a feature mask previously acknowledged
> by the analogous _OSC call with OSC_QUERY_ENABLE set.  If that
> happens, acpi_run_osc() will return an error and the kernel will
> assume that it cannot control any of the features it has asked
> for.  If an error bit has been set by mistake, however, the platform
> firmware may expect the kernel to actually take over the control of
> those features and nobody will take care of them going forward.

This 'may expect' seems like a nasty opening. I get that there is an oddity
if a firmware says it can do something and then when we try to ask
for that says no, but I'd be concerned that someone might have a bug
in the query instead so it promises more that is actually possible
and we grab control of things the firmware is still using with
may eat babies result.

At very least I think we should scream about any firmware that
does return an error in these cases.  You do that so I guess this
is making the best of a bad situation.

Otherwise one comment inline.
> 
> If the given feature mask has been already acknowledged once though,
> the kernel may reasonably expect the _OSC evaluation to succeed and
> acknowledge all of the features in the current mask again, but that
> is not generally guaranteed to happen, so it is actually good to
> verify the return buffer.  Still, it is sufficient to check the
> feature bits in the return buffer for this purpose.
> 
> Namely, the OSC_INVALID_UUID_ERROR and OSC_INVALID_REVISION_ERROR bits
> should not be set then because they were not set during the previous
> _OSC evaluation that has acknowledged the feature mask.  Moreover,
> if all of the feature bits that are set in the capabilities buffer
> are also set in the return buffer, the OSC_CAPABILITIES_MASK_ERROR
> should not be set either and the OSC_REQUEST_ERROR bit doesn't matter
> even if set.  Thus if that is the case, the kernel may regard the
> entire feature mask as acknowledged and take over the control of the
> given features as per Section 6.2.12 of ACPI 6.6 [1].
> 
> If the feature masks in the capabilities buffer and in the return
> buffer are different, the bits that are set in both masks may still
> be regarded as acknowledged and the corresponding features may be
> controlled by the kernel.
> 
> Introduce a new function carrying out an _OSC handshake along the
> lines of the above description and make the \_SB._OSC handling code
> use it to avoid failing in some cases in which it may succeed
> regardless of platform firmware deficiencies.
> 
> Link: https://uefi.org/specs/ACPI/6.6/06_Device_Configuration.html#osc-operating-system-capabilities
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/bus.c |  128 ++++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 88 insertions(+), 40 deletions(-)
> 
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -311,6 +311,79 @@ out:
>  }
>  EXPORT_SYMBOL(acpi_run_osc);
>  
> +static int acpi_osc_handshake(acpi_handle handle, const char *uuid_str,
> +			      int rev, struct acpi_buffer *cap)
> +{
> +	union acpi_object in_params[4], *out_obj;
> +	size_t bufsize = cap->length / sizeof(u32);
> +	struct acpi_object_list input;
> +	struct acpi_buffer output;
> +	u32 *capbuf, *retbuf, test;
> +	guid_t guid;
> +	int ret, i;
> +
> +	if (!cap || cap->length < 2 * sizeof(32) || guid_parse(uuid_str, &guid))
> +		return -EINVAL;
> +
> +	/* First evaluate _OSC with OSC_QUERY_ENABLE set. */
> +	capbuf = cap->pointer;
> +	capbuf[OSC_QUERY_DWORD] = OSC_QUERY_ENABLE;
> +
> +	ret = acpi_eval_osc(handle, &guid, rev, cap, in_params, &output);
> +	if (ret)
> +		return ret;
> +
> +	out_obj = output.pointer;
> +	retbuf = (u32 *)out_obj->buffer.pointer;
> +
> +	if (acpi_osc_error_check(handle, &guid, rev, cap, retbuf)) {
> +		ret = -ENODATA;
> +		goto out;
> +	}
> +
> +	/*
> +	 * Clear the feature bits in the capabilities buffer that have not been
> +	 * acknowledged and clear the return buffer.
> +	 */
> +	for (i = OSC_QUERY_DWORD + 1, test = 0; i < bufsize; i++) {
> +		capbuf[i] &= retbuf[i];
> +		test |= capbuf[i];
> +		retbuf[i] = 0;
> +	}
> +	/*
> +	 * If none of the feature bits have been acknowledged, there's nothing
> +	 * more to do.
> +	 */
> +	if (!test)
> +		goto out;
> +
> +	retbuf[OSC_QUERY_DWORD] = 0;
> +	/*
> +	 * Now evaluate _OSC again (directly) with OSC_QUERY_ENABLE clear and
> +	 * the updated input and output buffers used before.
> +	 */
> +	capbuf[OSC_QUERY_DWORD] = 0;
> +	/* Reuse in_params[] populated by acpi_eval_osc(). */
> +	input.pointer = in_params;
> +	input.count = 4;
> +
> +	if (ACPI_FAILURE(acpi_evaluate_object(handle, "_OSC", &input, &output))) {
> +		ret = -ENODATA;
> +		goto out;
> +	}
> +
> +	/* Clear the feature bits that have not been acknowledged in capbuf[]. */
> +	for (i = OSC_QUERY_DWORD + 1; i < bufsize; i++)
> +		capbuf[i] &= retbuf[i];
> +
> +	/* Check _OSC errors to print debug messages if any. */
> +	acpi_osc_error_check(acpi_osc_error_checkhandle, &guid, rev, cap, retbuf);

Maybe it's worth a 'Muddling on anyway' message to say that we are ignoring those
errors?

> +
> +out:
> +	ACPI_FREE(out_obj);
> +	return ret;
> +}
> +

