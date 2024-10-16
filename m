Return-Path: <linux-pci+bounces-14662-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E72459A0F85
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 18:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C09C1F272AD
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 16:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631651C878B;
	Wed, 16 Oct 2024 16:22:44 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E2145008;
	Wed, 16 Oct 2024 16:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729095764; cv=none; b=NbZ+o/RfzsnK2YoKaX9biAuA+KCXroz1PuxSTTl1srBf7OcxO173L4MAuRo2IijkuQYUMkBhf6zlHqNh1ec/rV+zw3tMyJz+DULhL8OpjTy5fmElz4NSJva3YUS+xtGHminsDUhxcC4b6jILe3qbmbJ7u6yBYX0zDettlS7fCUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729095764; c=relaxed/simple;
	bh=MvQA7IS7CGySYRfDQZKf2ZKM0e6XoSwsxyFBT+rE0GY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iTBy0TApgBWr5YT5XcfAGclerQmF7yPyjiAVKheL3HtLyYksvfjIZnMFQrLAs1WSPDkznGZ/PMHv1ag4WVHwzjTbZ78FkxmUQfkhqA66gI97JaaDPqOqhCPKi6V/VJeqvM6ZNq9EF9w36PALazqdylkfzyVPswvV0V0FKO0QjYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTGRX4hTvz6G9Mj;
	Thu, 17 Oct 2024 00:20:56 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id E06081400C9;
	Thu, 17 Oct 2024 00:22:37 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 16 Oct
 2024 18:22:37 +0200
Date: Wed, 16 Oct 2024 17:22:35 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <oohall@gmail.com>,
	<Benjamin.Cheatham@amd.com>, <rrichter@amd.com>, <nathan.fontenot@amd.com>,
	<smita.koralahallichannabasappa@amd.com>
Subject: Re: [PATCH 04/15] cxl/aer/pci: Add CXL PCIe port correctable error
 support in AER service driver
Message-ID: <20241016172235.00001e65@Huawei.com>
In-Reply-To: <20241008221657.1130181-5-terry.bowman@amd.com>
References: <20241008221657.1130181-1-terry.bowman@amd.com>
	<20241008221657.1130181-5-terry.bowman@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 8 Oct 2024 17:16:46 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> The AER service driver currently does not manage CXL PCIe port
> protocol errors reported by CXL root ports, CXL upstream switch ports,
> and CXL downstream switch ports. Consequently, RAS protocol errors
> from CXL PCIe port devices are not properly logged or handled.
> 
> These errors are reported to the OS via the root port's AER correctable
> and uncorrectable internal error fields. While the AER driver supports
> handling downstream port protocol errors in restricted CXL host (RCH)
> mode also known as CXL1.1, it lacks the same functionality for CXL
> PCIe ports operating in virtual hierarchy (VH) mode, introduced in
> CXL2.0.
> 
> To address this gap, update the AER driver to handle CXL PCIe port
> device protocol correctable errors (CE).
> 
> The uncorrectable error handling (UCE) will be added in a future
> patch.
> 
> Make this update alongside the existing downstream port RCH error
> handling logic, extending support to CXL PCIe ports in VH.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Minor comments inline.

J
> ---
>  drivers/pci/pcie/aer.c | 54 +++++++++++++++++++++++++++++++++---------
>  1 file changed, 43 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index dc8b17999001..1c996287d4ce 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -40,6 +40,8 @@
>  #define AER_MAX_TYPEOF_COR_ERRS		16	/* as per PCI_ERR_COR_STATUS */
>  #define AER_MAX_TYPEOF_UNCOR_ERRS	27	/* as per PCI_ERR_UNCOR_STATUS*/
>  
> +#define CXL_DVSEC_PORT_EXTENSIONS	3

Duplicate of definition in drivers/cxl/cxlpci.h

Maybe wrap it up in an is_cxl_port() or similar? Or just 
move that to a header both places can exercise.


> +
>  struct aer_err_source {
>  	u32 status;			/* PCI_ERR_ROOT_STATUS */
>  	u32 id;				/* PCI_ERR_ROOT_ERR_SRC */
> @@ -941,6 +943,17 @@ static bool find_source_device(struct pci_dev *parent,
>  	return true;
>  }
>  
> +static bool is_pcie_cxl_port(struct pci_dev *dev)
> +{
> +	if ((pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT) &&
> +	    (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM) &&
> +	    (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM))
> +		return false;
> +
> +	return (!!pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
> +					    CXL_DVSEC_PORT_EXTENSIONS));

No need for the !! it will return the same without that clamping to 1/0
because any non 0 value is true.

> +}
> +

