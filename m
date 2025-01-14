Return-Path: <linux-pci+bounces-19726-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32685A105CC
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 12:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6438F1886F37
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 11:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF37224D6;
	Tue, 14 Jan 2025 11:46:30 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFDB234CE0;
	Tue, 14 Jan 2025 11:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736855190; cv=none; b=FIUWPS41Bw36NoO6YVcrPkcaLcZPFZoEILzwy/2PE0vBUE0Pi2MIhAkBqdmeGLWiSkQQT3oYcevAa4wsBdUwF8hX38WWVBFDff87emGcg2I/y/+kJyUeZ/w/Jp+eg4BV5zKqO4VZ3DuLuAy/82lCCZFCmRNM9R3j96gyjs3hiZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736855190; c=relaxed/simple;
	bh=lwGJWsu4RM6fGqu8erF8lK/vr0xR6ZiYV8NemhmnHtU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LrDmHS5wQEhq40dEhYpcheV8cJx3cn0CAZlSXbqfHc5sMieYRp7tJYC350mz+yI08FVU+F5eBKM02I/CupD2iAjew3YJh9un63uB7omXUg2879saCql9IXDut/GPho0L9e19BAhe8nFX2AA7lm1EL6Vq9sgGIodL75krU1rHs+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YXRzb5d2Vz6K9H0;
	Tue, 14 Jan 2025 19:41:31 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id F2EC5140A86;
	Tue, 14 Jan 2025 19:46:23 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 14 Jan
 2025 12:46:23 +0100
Date: Tue, 14 Jan 2025 11:46:21 +0000
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
Subject: Re: [PATCH v5 13/16] cxl/pci: Add error handler for CXL PCIe Port
 RAS errors
Message-ID: <20250114114621.00007c08@huawei.com>
In-Reply-To: <20250107143852.3692571-14-terry.bowman@amd.com>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
	<20250107143852.3692571-14-terry.bowman@amd.com>
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

On Tue, 7 Jan 2025 08:38:49 -0600
Terry Bowman <terry.bowman@amd.com> wrote:

> Introduce correctable and uncorrectable CXL PCIe Port Protocol Error
> handlers.
> 
> The handlers will be called with a 'struct pci_dev' parameter
> indicating the CXL Port device requiring handling. The CXL PCIe Port
> device's underlying 'struct device' will match the port device in the
> CXL topology.
> 
> Use the PCIe Port's device object to find the matching CXL Upstream Switch
> Port, CXL Downstream Switch Port, or CXL Root Port in the CXL topology. The
> matching CXL Port device should contain a cached reference to the RAS
> register block. The cached RAS block will be used handling the error.
> 
> Invoke the existing __cxl_handle_ras() or __cxl_handle_cor_ras() using
> a reference to the RAS registers as a parameter. These functions will use
> the RAS register reference to indicate an error and clear the device's RAS
> status.
> 
> Future patches will assign the error handlers and add trace logging.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>  drivers/cxl/core/pci.c | 63 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 8275b3dc3589..411834f7efe0 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -776,6 +776,69 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>  	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
>  }
>  
> +static int match_uport(struct device *dev, const void *data)
> +{
> +	struct device *uport_dev = (struct device *)data;

It should be const and then no need to cast explicitly.


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
> +	struct cxl_port *port;
> +
> +	if (!pdev)
> +		return NULL;
> +
> +	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) ||
> +	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM)) {
> +		struct cxl_dport *dport;
> +		void __iomem *ras_base;
> +
> +		port = find_cxl_port(&pdev->dev, &dport);
Maybe some __free magic on port as then can just
return dport ? dport->regs.ras : NULL;
> +		ras_base = dport ? dport->regs.ras : NULL;
> +		if (port)
> +			put_device(&port->dev);
> +		return ras_base;
> +	} else if (pci_pcie_type(pdev) == PCI_EXP_TYPE_UPSTREAM) {

	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_UPSTREAM) {

or maybe just make it a switch statement?

> +		struct device *port_dev;
> +
> +		port_dev = bus_find_device(&cxl_bus_type, NULL, &pdev->dev,
> +					   match_uport);
Likewise on __free magic to automate the put.

> +		if (!port_dev)
> +			return NULL;
> +
> +		port = to_cxl_port(port_dev);
> +		if (!port)

why no put of the port_dev?

> +			return NULL;
> +
> +		put_device(port_dev);
> +		return port->uport_regs.ras;
> +	}
> +
> +	return NULL;
> +}


