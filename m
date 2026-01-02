Return-Path: <linux-pci+bounces-43930-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF64CEE6D8
	for <lists+linux-pci@lfdr.de>; Fri, 02 Jan 2026 12:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DADB53018199
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jan 2026 11:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1136130E822;
	Fri,  2 Jan 2026 11:53:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D41D2B9B9;
	Fri,  2 Jan 2026 11:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767354780; cv=none; b=mdRYWp2YhLJVJGqP92697hD6+5+Ic4awBcZDbJGZBTdZaWqpyJN+Iwmyk73WiNw8zR215sRFKAt7fWQLDD9Kn+xHHldj6frJvbonHBKzegkwUdbS3XPOWAXD8vsIf+RH5hjaI3beAWrztCp/V6YJTHtTP6wiVe5Efuc0PhQQMRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767354780; c=relaxed/simple;
	bh=sspdCbED63g83BojotuKWdg2+B/XPystf+q7O6UjsVM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ObtEPmMjmTXc5gshOoWUVkjUCKZgBsd3awsWH4eD/At8B8K/wMvhjIu4StlJ1dvlrualMnaGDhAnAWgu06UFrscv+JMlt79Vv5p+Oz0e5fHREgqQfCLaHdlgBoNgrjZoOpg3zU5dbx8T/di6PlOJGvpxIlZ4SAPuQ2jgvPvXOdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4djMVh5sNxzHnGgk;
	Fri,  2 Jan 2026 19:51:56 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 6743340539;
	Fri,  2 Jan 2026 19:52:53 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 2 Jan
 2026 11:52:52 +0000
Date: Fri, 2 Jan 2026 11:52:50 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Linux ACPI <linux-acpi@vger.kernel.org>, Dan Carpenter
	<dan.carpenter@linaro.org>, LKML <linux-kernel@vger.kernel.org>, Linux PCI
	<linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, "Srinivas
 Pandruvada" <srinivas.pandruvada@linux.intel.com>, Hans de Goede
	<hansg@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v1] ACPI: bus: Adjust acpi_osc_handshake() parameter
 list
Message-ID: <20260102115250.0000045c@huawei.com>
In-Reply-To: <12833187.O9o76ZdvQC@rafael.j.wysocki>
References: <12833187.O9o76ZdvQC@rafael.j.wysocki>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 26 Dec 2025 14:48:45 +0100
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> For the sake of interface cleanliness, it is better to avoid using
> ACPICA data types in the parameter lists of helper functions that
> don't belong to ACPICA, so adjust the parameter list of recently
> introduced acpi_osc_handshake() to take a capabilities buffer pointer
> and the size of the buffer (in u32 size units) as parameters directly
> instead of a struct acpi_buffer pointer.
> 
> This is also somewhat more straightforward on the caller side because
> they won't need to create struct acpi_buffer objects themselves to pass
> them to the helper function and it guarantees that the size of the
> buffer in bytes will always be a multiple of 4 (the size of u32).
> 
> Moreover, it addresses a premature cap pointer dereference and
> eliminates a sizeof(32) that should have been sizeof(u32) [1].
> 
> Fixes: e5322888e6bf ("ACPI: bus: Rework the handling of \_SB._OSC platform features")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/linux-acpi/202512242052.W4GhDauV-lkp@intel.com/
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
A couple of minor comments inline.  I see you have it queued up already, but
FWIW nothing here major enough to warrant reverting that.
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  drivers/acpi/bus.c |   30 ++++++++++++------------------
>  1 file changed, 12 insertions(+), 18 deletions(-)
> 
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -326,31 +326,33 @@ out:
>  EXPORT_SYMBOL(acpi_run_osc);
>  
>  static int acpi_osc_handshake(acpi_handle handle, const char *uuid_str,
> -			      int rev, struct acpi_buffer *cap)
> +			      int rev, u32 *capbuf, size_t bufsize)

Size parameters in number of u32s is to me a little confusing but
I guess this is only used locally so that's probably fine.
I'd have been tempted to call it dwords or something like that.


>  {
>  	union acpi_object in_params[4], *out_obj;
> -	size_t bufsize = cap->length / sizeof(u32);
>  	struct acpi_object_list input;
> +	struct acpi_buffer cap = {
> +		.pointer = capbuf,
> +		.length = bufsize * sizeof(32),

You fixed this up already but just for completeness.
sizeof(u32)

> +	};
>  	struct acpi_buffer output;
> -	u32 *capbuf, *retbuf, test;
> +	u32 *retbuf, test;
>  	guid_t guid;
>  	int ret, i;
>  
> -	if (!cap || cap->length < 2 * sizeof(32) || guid_parse(uuid_str, &guid))
> +	if (!capbuf || bufsize < 2 || guid_parse(uuid_str, &guid))
>  		return -EINVAL;
>  
>  	/* First evaluate _OSC with OSC_QUERY_ENABLE set. */
> -	capbuf = cap->pointer;
>  	capbuf[OSC_QUERY_DWORD] = OSC_QUERY_ENABLE;
>  
> -	ret = acpi_eval_osc(handle, &guid, rev, cap, in_params, &output);
> +	ret = acpi_eval_osc(handle, &guid, rev, &cap, in_params, &output);
>  	if (ret)
>  		return ret;
>  
>  	out_obj = output.pointer;
>  	retbuf = (u32 *)out_obj->buffer.pointer;
>  
> -	if (acpi_osc_error_check(handle, &guid, rev, cap, retbuf)) {
> +	if (acpi_osc_error_check(handle, &guid, rev, &cap, retbuf)) {
>  		ret = -ENODATA;
>  		goto out;
>  	}
> @@ -403,7 +405,7 @@ static int acpi_osc_handshake(acpi_handl
>  		 */
>  		acpi_handle_err(handle, "_OSC: errors while processing control request\n");
>  		acpi_handle_err(handle, "_OSC: some features may be missing\n");
> -		acpi_osc_error_check(handle, &guid, rev, cap, retbuf);
> +		acpi_osc_error_check(handle, &guid, rev, &cap, retbuf);
>  	}
>  
>  out:
> @@ -446,10 +448,6 @@ static void acpi_bus_osc_negotiate_platf
>  {
>  	static const u8 sb_uuid_str[] = "0811B06E-4A27-44F9-8D60-3CBBC22E7B48";
>  	u32 capbuf[2], feature_mask;
> -	struct acpi_buffer cap = {
> -		.pointer = capbuf,
> -		.length = sizeof(capbuf),
> -	};
>  	acpi_handle handle;
>  
>  	feature_mask = OSC_SB_PR3_SUPPORT | OSC_SB_HOTPLUG_OST_SUPPORT |
> @@ -497,7 +495,7 @@ static void acpi_bus_osc_negotiate_platf
>  
>  	acpi_handle_info(handle, "platform _OSC: OS support mask [%08x]\n", feature_mask);
>  
> -	if (acpi_osc_handshake(handle, sb_uuid_str, 1, &cap))
> +	if (acpi_osc_handshake(handle, sb_uuid_str, 1, capbuf, 2))

As below. Maybe ARRAY_SIZE(capbuf) instead of that 2.

>  		return;
>  
>  	feature_mask = capbuf[OSC_SUPPORT_DWORD];
> @@ -532,10 +530,6 @@ static void acpi_bus_osc_negotiate_usb_c
>  {
>  	static const u8 sb_usb_uuid_str[] = "23A0D13A-26AB-486C-9C5F-0FFA525A575A";
>  	u32 capbuf[3], control;
> -	struct acpi_buffer cap = {
> -		.pointer = capbuf,
> -		.length = sizeof(capbuf),
> -	};
>  	acpi_handle handle;
>  
>  	if (!osc_sb_native_usb4_support_confirmed)
> @@ -550,7 +544,7 @@ static void acpi_bus_osc_negotiate_usb_c
>  	capbuf[OSC_SUPPORT_DWORD] = 0;
>  	capbuf[OSC_CONTROL_DWORD] = control;
>  
> -	if (acpi_osc_handshake(handle, sb_usb_uuid_str, 1, &cap))
> +	if (acpi_osc_handshake(handle, sb_usb_uuid_str, 1, capbuf, 3))

Maybe ARRAY_SIZE(capbuf) just to avoid any chance they get out of sync?

>  		return;
>  
>  	osc_sb_native_usb4_control = capbuf[OSC_CONTROL_DWORD];
> 
> 
> 
> 


