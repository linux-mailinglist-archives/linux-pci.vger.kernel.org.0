Return-Path: <linux-pci+bounces-26122-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43501A922DE
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 18:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 083D2464B0F
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 16:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4D32550B6;
	Thu, 17 Apr 2025 16:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvZnOc/I"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A3D3C0C;
	Thu, 17 Apr 2025 16:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744907946; cv=none; b=koBZ/m+3gm7ctV7kY2hWT4oEDY4JpQwUlBgEGOi0eA0WHyYUCfAFIyPYFcRhhpVmgzTn11wOHCWGwsys1Ribp+KYfZLIENQ2rWi25fTjO0DNUfXTaNrQHULGTM9M5sdigajD68+ajhdxjB8I6qvKYyLWBzmhk+mvMrl0uPcw51A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744907946; c=relaxed/simple;
	bh=3bVynOwOhRnPTp6Qdaz4+H3O1NgzpHkzWFZ3znhf9uo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VVRvya14RPu9Ky6+EjenE63McBk5s6uIavWrCLaHkNi1HHTbd1AIbXuTNuLf+0jNn7I7EvogL1oAw5pwxmLUO5s+mHQJVzZVcbbNF3PWdUWF/gzpnlfArN4EypidgXPliIDkkPbrnjN3YxIA7BuKgDCMkc6pryNKybYs+2GeABI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SvZnOc/I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88995C4CEE4;
	Thu, 17 Apr 2025 16:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744907945;
	bh=3bVynOwOhRnPTp6Qdaz4+H3O1NgzpHkzWFZ3znhf9uo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=SvZnOc/I85gqJZkwDZjnKynKc9xfXK2fv/cyICHQQbwvMBE0KFtY6wuKGmzL9mPwG
	 Xtz400JLslF3YFx3+bs5sZQc1SKCHJVJBw3CzP0bJh55VYeyzK4+87+Nvqe2e0llg/
	 4N9LTR8XSWegH/g65+lWJ6yKxy7h621LGdjpvpsXvmwtnJLUIy4RRJkEjm8HuJiK9d
	 pRW8ZuMarCZvE8P9Fcwypgco114DDX7HooRZzkplniyzF5hZM5AglsFLfBc+UNn03T
	 JBrx8m8PHmiPm18GhmJ4bodD6XpW4r9r88xsb1SFChG1/dcsHYvuYSPWLJVMrhs391
	 CycdmYU0iEq/A==
Date: Thu, 17 Apr 2025 11:39:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Igor Mammedov <imammedo@redhat.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>
Subject: Re: [PATCH 1/1] PCI: Restore assigned resources fully after release
Message-ID: <20250417163904.GA114476@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250403093137.1481-1-ilpo.jarvinen@linux.intel.com>

On Thu, Apr 03, 2025 at 12:31:37PM +0300, Ilpo Järvinen wrote:
> PCI resource fitting code in __assign_resources_sorted() runs in
> multiple steps. A resource that was successfully assigned may have to
> be released before the next step attempts assignment again. The
> assign+release cycle is destructive to a start-aligned struct resource
> (bridge window or IOV resource) because the start field is overwritten
> with the real address when the resource got assigned.
> 
> Properly restore the resource after releasing it. The start, end, and
> flags fields must be stored into the related struct pci_dev_resource in
> order to be able to restore the resource to its original state.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Fixes: 96336ec70264 ("PCI: Perform reset_resource() and build fail list in sync")
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Applied to pci/for-linus for v6.15, thanks!

I'd like to add the following to the commit log if it's accurate:

  + One symptom:

  +   pci 0002:00:00.0: bridge window [mem size 0x00100000]: can't assign; bogus alignment

    Reported-by: Guenter Roeck <linux@roeck-us.net>
  + Closes: https://lore.kernel.org/r/01eb7d40-f5b5-4ec5-b390-a5c042c30aff@roeck-us.net/
  + Reported-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
  + Closes: https://lore.kernel.org/r/3578030.5fSG56mABF@workhorse

Let me know if that's wrong or there are additional reports.

> ---
>  drivers/pci/setup-bus.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 54d6f4fa3ce1..e994c546422c 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -187,6 +187,9 @@ static void pdev_sort_resources(struct pci_dev *dev, struct list_head *head)
>  			panic("%s: kzalloc() failed!\n", __func__);
>  		tmp->res = r;
>  		tmp->dev = dev;
> +		tmp->start = r->start;
> +		tmp->end = r->end;
> +		tmp->flags = r->flags;
>  
>  		/* Fallback is smallest one or list is empty */
>  		n = head;
> @@ -545,6 +548,7 @@ static void __assign_resources_sorted(struct list_head *head,
>  		pci_dbg(dev, "%s %pR: releasing\n", res_name, res);
>  
>  		release_resource(res);
> +		restore_dev_resource(dev_res);
>  	}
>  	/* Restore start/end/flags from saved list */
>  	list_for_each_entry(save_res, &save_head, list)
> 
> base-commit: 7d06015d936c861160803e020f68f413b5c3cd9d
> -- 
> 2.39.5
> 

