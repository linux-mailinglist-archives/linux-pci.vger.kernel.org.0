Return-Path: <linux-pci+bounces-43393-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD90CCFE67
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 13:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A05DA30F82DD
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 12:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEE82C11C5;
	Fri, 19 Dec 2025 12:46:46 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436692594BD;
	Fri, 19 Dec 2025 12:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766148406; cv=none; b=OBa2LYM+YYBZ2aVnAnlTKASo77C3kcKO7iRnoWK/pKZfocKZY5lHjx5/vLQ2LCrfxGhc0Sq0NJI9rLuJRnZw4OBQ5ObXOxY56U2FfH5/weiYe1Xp+dpwJwfcXkyQJlGdt+WsoUz0/oZT80yMxNY1e9hae+aLSH2sHr5JWeEzx2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766148406; c=relaxed/simple;
	bh=GtaDUBUpnj/o2cI+Wm0YSflL9XMNbQmOMUmt72Nwn7U=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EAgqjuWrEP8wjdnGZBijV1u8af+lJhruYbTLhUXT+Vj2LbDQ5Ijwj9OSm6Q97N9yr4L880bU/haQQDWy5zgJlF8Ot5NL+kHgNReYLdxXXkTTP+FFrs52yGhIUnPiCl1Udvdjx0G+Ioi9OXkzHgYaHi7px0JeaIplT6IB6mTgYeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dXnMm1q4tzHnGfH;
	Fri, 19 Dec 2025 20:46:12 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 607454056C;
	Fri, 19 Dec 2025 20:46:41 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 19 Dec
 2025 12:46:40 +0000
Date: Fri, 19 Dec 2025 12:46:39 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Linux ACPI <linux-acpi@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Bjorn
 Helgaas <helgaas@kernel.org>, Srinivas Pandruvada
	<srinivas.pandruvada@linux.intel.com>, Hans de Goede <hansg@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v1 4/8] ACPI: bus: Split _OSC error processing out of
 acpi_run_osc()
Message-ID: <20251219124639.000031c5@huawei.com>
In-Reply-To: <10786459.nUPlyArG6x@rafael.j.wysocki>
References: <5049211.GXAFRqVoOG@rafael.j.wysocki>
	<10786459.nUPlyArG6x@rafael.j.wysocki>
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

On Thu, 18 Dec 2025 21:36:57 +0100
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Split a function for processing _OSL errors called acpi_osc_error_check()
_OSC?
> out of acpi_run_osc() to facilitate subsequent changes.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Minor request inline. 
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> ---
>  drivers/acpi/bus.c |   56 ++++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 36 insertions(+), 20 deletions(-)
> 
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -236,13 +236,46 @@ static int acpi_eval_osc(acpi_handle han
>  	return 0;
>  }
>  
> +static bool acpi_osc_error_check(acpi_handle handle, guid_t *guid, int rev,
> +				 struct acpi_buffer *cap, u32 *retbuf)
> +{
> +	/* Bit 0 in the query DWORD of the return buffer is reserved. */
> +	u32 errors = retbuf[OSC_QUERY_DWORD] & OSC_ERROR_MASK;
> +	u32 *capbuf = cap->pointer;
> +
> +	/*
> +	 * If OSC_QUERY_ENABLE is set in the capabilities buffer, ignore bit 4.

Maybe add a tiny bit on why?

> +	 */
> +	if (capbuf[OSC_QUERY_DWORD] & OSC_QUERY_ENABLE)
> +		errors &= ~OSC_CAPABILITIES_MASK_ERROR;
> +
> +	if (!errors)
> +		return false;
> +
> +	if (errors & OSC_REQUEST_ERROR)
> +		acpi_handle_debug(handle, "_OSC: request failed\n");
> +
> +	if (errors & OSC_INVALID_UUID_ERROR)
> +		acpi_handle_debug(handle, "_OSC: invalid UUID\n");
> +
> +	if (errors & OSC_INVALID_REVISION_ERROR)
> +		acpi_handle_debug(handle, "_OSC: invalid revision\n");
> +
> +	if (errors & OSC_CAPABILITIES_MASK_ERROR)
> +		acpi_handle_debug(handle, "_OSC: capability bits masked\n");
> +
> +	acpi_dump_osc_data(handle, guid, rev, cap);
> +
> +	return true;
> +}

> 
> 


