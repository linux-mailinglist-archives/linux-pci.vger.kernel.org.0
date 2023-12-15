Return-Path: <linux-pci+bounces-1032-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 540CA813F3E
	for <lists+linux-pci@lfdr.de>; Fri, 15 Dec 2023 02:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F352D1C22050
	for <lists+linux-pci@lfdr.de>; Fri, 15 Dec 2023 01:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC270390;
	Fri, 15 Dec 2023 01:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GhbWFmer"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE4ACA66;
	Fri, 15 Dec 2023 01:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702604064; x=1734140064;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=S/Q5zmtAAGrAUaPeEvARQEllKO3Wd3fwtpI6ys7fByI=;
  b=GhbWFmerWUBWp20Rz7KoqDvGaFZ0HC43CDGpI0kQzzU1103bkc8M0EHb
   hXeGlvbFUkBAPqXQlHonB02u7GuLVscNB+070e7WMkxxFeij7C8BGYp4k
   M9OJLIzVUdSYAj+VIQoErYUtTIUPX4rqBzp5beRxiwxDVRWEzDNQ8CRBA
   MMVxwCBHu9MogM9sA5aCirfSww8oEb+E0zyKsTHsiF4xATDwIMxgysiQH
   bsuZi7yEIRn+ccT6WVtMo/JymLi0UVosqJeDJyf6Vuo1BjdaddeN7IpHO
   AanrmI4Fts6r0GViPpPY2o7lA/T4glpyvdHHSfEoCy5Nl/P7uGSQrpqeJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="16766929"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="16766929"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 17:34:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="774582765"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="774582765"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.213.168]) ([10.254.213.168])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 17:34:18 -0800
Message-ID: <2f49219e-601d-4ddc-a7b7-6ea8968a2f80@linux.intel.com>
Date: Fri, 15 Dec 2023 09:34:16 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, linux-pci@vger.kernel.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Haorong Ye <yehaorong@bytedance.com>
Subject: Re: [PATCH 2/2] iommu/vt-d: don's issue devTLB flush request when
 device is disconnected
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, bhelgaas@google.com,
 dwmw2@infradead.org, will@kernel.org, robin.murphy@arm.com
References: <20231213034637.2603013-1-haifeng.zhao@linux.intel.com>
 <20231213034637.2603013-3-haifeng.zhao@linux.intel.com>
 <96051115-c928-4f3c-bd65-4f3f8e83ca9c@linux.intel.com>
 <e6fddbb0-fa8f-43d4-8a5e-d177e9465912@linux.intel.com>
 <8c8a1e49-5447-4d61-b3ba-782873cc0f4a@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <8c8a1e49-5447-4d61-b3ba-782873cc0f4a@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2023/12/15 9:03, Ethan Zhao wrote:
> 
> 2. supprise_removal
> 
>   Users remove the devece directly or bring the device link down/turn off
> 
>   device power first by setting pci config space, link-down/not-present/
> 
>   power-off are all handled by pciehp the same way "supprise_removal", in
> 
>   such case, pciehp_ist() will flag the device as "disconnected" first, 
> then
> 
>   unconfig the devcie, unload driver, iommu release device(issing devTLB 
> flush)
> 
>   delete device. so we checking the device state could work such cases.

If so, then it is fine for the iommu driver. As Robin said, if the
device needs more cleanup, the iommu core should register a right
callback to the driver core and handle it before the device goes away.

Disabling PCI features seems to be a reasonable device cleanup. This
gives us another reason to move ATS enabling/disabling out from the
iommu subsystem. Once this is done, the device driver will enable ATS
during its probe and disable it during its release. There will be no
such workaround in the iommu driver anymore.

Best regards,
baolu

