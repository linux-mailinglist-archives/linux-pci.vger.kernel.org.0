Return-Path: <linux-pci+bounces-6386-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB298A9080
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 03:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F39F1C21989
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 01:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5286AD6;
	Thu, 18 Apr 2024 01:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G/CMBFif"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE99B1E48B;
	Thu, 18 Apr 2024 01:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713402954; cv=none; b=NGJJtJONQWhjHdumoNmGDUpMzdxj9zBCGTiLiRQWJd3jEBXVGplQLax5GdOo87TVynDkhwkTiXV2Me1TgwCkimcCM3H7B6O7d+V5SKZ28aM+H7rX+pUYmZK52rD/Cu51bUs/9XfQxkgTRrv3VJQKMc6emnLw1JoDOtnv5BkD4Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713402954; c=relaxed/simple;
	bh=uFbfo87nO14001kmIG2rJyAQXlEfsQr2jrkvTkeyE/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=boJvzUhS9Yf9pZFEiQ6QODGsRBmxONw3aVX7jfMhpylWO5/owHQd0bXPz9kV/OluERAUcgTd0YykTfMXMuGLU9+Wl2OzGPXCM1LJYKPNz9KTnNqD+LhFdL0wztsYxee1VUW01ia/FZC7Hr5w7F29YsZhSO4jQja/fLS9QlF5FM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G/CMBFif; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713402953; x=1744938953;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uFbfo87nO14001kmIG2rJyAQXlEfsQr2jrkvTkeyE/M=;
  b=G/CMBFif4soIZ9ddP8mHS3wmG2dhMSwhk3n4xuI70N9/dG7/yCmK0R32
   Ei7QEgCiogBnaqvtO8jYySEO5ntrexIt8QqL57vPLmnlu9D/oMAU6byDz
   6YnINYd4DDprK6vj/3iLgeaD6vWnDngMRuzAIFn9IJqwjQlnPrRMIPAfj
   tftP1GGY+5VEyBdz038yTyypTXWW3qXru4iRfpz2HBDw7AoAFeun5xSQQ
   1ThpOhYuoHxrD42v6r2upHfW+cvwAhfHy+rK6AjpSee9wO03iJqv1vf20
   +TFIaRLcMoQyVucdLadMGI7/1D2b1mJ5d7IK8xlkYqyV1TNntC7j64yQn
   A==;
X-CSE-ConnectionGUID: 8geL3SgbS/u7hVup4wYxFg==
X-CSE-MsgGUID: hdXBxz+vSBaItwSP08/Exg==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="8799536"
X-IronPort-AV: E=Sophos;i="6.07,210,1708416000"; 
   d="scan'208";a="8799536"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 18:15:53 -0700
X-CSE-ConnectionGUID: Qg3sfDisSnqFwL5IYU/Blw==
X-CSE-MsgGUID: ay2i8yP0QI2Tkuy5KlkNFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,210,1708416000"; 
   d="scan'208";a="27470822"
Received: from kglossop-mobl.amr.corp.intel.com (HELO [10.209.94.180]) ([10.209.94.180])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 18:15:52 -0700
Message-ID: <2aff18aa-32b7-4092-8235-aead9b708ea0@linux.intel.com>
Date: Wed, 17 Apr 2024 18:15:51 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/3] PCI: Add helper to check if any of ancestor device
 support D3cold
To: Kai-Heng Feng <kai.heng.feng@canonical.com>, bhelgaas@google.com
Cc: mahesh@linux.ibm.com, oohall@gmail.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 bagasdotme@gmail.com, regressions@lists.linux.dev,
 linux-nvme@lists.infradead.org, kch@nvidia.com, hch@lst.de,
 gloriouseggroll@gmail.com, kbusch@kernel.org, sagi@grimberg.me, hare@suse.de
References: <20240416043225.1462548-1-kai.heng.feng@canonical.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240416043225.1462548-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 4/15/24 9:32 PM, Kai-Heng Feng wrote:
> In addition to nearest upstream bridge, driver may want to know if the
> entire hierarchy can be powered off to perform different action.
>
> So walk higher up the hierarchy to find out if any device has valid
> _PR3.
>
> The user will be introduced in next patch.
>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---

Since it has been a while, I was not sure what this series is about.

IMO, it is better to include a cover letter with the summary of your
changes.


> v8:
>  - No change.
>
>  drivers/pci/pci.c   | 16 ++++++++++++++++
>  include/linux/pci.h |  2 ++
>  2 files changed, 18 insertions(+)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e5f243dd4288..7a5662f116b8 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6225,6 +6225,22 @@ bool pci_pr3_present(struct pci_dev *pdev)
>  		acpi_has_method(adev->handle, "_PR3");
>  }
>  EXPORT_SYMBOL_GPL(pci_pr3_present);
> +
> +bool pci_ancestor_pr3_present(struct pci_dev *pdev)
> +{
> +	struct pci_dev *parent = pdev;
> +
> +	if (acpi_disabled)
> +		return false;
> +
> +	while ((parent = pci_upstream_bridge(parent))) {
> +		if (pci_pr3_present(pdev))

I think it should be "parent" here?

> +			return true;
> +	}
> +
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(pci_ancestor_pr3_present);
>  #endif
>  
>  /**
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 16493426a04f..cd71ebfd0f89 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2620,10 +2620,12 @@ struct irq_domain *pci_host_bridge_acpi_msi_domain(struct pci_bus *bus);
>  void
>  pci_msi_register_fwnode_provider(struct fwnode_handle *(*fn)(struct device *));
>  bool pci_pr3_present(struct pci_dev *pdev);
> +bool pci_ancestor_pr3_present(struct pci_dev *pdev);
>  #else
>  static inline struct irq_domain *
>  pci_host_bridge_acpi_msi_domain(struct pci_bus *bus) { return NULL; }
>  static inline bool pci_pr3_present(struct pci_dev *pdev) { return false; }
> +static inline bool pci_ancestor_pr3_present(struct pci_dev *pdev) { return false; }
>  #endif
>  
>  #ifdef CONFIG_EEH

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


