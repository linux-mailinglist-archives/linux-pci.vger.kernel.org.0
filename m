Return-Path: <linux-pci+bounces-15639-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D33F9B688F
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 16:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51BC02866C7
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 15:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D616B213EF3;
	Wed, 30 Oct 2024 15:57:02 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2425D1F426F;
	Wed, 30 Oct 2024 15:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730303822; cv=none; b=oXMEd6adNJa6oUSrwLBornyAfx3QvGqcck1ScOWgEtfInW1eoqUGZhetQScWIGSfaHO0TWtxA5GB58/Xv7zHzSEES7xtHmCdiViHs9j0FDjL+loTUm21DPBsS2XvPNb4wPx/Vnec8teUPFlA6NlAKZPuxGp6lijqNegvAK0XhM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730303822; c=relaxed/simple;
	bh=lcdcICWIZgCkqKauCNeaI97hVgNLtvxkqm7Mte9DYXI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eUSH8o0HB9SZGemg6iV1O4pqHhHDtjbpGTwg0Tr9Ts+YnzlrQA7u/pBoOfyLvgZvjANvSaGSLc6CrJDTIHBy5FKbw70dVFAAZFwpxgvj0rkH0xMwvPkexlBiH8idGecD2+YsDJZop0cu6Sc7LewpvhU9Lik1TlJSquG40TA9fBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XdsBZ015Dz6K5yj;
	Wed, 30 Oct 2024 23:54:30 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 71259140158;
	Wed, 30 Oct 2024 23:56:55 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 30 Oct
 2024 16:56:54 +0100
Date: Wed, 30 Oct 2024 15:56:53 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <ira.weiny@intel.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH v2 10/14] cxl/pci: Map CXL PCIe upstream switch port RAS
 registers
Message-ID: <20241030155653.000079e9@Huawei.com>
In-Reply-To: <20241025210305.27499-11-terry.bowman@amd.com>
References: <20241025210305.27499-1-terry.bowman@amd.com>
	<20241025210305.27499-11-terry.bowman@amd.com>
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

On Fri, 25 Oct 2024 16:03:01 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> Add logic to map CXL PCIe upstream switch port (USP) RAS registers.
> 
> Introduce 'struct cxl_regs' member into 'struct cxl_port' to store a
> pointer to the upstream port's mapped RAS registers.
> 
> The upstream port may have multiple downstream endpoints. Before
> mapping AER registers check if the registers are already mapped.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>  drivers/cxl/core/pci.c | 17 +++++++++++++++++
>  drivers/cxl/cxl.h      |  4 ++++
>  drivers/cxl/mem.c      |  3 +++
>  3 files changed, 24 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 0bb61e39cf8f..53ca773557f3 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -773,6 +773,23 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>  	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
>  }
>  
> +void cxl_uport_init_ras_reporting(struct cxl_port *port)
> +{
> +	/* uport may have more than 1 downstream EP. Check if already mapped. */
> +	if (port->uport_regs.ras) {
> +		dev_warn(&port->dev, "RAS is already mapped\n");
As before, warn seems inappropriate from the comment.
> +		return;
> +	}
> +
> +	port->reg_map.host = &port->dev;
> +	if (cxl_map_component_regs(&port->reg_map, &port->uport_regs,
> +				   BIT(CXL_CM_CAP_CAP_ID_RAS))) {
> +		dev_err(&port->dev, "Failed to map RAS capability.\n");
> +		return;
> +	}
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_uport_init_ras_reporting, CXL);
> +


