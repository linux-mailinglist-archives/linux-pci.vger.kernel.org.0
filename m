Return-Path: <linux-pci+bounces-43573-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CBFCD911D
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 12:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3086A301441C
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 11:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C060E31AABC;
	Tue, 23 Dec 2025 11:18:21 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E4B330B21;
	Tue, 23 Dec 2025 11:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766488701; cv=none; b=SHqq9Wy0giTSW12yoyWLeNT6UI3OlbThQSO/L95QDyA/blPKBPt5enTUcy15IdNfh5BM8U+C1vOt5EbQ+79BlXJxUPtu5cIyJGB45TrsRnR/+8/nSQ5Ww7stVkDHMC0BzbbIMHlKlM2nfe6D0w/MBa3Oz4bqZGg7OzOYB5wVp+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766488701; c=relaxed/simple;
	bh=o6gUd3KjCrrNX+odeZ21l5up08lsDRbc24Z4xFWuysE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rU0csG/AiizTCdMLZ5oAZiLLfMo4FVwm3R2ijL+rIdQNWjJyuW9RaE6BvCMGLRKpyEUmrG2Dx7RnPCXQDcDqzrZ5K/l2jfC+0hPjRKTALYIR8pON+g8EvfC0c7y8jt51X/GUcSC6GFlgDgyf3SSm3WFWAs6RmzlQ1mqNeKMJxOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dbCCh4r7VzJ46d6;
	Tue, 23 Dec 2025 19:17:36 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id B0F4F4057A;
	Tue, 23 Dec 2025 19:18:15 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 23 Dec
 2025 11:18:15 +0000
Date: Tue, 23 Dec 2025 11:18:13 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI
	<linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
CC: Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Hans de Goede
	<hansg@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2.1 3/8] ACPI: bus: Split _OSC evaluation out of
 acpi_run_osc()
Message-ID: <20251223111813.00000d67@huawei.com>
In-Reply-To: <22963770.EfDdHjke4D@rafael.j.wysocki>
References: <2413407.ElGaqSPkdT@rafael.j.wysocki>
	<22963770.EfDdHjke4D@rafael.j.wysocki>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 22 Dec 2025 20:14:16 +0100
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Split a function for evaluating _OSC called acpi_eval_osc() out of
> acpi_run_osc() to facilitate subsequent changes and add some more
> parameters sanity checks to the latter.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Hi Rafael,

There is a little bit of reformatting / whitespace cleanup in here
that makes it a tiny bit harder to review than if that had been
done separately.  Not worth a respin though.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> ---
> 
> v1 -> v2.1:
>    * Fix typo in the changelog (Jonathan).
>    * Use at_least to enforce compiler checking of in_params[] size instead of
>      using "static" directly (Jonathan).
> 
> ---
>  drivers/acpi/bus.c |   91 ++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 53 insertions(+), 38 deletions(-)
> 
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -196,52 +196,67 @@ static void acpi_dump_osc_data(acpi_hand
>  			 OSC_INVALID_REVISION_ERROR | \
>  			 OSC_CAPABILITIES_MASK_ERROR)
>  
> -acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context)
> +static int acpi_eval_osc(acpi_handle handle, guid_t *guid, int rev,
> +			 struct acpi_buffer *cap,
> +			 union acpi_object in_params[at_least 4],
> +			 struct acpi_buffer *output)
>  {
> -	u32 errors, *capbuf = context->cap.pointer;
> -	acpi_status status;
>  	struct acpi_object_list input;
> -	union acpi_object in_params[4];
>  	union acpi_object *out_obj;
> -	guid_t guid;
> -	struct acpi_buffer output = {ACPI_ALLOCATE_BUFFER, NULL};
> -
> -	if (!context)
> -		return AE_ERROR;
> -	if (guid_parse(context->uuid_str, &guid))
> -		return AE_ERROR;
> -	context->ret.length = ACPI_ALLOCATE_BUFFER;
> -	context->ret.pointer = NULL;
> +	acpi_status status;
>  
> -	/* Setting up input parameters */
> -	input.count = 4;
> +	in_params[0].type = ACPI_TYPE_BUFFER;
> +	in_params[0].buffer.length = sizeof(*guid);
> +	in_params[0].buffer.pointer = (u8 *)guid;
> +	in_params[1].type = ACPI_TYPE_INTEGER;
> +	in_params[1].integer.value = rev;
> +	in_params[2].type = ACPI_TYPE_INTEGER;
> +	in_params[2].integer.value = cap->length / sizeof(u32);
> +	in_params[3].type = ACPI_TYPE_BUFFER;
> +	in_params[3].buffer.length = cap->length;
> +	in_params[3].buffer.pointer = cap->pointer;
>  	input.pointer = in_params;
> -	in_params[0].type 		= ACPI_TYPE_BUFFER;
> -	in_params[0].buffer.length 	= 16;
> -	in_params[0].buffer.pointer	= (u8 *)&guid;
> -	in_params[1].type 		= ACPI_TYPE_INTEGER;
> -	in_params[1].integer.value 	= context->rev;
> -	in_params[2].type 		= ACPI_TYPE_INTEGER;
> -	in_params[2].integer.value	= context->cap.length/sizeof(u32);
> -	in_params[3].type		= ACPI_TYPE_BUFFER;
> -	in_params[3].buffer.length 	= context->cap.length;
> -	in_params[3].buffer.pointer 	= context->cap.pointer;
Not sure I'd have made this formatting change in here because it
'might' have hidden real functional changes from reviewers.

> -
> -	status = acpi_evaluate_object(handle, "_OSC", &input, &output);
> -	if (ACPI_FAILURE(status))
> -		return status;
> +	input.count = 4;
>  
> -	if (!output.length)
> -		return AE_NULL_OBJECT;
> +	output->length = ACPI_ALLOCATE_BUFFER;
> +	output->pointer = NULL;
>  
> -	out_obj = output.pointer;
> -	if (out_obj->type != ACPI_TYPE_BUFFER
> -		|| out_obj->buffer.length != context->cap.length) {
> -		acpi_dump_osc_data(handle, &guid, context->rev, &context->cap);
> -		acpi_handle_debug(handle, "_OSC: evaluation returned wrong type");
> -		status = AE_TYPE;
> -		goto out_kfree;
> +	status = acpi_evaluate_object(handle, "_OSC", &input, output);
> +	if (ACPI_FAILURE(status) || !output->length)
> +		return -ENODATA;
> +
> +	out_obj = output->pointer;
> +	if (out_obj->type != ACPI_TYPE_BUFFER ||
> +	    out_obj->buffer.length != cap->length) {
> +		acpi_handle_debug(handle, "Invalid _OSC return buffer\n");
> +		acpi_dump_osc_data(handle, guid, rev, cap);
> +		ACPI_FREE(out_obj);
> +		return -ENODATA;
>  	}
> +
> +	return 0;
> +}



