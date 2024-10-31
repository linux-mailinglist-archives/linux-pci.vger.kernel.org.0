Return-Path: <linux-pci+bounces-15725-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A81D9B7FDD
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 17:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F7B228116D
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 16:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A391B6541;
	Thu, 31 Oct 2024 16:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lNzvSsSP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A5219C562;
	Thu, 31 Oct 2024 16:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730391661; cv=none; b=NdZBXwJSQC5w/PQMD70g+EOHOe5MfAY2Szbcak7aRN87T++I0aKYtnOZbSOaTx07B0Hbjl1HnyytOgtUYBctzItGZQ1+kZxuSrmR8l3di0qfL0R7rZLNtqK3ArOcqANnc3STAxlOnrvafIowm9MEdz32IJAe/D8Qs3++jahX4xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730391661; c=relaxed/simple;
	bh=tjreIR6D1ItokDQ+ixbb6MEE6BfjD32ie6X5Zd9jpps=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SBb8UpXjh1Ak4rLFBKOKjAebjerPGGftSFe8STlX9VDZoVn5xtaJlLAc+ZGmPsrt7VjL2DcDpB7ag//MXD+qnFXob3iopWKVgcX1dck4lshaLSYuMet1dXKGC2xQnhb5lp3T3qag+kWLTULLubSMKpLemOdgNxPt1qFDlnfLawI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lNzvSsSP; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730391660; x=1761927660;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=tjreIR6D1ItokDQ+ixbb6MEE6BfjD32ie6X5Zd9jpps=;
  b=lNzvSsSPtE4jomS1BiMPRuBpx2HF2kSY1DiYWx/OqqkFfM4uT5nPloOy
   5XZjVWTfJidbJkcXQQKCUZYX/mPUbKNRPGIydbojNAPpatzIb/F2M6tpn
   iUtC/FXCkFf4adu4aN6Ijwj8VnRyoTvW1ghPClGMafmcxphjBwOq/rD+T
   zfsO0MoI27AM5pD2g8yrsZa+/rKKZ5WEZnUHSkLtiHOv0pdrYx04st0dL
   QNbAfoR3L86JEEbWSp59RI0+8I+VkoRtZQ8yEp/vyrEB9efRYRXHFgyET
   m+aWDzcTrbYfuielqr3YlELu4L0pVnzP/NHp8Doz0yMGQuis5/KKyFx7i
   Q==;
X-CSE-ConnectionGUID: uKrZ0KA0TbKD3CtfFUOrYQ==
X-CSE-MsgGUID: F/6ACO03QBedGIsg+rQmJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="30032013"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="30032013"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 09:20:58 -0700
X-CSE-ConnectionGUID: Wnukmcy9TS6oisULlfZ1kA==
X-CSE-MsgGUID: +203foodRn6saXOI2z72Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="113458440"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.108.232]) ([10.125.108.232])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 09:20:52 -0700
Message-ID: <a1721ede-6c51-429d-a820-85e11b21c441@intel.com>
Date: Thu, 31 Oct 2024 09:20:50 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/14] PCI/AER: Introduce 'struct cxl_err_handlers' and
 add to 'struct pci_driver'
To: Terry Bowman <terry.bowman@amd.com>, ming4.li@intel.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com
References: <20241025210305.27499-1-terry.bowman@amd.com>
 <20241025210305.27499-2-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20241025210305.27499-2-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/25/24 2:02 PM, Terry Bowman wrote:
> CXL.io provides PCIe like protocol error implementation, but CXL.io and
> PCIe have different handling requirements.
> 
> The PCIe AER service driver may attempt recovering PCIe devices with
> uncorrectable errors while recovery is not used for CXL.io. Recovery is not
> used in the CXL.io recovery because of the potential for corruption on
> what can be system memory.
> 
> Create pci_driver::cxl_err_handlers similar to pci_driver::error_handler.
> Create handlers for correctable and uncorrectable CXL.io error
> handling.
> 
> The CXL error handlers will be used in future patches adding CXL PCIe
> port protocol error handling.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  include/linux/pci.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 573b4c4c2be6..106ac83e3a7b 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -886,6 +886,14 @@ struct pci_error_handlers {
>  	void (*cor_error_detected)(struct pci_dev *dev);
>  };
>  
> +/* CXL bus error event callbacks */
> +struct cxl_error_handlers {
> +	/* CXL bus error detected on this device */
> +	bool (*error_detected)(struct pci_dev *dev);
> +
> +	/* Allow device driver to record more details of a correctable error */
> +	void (*cor_error_detected)(struct pci_dev *dev);
> +};
>  
>  struct module;
>  
> @@ -956,6 +964,7 @@ struct pci_driver {
>  	int  (*sriov_set_msix_vec_count)(struct pci_dev *vf, int msix_vec_count); /* On PF */
>  	u32  (*sriov_get_vf_total_msix)(struct pci_dev *pf);
>  	const struct pci_error_handlers *err_handler;
> +	const struct cxl_error_handlers *cxl_err_handler;
>  	const struct attribute_group **groups;
>  	const struct attribute_group **dev_groups;
>  	struct device_driver	driver;


