Return-Path: <linux-pci+bounces-9015-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D6B910587
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 15:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E5F51C20F5A
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 13:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6241ACE89;
	Thu, 20 Jun 2024 13:11:49 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801A81ACE81;
	Thu, 20 Jun 2024 13:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718889109; cv=none; b=m0Bb3j5Aa9OT85ywEk4/pAqI91Fu+GHuCo2A9rzlXAXGKfUxIXF/IUtq/LEBKRll8cHqzaFGgTljMSY/FXCYqQItsffthKpYB4IB84zoa8MnGj6B5mIzWbp5oZpXFK+onO9RtQ45P7lMF+mcGBgib23WyF4OkMeVTuh1UP2t+B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718889109; c=relaxed/simple;
	bh=KquCfc0e5jrKrmjpwVd+GhjdiZ1fZXcuvxYZaZ8SeLg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NKtyq8Xo+wvo0BcT3tkhzmPF5G9bORA6WVUdMs1yLfCEpz/9eC+NXxhzAzFVvq7QcysQjKuDqK2q+mR/CgCioSXxuzifUx8xkoHYD3ePQPWvwvvtN/hTWEbRAVsYt3wwVf1i9cc18atqVbE7GmwnYGUimQ7gtAK1R7QXlRuXGP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W4gnt4GWqz6K9TT;
	Thu, 20 Jun 2024 21:10:10 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id CA89C14058E;
	Thu, 20 Jun 2024 21:11:43 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 20 Jun
 2024 14:11:43 +0100
Date: Thu, 20 Jun 2024 14:11:42 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>, <ming4.li@intel.com>,
	<vishal.l.verma@intel.com>, <jim.harris@samsung.com>,
	<ilpo.jarvinen@linux.intel.com>, <ardb@kernel.org>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Yazen.Ghannam@amd.com>,
	<Robert.Richter@amd.com>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>
Subject: Re: [RFC PATCH 8/9] PCI/AER: Export
 pci_aer_unmask_internal_errors()
Message-ID: <20240620141142.00005cf0@Huawei.com>
In-Reply-To: <20240617200411.1426554-9-terry.bowman@amd.com>
References: <20240617200411.1426554-1-terry.bowman@amd.com>
	<20240617200411.1426554-9-terry.bowman@amd.com>
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
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 17 Jun 2024 15:04:10 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> AER correctable internal errors (CIE) and AER uncorrectable internal
> errors (UIE) are disabled through the AER mask register by default.[1]
> 
> CXL PCIe ports use the CIE/UIE to report RAS errors and as a result
> need CIE/UIE enabled.[2]
> 
> Change pci_aer_unmask_internal_errors() function to be exported for
> the CXL driver and other drivers to use.

I've perhaps forgotten the end conclusion, but I thought there was
a request to just try enabling this in general and mask it out only
for known broken devices?

Admittedly that's a more daring path, so maybe I hallucinated it!

> 
> [1] PCI6.0 - 7.8.4.3 Uncorrectable
> [2] CXL3.1 - 12.2.2 CXL Root Ports, Downstream Switch Ports, and Upstream
>              Switch Ports
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> ---
>  drivers/pci/pcie/aer.c | 3 ++-
>  include/linux/aer.h    | 6 ++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 4dc03cb9aff0..d7a1982f0c50 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -951,7 +951,7 @@ static bool find_source_device(struct pci_dev *parent,
>   * Note: AER must be enabled and supported by the device which must be
>   * checked in advance, e.g. with pcie_aer_is_native().
>   */
> -static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
> +void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>  {
>  	int aer = dev->aer_cap;
>  	u32 mask;
> @@ -964,6 +964,7 @@ static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>  	mask &= ~PCI_ERR_COR_INTERNAL;
>  	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
>  }
> +EXPORT_SYMBOL_GPL(pci_aer_unmask_internal_errors);
>  
>  static bool is_cxl_mem_dev(struct pci_dev *dev)
>  {
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index 4b97f38f3fcf..a4fd25ea0280 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -50,6 +50,12 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>  static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>  #endif
>  
> +#ifdef CONFIG_PCIEAER_CXL
> +void pci_aer_unmask_internal_errors(struct pci_dev *dev);
> +#else
> +static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
> +#endif
> +
>  void pci_print_aer(struct pci_dev *dev, int aer_severity,
>  		    struct aer_capability_regs *aer);
>  int cper_severity_to_aer(int cper_severity);


