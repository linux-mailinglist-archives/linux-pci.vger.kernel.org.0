Return-Path: <linux-pci+bounces-43392-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACEFCCFDEF
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 13:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 87E173033582
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 12:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C15329C78;
	Fri, 19 Dec 2025 12:44:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8858328B64;
	Fri, 19 Dec 2025 12:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766148258; cv=none; b=Y29o5UKShAmVgET2RfMihwnGkaF84wWVVp6ZzmiUI8nUZGBzK0Gb9EsDc2mKOYB0VTF7vPx8ACZHGxll8fXRt3KjY5rX3Y8Q2zBjwRlPE+hN+2AeFDrr1cSjZMRU66fKD30nj48fa7pjgBip99pKe27kye2DBAMCg4fQfZadzmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766148258; c=relaxed/simple;
	bh=iKzE5RauLDZe0i/Y6euP5eyddQjGmkaX1s8zq51NfAA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ru6//MhQ9GI75ObsRMmDsEt/zKYBVGrzut4ynNMVan4TTsN27Yiksk07341fgdKljHBz9ZSNbR1fL3HfnMmNonZ3STTGOg2JFs+g8oW3BrRyCtD+zGyF0S03+KiNfu4dqiRb/fJeH/a6CclncGOgtM76gR6RUUF0p5rfXsLcI/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dXnJq2qplzJ468V;
	Fri, 19 Dec 2025 20:43:39 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 04D5140565;
	Fri, 19 Dec 2025 20:44:12 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 19 Dec
 2025 12:44:11 +0000
Date: Fri, 19 Dec 2025 12:44:09 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Linux ACPI <linux-acpi@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Bjorn
 Helgaas <helgaas@kernel.org>, Srinivas Pandruvada
	<srinivas.pandruvada@linux.intel.com>, Hans de Goede <hansg@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v1 3/8] ACPI: bus: Split _OSC evaluation out of
 acpi_run_osc()
Message-ID: <20251219124409.00002f4e@huawei.com>
In-Reply-To: <3407425.44csPzL39Z@rafael.j.wysocki>
References: <5049211.GXAFRqVoOG@rafael.j.wysocki>
	<3407425.44csPzL39Z@rafael.j.wysocki>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 18 Dec 2025 21:36:08 +0100
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Split a function for evaluating _OSL called acpi_eval_osc() out of

_OSC

> acpi_run_osc() to facilitate subsequent changes and add some more
> parameters sanity checks to the latter.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

One comment on the fun static keyword usage.  Next time I have
to ask/answer some silly C questions in an interview that one is definitely going
in :)
> ---
>  drivers/acpi/bus.c |   89 ++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 52 insertions(+), 37 deletions(-)
> 
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -195,52 +195,67 @@ static void acpi_dump_osc_data(acpi_hand
>  			 OSC_INVALID_REVISION_ERROR | \
>  			 OSC_CAPABILITIES_MASK_ERROR)
>  
> -acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context)
> +static int acpi_eval_osc(acpi_handle handle, guid_t *guid, int rev,
> +			 struct acpi_buffer *cap,
> +			 union acpi_object in_params[static 4],

This static usage has such non intuitive behavior maybe use
the new at_least marking in compiler_types.h to indicate
what protection against wrong sizes it can offer.

> +			 struct acpi_buffer *output)
>  {
> -	acpi_status status;
>  	struct acpi_object_list input;
> -	union acpi_object in_params[4];
>  	union acpi_object *out_obj;
> +	acpi_status status;
> +
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
> +	input.pointer = in_params;
> +	input.count = 4;
> +
> +	output->length = ACPI_ALLOCATE_BUFFER;
> +	output->pointer = NULL;
> +
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
> +	}
> +
> +	return 0;
> +}


