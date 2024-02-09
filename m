Return-Path: <linux-pci+bounces-3299-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 891BD84FD34
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 20:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AFAF287114
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 19:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F5C84A45;
	Fri,  9 Feb 2024 19:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HrmrLIo4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3770280BFA;
	Fri,  9 Feb 2024 19:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707508396; cv=none; b=iDi0mFOQyEMcnfeWtycta45xYRTl9PRHWq/+Q+yAqhuJ9sj7zcGULywCbHEp9O/J+NU6bK/v/Z5GUnC2HQc7FU6EHfiytQYIzsOhpf6bXAbsyenUhzBlwwhV3m2Pz2iLbTQGLOcC7LKj+c+aaiIrclG8QURHvsaqdpPuBoz3V+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707508396; c=relaxed/simple;
	bh=R78s8t6vdwvLdXjmTPvMxGR2jaSEL8AbB+GGaJc7J7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b7Ugi4SBcfbBB07/zU2Wv5G+QhcVtEKcnHtbXtUB9/C8EzvBFhVVkExkz653MGiTJNtgzSgFy9ELv17rDGlfaeTA8tdDWaZvMhcrlyvER0z4iEjgAIb2nPWsRdu8wXVPcPA6Gno/ICUCFkxS0CXEO4uLcmon15aMQ9Paki9zYpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HrmrLIo4; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707508394; x=1739044394;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=R78s8t6vdwvLdXjmTPvMxGR2jaSEL8AbB+GGaJc7J7M=;
  b=HrmrLIo4B/a2Og62rbci4gXRBuECIVCOrIahZyKK0SmnRM9X8BYGsjOp
   mpwZKuwninCJRHL+sUspdBjwumrvmyfP6catK44GWCDTXdDNZu9Bg9ydc
   nPVzzXzyFZEpzWry2skS17fkKsmU661HF7Zn+EGFH0tiMi2YZpMkTBCqY
   ovBBxlFmjScILvHReudO1TpoR/aT6BJ3vUjIG9HFgRJQyM1PgM+NtVK2M
   D2cCBbR1LhG/Lbl51PthbbhSH6/pbq3nKav/r0CO3lO3Y/xndTe6Ubk4/
   KIlYhvPOefq/LPj/yzwKOV53cQEIxkoaIvuul7C5B5ShJNi16d4E1n4Wa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="1643230"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="1643230"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 11:53:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="33103908"
Received: from ticela-or-295.amr.corp.intel.com (HELO [10.209.25.188]) ([10.209.25.188])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 11:53:13 -0800
Message-ID: <fc541aa6-9a45-48ff-a394-630721da7d9e@linux.intel.com>
Date: Fri, 9 Feb 2024 11:53:12 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: make pcie_port_bus_type const
To: "Ricardo B. Marliere" <ricardo@marliere.net>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240208-bus_cleanup-pci2-v1-1-5e578210b6f2@marliere.net>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240208-bus_cleanup-pci2-v1-1-5e578210b6f2@marliere.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/8/24 11:41 AM, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the pcie_port_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---

Looks fine to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>  drivers/pci/pci-driver.c   | 2 +-
>  drivers/pci/pcie/portdrv.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index ec838f2e892e..a29098e24683 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1705,7 +1705,7 @@ static int pcie_port_bus_match(struct device *dev, struct device_driver *drv)
>  	return 1;
>  }
>  
> -struct bus_type pcie_port_bus_type = {
> +const struct bus_type pcie_port_bus_type = {
>  	.name		= "pci_express",
>  	.match		= pcie_port_bus_match,
>  };
> diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
> index 1f3803bde7ee..12c89ea0313b 100644
> --- a/drivers/pci/pcie/portdrv.h
> +++ b/drivers/pci/pcie/portdrv.h
> @@ -96,7 +96,7 @@ struct pcie_port_service_driver {
>  int pcie_port_service_register(struct pcie_port_service_driver *new);
>  void pcie_port_service_unregister(struct pcie_port_service_driver *new);
>  
> -extern struct bus_type pcie_port_bus_type;
> +extern const struct bus_type pcie_port_bus_type;
>  
>  struct pci_dev;
>  
>
> ---
> base-commit: cc24b2d080dca2ce1c89a8a71c00bdf21155f357
> change-id: 20240208-bus_cleanup-pci2-61fe9c495d08
>
> Best regards,

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


