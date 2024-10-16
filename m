Return-Path: <linux-pci+bounces-14676-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4109A1083
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 19:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13E6C1C22027
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 17:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F2018BB93;
	Wed, 16 Oct 2024 17:21:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6131212641;
	Wed, 16 Oct 2024 17:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729099277; cv=none; b=nrISeBmZBDC4t30SaPMCZZqkSiE8/AwMWkbwcXqK4CCEoCbBSyfKdPSJ+nOzBU1jAo/rP/swOgEA/NyDuQWNfvANH5DTAZ38ZxcHQWLASceNem+DTLXNF8HuA7M6eQd+GForcw21P7fYhYYkdTc46Xwd0VBGkJJKDRMbxL7NuNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729099277; c=relaxed/simple;
	bh=4FbU0E/CHSTfjUmrOg5/cvyBvQpN6UMJaVvsGY+WKqU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BwB+lo1/dscXMGUCNXnXQGpfsKLByWobv/Dz0WewUgMjkkHlo4UGkSoiUnUZBJprX2Rs2+sbc5M581xtp/5DjOz62dA2sTI2+WQzCkyZF7vrsHW5wLVE47EqogYMQDciZJ+6Fk16vrDY9+bsvjSzLejS3Hdd+he8zXs3UMpa0AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTHl65kvGz6J7GS;
	Thu, 17 Oct 2024 01:19:30 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7CF94140A46;
	Thu, 17 Oct 2024 01:21:12 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 16 Oct
 2024 19:21:11 +0200
Date: Wed, 16 Oct 2024 18:21:10 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <oohall@gmail.com>,
	<Benjamin.Cheatham@amd.com>, <rrichter@amd.com>, <nathan.fontenot@amd.com>,
	<smita.koralahallichannabasappa@amd.com>
Subject: Re: [PATCH 15/15] cxl/pci: Enable internal CE/UCE interrupts for
 CXL PCIe port devices
Message-ID: <20241016182110.00003455@Huawei.com>
In-Reply-To: <20241008221657.1130181-16-terry.bowman@amd.com>
References: <20241008221657.1130181-1-terry.bowman@amd.com>
	<20241008221657.1130181-16-terry.bowman@amd.com>
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
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 8 Oct 2024 17:16:57 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> The AER service drivers and CXL drivers are updated to handle PCIe
> port protocol errors. But, the PCIe AER correctable and uncorrectable
> internal errors are mask disabled for the PCIe port devices.
> 
> Enable the AER internal errors for CXL PCIe port devices.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

A while back I thought we had a discussion about just enabling these
for all devices and seeing if anyone screamed?

I'd love to do that rather than carefully enabling them for CXL devices
only ;)

If not, this looks fine to me.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/pci.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 4706113d2582..1d84a7022c4d 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -908,6 +908,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_port_err_detected, CXL);
>  
>  void cxl_uport_init_aer(struct cxl_port *port)
>  {
> +	struct pci_dev *pdev = to_pci_dev(port->uport_dev);
>  	/* uport may have more than 1 downstream EP. Check if already mapped. */
>  	if (port->uport_regs.ras) {
>  		dev_warn(&port->dev, "RAS is already mapped\n");
> @@ -920,12 +921,14 @@ void cxl_uport_init_aer(struct cxl_port *port)
>  		dev_err(&port->dev, "Failed to map RAS capability.\n");
>  		return;
>  	}
> +	pci_aer_unmask_internal_errors(pdev);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_uport_init_aer, CXL);
>  
>  void cxl_dport_init_aer(struct cxl_dport *dport)
>  {
>  	struct device *dport_dev = dport->dport_dev;
> +	struct pci_dev *pdev = to_pci_dev(dport_dev);
>  
>  	if (dport->rch) {
>  		struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport_dev);
> @@ -949,6 +952,7 @@ void cxl_dport_init_aer(struct cxl_dport *dport)
>  		dev_err(dport_dev, "Failed to map RAS capability.\n");
>  		return;
>  	}
> +	pci_aer_unmask_internal_errors(pdev);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_dport_init_aer, CXL);
>  


