Return-Path: <linux-pci+bounces-26747-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C02AA9C662
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 12:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 710241BA5197
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 10:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBC423D284;
	Fri, 25 Apr 2025 10:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k685Zw1u"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C4522F3BE;
	Fri, 25 Apr 2025 10:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745578689; cv=none; b=CrDa6PYCh2qzZMdDCaI7Aey5JXdI/402aixyI5Vh4zX6SWFr1SYcGElgoAIQfI6Ooar6IO3rZDSNu2MdM/cyFjhG1gQReBs6jwTZgLyCArQvnQfXIBzB4/ViaiULWURyC4Zmd48wJ3W8DehmgX1KJdOEthPQPDxA/gDutEPCkXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745578689; c=relaxed/simple;
	bh=4Wn7tH9mtEyjm/uMupHTDegpcB+IXg7Sq+ep6rcVgSY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jpTwB+z1QITGDHGCFfMYdlqA0VICWIJhrmVyDbXLLByfShQBuizasKUsw8Om/pp1zCY2A/VrqtgaI2nGCg9oMVLQaPrSQGsanNNONVMPyCTr+RPRJW7EAfF7QmtFVG6n2VgDsHoA0PnNfP3pCG+zK7Q9ftaCnOml9lLOnBpXhY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k685Zw1u; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745578688; x=1777114688;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=4Wn7tH9mtEyjm/uMupHTDegpcB+IXg7Sq+ep6rcVgSY=;
  b=k685Zw1uqN7TvSxVWP0lnvqZ0oLq7yJnIgxDgyanHAPsH6N9upRyqlcM
   P/YlgBsMCB3AhAkFVjt93jWeZNcX58BXLOdjxRtrNVCneyR7r3aDQOUmy
   WWiqSEuNHSIlUt6ViNIvPeNw+VwB/fPnEzVhQejIu/n5oRLWeVGlwszi3
   tZBN6faWGbkFQl1WuAKhKQ0tPS7LoOJ2jjTIKSPLIKxC7ZZULBRkze+4J
   8DzzENK9hno1NzeO8kWfEC8MjftOBBMVolK8zQWGmQNWcXl6jVlyRq/Sk
   lQC5AmFl6ih44Yvc+vYp5jrmzbyNqjeggwb+2awqQDqK8zMnS7y4wlBQC
   w==;
X-CSE-ConnectionGUID: gfawOh2XS1eueu1zi2hiyw==
X-CSE-MsgGUID: C75WOvpYRZuhugzbq4DQ1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="57879073"
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="57879073"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 03:58:07 -0700
X-CSE-ConnectionGUID: oo8HXNhmTfCk2oNGOF8L6Q==
X-CSE-MsgGUID: CpDbRpwAR9WvQna2kn5dmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="133381856"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.154])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 03:58:00 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 25 Apr 2025 13:57:56 +0300 (EEST)
To: "David E. Box" <david.e.box@linux.intel.com>
cc: corbet@lwn.net, bhelgaas@google.com, kuurtb@gmail.com, 
    Hans de Goede <hdegoede@redhat.com>, vkoul@kernel.org, 
    yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev, 
    sanyog.r.kale@intel.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    "Rafael J. Wysocki" <rafael@kernel.org>, dakr@kernel.org, 
    dan.j.williams@intel.com, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-pci@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
    Dell.Client.Kernel@dell.com, linux-sound@vger.kernel.org
Subject: Re: [PATCH 4/7] pci: doe: Replace sysfs visibility macro
In-Reply-To: <20250423175040.784680-5-david.e.box@linux.intel.com>
Message-ID: <8d261613-60d3-8825-e073-1b39daadc29a@linux.intel.com>
References: <20250423175040.784680-1-david.e.box@linux.intel.com> <20250423175040.784680-5-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 23 Apr 2025, David E. Box wrote:

> Replace deprecated DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE() call with the new
> DEFINE_SYSFS_GROUP_VISIBILITY() helper for the pci_doe_features_sysfs group
> in drivers/pci/doe.c.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  drivers/pci/doe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> index aae9a8a00406..18b355506dc1 100644
> --- a/drivers/pci/doe.c
> +++ b/drivers/pci/doe.c
> @@ -119,7 +119,7 @@ static bool pci_doe_features_sysfs_group_visible(struct kobject *kobj)
>  
>  	return !xa_empty(&pdev->doe_mbs);
>  }
> -DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(pci_doe_features_sysfs)
> +DEFINE_SYSFS_GROUP_VISIBILITY(pci_doe_features_sysfs)

Hi David,

Is it intentional to not have semicolon at the end?

>  const struct attribute_group pci_doe_sysfs_group = {
>  	.name	    = "doe_features",
> 

-- 
 i.


