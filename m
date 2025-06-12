Return-Path: <linux-pci+bounces-29574-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97359AD78C4
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 19:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CA5318908D8
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 17:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161F419644B;
	Thu, 12 Jun 2025 17:16:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290EB2F431F;
	Thu, 12 Jun 2025 17:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749748578; cv=none; b=KeEPbTqXzMlEk+s4bZZqFgAiZHqdTcjQhV05lWhDrNzjx/RVacfY0ir11vt9Fw8f+eZdoiDHjiPW7G2UGz9jpz7MHsBj8Yn5n5CpfU7Avp4ohh/USlP4ychLdzJ/btM0mmEoTy8Sos3kCS95YFGlaF8r5GFLY19gUN2gvOM4Kvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749748578; c=relaxed/simple;
	bh=ek+3gPgVVci8MJm3C3SeQZ0h6zDD4SxndXVWxB3rYSs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iZUCesfCq7vh71b/qq69GDNrETiXmmbkryLdOJCtah1Pbiyy0KfPgsfb1BLFjt1OCHYGWf+hHVjVPkK2a0ki0prfhpUbQqFZU9Nq+XDi8AeUGyYz421iwMH2GivHvTfY3xBkCiYo0pa/aIoFi8+L2N6Gap8CWm78rIojkdWTITY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bJ8Fz0H0fz6L5DM;
	Fri, 13 Jun 2025 01:11:51 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 26F03140136;
	Fri, 13 Jun 2025 01:16:13 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 12 Jun
 2025 19:16:12 +0200
Date: Thu, 12 Jun 2025 18:16:10 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <PradeepVineshReddy.Kodamati@amd.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <bp@alien8.de>,
	<ming.li@zohomail.com>, <shiju.jose@huawei.com>, <dan.carpenter@linaro.org>,
	<Smita.KoralahalliChannabasappa@amd.com>, <kobayashi.da-06@fujitsu.com>,
	<yanfei.xu@intel.com>, <rrichter@amd.com>, <peterz@infradead.org>,
	<colyli@suse.de>, <uaisheng.ye@intel.com>,
	<fabio.m.de.francesco@linux.intel.com>, <ilpo.jarvinen@linux.intel.com>,
	<yazen.ghannam@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v9 14/16] cxl/pci: Remove unnecessary CXL Endpoint
 handling helper functions
Message-ID: <20250612181610.00004a79@huawei.com>
In-Reply-To: <20250603172239.159260-15-terry.bowman@amd.com>
References: <20250603172239.159260-1-terry.bowman@amd.com>
	<20250603172239.159260-15-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 3 Jun 2025 12:22:37 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> The CXL driver's cxl_handle_endpoint_cor_ras()/cxl_handle_endpoint_ras()
> are unnecessary helper functions used only for Endpoints. Remove these
> functions as they are not common for all CXL devices and do not provide
> value for EP handling.
> 
> Rename __cxl_handle_ras to cxl_handle_ras() and __cxl_handle_cor_ras()
> to cxl_handle_cor_ras().
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

If it looks like we are going to need a few more versions, maybe
drag this to front so Dave can pick it up and reduce size of the
patch set? This one is a good cleanup on it's own.

> ---
>  drivers/cxl/core/pci.c | 32 ++++++++++++--------------------
>  1 file changed, 12 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index b6836825e8df..b36a58607041 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -664,8 +664,8 @@ void read_cdat_data(struct cxl_port *port)
>  }
>  EXPORT_SYMBOL_NS_GPL(read_cdat_data, "CXL");
>  
> -static void __cxl_handle_cor_ras(struct device *dev, u64 serial,
> -				 void __iomem *ras_base)
> +static void cxl_handle_cor_ras(struct device *dev, u64 serial,
> +			       void __iomem *ras_base)
>  {
>  	void __iomem *addr;
>  	u32 status;
> @@ -684,11 +684,6 @@ static void __cxl_handle_cor_ras(struct device *dev, u64 serial,
>  	trace_cxl_aer_correctable_error(dev, serial, status);
>  }
>  
> -static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
> -{
> -	return __cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->serial, cxlds->regs.ras);
> -}
> -
>  /* CXL spec rev3.0 8.2.4.16.1 */
>  static void header_log_copy(void __iomem *ras_base, u32 *log)
>  {
> @@ -710,8 +705,8 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
>   * Log the state of the RAS status registers and prepare them to log the
>   * next error status. Return 1 if reset needed.
>   */
> -static pci_ers_result_t __cxl_handle_ras(struct device *dev, u64 serial,
> -					 void __iomem *ras_base)
> +static pci_ers_result_t cxl_handle_ras(struct device *dev, u64 serial,
> +				       void __iomem *ras_base)
>  {
>  	u32 hl[CXL_HEADERLOG_SIZE_U32];
>  	void __iomem *addr;
> @@ -746,11 +741,6 @@ static pci_ers_result_t __cxl_handle_ras(struct device *dev, u64 serial,
>  	return PCI_ERS_RESULT_PANIC;
>  }
>  
> -static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
> -{
> -	return __cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial, cxlds->regs.ras);
> -}
> -
>  #ifdef CONFIG_PCIEAER_CXL
>  
>  static void __iomem *cxl_get_ras_base(struct device *dev)
> @@ -802,7 +792,7 @@ void cxl_port_cor_error_detected(struct device *dev)
>  {
>  	void __iomem *ras_base = cxl_get_ras_base(dev);
>  
> -	__cxl_handle_cor_ras(dev, 0, ras_base);
> +	cxl_handle_cor_ras(dev, 0, ras_base);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_port_cor_error_detected, "CXL");
>  
> @@ -810,20 +800,20 @@ pci_ers_result_t cxl_port_error_detected(struct device *dev)
>  {
>  	void __iomem *ras_base = cxl_get_ras_base(dev);
>  
> -	return  __cxl_handle_ras(dev, 0, ras_base);
> +	return  cxl_handle_ras(dev, 0, ras_base);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_port_error_detected, "CXL");
>  
>  static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
>  					  struct cxl_dport *dport)
>  {
> -	return __cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->serial, dport->regs.ras);
> +	return cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->serial, dport->regs.ras);
>  }
>  
>  static bool cxl_handle_rdport_ras(struct cxl_dev_state *cxlds,
>  				       struct cxl_dport *dport)
>  {
> -	return __cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial, dport->regs.ras);
> +	return cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial, dport->regs.ras);
>  }
>  
>  /*
> @@ -921,7 +911,8 @@ void cxl_cor_error_detected(struct device *dev)
>  		if (cxlds->rcd)
>  			cxl_handle_rdport_errors(cxlds);
>  
> -		cxl_handle_endpoint_cor_ras(cxlds);
> +		cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->serial,
> +				   cxlds->regs.ras);
>  	}
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
> @@ -958,7 +949,8 @@ pci_ers_result_t cxl_error_detected(struct device *dev)
>  		 * chance the situation is recoverable dump the status of the RAS
>  		 * capability registers and bounce the active state of the memdev.
>  		 */
> -		ue = cxl_handle_endpoint_ras(cxlds);
> +		ue = cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial,
> +				    cxlds->regs.ras);
>  	}
>  
>  	return ue;


