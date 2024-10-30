Return-Path: <linux-pci+bounces-15634-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F363A9B6834
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 16:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82270B240E4
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 15:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497B321314E;
	Wed, 30 Oct 2024 15:45:45 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A241990C5;
	Wed, 30 Oct 2024 15:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730303145; cv=none; b=uOv9Saft/AH4OtgSkeusWgdW1s/aA6L2RW/+JvSNTyjv2rN+52DzqYC3PKjcWfxmfILCVgkGC5esv8mfgbpmf0KQN4plR3TkrTHgDd/UIe5H0N/8i0dZslO7QJaMX3a6h+maYvWMYeR+ENmJiIGsgkZbHJO+AWlayWYY4wNliDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730303145; c=relaxed/simple;
	bh=rsME5Vtg9NwmL1hNC+wYulcyxWLemaHEv/m3v2exxvE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cEIQqymQbe/KL/r82NeME/WBSQtwGPN3kPqPNLaWM165xATVHbUjrmm3M1COKCLxdYh7JRXGzlL4/P0+hyEZKAmmGgAi/+c9tXgaFkwrk/3SO5ZCXU1nD1phR1d2VpocjcAkinxUIYvvwd5oqoLsGZiSksgqsZ2ZQY5FBlu68FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xdrtl2nkBz67cSV;
	Wed, 30 Oct 2024 23:40:47 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A3CCB1404F9;
	Wed, 30 Oct 2024 23:45:38 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 30 Oct
 2024 16:45:37 +0100
Date: Wed, 30 Oct 2024 15:45:36 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <ira.weiny@intel.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH v2 08/14] cxl/pci: Change find_cxl_ports() to non-static
Message-ID: <20241030154536.00006f9a@Huawei.com>
In-Reply-To: <20241025210305.27499-9-terry.bowman@amd.com>
References: <20241025210305.27499-1-terry.bowman@amd.com>
	<20241025210305.27499-9-terry.bowman@amd.com>
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

On Fri, 25 Oct 2024 16:02:59 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

Typo in title. Shouldn't be plural ports.


> CXL PCIe port protocol error support will be added in the future. This
> requires searching for a CXL PCIe port device in the CXL topology as
> provided by find_cxl_port(). But, find_cxl_port() is defined static
> and as a result is not callable outside of this source file.
> 
> Update the find_cxl_port() declaration to be non-static.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Doesn't hugely matter but I'd do this later in the series as it's
not used until patch 12 (I think) and by then reviewers may have forgotten what
it is for.

Fine otherwise,

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/core.h | 3 +++
>  drivers/cxl/core/port.c | 4 ++--
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 0c62b4069ba0..d81e5ee25f58 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -110,4 +110,7 @@ bool cxl_need_node_perf_attrs_update(int nid);
>  int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
>  					struct access_coordinate *c);
>  
> +struct cxl_port *find_cxl_port(struct device *dport_dev,
> +			       struct cxl_dport **dport);
> +
>  #endif /* __CXL_CORE_H__ */
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index e666ec6a9085..2ac835cd4f1b 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1342,8 +1342,8 @@ static struct cxl_port *__find_cxl_port(struct cxl_find_port_ctx *ctx)
>  	return NULL;
>  }
>  
> -static struct cxl_port *find_cxl_port(struct device *dport_dev,
> -				      struct cxl_dport **dport)
> +struct cxl_port *find_cxl_port(struct device *dport_dev,
> +			       struct cxl_dport **dport)
>  {
>  	struct cxl_find_port_ctx ctx = {
>  		.dport_dev = dport_dev,


