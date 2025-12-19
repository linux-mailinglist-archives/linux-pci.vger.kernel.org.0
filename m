Return-Path: <linux-pci+bounces-43385-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A4ECCFE3A
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 13:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8BA531213C9
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 12:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E613446A5;
	Fri, 19 Dec 2025 12:33:27 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5D734404E;
	Fri, 19 Dec 2025 12:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766147607; cv=none; b=TSifAVjhwyuHkmZeucvC0SOOSLrzV18dsTFMSjYqT2yMKldfHH8e5bNpWPFkaQmiU8ec4mzUH50wS/FCsGVIxvWxCQIkprQ9o8AGZeIA9wvezRCGco7pfgCWbXi/uL84wvwtmafhWX25VMvCi9ZTXLZ7tqqr5irXo9GxcGtUJ4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766147607; c=relaxed/simple;
	bh=fIhImPED48cgoZW0+r+wQ5H2ADB6rXwPgPjQ00/LlTo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=egZpXydhx2e3XHKhgqXCKH9x+nRgfh2SKnqnhVvA3ALcnb0Ze2wX7zi74+hjGZHp05yVSGHcy3wTX813lQBiNasqvoRN+3T/pukHfFb4+CJFWfceBafNZeQLU8leMT2N95B7LEji2clYeGYBi54fNKzAveyEAXLvHLJ8q4eXvaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dXn4K0FVxzJ46BZ;
	Fri, 19 Dec 2025 20:32:49 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 9D16F40565;
	Fri, 19 Dec 2025 20:33:21 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 19 Dec
 2025 12:33:21 +0000
Date: Fri, 19 Dec 2025 12:33:19 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Linux ACPI <linux-acpi@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Bjorn
 Helgaas <helgaas@kernel.org>, Srinivas Pandruvada
	<srinivas.pandruvada@linux.intel.com>, Hans de Goede <hansg@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v1 2/8] ACPI: bus: Rework printing debug messages on
 _OSC errors
Message-ID: <20251219123319.00001e98@huawei.com>
In-Reply-To: <3036574.e9J7NaK4W3@rafael.j.wysocki>
References: <5049211.GXAFRqVoOG@rafael.j.wysocki>
	<3036574.e9J7NaK4W3@rafael.j.wysocki>
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

On Thu, 18 Dec 2025 21:35:27 +0100
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Instead of using one function, acpi_print_osc_error(), for printing a
> debug message and dumping the _OSC request data in one go, use
> acpi_handle_debug() directly for printing messages and a separate
> function called acpi_dump_osc_data() for dumping the _OSC request data
> after printing one or more of them.
> 
> This allows the message printing in the _OSC handling code to be
> organized so that the messages printed by it are easier to parse.
Hi Rafael,

Perhaps an example of the print to motivate this change clearly?
The absence of a guid on the error string line for instance may
or may not bother people. It's there in the dump but that comes
after the error print I think.

Thanks,

Jonathan


> 
> Also, use %pUL for UUID printing instead of printing UUIDs as strings
> and include the revision number into the dumped _OSC request data.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/bus.c |   35 ++++++++++++++++-------------------
>  1 file changed, 16 insertions(+), 19 deletions(-)
> 
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -180,18 +180,15 @@ void acpi_bus_detach_private_data(acpi_h
>  }
>  EXPORT_SYMBOL_GPL(acpi_bus_detach_private_data);
>  
> -static void acpi_print_osc_error(acpi_handle handle,
> -				 struct acpi_osc_context *context, char *error)
> +static void acpi_dump_osc_data(acpi_handle handle, const guid_t *guid, int rev,
> +			       struct acpi_buffer *cap)
>  {
> +	u32 *capbuf = cap->pointer;
>  	int i;
>  
> -	acpi_handle_debug(handle, "(%s): %s\n", context->uuid_str, error);
> -
> -	pr_debug("_OSC request data:");
> -	for (i = 0; i < context->cap.length; i += sizeof(u32))
> -		pr_debug(" %x", *((u32 *)(context->cap.pointer + i)));
> -
> -	pr_debug("\n");
> +	for (i = 0; i < cap->length / sizeof(u32); i++)
> +		acpi_handle_debug(handle, "(%pUL, %d): capabilities DWORD %i: [%08x]\n",
> +				  guid, rev, i, capbuf[i]);
>  }
>  
>  #define OSC_ERROR_MASK 	(OSC_REQUEST_ERROR | OSC_INVALID_UUID_ERROR | \
> @@ -239,8 +236,8 @@ acpi_status acpi_run_osc(acpi_handle han
>  	out_obj = output.pointer;
>  	if (out_obj->type != ACPI_TYPE_BUFFER
>  		|| out_obj->buffer.length != context->cap.length) {
> -		acpi_print_osc_error(handle, context,
> -			"_OSC evaluation returned wrong type");
> +		acpi_handle_debug(handle, "_OSC evaluation returned wrong type");
> +		acpi_dump_osc_data(handle, &guid, context->rev, &context->cap);
>  		status = AE_TYPE;
>  		goto out_kfree;
>  	}
> @@ -252,18 +249,18 @@ acpi_status acpi_run_osc(acpi_handle han
>  
>  	if (errors) {
>  		if (errors & OSC_REQUEST_ERROR)
> -			acpi_print_osc_error(handle, context,
> -				"_OSC request failed");
> +			acpi_handle_debug(handle, "_OSC request failed");
> +
>  		if (errors & OSC_INVALID_UUID_ERROR)
> -			acpi_print_osc_error(handle, context,
> -				"_OSC invalid UUID");
> +			acpi_handle_debug(handle, "_OSC invalid UUID");
> +
>  		if (errors & OSC_INVALID_REVISION_ERROR)
> -			acpi_print_osc_error(handle, context,
> -				"_OSC invalid revision");
> +			acpi_handle_debug(handle, "_OSC invalid revision");
> +
>  		if (errors & OSC_CAPABILITIES_MASK_ERROR)
> -			acpi_print_osc_error(handle, context,
> -				"_OSC capability bits masked");
> +			acpi_handle_debug(handle, "_OSC capability bits masked");
>  
> +		acpi_dump_osc_data(handle, &guid, context->rev, &context->cap);
>  		status = AE_ERROR;
>  		goto out_kfree;
>  	}
> 
> 
> 
> 


