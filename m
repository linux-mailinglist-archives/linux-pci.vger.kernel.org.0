Return-Path: <linux-pci+bounces-1971-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F36829350
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 06:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 792BAB22AC8
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 05:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C0CDDAE;
	Wed, 10 Jan 2024 05:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="feGylJ4r"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A6EDDA1;
	Wed, 10 Jan 2024 05:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704864663; x=1736400663;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Hj5faYh6SvrBUXVDfagDM590B8t7PvOarGxhZS51nSo=;
  b=feGylJ4rrvVkKyuzWUzCpNK1GTp8DhfcHG+o9uAfavW0Yi+qROexLxT1
   7pZQgxjuIdGUMGNtTVbVJvvywE4SRqZnFUNhtnfIEmcwKc7nRlinPJAgy
   fUghxhPXF8GOZNjq4HXSuY+wSSvs4M/BY5nRz1f69F2lBa4cnjE0W61aR
   AezlSs6TN0uNBSpHfXa5cjnvOpeuW1PR1BVrUftXisU7P7UVWhMmfVn5A
   Qw6b2cti2AUNw5qGJl0CnVAwUTGeKksuxdOhD4BI5Y0YypgK3jWI+lOmU
   7pO06Hfhdj9yxgByC4dJYZYLI9zMbKjqeeNmOI4MoFkOC2O3T42PK22n1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="5161350"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="5161350"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 21:31:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="816230686"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="816230686"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga001.jf.intel.com with ESMTP; 09 Jan 2024 21:30:59 -0800
Message-ID: <8250acd8-4013-487d-9b31-102334ff316a@linux.intel.com>
Date: Wed, 10 Jan 2024 13:25:46 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, linux-pci@vger.kernel.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v10 3/5] PCI: make pci_dev_is_disconnected() helper
 public for other drivers
Content-Language: en-US
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, kevin.tian@intel.com,
 bhelgaas@google.com, dwmw2@infradead.org, will@kernel.org,
 robin.murphy@arm.com, lukas@wunner.de
References: <20231228170504.720794-1-haifeng.zhao@linux.intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231228170504.720794-1-haifeng.zhao@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/29/23 1:05 AM, Ethan Zhao wrote:
> Make pci_dev_is_disconnected() public so that it can be called from
> Intel VT-d driver to quickly fix/workaround the surprise removal
> unplug hang issue for those ATS capable devices on PCIe switch downstream
> hotplug capable ports.
> 
> Beside pci_device_is_present() function, this one has no config space
> space access, so is light enough to optimize the normal pure surprise
> removal and safe removal flow.
> 
> Tested-by: Haorong Ye<yehaorong@bytedance.com>
> Signed-off-by: Ethan Zhao<haifeng.zhao@linux.intel.com>
> ---
>   drivers/pci/pci.h   | 5 -----
>   include/linux/pci.h | 5 +++++
>   2 files changed, 5 insertions(+), 5 deletions(-)

This should be moved before PATCH 2/5? Otherwise, PATCH 2/5 couldn't be
compiled.

Best regards,
baolu

