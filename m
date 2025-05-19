Return-Path: <linux-pci+bounces-28038-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E056AABCB0E
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 00:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81C9A4A1E8E
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 22:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F006821CC7F;
	Mon, 19 May 2025 22:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V2jty9u4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E06A21CA14;
	Mon, 19 May 2025 22:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747694515; cv=none; b=ohpntFUO732KbJucd3N9fy/Eba48gkT8po1q7QCEbF8x0GSZqvBw0bBeerRETunVmPusTuC9ZbAAMkp15qSU3e+tTaBiS74MljZLybG2emRSYesJkBT5J70VhVpPy1ovgrjKjZkhzN5Ks7QLtM77TzeAej4Yg2doEe2ME5JfEVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747694515; c=relaxed/simple;
	bh=mMXMidsfCoqJOKi8B+7joSdBmF/Wv4ltuLs090jXvPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MPuNHMJTvQyKLJQcNzWRwL2XTX70TgcQhHALPvwfqXUOnJ4XahQ69ak1oKwYBXjZNW5CnxT1x8c0uj/aquUOGPRUQD7VJCAqs0mCWsFf5xXHk4xIrA5gf3LGtr0ZQ4NIG/xGiV6pZ5++3oj62G32PCYyTMMG3qlpESSoLkbaqPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V2jty9u4; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747694514; x=1779230514;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mMXMidsfCoqJOKi8B+7joSdBmF/Wv4ltuLs090jXvPg=;
  b=V2jty9u4IVbRey4tHTdEwCEciPB6z266zntcnKPkmt+Wlb4Z9s8ui4mf
   +CBFWxsDra8LRkNl+M0SM0rWhCc4G+0MADgrtg9goERbnJx7/RVLkPkNl
   a1ZaV3hEM6wmJeFKqxnV0Jir5Yj93kYdefB08hDZGLWCc2axdYuP54TmU
   5/8tVV6OOaB1H2u2dWIhueSPLytdCboOna+tcs/bSid3tpHldXmCPZb3c
   DWHmArjWi4VYyKoNwGMvxvTeUVQATWBfJDTyELLSB6tvw+qKyi+869h9l
   Def9426YgBY6qQQwwW9T6K9UZluXrZCuAXudAQojWQ+xJvkap8e1vRHMe
   Q==;
X-CSE-ConnectionGUID: JI0JtucwQPmDL7b4uk79XA==
X-CSE-MsgGUID: v3+5KhuiQW+oSdKqyv5r+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="53408064"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="53408064"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 15:41:53 -0700
X-CSE-ConnectionGUID: 61PQEioIQ/iJ1hNNkacuzg==
X-CSE-MsgGUID: Zp6lnw4ETfKVUtkIljdg1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="139230552"
Received: from mdroper-mobl2.amr.corp.intel.com (HELO [10.124.221.39]) ([10.124.221.39])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 15:41:52 -0700
Message-ID: <1b1b80e2-4f59-462e-96a9-546b1d7a7644@linux.intel.com>
Date: Mon, 19 May 2025 15:41:50 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/16] PCI/DPC: Initialize aer_err_info before using it
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
 <20250519213603.1257897-2-helgaas@kernel.org>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250519213603.1257897-2-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 5/19/25 2:35 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> Previously the struct aer_err_info "info" was allocated on the stack

/s/Previously/Currently ?

> without being initialized, so it contained junk except for the fields we
> explicitly set later.
>
> Initialize "info" at declaration so it starts as all zeroes.

/s/zeroes/zeros

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>   drivers/pci/pcie/dpc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index df42f15c9829..fe7719238456 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -258,7 +258,7 @@ static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
>   void dpc_process_error(struct pci_dev *pdev)
>   {
>   	u16 cap = pdev->dpc_cap, status, source, reason, ext_reason;
> -	struct aer_err_info info;
> +	struct aer_err_info info = { 0 };
>   
>   	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
>   	pci_read_config_word(pdev, cap + PCI_EXP_DPC_SOURCE_ID, &source);

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


