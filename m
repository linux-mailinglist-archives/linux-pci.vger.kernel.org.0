Return-Path: <linux-pci+bounces-30919-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04489AEB618
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 13:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 489C84A78D0
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 11:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFFD21D5AA;
	Fri, 27 Jun 2025 11:17:49 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49381A841C;
	Fri, 27 Jun 2025 11:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751023069; cv=none; b=GKzVI8yqjflz3psLpO7djU6iMIeFMVDOjBXec9pIGGKOfh8zmgOdWM2TajaTQfmOzF49NhIwTeA6j2bq7tHL92AD2YzV+1IQ28WDsWcbZgw98Z4U1E2lCTMTTFq9nYVJdJWWdDizOikAKmyohUoOKRXzSDvuMsN3CUZmfh9nNDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751023069; c=relaxed/simple;
	bh=pYtOo8dAH71teRjONxUGNZbvT2EjvrlL3tL+bsYFbQ8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W/9DbnKU4EJ+aKjjG3PFwfJePTFekk/BtWZaX8EoLUrvNP1FmDzO2hPKRWp52PbsdW0Vfenf0tWnEMxforv2deExiP6R7R2HDPU+bNqqcziIBKj1WRJS82ieOPyjjd0Gwgl9Dxxl9LzZSYnHCtfKbWSTBWHA5tvPDoGbgCG3wPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bTCgW5cmRz6M4W8;
	Fri, 27 Jun 2025 19:16:55 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 5960714011D;
	Fri, 27 Jun 2025 19:17:44 +0800 (CST)
Received: from localhost (10.48.153.213) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 27 Jun
 2025 13:17:43 +0200
Date: Fri, 27 Jun 2025 12:17:41 +0100
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
Subject: Re: [PATCH v10 09/17] cxl/pci: Map CXL Endpoint Port and CXL Switch
 Port RAS registers
Message-ID: <20250627121741.00002f2a@huawei.com>
In-Reply-To: <20250626224252.1415009-10-terry.bowman@amd.com>
References: <20250626224252.1415009-1-terry.bowman@amd.com>
	<20250626224252.1415009-10-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 26 Jun 2025 17:42:44 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> CXL Endpoint (EP) Ports may include Root Ports (RP) or Downstream Switch
> Ports (DSP). CXL RPs and DSPs contain RAS registers that require memory
> mapping to enable RAS logging. This initialization is currently missing and
> must be added for CXL RPs and DSPs.
> 
> Update cxl_dport_init_ras_reporting() to support RP and DSP RAS mapping.
> Add alongside the existing Restricted CXL Host Downstream Port RAS mapping.
> 
> Update cxl_endpoint_port_probe() to invoke cxl_dport_init_ras_reporting().
> This will initiate the RAS mapping for CXL RPs and DSPs when each CXL EP is
> created and added to the EP port.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

One trivial comment inline.  I'm not super confident that I follow exactly
what is going on here so more eyes needed.  However I think it's fine.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 021f35145c65..b52f82925891 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c

>  
> +static void cxl_switch_port_init_ras(struct cxl_port *port)
> +{
> +	if (is_cxl_root(to_cxl_port(port->dev.parent)))
> +		return;
> +
> +	/* May have upstream DSP or RP */
> +	if (port->parent_dport && dev_is_pci(port->parent_dport->dport_dev)) {

 A lot of port->parent_dport in here. Maybe a local variable for that with
a suitable name to describe that its the next port in the upstream direction.

> +		struct pci_dev *pdev = to_pci_dev(port->parent_dport->dport_dev);
> +
> +		if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) ||
> +		    (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM))
> +			cxl_dport_init_ras_reporting(port->parent_dport, &port->dev);
> +	}
> +
> +	cxl_uport_init_ras_reporting(port, &port->dev);
> +}
> +
> +static void cxl_endpoint_port_init_ras(struct cxl_port *port)
> +{
> +	struct cxl_dport *dport;
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
> +	struct cxl_port *parent_port __free(put_cxl_port) =
> +		cxl_mem_find_port(cxlmd, &dport);
> +
> +	if (!dport || !dev_is_pci(dport->dport_dev)) {
> +		dev_err(&port->dev, "CXL port topology not found\n");
> +		return;
> +	}
> +
> +	cxl_dport_init_ras_reporting(dport, cxlmd->cxlds->dev);
> +}
>

