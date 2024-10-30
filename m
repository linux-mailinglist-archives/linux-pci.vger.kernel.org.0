Return-Path: <linux-pci+bounces-15641-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 316DB9B68CA
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 17:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9C4A288330
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 16:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F77C2141C2;
	Wed, 30 Oct 2024 16:03:57 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A4F1F426F;
	Wed, 30 Oct 2024 16:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730304237; cv=none; b=CvEiOqA0YwrEVNbGj7qbX+03KgmQjur/BoLNrLvjhsaTK3RbgxY9SvqiPEb84/oE0sMj2YgjbZfeDwRs87zsQov/W2jHp0iulxkZypGl+rLjYzLxpdVThirwZp8+RLrS99Ilxrhn45AFY3yKyuU/b/818u4rHhRhf3k6JJPOK6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730304237; c=relaxed/simple;
	bh=MIFL21hA3B+jSnmLceMUs1JbFhcBmdo1m9jwxnwcY7U=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nOXNY4hy0gZSFEgMnR8HK6UGUV1J59z4l6PpxTqFcoIuW5wQi4tagFEhANOgL+2oEybzb+gtg2R6ilYZdpWzGAkIxCNTg1Oh3sBF8Qfa9VP8JHci34Hs1HEMKxut3AtTNyF2+BM214iTjo1m3NvUDupFT7iUQKTKjZPW/hoRvKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XdsHn1SJpz6GBVS;
	Wed, 30 Oct 2024 23:59:01 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7F4E01400D3;
	Thu, 31 Oct 2024 00:03:52 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 30 Oct
 2024 17:03:51 +0100
Date: Wed, 30 Oct 2024 16:03:49 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <ira.weiny@intel.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH v2 12/14] cxl/pci: Add error handler for CXL PCIe port
 RAS errors
Message-ID: <20241030160349.000040d4@Huawei.com>
In-Reply-To: <20241025210305.27499-13-terry.bowman@amd.com>
References: <20241025210305.27499-1-terry.bowman@amd.com>
	<20241025210305.27499-13-terry.bowman@amd.com>
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
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 25 Oct 2024 16:03:03 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> Introduce correctable and uncorrectable CXL PCIe port handlers.
> 
> Use the PCIe port's device object to find the matching port or
> downstream port in the CXL topology. The matching port or downstream
> port will include the cached RAS register block.
> 
> Invoke the existing __cxl_handle_ras() with the RAS registers as a
> parameter. __cxl_handle_ras() will log the RAS errors (if present)
> and clear the RAS status.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>  drivers/cxl/core/pci.c | 59 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index bb2fd7d04c4f..adb184d346ae 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -772,6 +772,65 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>  	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
>  }
>  
> +static int match_uport(struct device *dev, const void *data)
> +{
> +	struct device *uport_dev = (struct device *)data;
> +	struct cxl_port *port;
> +
> +	if (!is_cxl_port(dev))
> +		return 0;
> +
> +	port = to_cxl_port(dev);
> +
> +	return port->uport_dev == uport_dev;
> +}
> +
> +static void __iomem *cxl_pci_port_ras(struct pci_dev *pdev)
> +{
> +	struct cxl_port *port __free(put_cxl_port) = NULL;
> +	void __iomem *ras_base = NULL;
> +
> +	if (!pdev)
> +		return NULL;
> +
> +	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) ||
> +	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM)) {
> +		struct cxl_dport *dport;
> +
> +		port = find_cxl_port(&pdev->dev, &dport);

Scope of port is messy as the constructor and destructor
are not well associated. I'd drag a copy into each leg so they can
remain closer to each other.
Or don't use __free() as it's not adding much here.

> +		ras_base = dport ? dport->regs.ras : NULL;	
> +	} else if (pci_pcie_type(pdev) == PCI_EXP_TYPE_UPSTREAM) {
> +		struct device *port_dev;
> +
> +		port_dev = bus_find_device(&cxl_bus_type, NULL, &pdev->dev,
> +					   match_uport);
> +		if (!port_dev)
> +			return NULL;
> +
> +		port = to_cxl_port(port_dev);
> +		ras_base = port ? port->uport_regs.ras : NULL;
> +	}
> +
> +	return ras_base;
> +}
> +
> +static void cxl_port_cor_error_detected(struct pci_dev *pdev)
> +{
> +	void __iomem *ras_base = cxl_pci_port_ras(pdev);
> +
> +	__cxl_handle_cor_ras(&pdev->dev, ras_base);
> +}
> +
> +static bool cxl_port_error_detected(struct pci_dev *pdev)
> +{
> +	void __iomem *ras_base = cxl_pci_port_ras(pdev);
> +	bool ue;
> +
> +	ue = __cxl_handle_ras(&pdev->dev, ras_base);
> +
> +	return ue;
> +}
> +
>  void cxl_uport_init_ras_reporting(struct cxl_port *port)
>  {
>  	/* uport may have more than 1 downstream EP. Check if already mapped. */


