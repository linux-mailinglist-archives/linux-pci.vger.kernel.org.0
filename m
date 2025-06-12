Return-Path: <linux-pci+bounces-29573-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD78FAD78C2
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 19:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2B7818908D8
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 17:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDAD29B782;
	Thu, 12 Jun 2025 17:14:54 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F68629B233;
	Thu, 12 Jun 2025 17:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749748493; cv=none; b=fgpz8R1to7q1oamZVfw47IUnKzS5T6hT5l8LuwUuawbCXhSK7n8p3B5vzUVLFPOD3P+zcwmQqe6r54iEiZ7b2JVRZORvZ5Xn923ip29zPgSDya4uL2u5Cm5Ej2ejqH5/moMYjkJ2NMXuAKAVZG73CRMm7cpNjwtd1/HiDzP6VZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749748493; c=relaxed/simple;
	bh=a/DmHSUxAaSma9fEE56lTM1/l7sFwT3JuveXOPQiRS4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AXGy+SckDXIwzzWvpJ1OEpMlkUUzp10cgkbF9+Lbqij238m3ALd6wEDOL/836D8EJg7iEEARtwpnQ8qWVNxo+GowJZUDk86qSgRYumeC1JrURB4wjatX2W0afK+ohsj8BzqQvXrRy5MNEEHjnmbKYynldcQJ4OeHTCydZ2Ty1lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bJ8DK4zxMz6L56K;
	Fri, 13 Jun 2025 01:10:25 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C7CC014010C;
	Fri, 13 Jun 2025 01:14:47 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 12 Jun
 2025 19:14:46 +0200
Date: Thu, 12 Jun 2025 18:14:45 +0100
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
Subject: Re: [PATCH v9 13/16] cxl/pci: Introduce CXL Port protocol error
 handlers
Message-ID: <20250612181445.000045ab@huawei.com>
In-Reply-To: <20250603172239.159260-14-terry.bowman@amd.com>
References: <20250603172239.159260-1-terry.bowman@amd.com>
	<20250603172239.159260-14-terry.bowman@amd.com>
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

On Tue, 3 Jun 2025 12:22:36 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> Introduce CXL error handlers for CXL Port devices.
> 
> Add functions cxl_port_cor_error_detected() and cxl_port_error_detected().
> These will serve as the handlers for all CXL Port devices. Introduce
> cxl_get_ras_base() to provide the RAS base address needed by the handlers.
> 
> Update cxl_handle_prot_error() to call the CXL Port or CXL Endpoint handler
> depending on which CXL device reports the error.
> 
> Implement pci_get_ras_base() to return the cached RAS register address of a
> CXL Root Port, CXL Downstream Port, or CXL Upstream Port.
> 
> Update the AER driver's is_cxl_error() to remove the filter PCI type check
> because CXL Port devices are now supported.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

A few minor things on a fresh read.

>  size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index e094ef518e0a..b6836825e8df 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -753,6 +753,67 @@ static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
>  
>  #ifdef CONFIG_PCIEAER_CXL
>  
> +static void __iomem *cxl_get_ras_base(struct device *dev)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	void __iomem *ras_base;
> +
> +	switch (pci_pcie_type(pdev)) {
> +	case PCI_EXP_TYPE_ROOT_PORT:
> +	case PCI_EXP_TYPE_DOWNSTREAM:
> +	{
> +		struct cxl_dport *dport = NULL;
> +		struct cxl_port *port __free(put_cxl_port) = find_cxl_port(&pdev->dev, &dport);
> +
> +		if (!dport || !dport->dport_dev) {
> +			pci_err(pdev, "Failed to find the CXL device");
> +			return NULL;
> +		}
> +
> +		ras_base = dport ? dport->regs.ras : NULL;
As below - perhaps a sanity check for error and early return makes sense here.

> +		break;
> +	}
> +	case PCI_EXP_TYPE_UPSTREAM:
> +	{
> +		struct cxl_port *port;
> +		struct device *dev __free(put_device) = bus_find_device(&cxl_bus_type, NULL,
> +									&pdev->dev, match_uport);
> +
> +		if (!dev || !is_cxl_port(dev)) {
> +			pci_err(pdev, "Failed to find the CXL device");
> +			return NULL;
> +		}
> +
> +		port = to_cxl_port(dev);
> +		ras_base = port ? port->uport_regs.ras : NULL;

I'd be tempted to return here to keep the flows simple.  Maybe avoiding the ternary
		if (!port)
			return NULL;

		return port->uport_regs.ras;


> +		break;
> +	}
> +	default:
> +	{
> +		pci_warn_once(pdev, "Error: Unsupported device type (%X)", pci_pcie_type(pdev));
> +		return NULL;

Better not to introduce scope {} when not needed.

> +	}
> +	}
> +
> +	return ras_base;
> +}

> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 664f532cc838..6093e70ece37 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c

> +
> +/* Return 'struct device*' responsible for freeing pdev's CXL resources */
> +static struct device *get_pci_cxl_host_dev(struct pci_dev *pdev)
> +{
> +	struct device *host_dev;
> +
> +	switch (pci_pcie_type(pdev)) {
> +	case PCI_EXP_TYPE_ROOT_PORT:
> +	case PCI_EXP_TYPE_DOWNSTREAM:
> +	{
> +		struct cxl_dport *dport = NULL;
> +		struct cxl_port *port = find_cxl_port(&pdev->dev, &dport);
> +
> +		if (!dport || !dport->dport_dev)

What does !dport->dprot_dev mean?  I.e. how does that happen?
I can only find places where we set it just after allocating a dport.
Perhaps a comment?



> +			return NULL;
> +
> +		host_dev = &port->dev;
> +		break;
> +	}
> +	case PCI_EXP_TYPE_UPSTREAM:
> +	{
> +		struct cxl_port *port;
> +		struct device *cxl_dev = bus_find_device(&cxl_bus_type, NULL,
> +							 &pdev->dev, match_uport);

Doesn't his leave you holding a reference to a device different form
the one you return? Hence wrong one gets put in caller.

> +
> +		if (!cxl_dev || !is_cxl_port(cxl_dev))
> +			return NULL;
> +
> +		port = to_cxl_port(cxl_dev);
> +		host_dev = &port->dev;
Actually no. Isn't this a circle that lands you on cxl_dev again?

		container_of(dev, struct cxl_port, dev)->dev

> +		break;
> +	}
> +	case PCI_EXP_TYPE_ENDPOINT:
> +	case PCI_EXP_TYPE_RC_END:
> +	{
> +		struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> +
> +		if (!cxlds)
> +			return NULL;
> +
> +		host_dev = get_device(&cxlds->cxlmd->dev);
> +		break;

Maybe just return it here? Similar for other cases.
Saves a reader keeping track of references if we get them roughly where
we return them.

> +	}
> +	default:
> +	{
No need for scope on this one (or at least some of the others) so drop the {}

> +		pci_warn_once(pdev, "Error: Unsupported device type (%X)", pci_pcie_type(pdev));
> +		return NULL;
> +	}
> +	}
> +
> +	return host_dev;
> +}
> +
> +static int cxl_report_error_detected(struct pci_dev *pdev, void *data)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device *host_dev __free(put_device) = get_pci_cxl_host_dev(pdev);
> +	pci_ers_result_t vote, *result = data;
>  
>  	device_lock(&pdev->dev);
> -	vote = cxl_error_detected(&pdev->dev);
> +	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT) ||
> +	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END)) {
> +		vote = cxl_error_detected(dev);
> +	} else {
> +		vote = cxl_port_error_detected(dev);
> +	}
>  	*result = cxl_merge_result(*result, vote);
>  	device_unlock(&pdev->dev);
>  
> @@ -244,14 +309,18 @@ static struct pci_dev *sbdf_to_pci(struct cxl_prot_error_info *err_info)
>  static void cxl_handle_prot_error(struct cxl_prot_error_info *err_info)
>  {
>  	struct pci_dev *pdev __free(pci_dev_put) = pci_dev_get(sbdf_to_pci(err_info));
> -	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> -	struct device *cxlmd_dev __free(put_device) = get_device(&cxlds->cxlmd->dev);
>  
>  	if (!pdev) {
>  		pr_err("Failed to find the CXL device\n");
>  		return;
>  	}
>  
> +	struct device *host_dev __free(put_device) = get_pci_cxl_host_dev(pdev);
> +	if (!host_dev) {
> +		pr_err("Failed to find the CXL device's host\n");
> +		return;
> +	}
> +


