Return-Path: <linux-pci+bounces-18212-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E39D29EDD86
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 03:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9039416650D
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 02:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9797DA8C;
	Thu, 12 Dec 2024 02:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="FZXt78SX"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-o92.zoho.com (sender4-pp-o92.zoho.com [136.143.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E93813AA20;
	Thu, 12 Dec 2024 02:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733969988; cv=pass; b=kyxMoidPucNypHhQwcQ+eArrIOjHHTg8VhTwuwtvr++7NUqCIZFCcWzFLHMpTMsOAv9cJZgnVienwGHjOWa7ZCSLw3vpYuNHAeppMstDLZgC32LRrTcLfd5XYZIwyt2DxY6QVuOHZWIuCL2/Kb/AcEx742IRfMbOpsb4mmteikA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733969988; c=relaxed/simple;
	bh=QPVmKbqFD+ZBCnWGXF58PWMNDZfaSkGKql4/+TfsO9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UGq7I3dCH+87Q5aFscxv4OiYXsUrAE/KKzzDp9oGEc46cJWyog1Ym3TtOz4jEyhTi6uq+VsfPXxB6ILLEQz+p35odpWRtEcuIZ56h34fgjziQr9AQhdPtTrsnlxeWqwAOYWY0zYlmaSPhVrWNKSfvJlzBQ0QfgbeCgscjR8VKgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=FZXt78SX; arc=pass smtp.client-ip=136.143.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1733969966; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NW/+2sE2YZ91T13gpe01l8+xL4DPeSi5fibMF6MiEzP2cPlGa+KrEm++tlkwWyU7RkXdPvW8RLSB53N4aubxgb2m7s1nAV2GZl95DoG7PdNgoQAP5GHkQHs3qDzgg1x0DtYSHQr09ZmANQQhbvzsqgkjdBTLhaDIdZ3E9p1iWqE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1733969966; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=1CmRQYWQH5cZEG1iv6rm4RsKOtMnh3YorKEU0Fe4YIA=; 
	b=Fi2rgE9AP5z8NjbIzuebj52Jgp2/WZJNd3c9nQe6Bk1ou/Ylc/nZ59ijTCtIag4bRkB04rUh3GzpZj3y+o+DJ8ik0U+4KJqwZM2FpBu4vvZhCTRGZ8XpYPewxYv4ZDw4/WgyUeZBssR4gpkmz+PxELPv7/0gAsY4UE5yb+RUyCM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733969966;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To:Cc;
	bh=1CmRQYWQH5cZEG1iv6rm4RsKOtMnh3YorKEU0Fe4YIA=;
	b=FZXt78SXHiqvScMdw4+3/BfwiWZYp9t9f1frUuAwf0C+Gz4IFwzxN3SYbTDYlLMh
	WeEiZB4tnw8NAI73r6zBYQQU/V1pNJmX0yyIWkLpsTp+gx4oERa+I43IgyJUUivnU+C
	raWoLINXmhBddR3300KX8J+KzcsIKQ1zBtnG/36c=
Received: by mx.zohomail.com with SMTPS id 1733969965267836.7884091257791;
	Wed, 11 Dec 2024 18:19:25 -0800 (PST)
Message-ID: <74701c17-ac1d-4ae3-a4a7-18668322c4b2@zohomail.com>
Date: Thu, 12 Dec 2024 10:19:19 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/15] cxl/pci: Add error handler for CXL PCIe Port RAS
 errors
To: Terry Bowman <terry.bowman@amd.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nifan.cxl@gmail.com, ming4.li@intel.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
 PradeepVineshReddy.Kodamati@amd.com
References: <20241211234002.3728674-1-terry.bowman@amd.com>
 <20241211234002.3728674-13-terry.bowman@amd.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20241211234002.3728674-13-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr08011227d4c3de192d64bc18a62e61390000c179fc2b3607bcc824a48790af7393ceaf158a2e3b62a05ad9:zu080112271c69f0236998054652cf95fa0000fe40288b96694c3d5ad004144140e23a8eda6a5d821ff91dd8:rf0801122ba3daca91443f6b54b3219ebf00004b7f8666d048d343fcc70c24f2cbd806c2ee498775bbe4251697e35f46:ZohoMail
X-ZohoMailClient: External

On 12/12/2024 7:39 AM, Terry Bowman wrote:
> Introduce correctable and uncorrectable CXL PCIe port protocol error
> handlers.
>
> The handlers will be called with a 'struct pci_dev' parameter
> indicating the CXL Port device requiring handling. The CXL PCIe Port
> device's underlying 'struct device' will match the Port device in the
> CXL topology.
>
> Use the PCIe Port's device object to find the matching Upstream Switch
> Port, Downstream Switch Port, or Root Port in the CXL topology. The
> matching device will contain a reference to the RAS register block used to
> handle and log the error.
>
> Invoke the existing __cxl_handle_ras() or __cxl_handle_cor_ras() passing
> a reference to the RAS registers as a parameter. These functions will use
> the register reference to clear the device's RAS status.
>
> Future patches will assign the error handlers and add trace logging.
>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>  drivers/cxl/core/pci.c | 61 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 89f8d65d71ce..52afaedf5171 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -772,6 +772,67 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
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
> +	void __iomem *ras_base;
> +	struct cxl_port *port;
> +
> +	if (!pdev)
> +		return NULL;
> +
> +	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) ||
> +	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM)) {
> +		struct cxl_dport *dport;
> +
> +		port = find_cxl_port(&pdev->dev, &dport);
> +		ras_base = dport ? dport->regs.ras : NULL;
> +		if (port)
> +			put_device(&port->dev);
> +		return ras_base;
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

I think that is no need to check 'port', just directly use 'ras_base = port->uport_regs.ras;', because match_uport() already checks it, returned port_dev must be a port.


Ming


