Return-Path: <linux-pci+bounces-34465-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9EFB2FE1F
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 17:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 980731768C2
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 15:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8233B2D3A69;
	Thu, 21 Aug 2025 15:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqDn4Q3J"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5328313DBA0;
	Thu, 21 Aug 2025 15:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755789286; cv=none; b=fnVZj6u/E4XT9gJJJnhBuMVE37OXBNMlNSWEAv7Lx8tMDa4iqXEcz5n5spsCJ6Br2w9B1G1xKwNWdQ48qqYrYd6zZ5aRzmvR4BNm5pyprWDigNzhWzyllEwX1GqcHoJrRGqptxPOS4DtoEOxAIiJNrQJqdB0X/DsiEc9La6krMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755789286; c=relaxed/simple;
	bh=jq+P7k8cfTxOl/qVSRztvlA0YyPp8635tgozhST0YyA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sk3hLKQlKoKhBzUThBU7+Sm/Ynbap3aCRuJbO/B2OMBhdv2rjHV7KfTWVh0HHlmAq1Kw9mMNey7ysXifPc5G9ChQ0SaZr3qMRXdnsa4hqIYknG/IiosTe48OXuXcKpEXEy8awa2lJeNOWEgOZNO+o5OT7eyXLUskp9fcY+80t6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MqDn4Q3J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E4F0C4CEEB;
	Thu, 21 Aug 2025 15:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755789285;
	bh=jq+P7k8cfTxOl/qVSRztvlA0YyPp8635tgozhST0YyA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=MqDn4Q3JKTqB9i2DxzAIBgcQJy5dKCJe+bcRsAIzSTMl8Uh54luweud6phUy94RK2
	 38yX+cYHrWsNpnD8Tio6uJErHAx1Y2LArdIw/a7pr/TZYXl22HuPoGB5IsJXawr5zn
	 pFQIunhN1vz58R5edatwuBWVg+fkmFGO2rDg1gN2qeFJDcMw8FCluh5xB7kQi+qXfa
	 5J94MgfFSSEgS/nGUe2NbYs5zVhmdwt642SeSeLVpMTiGMU0a+JK4jn05yyyj166XZ
	 MZ+efTVFtNownE+V6SzdYCVvRviU7oXVpha79et2KJf7eEUURwPQvon81PC0cLVOqy
	 1wx7w6E+06lIQ==
Date: Thu, 21 Aug 2025 10:14:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>, Rio <rio@r26.me>,
	D Scott Phillips <scott@os.amperecomputing.com>,
	linux-kernel@vger.kernel.org,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 3/3] PCI: Fix failure detection during resource resize
Message-ID: <20250821151444.GA674725@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250630142641.3516-4-ilpo.jarvinen@linux.intel.com>

On Mon, Jun 30, 2025 at 05:26:41PM +0300, Ilpo Järvinen wrote:
> Since the commit 96336ec70264 ("PCI: Perform reset_resource() and build
> fail list in sync") the failed list is always built and returned to let
> the caller decide what to do with the failures. The caller may want to
> retry resource fitting and assignment and before that can happen, the
> resources should be restored to their original state (a reset
> effectively clears the struct resource), which requires returning them
> on the failed list so that the original state remains stored in the
> associated struct pci_dev_resource.
> 
> Resource resizing is different from the ordinary resource fitting and
> assignment in that it only considers part of the resources. This means
> failures for other resource types are not relevant at all and should be
> ignored. As resize doesn't unassign such unrelated resources, those
> resource ending up into the failed list implies assignment of that
> resource must have failed before resize too. The check in
> pci_reassign_bridge_resources() to decide if the whole assignment is
> successful, however, is based on list emptiness which will cause false
> negatives when the failed list has resources with an unrelated type.
> 
> If the failed list is not empty, call pci_required_resource_failed()
> and extend it to be able to filter on specific resource types too (if
> provided).
> 
> Calling pci_required_resource_failed() at this point is slightly
> problematic because the resource itself is reset when the failed list
> is constructed in __assign_resources_sorted(). As a result,
> pci_resource_is_optional() does not have access to the original
> resource flags. This could be worked around by restoring and
> re-reseting the resource around the call to pci_resource_is_optional(),
> however, it shouldn't cause issue as resource resizing is meant for
> 64-bit prefetchable resources according to Christian König (see the
> Link which unfortunately doesn't point directly to Christian's reply
> because lore didn't store that email at all).
> 
> Fixes: 96336ec70264 ("PCI: Perform reset_resource() and build fail list in sync")
> Link: https://lore.kernel.org/all/c5d1b5d8-8669-5572-75a7-0b480f581ac1@linux.intel.com/
> Reported-by: D Scott Phillips <scott@os.amperecomputing.com>

Any URL we can include here?

> Tested-by: D Scott Phillips <scott@os.amperecomputing.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: D Scott Phillips <scott@os.amperecomputing.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: <stable@vger.kernel.org>
> ---
>  drivers/pci/setup-bus.c | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 24863d8d0053..dbbd80d78d3d 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -28,6 +28,10 @@
>  #include <linux/acpi.h>
>  #include "pci.h"
>  
> +#define PCI_RES_TYPE_MASK \
> +	(IORESOURCE_IO | IORESOURCE_MEM | IORESOURCE_PREFETCH |\
> +	 IORESOURCE_MEM_64)
> +
>  unsigned int pci_flags;
>  EXPORT_SYMBOL_GPL(pci_flags);
>  
> @@ -384,13 +388,19 @@ static bool pci_need_to_release(unsigned long mask, struct resource *res)
>  }
>  
>  /* Return: @true if assignment of a required resource failed. */
> -static bool pci_required_resource_failed(struct list_head *fail_head)
> +static bool pci_required_resource_failed(struct list_head *fail_head,
> +					 unsigned long type)
>  {
>  	struct pci_dev_resource *fail_res;
>  
> +	type &= PCI_RES_TYPE_MASK;
> +
>  	list_for_each_entry(fail_res, fail_head, list) {
>  		int idx = pci_resource_num(fail_res->dev, fail_res->res);
>  
> +		if (type && (fail_res->flags & PCI_RES_TYPE_MASK) != type)
> +			continue;
> +
>  		if (!pci_resource_is_optional(fail_res->dev, idx))
>  			return true;
>  	}
> @@ -504,7 +514,7 @@ static void __assign_resources_sorted(struct list_head *head,
>  	}
>  
>  	/* Without realloc_head and only optional fails, nothing more to do. */
> -	if (!pci_required_resource_failed(&local_fail_head) &&
> +	if (!pci_required_resource_failed(&local_fail_head, 0) &&
>  	    list_empty(realloc_head)) {
>  		list_for_each_entry(save_res, &save_head, list) {
>  			struct resource *res = save_res->res;
> @@ -1708,10 +1718,6 @@ static void __pci_bridge_assign_resources(const struct pci_dev *bridge,
>  	}
>  }
>  
> -#define PCI_RES_TYPE_MASK \
> -	(IORESOURCE_IO | IORESOURCE_MEM | IORESOURCE_PREFETCH |\
> -	 IORESOURCE_MEM_64)
> -
>  static void pci_bridge_release_resources(struct pci_bus *bus,
>  					 unsigned long type)
>  {
> @@ -2449,8 +2455,12 @@ int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
>  		free_list(&added);
>  
>  	if (!list_empty(&failed)) {
> -		ret = -ENOSPC;
> -		goto cleanup;
> +		if (pci_required_resource_failed(&failed, type)) {
> +			ret = -ENOSPC;
> +			goto cleanup;
> +		}
> +		/* Only resources with unrelated types failed (again) */
> +		free_list(&failed);
>  	}
>  
>  	list_for_each_entry(dev_res, &saved, list) {
> -- 
> 2.39.5
> 

