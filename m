Return-Path: <linux-pci+bounces-28083-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1350BABD4F9
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 12:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A1664C1C8F
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 10:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E94726B94F;
	Tue, 20 May 2025 10:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P0bkxUmf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AF826B0A7;
	Tue, 20 May 2025 10:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747736895; cv=none; b=h/4c7pIps3XpUloJceRoy7Txry/L72G0guzE82UQ7IP0W/KGGetw4L3jUelE18te95HRvAJas3XFt9yZaAQjYmO3BMKgkBRPvPDNaBeAQDeGE8fRmtqjEOuRM8MlbHlaoyznNHckHYmaOP8HKxfFDTaFYw/pc+g43Onowi7VNzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747736895; c=relaxed/simple;
	bh=ABdjG3Pe62S3x9ocvJ5urldXhGi9h8OX8THWZ/USw6U=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lzVQEAm2QgsGMCy4mClUsuZ52ZhTSZcnMAr5fsGig70UE64OL+bpkLYgNEvO+dREyBcCoRkVP23c1Vz0GcSoX5bQxG8kW+YMGEb8TXscaQnfbGJF/EvmALzXFZaytHyYkSPrvfgwQqV+dU8XmOU1HIR7cN7SxH7W0bZ9NHMkAx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P0bkxUmf; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747736894; x=1779272894;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ABdjG3Pe62S3x9ocvJ5urldXhGi9h8OX8THWZ/USw6U=;
  b=P0bkxUmfJiWmlKXvEaY9RMLGLy2gyqOzDScJzmgrA3RyMYImlmf+k9D6
   JDALcKyKivzDcZkwtcU/49/PQ7NjBRfx3ucNdZ4zACMmXrPCmEUyacZq5
   anmRcNLY4KHye7Rsl9Z998xlb1A0rhlgh8uWr/wgwYTjiPyYRN9lF+Esg
   blsSXJoc9IXm6IBUX4r1p+xqdleTBrnljMacQMAM/IqRtF0eAu7AroxFI
   Dqkq6+3K9UDYAZoeb9x44oAc2DbsARHzKq9q/DP4/Hof8iyEdvpJNxb2o
   nzih8KqKPb5yIR7nqgej5Usom8w6Af3O6muJ2dQlKIcrww0bUmzOjyZQE
   g==;
X-CSE-ConnectionGUID: Ga3F/Ic0SO2xQa0V0SwevA==
X-CSE-MsgGUID: 18Y1QlMTSDiFllQrPj40Ow==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="60700836"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="60700836"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 03:28:13 -0700
X-CSE-ConnectionGUID: 9pyCjzPqSgefZQ4zCEbisg==
X-CSE-MsgGUID: DlBKfSmYShKo2EDVX2N9Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="144640371"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.235])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 03:28:05 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 20 May 2025 13:28:02 +0300 (EEST)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: linux-pci@vger.kernel.org, Jon Pan-Doh <pandoh@google.com>, 
    Karolina Stolarek <karolina.stolarek@oracle.com>, 
    Martin Petersen <martin.petersen@oracle.com>, 
    Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
    Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
    Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, 
    Lukas Wunner <lukas@wunner.de>, 
    Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
    Sargun Dhillon <sargun@meta.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
    Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
    Oliver O'Halloran <oohall@gmail.com>, Kai-Heng Feng <kaihengf@nvidia.com>, 
    Keith Busch <kbusch@kernel.org>, Robert Richter <rrichter@amd.com>, 
    Terry Bowman <terry.bowman@amd.com>, Shiju Jose <shiju.jose@huawei.com>, 
    Dave Jiang <dave.jiang@intel.com>, LKML <linux-kernel@vger.kernel.org>, 
    linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v6 02/16] PCI/DPC: Log Error Source ID only when valid
In-Reply-To: <20250519213603.1257897-3-helgaas@kernel.org>
Message-ID: <b6ba76ff-7cbd-2d73-fdc4-41aa8c788bc9@linux.intel.com>
References: <20250519213603.1257897-1-helgaas@kernel.org> <20250519213603.1257897-3-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 19 May 2025, Bjorn Helgaas wrote:

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
>   - pci 0000:00:01.0: DPC: containment event, status:0x000d source:0x0200
>   - pci 0000:00:01.0: DPC: ERR_FATAL detected
>   + pci 0000:00:01.0: DPC: containment event, status:0x000d, ERR_FATAL received from 0000:02:00.0
> 
> and when DPC triggered for other reasons, where DPC Error Source ID is
> undefined, e.g., unmasked uncorrectable error:
> 
>   - pci 0000:00:01.0: DPC: containment event, status:0x0009 source:0x0200
>   - pci 0000:00:01.0: DPC: unmasked uncorrectable error detected
>   + pci 0000:00:01.0: DPC: containment event, status:0x0009: unmasked uncorrectable error detected
> 
> Previously the "containment event" message was at KERN_INFO and the
> "%s detected" message was at KERN_WARNING.  Now the single message is at
> KERN_WARNING.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pcie/dpc.c | 45 ++++++++++++++++++++++++++----------------
>  1 file changed, 28 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index fe7719238456..315bf2bfd570 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -261,25 +261,36 @@ void dpc_process_error(struct pci_dev *pdev)
>  	struct aer_err_info info = { 0 };
>  
>  	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
> -	pci_read_config_word(pdev, cap + PCI_EXP_DPC_SOURCE_ID, &source);
> -
> -	pci_info(pdev, "containment event, status:%#06x source:%#06x\n",
> -		 status, source);
>  
>  	reason = status & PCI_EXP_DPC_STATUS_TRIGGER_RSN;
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
>  	/* show RP PIO error detail information */
>  	if (pdev->dpc_rp_extensions &&
> 

After adding that switch (reason) there, wouldn't it make sense to move 
also the code from the if blocks into the case blocks? That if 
conditions check for reason anyway so those if branches would naturally 
belong under one of the cases each.

-- 
 i.


