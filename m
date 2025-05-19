Return-Path: <linux-pci+bounces-28044-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 897DFABCBB4
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 01:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FE5B8C1135
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 23:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0511991CD;
	Mon, 19 May 2025 23:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cbppcEK3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA2A4B1E5E;
	Mon, 19 May 2025 23:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747698443; cv=none; b=sDpLxVEItZPcIhiQwQ+BrXOf48Uzyd4DAO50VM9VGgAFyAWCGiMzsnDDEw/hh1IjG8/OytMiXfa1HQ5eQQtHUaiVC7yMfVx080vBusik2CueFgtO6gMr4S74cRjhQdkRiYGqeMAY315r8KgzA82Yk7pmoDgFnZsalKFuBmbeWFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747698443; c=relaxed/simple;
	bh=2BXuPy0dtOIAjcn43s0b9leWNNf00rEj6dxgDnly9m4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sGVXkxyJXLTLhVCt8ClKEOdRry+N5HiZAr7r0I8hnUzXacn/MWuRf+FuGT7A/1HLqCdI0dtc/TJVBQeKqMut6SPhXygnA7tlF65dk3KGqKYFBX84MRqVCoyFs9wTtEHc6eNicN0tZnsSwOYQVK5ewW5AFBT1PyvR03qO7HupSAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cbppcEK3; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747698441; x=1779234441;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2BXuPy0dtOIAjcn43s0b9leWNNf00rEj6dxgDnly9m4=;
  b=cbppcEK3+rUbm7/vy1WG0LI3QtNbdPT4jPj0Hs8WY6g8r6We+ddxlFS+
   POcl0GpJ+3rR3NajGbknedhJLNFWE3pbF9sZoHT6Lqz3fOgb3QV8SPb9o
   yKi3NGzXxaa6r4vJ7qMBUr5UiogsXv6LFd7hDfO0nvbOt9FuEqEYFZ0KJ
   D5UIYj9JIgQ1sr/lFpn5sGQ4fjMM4HOzmtovc0eJRI5NMF4erMaBOHqYF
   HfJTgk8yl8EaQVIMG8I9KlulvavQJ5B/awl47eqyQ+UTcI03D0F87PlrU
   Z3nfYxnAJIYU1WhMz57wnMQ2kplsX2HpaPUY+9unE3sJhTnydBtd+xyLx
   w==;
X-CSE-ConnectionGUID: 3LpQVSMpQcyoMbYahtBJNA==
X-CSE-MsgGUID: c6O9nxykTJaRNqOU24OqSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="52245871"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="52245871"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 16:47:19 -0700
X-CSE-ConnectionGUID: QWIh/uQRSY+1nhDqJrlsaw==
X-CSE-MsgGUID: OwcPBSk6TZS2d7dRiA+p6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="139421077"
Received: from mdroper-mobl2.amr.corp.intel.com (HELO [10.124.221.39]) ([10.124.221.39])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 16:47:18 -0700
Message-ID: <2889da2a-5cda-4a78-9457-864276c92410@linux.intel.com>
Date: Mon, 19 May 2025 16:47:17 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/16] PCI/AER: Extract bus/dev/fn in
 aer_print_port_info() with PCI_BUS_NUM(), etc
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: Jon Pan-Doh <pandoh@google.com>,
 Karolina Stolarek <karolina.stolarek@oracle.com>,
 Martin Petersen <martin.petersen@oracle.com>,
 Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>,
 Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Lukas Wunner <lukas@wunner.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Sargun Dhillon <sargun@meta.com>, "Paul E . McKenney" <paulmck@kernel.org>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Kai-Heng Feng <kaihengf@nvidia.com>,
 Keith Busch <kbusch@kernel.org>, Robert Richter <rrichter@amd.com>,
 Terry Bowman <terry.bowman@amd.com>, Shiju Jose <shiju.jose@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20250519213603.1257897-1-helgaas@kernel.org>
 <20250519213603.1257897-5-helgaas@kernel.org>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250519213603.1257897-5-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/19/25 2:35 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> Use PCI_BUS_NUM(), PCI_SLOT(), PCI_FUNC() to extract the bus number,
> device, and function number directly from the Error Source ID.  There's no
> need to shift and mask it explicitly.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>   drivers/pci/pcie/aer.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index b8494ccd935b..dc8a50e0a2b7 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -736,14 +736,13 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>   static void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info,
>   				const char *details)
>   {
> -	u8 bus = info->id >> 8;
> -	u8 devfn = info->id & 0xff;
> +	u16 source = info->id;
>   
>   	pci_info(dev, "%s%s error message received from %04x:%02x:%02x.%d%s\n",

Since it is used in many places in PCI driver, may be define

#define PCI_ADDR_FMT "%04x:%02x:%02x.%d"

>   		 info->multi_error_valid ? "Multiple " : "",
>   		 aer_error_severity_string[info->severity],
> -		 pci_domain_nr(dev->bus), bus, PCI_SLOT(devfn),
> -		 PCI_FUNC(devfn), details);
> +		 pci_domain_nr(dev->bus), PCI_BUS_NUM(source),
> +		 PCI_SLOT(source), PCI_FUNC(source), details);
>   }
>   
>   #ifdef CONFIG_ACPI_APEI_PCIEAER

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


