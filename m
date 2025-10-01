Return-Path: <linux-pci+bounces-37340-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BEFBB0219
	for <lists+linux-pci@lfdr.de>; Wed, 01 Oct 2025 13:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 448043BC65E
	for <lists+linux-pci@lfdr.de>; Wed,  1 Oct 2025 11:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364DE2C237E;
	Wed,  1 Oct 2025 11:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fWnCDozV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D59A23313E
	for <linux-pci@vger.kernel.org>; Wed,  1 Oct 2025 11:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759317962; cv=none; b=oRpGYg6oWv4Ep89oUF1LGRtn5xV0+nXlupIA1vjPDyqz1M58unDPPT8DTVVWITTpaWBNWO1cFFclMiXe+J3CEQHH0KSHzF8iK3dLSHKI4k6iq9Cndpwc/GqaJU5Xaq9cLERMxTYtvjpUJ7xQdwg/85CCVJsY7Crg/kYi5NyrZuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759317962; c=relaxed/simple;
	bh=S2kQEIML+DO4sJ2loKB9JbXprvtudInijh+66ThGFxk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=X1tL/WX+mDiVJnYRbJta1p8wuMVB96RGsJLIAEhUIqxHkXfy2As4/9RwafRUpwh39ByyiC0BD/lGVbnW/seWyhSphn1zNq72i+39W44e4oYh3tStqM6DZlJ/KtirySDWOuI63x5GhWoWwhrf36eHotVZSyDeJDcZt8ffCfAdHC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fWnCDozV; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759317961; x=1790853961;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=S2kQEIML+DO4sJ2loKB9JbXprvtudInijh+66ThGFxk=;
  b=fWnCDozVcTVO21pdfXEc2+O+tQ3RFfdmfArXTo32ySUPYsjTjtLHvjRC
   O0B1NFaGMpN5g6CTElKXypOaKa7cVna5EJmJjBrxPBmNpKn8CU7RWrOp3
   w0/77wlX1ucw4QMhvDuSZ7qYnOjbnitxb4HEe7jcQYi3s/oeOHUbqwhIr
   /ZoSlZQ+5j6TNzZbADWnHfo6LHoBx0N2t0Bh7lxI9ZN2QPp90wMKQEFKM
   2vuHqoqgEZI7gIx139N7Mj0GyY9VhoLTC7H6HJkXVaR0+kE+xE9M0PyMn
   lKpCy3HC+7vTO/wYrZeounjYzxgAeD449ozUyC9zXI5VRKEwm2Ybggqpd
   g==;
X-CSE-ConnectionGUID: bDMFEHzYROW8Ys5YdaloNQ==
X-CSE-MsgGUID: D86e5gQlRACj+x9CGmKG/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61297771"
X-IronPort-AV: E=Sophos;i="6.18,306,1751266800"; 
   d="scan'208";a="61297771"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 04:26:00 -0700
X-CSE-ConnectionGUID: vjLKRAnWTL+d/gdxhGR7hA==
X-CSE-MsgGUID: OKJkYm1/QL+JOK3Y76R0Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,306,1751266800"; 
   d="scan'208";a="183052786"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.85])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 04:25:58 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 1 Oct 2025 14:25:54 +0300 (EEST)
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
cc: bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Add lock  and reference count in
 pci_get_domain_bus_and_slot()
In-Reply-To: <20251001043705.263609-1-kaushlendra.kumar@intel.com>
Message-ID: <f78ffb8a-0709-6096-87f7-b74bf32aae6a@linux.intel.com>
References: <20251001043705.263609-1-kaushlendra.kumar@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 1 Oct 2025, Kaushlendra Kumar wrote:

> Add proper locking and reference counting to pci_get_domain_bus_and_slot

Add () to any function names.

> during PCI device enumeration. The function now holds pci_bus_sem during
> device iteration and properly increments the device reference count
> before returning.

These two sentences duplicate each other. Could you state things just once 
with the more precise explanation that is in the 2nd sentence.

Also, I'd prefer to see the problem described in a paragraph preceeding 
this solution paragraph/sentence.

Fixes tag?

> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> ---
>  drivers/pci/search.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/search.c b/drivers/pci/search.c
> index 53840634fbfc..dc49d3db69a4 100644
> --- a/drivers/pci/search.c
> +++ b/drivers/pci/search.c
> @@ -230,12 +230,17 @@ struct pci_dev *pci_get_domain_bus_and_slot(int domain, unsigned int bus,
>  {
>  	struct pci_dev *dev = NULL;
>  
> +	down_read(&pci_bus_sem);

How about using

guard(rwsem_read)(&pci_bus_sem);

?

I think that would look a lot cleaner overall.

>  	for_each_pci_dev(dev) {
>  		if (pci_domain_nr(dev->bus) == domain &&
>  		    (dev->bus->number == bus && dev->devfn == devfn))
> -			return dev;
> +			goto out;
>  	}
> -	return NULL;
> +	dev = NULL;
> + out:
> +	pci_dev_get(dev);

So now you're incrementing the reference count but there's no code in this 
patch to counterdecrement it? Are all callers already decrementing it 
(which leads to underflows w/o this patch)? This needs to be explained in 
the changelog text.

> +	up_read(&pci_bus_sem);
> +	return dev;
>  }
>  EXPORT_SYMBOL(pci_get_domain_bus_and_slot);

-- 
 i.


