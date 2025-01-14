Return-Path: <linux-pci+bounces-19724-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDD0A10599
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 12:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E825B1679AE
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 11:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE265229614;
	Tue, 14 Jan 2025 11:39:13 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCA61EA80;
	Tue, 14 Jan 2025 11:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736854753; cv=none; b=peZThufD5YqwdTbwwrMpIkXC2ZDv8syjbxsde6Np6cXNkMsc0XIHcLaqC37pxXJ9uEbgJ44sGKOvoDk7CrCHGdpia9e0SiUV3T86xn50msAjF6vS4kkSW7+w2Xp65Dewz3PrCkhPyrMQKg5NQnu/mDIC9a/5PiZTeyC1my+6Jro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736854753; c=relaxed/simple;
	bh=nmOs7pBtHNjQpn0UdeNX2UGSJjfgcef8XjYMSPpNmSA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=arLyTwRE/HIhR/t11h/eu+W2na70JcX9mnC5HHU6mWVjmfID5RB1yaZnNSasbbhLnkpQ3tPSv6q/ht9BlCWG0gKhtJ8d7gqTZV5fd1PDuE2LlGUlEcPvrS4g9jY5bR6bY1JD5lvYax1MJpiOmZe6cwOYrjhwD2dD3+nloIg442c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YXRtt0NY4z6M4Mm;
	Tue, 14 Jan 2025 19:37:26 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 9A31414022E;
	Tue, 14 Jan 2025 19:39:09 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 14 Jan
 2025 12:39:08 +0100
Date: Tue, 14 Jan 2025 11:39:07 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <ira.weiny@intel.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<lukas@wunner.de>, <ming.li@zohomail.com>,
	<PradeepVineshReddy.Kodamati@amd.com>, <alucerop@amd.com>
Subject: Re: [PATCH v5 10/16] cxl/pci: Update RAS handler interfaces to also
 support CXL PCIe Ports
Message-ID: <20250114113907.00000e1a@huawei.com>
In-Reply-To: <20250107143852.3692571-11-terry.bowman@amd.com>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
	<20250107143852.3692571-11-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 7 Jan 2025 08:38:46 -0600
Terry Bowman <terry.bowman@amd.com> wrote:

> CXL PCIe Port Protocol Error handling support will be added to the
> CXL drivers in the future. In preparation, rename the existing
> interfaces to support handling all CXL PCIe Port Protocol Errors.
> 
> The driver's RAS support functions currently rely on a 'struct
> cxl_dev_state' type parameter, which is not available for CXL Port
> devices. However, since the same CXL RAS capability structure is
> needed across most CXL components and devices, a common handling
> approach should be adopted.
> 
> To accommodate this, update the __cxl_handle_cor_ras() and
> __cxl_handle_ras() functions to use a `struct device` instead of
> `struct cxl_dev_state`.
> 
> No functional changes are introduced.
> 
> [1] CXL 3.1 Spec, 8.2.4 CXL.cache and CXL.mem Registers
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Alejandro Lucero <alucerop@amd.com>
A few protections you introduce in later patches should be here
to make the change to dev safer.

Otherwise looks fine.

Jonathan

> ---
>  drivers/cxl/core/pci.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 97e6a15bea88..5699ee5b29df 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -650,7 +650,7 @@ void read_cdat_data(struct cxl_port *port)
>  }
>  EXPORT_SYMBOL_NS_GPL(read_cdat_data, "CXL");
>  
> -static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
> +static void __cxl_handle_cor_ras(struct device *dev,
>  				 void __iomem *ras_base)
>  {
>  	void __iomem *addr;
> @@ -663,13 +663,13 @@ static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
>  	status = readl(addr);
>  	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
>  		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> -		trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
> +		trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);

I'd expect the protection on the dev being a memdev to be in this patch
given the relaxation on the interface.  Pull that bit forward form patch 14.


>  	}
>  }
>  
>  static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
>  {
> -	return __cxl_handle_cor_ras(cxlds, cxlds->regs.ras);
> +	return __cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
>  }
>  
>  /* CXL spec rev3.0 8.2.4.16.1 */
> @@ -693,8 +693,7 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
>   * Log the state of the RAS status registers and prepare them to log the
>   * next error status. Return 1 if reset needed.
>   */
> -static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
> -				  void __iomem *ras_base)
> +static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>  {
>  	u32 hl[CXL_HEADERLOG_SIZE_U32];
>  	void __iomem *addr;
> @@ -721,7 +720,7 @@ static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
>  	}
>  
>  	header_log_copy(ras_base, hl);
> -	trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe, hl);
> +	trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
>  	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);

As above.  If the interface takes a dev we need to check it is the right
type of dev.

>  
>  	return true;
> @@ -729,7 +728,7 @@ static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
>  
>  static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
>  {
> -	return __cxl_handle_ras(cxlds, cxlds->regs.ras);
> +	return __cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
>  }
>  
>  #ifdef CONFIG_PCIEAER_CXL
> @@ -818,13 +817,13 @@ EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
>  static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
>  					  struct cxl_dport *dport)
>  {
> -	return __cxl_handle_cor_ras(cxlds, dport->regs.ras);
> +	return __cxl_handle_cor_ras(&cxlds->cxlmd->dev, dport->regs.ras);
>  }
>  
>  static bool cxl_handle_rdport_ras(struct cxl_dev_state *cxlds,
>  				       struct cxl_dport *dport)
>  {
> -	return __cxl_handle_ras(cxlds, dport->regs.ras);
> +	return __cxl_handle_ras(&cxlds->cxlmd->dev, dport->regs.ras);
>  }
>  
>  /*


