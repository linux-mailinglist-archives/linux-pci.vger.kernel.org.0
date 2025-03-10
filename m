Return-Path: <linux-pci+bounces-23334-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9771A59AF3
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 17:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 555F43A84C6
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 16:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FD622FE03;
	Mon, 10 Mar 2025 16:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E41Gf/ML"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499B91D79BE
	for <linux-pci@vger.kernel.org>; Mon, 10 Mar 2025 16:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624010; cv=none; b=Nw+ptFXfJJjElfsOFGTNBr/bKQ+8B9bvXQQ7vL+XkDxLh5q8CT3Z0wefNS2QN0UL5nS5yDwEwUD0WS9DVMYcw3CRRfQvVSvMpKRBiWczdMXFJ+gQvJ9KyL89k5ZHFE+Mz+n/pl/7fqa+acA6+tM9gYH5z2eSl1t3JEtwJ4YVfXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624010; c=relaxed/simple;
	bh=Fbu15y+4+MuCNp8wyBHZk4lxmToA8kq6KLy2njV3kh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JJGXed1+H11wt4lX0BBEDSI3mRpDvdkOPDQfkbeH0uKTbu4UfPLMf0QJ+3ThIuIKgsBuGusZix9/K5oxvlwfVj7ZdHHa2m3yLlb5hUbGUIlXHtWUJIL+aiGEqgiogJGrZgMtIwcZn1oh7h04PCQDbyUv/x2zldv3frHKO7BfLzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E41Gf/ML; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741624009; x=1773160009;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Fbu15y+4+MuCNp8wyBHZk4lxmToA8kq6KLy2njV3kh4=;
  b=E41Gf/MLngWnbfAL6p/9OJPs6RQ4psm3L6WJ+wD6F1IFXdEy331Z7tFA
   2A1+O6qwCYdjHCni9LI+VVB3b44fuMp1qqtTFM4KHC9MN1nbKiRNcZTsw
   sfudyucqy/DNtxwHpiTi51eXPDIWM5cAQZzZ2C6PvRse4Y6HyarFpLZE3
   gSRdPXrFJMSS/2nzCqGFSnQ+xuVrL8SMSffBGzLQ9F6QAJjCyNf26d/TH
   Nx+gHIsiZ/Bd4NcojiXTa44h5xSRFZUL+Q2XS27LKJm8l+w8X0cI/y8qG
   o5zmuBWcGFn78DaVLHvC6KCUUGwKZV4c05Pf6iJzsZuBmUdwgwO9pCrLn
   w==;
X-CSE-ConnectionGUID: TnAh0/HZQ8yDr08qTIz/1Q==
X-CSE-MsgGUID: oMqqap4PQl+5fbGwnIN6kw==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="42663877"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="42663877"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 09:26:49 -0700
X-CSE-ConnectionGUID: soSpy2//TWm64rkDngTYgw==
X-CSE-MsgGUID: grecUCfVQ0S6v8g1WBOcWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="120530772"
Received: from bkammerd-mobl.amr.corp.intel.com (HELO [10.124.220.122]) ([10.124.220.122])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 09:26:48 -0700
Message-ID: <2bbc5ed1-f5c3-4cd3-b72a-a40bc0749d8e@linux.intel.com>
Date: Mon, 10 Mar 2025 09:26:47 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/11] coco/guest: Move shared guest CC infrastructure
 to drivers/virt/coco/guest/
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev
Cc: Wu Hao <hao.wu@intel.com>, Yilun Xu <yilun.xu@intel.com>,
 Samuel Ortiz <sameo@rivosinc.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Alexey Kardashevskiy <aik@amd.com>, gregkh@linuxfoundation.org,
 linux-pci@vger.kernel.org, lukas@wunner.de
References: <174107245357.1288555.10863541957822891561.stgit@dwillia2-xfh.jf.intel.com>
 <174107246641.1288555.208426916259466774.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <174107246641.1288555.208426916259466774.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/3/25 11:14 PM, Dan Williams wrote:
> In preparation for creating a new drivers/virt/coco/host/ directory to
> house shared host driver infrastructure for confidential computing, move
> configfs-tsm to a guest/ sub-directory. The tsm.ko module is renamed to
> tsm_reports.ko. The old tsm.ko module was only ever demand loaded by
> kernel internal dependencies, so it should not affect existing userspace
> module install scripts.
>
> The new drivers/virt/coco/guest/ is also a preparatory landing spot for
> new / optional TSM Report mechanics like a TCB stability enumeration /
> watchdog mechanism. To be added later.
>
> Cc: Wu Hao <hao.wu@intel.com>
> Cc: Yilun Xu <yilun.xu@intel.com>
> Cc: Samuel Ortiz <sameo@rivosinc.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Reviewed-by: Alexey Kardashevskiy <aik@amd.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan 
<sathyanarayanan.kuppuswamy@linux.intel.com>

>   MAINTAINERS                      |    2 +-
>   drivers/virt/coco/Kconfig        |    6 ++----
>   drivers/virt/coco/Makefile       |    2 +-
>   drivers/virt/coco/guest/Kconfig  |    7 +++++++
>   drivers/virt/coco/guest/Makefile |    3 +++
>   drivers/virt/coco/guest/report.c |    0
>   6 files changed, 14 insertions(+), 6 deletions(-)
>   create mode 100644 drivers/virt/coco/guest/Kconfig
>   create mode 100644 drivers/virt/coco/guest/Makefile
>   rename drivers/virt/coco/{tsm.c => guest/report.c} (100%)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 38bcf530c2ae..6a1d705c8eac 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24116,7 +24116,7 @@ M:	Dan Williams <dan.j.williams@intel.com>
>   L:	linux-coco@lists.linux.dev
>   S:	Maintained
>   F:	Documentation/ABI/testing/configfs-tsm-report
> -F:	drivers/virt/coco/tsm.c
> +F:	drivers/virt/coco/guest/
>   F:	include/linux/tsm.h
>   
>   TRUSTED SERVICES TEE DRIVER
> diff --git a/drivers/virt/coco/Kconfig b/drivers/virt/coco/Kconfig
> index ff869d883d95..819a97e8ba99 100644
> --- a/drivers/virt/coco/Kconfig
> +++ b/drivers/virt/coco/Kconfig
> @@ -3,10 +3,6 @@
>   # Confidential computing related collateral
>   #
>   
> -config TSM_REPORTS
> -	select CONFIGFS_FS
> -	tristate
> -
>   source "drivers/virt/coco/efi_secret/Kconfig"
>   
>   source "drivers/virt/coco/pkvm-guest/Kconfig"
> @@ -16,3 +12,5 @@ source "drivers/virt/coco/sev-guest/Kconfig"
>   source "drivers/virt/coco/tdx-guest/Kconfig"
>   
>   source "drivers/virt/coco/arm-cca-guest/Kconfig"
> +
> +source "drivers/virt/coco/guest/Kconfig"
> diff --git a/drivers/virt/coco/Makefile b/drivers/virt/coco/Makefile
> index c3d07cfc087e..885c9ef4e9fc 100644
> --- a/drivers/virt/coco/Makefile
> +++ b/drivers/virt/coco/Makefile
> @@ -2,9 +2,9 @@
>   #
>   # Confidential computing related collateral
>   #
> -obj-$(CONFIG_TSM_REPORTS)	+= tsm.o
>   obj-$(CONFIG_EFI_SECRET)	+= efi_secret/
>   obj-$(CONFIG_ARM_PKVM_GUEST)	+= pkvm-guest/
>   obj-$(CONFIG_SEV_GUEST)		+= sev-guest/
>   obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdx-guest/
>   obj-$(CONFIG_ARM_CCA_GUEST)	+= arm-cca-guest/
> +obj-$(CONFIG_TSM_REPORTS)	+= guest/
> diff --git a/drivers/virt/coco/guest/Kconfig b/drivers/virt/coco/guest/Kconfig
> new file mode 100644
> index 000000000000..ed9bafbdd854
> --- /dev/null
> +++ b/drivers/virt/coco/guest/Kconfig
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Confidential computing shared guest collateral
> +#
> +config TSM_REPORTS
> +	select CONFIGFS_FS
> +	tristate
> diff --git a/drivers/virt/coco/guest/Makefile b/drivers/virt/coco/guest/Makefile
> new file mode 100644
> index 000000000000..b3b217af77cf
> --- /dev/null
> +++ b/drivers/virt/coco/guest/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_TSM_REPORTS)	+= tsm_report.o
> +tsm_report-y := report.o
> diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/guest/report.c
> similarity index 100%
> rename from drivers/virt/coco/tsm.c
> rename to drivers/virt/coco/guest/report.c
>
>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


