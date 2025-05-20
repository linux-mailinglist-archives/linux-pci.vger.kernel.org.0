Return-Path: <linux-pci+bounces-28064-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B971ABCE5F
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 07:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2C2A4A3255
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 05:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249CC1684B4;
	Tue, 20 May 2025 05:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I5qknKkJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EFCBE5E;
	Tue, 20 May 2025 05:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747717278; cv=none; b=O8CrhT10HyHfnZDzV77TNSRvsqIEAxdpF6hxmCRW7nC/7kr7YrChghyK4vv1SKI7BSmp1PN8kAxqo0x0ZLJzFCDb5FCJmdY9C3iEg0YziZPrVVzgmIDFlhE7v5/4MGRx0k9eEu3FIX7Fk6+rDfppgIq/Li25FrqITupaNquNKp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747717278; c=relaxed/simple;
	bh=rYUVuOK5P7Bcz50bfsx98bvImcvMk1Jc4VhxeSIN7wI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jklCnybwADat+V6telWwpK7kxE7OoJnhcr2vMVq4OesmLt9RzQQiMBZJD/KWR3X/S/p3Ud/cuo4JzTWMYwRhbQGRiiiM6O4+AQhOOqKoeYioQV4mTSV9MpisHat1ZRD12OoRRGv4S0k1r2txJLm9YOBuqjX8eV+2FsJqC34J3vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I5qknKkJ; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747717276; x=1779253276;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rYUVuOK5P7Bcz50bfsx98bvImcvMk1Jc4VhxeSIN7wI=;
  b=I5qknKkJUSn1/plGAL1zHEs/MHSKIFvLHbTfdm7jI+LAr47AmqzD6uVD
   EbBguqsPzWcd1UCYNiio+yIH0VfMPydFC+CbJLZNXmnpGTuZt6XOI9U6U
   Ac/6odssWzS/7gPcN5DNoVWkwxxBBXwdOycPnhDkcV8KT4kGk4m4j4Q3K
   UEbqrKIUg4yQhKA2muLEIFPNshBrLVTbu+rGdcfKnkOrnh41gbXR5Xb1s
   26wnfBDOIXJ0rMyxtCLQ61Uz5unvX6xbzNaTZts7SckrrQdpCuaKbBh31
   TtZGPbnTJhnGAo0sJjvEJT+f+j1p8MPueMW/e+N3wr9qbAqLrGXFAKwPS
   Q==;
X-CSE-ConnectionGUID: loyvM+hrS3WBZqhMUKVyUg==
X-CSE-MsgGUID: BAonH5GrQ0+MH6WkG5sSMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="37251772"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="37251772"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 22:01:15 -0700
X-CSE-ConnectionGUID: dNmfyY0QSeq8TIS4QfO6fw==
X-CSE-MsgGUID: 43QwtQ8IRAydXYI4E+KUeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="139306286"
Received: from mdroper-mobl2.amr.corp.intel.com (HELO [10.124.221.39]) ([10.124.221.39])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 22:01:12 -0700
Message-ID: <75a3749b-36d9-467c-80a7-7e4a42e2f9b1@linux.intel.com>
Date: Mon, 19 May 2025 22:01:09 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 15/16] PCI/AER: Add ratelimits to PCI AER Documentation
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
 <20250519213603.1257897-16-helgaas@kernel.org>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250519213603.1257897-16-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/19/25 2:35 PM, Bjorn Helgaas wrote:
> From: Jon Pan-Doh <pandoh@google.com>
>
> Add ratelimits section for rationale and defaults.
>
> Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
> Signed-off-by: Jon Pan-Doh <pandoh@google.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Acked-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>   Documentation/PCI/pcieaer-howto.rst | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
> index f013f3b27c82..896d2a232a90 100644
> --- a/Documentation/PCI/pcieaer-howto.rst
> +++ b/Documentation/PCI/pcieaer-howto.rst
> @@ -85,6 +85,17 @@ In the example, 'Requester ID' means the ID of the device that sent
>   the error message to the Root Port. Please refer to PCIe specs for other
>   fields.
>   
> +AER Ratelimits
> +--------------
> +
> +Since error messages can be generated for each transaction, we may see
> +large volumes of errors reported. To prevent spammy devices from flooding
> +the console/stalling execution, messages are throttled by device and error
> +type (correctable vs. uncorrectable).

Can we list exceptions like DPC and FATAL errors (if added) ?

> +
> +AER uses the default ratelimit of DEFAULT_RATELIMIT_BURST (10 events) over
> +DEFAULT_RATELIMIT_INTERVAL (5 seconds).
> +
>   AER Statistics / Counters
>   -------------------------
>   

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


