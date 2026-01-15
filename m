Return-Path: <linux-pci+bounces-44968-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DA1D2562D
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 16:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 018A130ADDA2
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 15:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D9A39C624;
	Thu, 15 Jan 2026 15:30:21 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7CB23EA88;
	Thu, 15 Jan 2026 15:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768491021; cv=none; b=WOyNH5fQSOY6LmQSxGHWIfcXbF9oxlsRJHj0SeDiJAU7ZxMiHvwBRJLRCaDNphji9uSv+5wusm8q+V3uTAav/9bRTDV2DKS5XBjYKcTW40176NCLW7aT8EJOqKKuK+bZ7cl3HOg/kZrjWjio3DKHTGoXMAUkYUoB+PBYvRR2oyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768491021; c=relaxed/simple;
	bh=7uGObAKGwUQTt4ptgEJbuzidA/nvIM04T8WaIPCSIG0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lQ1L1KVrNaWyMbHG+HmOqzAjMz7wxOF9bos2yDc0rhD1883AoS3YhAkYHSy1y3npIdvIOUHBD8wdRiKgcklWxb3nG7W481FI8oOo2V7NcdBOYRtNYHCLCVTKz2zTrBQoC13R6ykAzj8m3+1KpWcyphQ36haujPILhb83ep5i4Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dsRkH1M2GzJ46Q7;
	Thu, 15 Jan 2026 23:29:59 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id A1A5040569;
	Thu, 15 Jan 2026 23:30:15 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 15 Jan
 2026 15:30:14 +0000
Date: Thu, 15 Jan 2026 15:30:13 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>, <alucerop@amd.com>,
	<ira.weiny@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v14 25/34] cxl/port: Map Port component registers before
 switchport init
Message-ID: <20260115153013.000049eb@huawei.com>
In-Reply-To: <20260114182055.46029-26-terry.bowman@amd.com>
References: <20260114182055.46029-1-terry.bowman@amd.com>
	<20260114182055.46029-26-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed, 14 Jan 2026 12:20:46 -0600
Terry Bowman <terry.bowman@amd.com> wrote:

> Port HDM registers must be mapped before calling
> devm_cxl_switch_port_decoders_setup(). Invoke a call to this function
> in cxl_port_add_dport().
As I read that description, there is a bisection break before this
in that if you build up to patch 24, they won't be mapped before
it is called.

Maybe this needs squashing with an earlier patch, or if it is for
some reason safe, then add a comment here on why.

> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>  drivers/cxl/core/port.c | 3 ++-
>  drivers/cxl/cxlpci.h    | 3 +++
>  drivers/cxl/port.c      | 5 +++++
>  3 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 2c4e28e7975c..3f730511f11d 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -778,7 +778,7 @@ static int cxl_setup_comp_regs(struct device *host, struct cxl_register_map *map
>  	return cxl_setup_regs(map);
>  }
>  
> -static int cxl_port_setup_regs(struct cxl_port *port,
> +int cxl_port_setup_regs(struct cxl_port *port,
>  			resource_size_t component_reg_phys)
>  {
>  	if (dev_is_platform(port->uport_dev))
> @@ -786,6 +786,7 @@ static int cxl_port_setup_regs(struct cxl_port *port,
>  	return cxl_setup_comp_regs(&port->dev, &port->reg_map,
>  				   component_reg_phys);
>  }
> +EXPORT_SYMBOL_NS_GPL(cxl_port_setup_regs, "CXL");
>  
>  static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
>  				resource_size_t component_reg_phys)
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index ef4496b4e55e..532506595d0f 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -99,4 +99,7 @@ static inline void devm_cxl_port_ras_setup(struct cxl_port *port)
>  }
>  #endif
>  
> +int cxl_port_setup_regs(struct cxl_port *port,
> +			resource_size_t component_reg_phys);
> +
>  #endif /* __CXL_PCI_H__ */
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index d76b4b532064..f8a33dbf8222 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -278,6 +278,11 @@ static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
>  		return ERR_CAST(port_group);
>  
>  	if (port->nr_dports == 0) {
> +
> +		rc = cxl_port_setup_regs(port, port->component_reg_phys);
> +		if (rc)
> +			return ERR_PTR(rc);
> +
>  		rc = devm_cxl_switch_port_decoders_setup(port);
>  		if (rc)
>  			return ERR_PTR(rc);


