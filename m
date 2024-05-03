Return-Path: <linux-pci+bounces-7056-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8CF8BB509
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 22:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 147D62830F2
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 20:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AF92C69D;
	Fri,  3 May 2024 20:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCLqlcw1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A932E22F08;
	Fri,  3 May 2024 20:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714769352; cv=none; b=rb8s5zg93vqvZ9i0dmuwxjjtUc0cxs7IuWOWTDvoBbxE4KXkCZXcqZkrE4lt+TiNvWLGotE3te55RZFflAE0+0KrJuF1Yg8n2FKJDkgHgRHJN3ViAgcMW5k4U3JTJ0EAheSBPN4s31lZojA/mwgg74tWalRvMsa2Gs1i17ySGbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714769352; c=relaxed/simple;
	bh=4z4NtWY+hIBBvVSonfOpc0dCyguz5kR/ln02LAqO7i8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=A4495SAP2MXuf48RkJmNyOjOSWMDRD3LSCPBcl2gb0fAWahcU5UuwrNI30gEur/hQSqQ7oRm+RD9m1ua/SNeO1badmI1gcoN3yyx4W7w8UBCx0/OIlrMgApERWS8QtlWB+5sl1Mj0i8GByBxF8L1r3EBINzYw1SsLGQH0zzadN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCLqlcw1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13FF2C116B1;
	Fri,  3 May 2024 20:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714769352;
	bh=4z4NtWY+hIBBvVSonfOpc0dCyguz5kR/ln02LAqO7i8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=PCLqlcw1FWL4kOhGFRycyOYpLX+ttTyqaOE25GfI0xotfk34b3K3JfcC4/dOUGJr9
	 ln80Mx4sfraJGJquu6Xl/WEeBLUSPm5O6s+ui8sBgaj1v9JnH8NhJdKwgZNp0Q+hmc
	 QiQRC/t3q8WyOkVIZnJQ6D/A+Nb5O9BWJqN+msRNInnI+/KlcgR15xIXMnJCpK6edd
	 tBx1XtZgk2TDBdu6sAiY4i00m9olO198PwOEa+88ERGStkkk/ArL1fV1jNO4OV+Wrq
	 rFqwVBI7kbPMifmoKiA6Yy/VDbOsHn5LipANxhLX0nuf/BVYpeLZlva+8j2UvlKVlw
	 Ca9rZBHfXiptw==
Date: Fri, 3 May 2024 15:49:10 -0500
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
Subject: Re: [PATCH v2 2/7] resource: Rename find_resource() to
 find_empty_resource_slot()
Message-ID: <20240503204910.GA1602543@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231228165707.3447-3-ilpo.jarvinen@linux.intel.com>

On Thu, Dec 28, 2023 at 06:57:02PM +0200, Ilpo Järvinen wrote:
> Rename find_resource() to find_empty_resource_slot() to better describe
> what the functions does. This is a preparation for exposing it beyond
> resource.c which is needed by PCI core. Also rename the __ variant to
> match the names.

I wonder if "find_resource_space()" or "find_available_resource()"
would be better than "_slot"?

"Slot" *is* already used a few times in kernel/resource.c, but in most
cases I think it refers to a "resource", and find_resource() basically
returns a filled-in struct resource.

And of course "slot" suggests something entirely different in the PCI
context.

> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  kernel/resource.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 866ef3663a0b..94f67005e1e2 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -574,10 +574,9 @@ static void resource_clip(struct resource *res, resource_size_t min,
>   * Find empty slot in the resource tree with the given range and
>   * alignment constraints
>   */
> -static int __find_resource(struct resource *root, struct resource *old,
> -			 struct resource *new,
> -			 resource_size_t  size,
> -			 struct resource_constraint *constraint)
> +static int __find_empty_resource_slot(struct resource *root, struct resource *old,
> +				      struct resource *new, resource_size_t size,
> +				      struct resource_constraint *constraint)
>  {
>  	struct resource *this = root->child;
>  	struct resource tmp = *new, avail, alloc;
> @@ -633,11 +632,11 @@ next:		if (!this || this->end == root->end)
>  /*
>   * Find empty slot in the resource tree given range and alignment.
>   */
> -static int find_resource(struct resource *root, struct resource *new,
> -			resource_size_t size,
> -			struct resource_constraint  *constraint)
> +static int find_empty_resource_slot(struct resource *root, struct resource *new,
> +				    resource_size_t size,
> +				    struct resource_constraint *constraint)
>  {
> -	return  __find_resource(root, NULL, new, size, constraint);
> +	return  __find_empty_resource_slot(root, NULL, new, size, constraint);
>  }
>  
>  /**
> @@ -660,7 +659,7 @@ static int reallocate_resource(struct resource *root, struct resource *old,
>  
>  	write_lock(&resource_lock);
>  
> -	if ((err = __find_resource(root, old, &new, newsize, constraint)))
> +	if ((err = __find_empty_resource_slot(root, old, &new, newsize, constraint)))
>  		goto out;
>  
>  	if (resource_contains(&new, old)) {
> @@ -729,7 +728,7 @@ int allocate_resource(struct resource *root, struct resource *new,
>  	}
>  
>  	write_lock(&resource_lock);
> -	err = find_resource(root, new, size, &constraint);
> +	err = find_empty_resource_slot(root, new, size, &constraint);
>  	if (err >= 0 && __request_resource(root, new))
>  		err = -EBUSY;
>  	write_unlock(&resource_lock);
> -- 
> 2.30.2
> 

