Return-Path: <linux-pci+bounces-30916-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E57FAEB5F8
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 13:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58B154A51C5
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 11:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D522D3EC9;
	Fri, 27 Jun 2025 11:05:49 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D3729DB86;
	Fri, 27 Jun 2025 11:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751022349; cv=none; b=cqSpZGpHuCX7wAZPPA+QfYhwZYfBZG9wSS/ozmB/oDswavyoQbcFEk3SC9es6+3bM+dcEsU0PPtyb57Id4cYX5BHZK2LoSmWH7qSD9Yk4BqGTNk/U+kPEGv+Ovs/OpBlfmQSop7FjySsv4zd61HbabjhFco9XnSiY9jS4AyzZI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751022349; c=relaxed/simple;
	bh=dVaxlZR2NnqX9HVJNPgzIQOX2qLh/5lVHVRI7hu+OqA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ihKU1dNf1HJXLmbrvet8OBR1D+a3M7SL2U++4GlAD3necuP79vRvVRUpbAkqLJ7sMMvXaChcSUzj/kDu66HFMv0IwWF5YUdVNpMqqKHkmTpoqHcWbU8IGmwDjFoWEX+T3HAx5WFqSl/R1IUieqvehLhkdtYxYph3CmnDTgTHb+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bTCPg51DBz6M4WJ;
	Fri, 27 Jun 2025 19:04:55 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 40CBB14011D;
	Fri, 27 Jun 2025 19:05:44 +0800 (CST)
Received: from localhost (10.48.153.213) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 27 Jun
 2025 13:05:43 +0200
Date: Fri, 27 Jun 2025 12:05:41 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v10 07/17] CXL/PCI: Introduce CXL uncorrectable protocol
 error recovery
Message-ID: <20250627120541.00003a14@huawei.com>
In-Reply-To: <20250626224252.1415009-8-terry.bowman@amd.com>
References: <20250626224252.1415009-1-terry.bowman@amd.com>
	<20250626224252.1415009-8-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 26 Jun 2025 17:42:42 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> Create cxl_do_recovery() to provide uncorrectable protocol error (UCE)
> handling. Follow similar design as found in PCIe error driver,
> pcie_do_recovery(). One difference is cxl_do_recovery() will treat all UCEs
> as fatal with a kernel panic. This is to prevent corruption on CXL memory.
> 
> Export the PCI error driver's merge_result() to CXL namespace.

I think this may be a confusion from earlier review.  Anyhow, it should
be namespaced in the sense of not exporting something the vague name of
merge_result but it's PCI code, not CXL code and we don't have the dangerous
interface argument to justify putting it in the CXL namespace so I think
a namespaced EXPORT makes little sense for this one.

Jonathan


> Introduce
> PCI_ERS_RESULT_PANIC and add support in merge_result() routine. This will
> be used by CXL to panic the system in the case of uncorrectable protocol
> errors. PCI error handling is not currently expected to use the
> PCI_ERS_RESULT_PANIC.
> 
> Copy pci_walk_bridge() to cxl_walk_bridge(). Make a change to walk the
> first device in all cases.
> 
> Copy the PCI error driver's report_error_detected() to cxl_report_error_detected().
> Note, only CXL Endpoints and RCH Downstream Ports(RCH DSP) are currently
> supported. Add locking for PCI device as done in PCI's report_error_detected().
> This is necessary to prevent the RAS registers from disappearing before
> logging is completed.
> 
> Call panic() to halt the system in the case of uncorrectable errors (UCE)
> in cxl_do_recovery(). Export pci_aer_clear_fatal_status() for CXL to use
> if a UCE is not found. In this case the AER status must be cleared and
> uses pci_aer_clear_fatal_status().
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>


> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index de6381c690f5..63fceb3e8613 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -21,9 +21,12 @@
>  #include "portdrv.h"
>  #include "../pci.h"
>  
> -static pci_ers_result_t merge_result(enum pci_ers_result orig,
> -				  enum pci_ers_result new)
> +pci_ers_result_t merge_result(enum pci_ers_result orig,
> +			      enum pci_ers_result new)
>  {
> +	if (new == PCI_ERS_RESULT_PANIC)
> +		return PCI_ERS_RESULT_PANIC;
> +
>  	if (new == PCI_ERS_RESULT_NO_AER_DRIVER)
>  		return PCI_ERS_RESULT_NO_AER_DRIVER;
>  
> @@ -45,6 +48,7 @@ static pci_ers_result_t merge_result(enum pci_ers_result orig,
>  
>  	return orig;
>  }
> +EXPORT_SYMBOL_NS_GPL(merge_result, "CXL"); 

Do we care about namespacing this?  I think not given it is PCIe code
and hardly destructive for other drivers to mess with it if they like.

I would namespace it in the sense of renaming it to make it clear
it's about pci errors though.

pci_ers_merge_result() perhaps?

Do that as a percursor patch.


>  
>  static int report_error_detected(struct pci_dev *dev,
>  				 pci_channel_state_t state,


