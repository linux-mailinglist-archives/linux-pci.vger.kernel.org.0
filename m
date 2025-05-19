Return-Path: <linux-pci+bounces-28041-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2CBABCB54
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 01:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1782D17DF84
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 23:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7D91AA786;
	Mon, 19 May 2025 23:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e32eysEZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7D51373;
	Mon, 19 May 2025 23:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747696569; cv=none; b=rLJmEJnjIZdBwXdau+KuF9x1U0cjZO7Iat0txiShthClWHpyMMPiSuHmTzSMQ0vHlCrAkc8+wEUi1c6IjrsFHyW3kurD8WqxCuOekR+30aALf0MVjNUC+wg8hk+k2V11LPNpr/uhK+NZ82eUPtbeDYRZ6O+Qx8DtsMHI8OUkqes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747696569; c=relaxed/simple;
	bh=dXooAyhFtIbkNwlVi/qdsagXG5Z4H1TWB2hLbacD1/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GUpgiWtNJ0hr5rLk3zBbfeKbUzpeFw8E5TbdTsHwA4oLlfYyHdTgbqfaCbc1PN5YCrofK4mxWLc1ZuzBlZ+vx8p2IencIreZU/edUhKWhdZ/yvsNrCMYkq6575QVJnN0mNaO4lkZ/k5pRxV7YQ9qdzIOUGupMEweUfLKkefWXfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e32eysEZ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747696568; x=1779232568;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dXooAyhFtIbkNwlVi/qdsagXG5Z4H1TWB2hLbacD1/c=;
  b=e32eysEZHHhZvUCOQEDUdgbolfjS5yCm0ErtEMecdxOq+j2vPR/P977W
   W7TQAxV96Ik6GDcKAyx8q4QeqEBvuJeyxH/lh5QLhGBJ0NbG3UrStBhab
   OTLrq9KWJVB7ZuAdHNkncwZXdjbXpwxOC4kbw9k6yq3R3rhtIvhDfT1TE
   r8YPCsMDLHxIBoB7g8L1naP+L6s5W3Z0wtpO3C0NCCmuGomKf9tfJETlk
   rHIRtGbZKEGDT459s3m594bvZN6SS0KwJktl06AcRn1nulZO7iLzAU6g9
   tBYMGklc+nZYVnf+TmAYSoR6awB2tn9lQa4icGjhnOPVBMYDkAv7hra7k
   A==;
X-CSE-ConnectionGUID: qYv9Z1jVT6mxSDkSObQT5A==
X-CSE-MsgGUID: /mL7n3RoQNKhD7YnWH/mHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49677370"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="49677370"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 16:15:58 -0700
X-CSE-ConnectionGUID: VzHO+0MGRvOaAlG2gyO3pw==
X-CSE-MsgGUID: lgvVC65aSzObW5WDwhFXEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="140412830"
Received: from mdroper-mobl2.amr.corp.intel.com (HELO [10.124.221.39]) ([10.124.221.39])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 16:15:58 -0700
Message-ID: <e37c5f7f-3460-4f58-892f-39faf88a8e9c@linux.intel.com>
Date: Mon, 19 May 2025 16:15:56 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/16] PCI/DPC: Log Error Source ID only when valid
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
 <20250519213603.1257897-3-helgaas@kernel.org>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250519213603.1257897-3-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/19/25 2:35 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> DPC Error Source ID is only valid when the DPC Trigger Reason indicates
> that DPC was triggered due to reception of an ERR_NONFATAL or ERR_FATAL
> Message (PCIe r6.0, sec 7.9.14.5).
>
> When DPC was triggered by ERR_NONFATAL (PCI_EXP_DPC_STATUS_TRIGGER_RSN_NFE)
> or ERR_FATAL (PCI_EXP_DPC_STATUS_TRIGGER_RSN_FE) from a downstream device,
> log the Error Source ID (decoded into domain/bus/device/function).  Don't
> print the source otherwise, since it's not valid.
>
> For DPC trigger due to reception of ERR_NONFATAL or ERR_FATAL, the dmesg
> logging changes:
>
>    - pci 0000:00:01.0: DPC: containment event, status:0x000d source:0x0200
>    - pci 0000:00:01.0: DPC: ERR_FATAL detected
>    + pci 0000:00:01.0: DPC: containment event, status:0x000d, ERR_FATAL received from 0000:02:00.0
>
> and when DPC triggered for other reasons, where DPC Error Source ID is
> undefined, e.g., unmasked uncorrectable error:
>
>    - pci 0000:00:01.0: DPC: containment event, status:0x0009 source:0x0200
>    - pci 0000:00:01.0: DPC: unmasked uncorrectable error detected
>    + pci 0000:00:01.0: DPC: containment event, status:0x0009: unmasked uncorrectable error detected
>
> Previously the "containment event" message was at KERN_INFO and the
> "%s detected" message was at KERN_WARNING.  Now the single message is at
> KERN_WARNING.

Since we are handling Uncorrectable errors, why not use pci_err?

>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>   drivers/pci/pcie/dpc.c | 45 ++++++++++++++++++++++++++----------------
>   1 file changed, 28 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index fe7719238456..315bf2bfd570 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -261,25 +261,36 @@ void dpc_process_error(struct pci_dev *pdev)
>   	struct aer_err_info info = { 0 };
>   
>   	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
> -	pci_read_config_word(pdev, cap + PCI_EXP_DPC_SOURCE_ID, &source);
> -
> -	pci_info(pdev, "containment event, status:%#06x source:%#06x\n",
> -		 status, source);
>   
>   	reason = status & PCI_EXP_DPC_STATUS_TRIGGER_RSN;
> -	ext_reason = status & PCI_EXP_DPC_STATUS_TRIGGER_RSN_EXT;
> -	pci_warn(pdev, "%s detected\n",
> -		 (reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_UNCOR) ?
> -		 "unmasked uncorrectable error" :
> -		 (reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_NFE) ?
> -		 "ERR_NONFATAL" :
> -		 (reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_FE) ?
> -		 "ERR_FATAL" :
> -		 (ext_reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_RP_PIO) ?
> -		 "RP PIO error" :
> -		 (ext_reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_SW_TRIGGER) ?
> -		 "software trigger" :
> -		 "reserved error");
> +
> +	switch (reason) {
> +	case PCI_EXP_DPC_STATUS_TRIGGER_RSN_UNCOR:
> +		pci_warn(pdev, "containment event, status:%#06x: unmasked uncorrectable error detected\n",
> +			 status);
> +		break;
> +	case PCI_EXP_DPC_STATUS_TRIGGER_RSN_NFE:
> +	case PCI_EXP_DPC_STATUS_TRIGGER_RSN_FE:
> +		pci_read_config_word(pdev, cap + PCI_EXP_DPC_SOURCE_ID,
> +				     &source);
> +		pci_warn(pdev, "containment event, status:%#06x, %s received from %04x:%02x:%02x.%d\n",
> +			 status,

I see the BDF extraction and format code in many places in the PCI drivers. May be a
common macro will make it more readable.

> +			 (reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_FE) ?
> +				"ERR_FATAL" : "ERR_NONFATAL",
> +			 pci_domain_nr(pdev->bus), PCI_BUS_NUM(source),
> +			 PCI_SLOT(source), PCI_FUNC(source));
> +		return;
> +	case PCI_EXP_DPC_STATUS_TRIGGER_RSN_IN_EXT:
> +		ext_reason = status & PCI_EXP_DPC_STATUS_TRIGGER_RSN_EXT;
> +		pci_warn(pdev, "containment event, status:%#06x: %s detected\n",
> +			 status,
> +			 (ext_reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_RP_PIO) ?
> +			 "RP PIO error" :
> +			 (ext_reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_SW_TRIGGER) ?
> +			 "software trigger" :
> +			 "reserved error");
> +		break;
> +	}
>   
>   	/* show RP PIO error detail information */
>   	if (pdev->dpc_rp_extensions &&

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


