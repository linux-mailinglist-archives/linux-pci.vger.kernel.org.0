Return-Path: <linux-pci+bounces-7057-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8978BB50C
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 22:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76533282D70
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 20:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5752D05E;
	Fri,  3 May 2024 20:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pIys1pJf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D0B2C694;
	Fri,  3 May 2024 20:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714769467; cv=none; b=B0cseXvwtKzDKi/c9C5b8n+OdsduEDYUuQIPEIaxslgFx2OEzwVJmafTlGW16F+CaOJaB0TUUyRZGw8Kak7Xx2joSH2YimSGto18eVR01mX6XvE7gQ0HeRXXJVnyibUVFCyKlTCCrn8UtagGOlhsyYOdEcd6JFon9U4ALvJ6Vf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714769467; c=relaxed/simple;
	bh=gzgvy4pSOWRoA4F6feWlHdcjj1qZ8ZrQ6EZwMDRbHGc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fvVQunshnalYNXTt/e6sYRsHenk87aDiq+FedfSqWdGlUOhFRNgfmJWmpE3rq98cCr+9xF5KpUMPRQ5mSN8n6zjYrQrKs5zwCSL7EhJsLmb+3RVt8tynLrb0iCYN5BfQb9KBT4b+xFDpfQn3hnct1S0q/A21MgkHi+tpXwXoGM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pIys1pJf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDDA7C116B1;
	Fri,  3 May 2024 20:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714769467;
	bh=gzgvy4pSOWRoA4F6feWlHdcjj1qZ8ZrQ6EZwMDRbHGc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=pIys1pJfO0xqtjzWXcq/a2BLjC2j7vUDsIr7R58ZsFD3jXo5fIaGjQXw9sXngjiwo
	 D60HKGtfcJ5sj7vFBSCxf1g2fpz/zsxeIkDIh0jtD/W8UZV6Yjq3xmoAGaITZvABgb
	 WM9t3WQfk6MbJEH4mk94jQU8+LcxnagfDvsxNZh2dr7MCkEZklr1i36CTbdlerV7lE
	 zkm2INulI6Xoxtl+FfwE9j6jdUnaboQ1uIbHRLdO7VXHakpFnr4LzyjafNaUG8VJGn
	 ZM4v0uhnIjTYd0stY+0bn+AfqanbiSfsVKNCFl1FCLkLUSSJJHveFq0LmX2EL6Bduk
	 23KGsHrEYj9BA==
Date: Fri, 3 May 2024 15:51:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Igor Mammedov <imammedo@redhat.com>, Lukas Wunner <lukas@wunner.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 3/7] resource: Document find_empty_resource_slot() and
 resource_constraint
Message-ID: <20240503205105.GA1602720@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231228165707.3447-4-ilpo.jarvinen@linux.intel.com>

On Thu, Dec 28, 2023 at 06:57:03PM +0200, Ilpo Järvinen wrote:
> Document find_empty_resource_slot() and the struct resource_constraint
> as they are going to be exposed outside of resource.c.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  kernel/resource.c | 28 +++++++++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 94f67005e1e2..ed4bb8ad701a 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -46,7 +46,18 @@ struct resource iomem_resource = {
>  };
>  EXPORT_SYMBOL(iomem_resource);
>  
> -/* constraints to be met while allocating resources */
> +/**
> + * resource_constraint - constraints to be met while searching empty resource slots

Needs "struct resource_constraint", I think, to satisfy
scripts/kernel-doc.

> + * @min:		The minimum address for the memory range
> + * @max:		The maximum address for the memory range
> + * @align:		Alignment for the start address of the empty slot
> + * @alignf:		Additional alignment constraints callback
> + * @alignf_data:	Data provided for @alignf callback
> + *
> + * Contains the range and alignment constraints that have to be met during
> + * find_empty_resource_slot(). @alignf can be NULL indicating no alignment
> + * beyond @align is necessary.
> + */
>  struct resource_constraint {
>  	resource_size_t min, max, align;
>  	resource_size_t (*alignf)(void *, const struct resource *,
> @@ -629,8 +640,19 @@ next:		if (!this || this->end == root->end)
>  	return -EBUSY;
>  }

