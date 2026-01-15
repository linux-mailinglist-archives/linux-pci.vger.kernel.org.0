Return-Path: <linux-pci+bounces-44959-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2335CD25260
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 16:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8170230559E8
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 15:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB7A3A9600;
	Thu, 15 Jan 2026 15:02:41 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179CB3A4F21;
	Thu, 15 Jan 2026 15:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768489360; cv=none; b=G1RSVqvKVP81ZN86sio+inbuePvwrtuF7rlC34AbBQ2abOL2aHZNTz4WGPbjkstlunTIwSfg/p5+RRRrP+DDO/XWYD1xX42xnJvvvLOX6zp19TD8ZbCfbHuSkL0IQ5Ma/x4KI1s4mbSk89Qg1SK1COFer4KJaX8yhTj131AIOMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768489360; c=relaxed/simple;
	bh=dEW9KCxyORB+MhqwZ2IGgCEDvpyLQ/GTf2y/8Qb/WYc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rPFlf1Xm4WjFTNF3U/gSTiAF3FaXTuIjpzxkbTH78GaqUIhIt3ZlgfaZkWdoFat4kF94yye1/weg6wrMhDNi2lOpBnM+ppppm6ITncBLiCox2zC2WFp1lyLaOn6xqE96zTp/LKGFQ+AwanI+hHOVmdDk0I7XrKoxCA+ys8lejUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dsR6B2MS8zHnH4l;
	Thu, 15 Jan 2026 23:02:10 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 6858140572;
	Thu, 15 Jan 2026 23:02:32 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 15 Jan
 2026 15:02:31 +0000
Date: Thu, 15 Jan 2026 15:02:30 +0000
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
Subject: Re: [PATCH v14 21/34] cxl/port: Move dport RAS reporting to a port
 resource
Message-ID: <20260115150230.00002e32@huawei.com>
In-Reply-To: <20260114182055.46029-22-terry.bowman@amd.com>
References: <20260114182055.46029-1-terry.bowman@amd.com>
	<20260114182055.46029-22-terry.bowman@amd.com>
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
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed, 14 Jan 2026 12:20:42 -0600
Terry Bowman <terry.bowman@amd.com> wrote:

> From: Dan Williams <dan.j.williams@intel.com>
> 
> Towards the end goal of making all CXL RAS capability handling uniform
> across upstream host bridges, upstream switch ports, and upstream endpoint
> ports, move dport RAS setup to cxl_endpoint_port_probe(). Rename the RAS
> setup helper to devm_cxl_dport_ras_setup() for symmetry with
> devm_cxl_switch_port_decoders_setup().
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Terry Bowman <terry.bowman@amd.com>

One trivial thing inline.
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> 
> ---
> 
> Changes in v13 -> v14:
> - New patch
> ---
>  drivers/cxl/core/ras.c        | 12 ++++++------
>  drivers/cxl/cxlpci.h          |  8 ++++----
>  drivers/cxl/mem.c             |  2 --
>  drivers/cxl/port.c            | 12 ++++++++++++
>  tools/testing/cxl/Kbuild      |  2 +-
>  tools/testing/cxl/test/mock.c |  6 +++---
>  6 files changed, 26 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 72908f3ced77..d71fcac31cf2 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -139,17 +139,17 @@ static void cxl_dport_map_ras(struct cxl_dport *dport)
>  }
>  
>  /**
> - * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
> + * devm_cxl_dport_ras_setup - Setup CXL RAS report on this dport
>   * @dport: the cxl_dport that needs to be initialized
> - * @host: host device for devm operations
>   */
> -void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
> +void devm_cxl_dport_ras_setup(struct cxl_dport *dport)
Not a thing for this patch set, but might be nice to at somepoint
prefix all the functions that have devm_ registrations in them so
it is obvious where those are hiding. I had to dig down a few
levels to find the call.
>  {
> -	dport->reg_map.host = host;
> +	dport->reg_map.host = &dport->port->dev;
>  	cxl_dport_map_ras(dport);
>  
>  	if (dport->rch) {
> -		struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport->dport_dev);
> +		struct pci_host_bridge *host_bridge =
> +			to_pci_host_bridge(dport->dport_dev);

Unrelated change.  This series is complex, so this sort of noise is not helpful
to reviewability!

>  
>  		if (!host_bridge->native_aer)
>  			return;
> @@ -158,7 +158,7 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
>  		cxl_disable_rch_root_ints(dport);
>  	}
>  }
> -EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_dport_ras_setup, "CXL");
>  
>  void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base)
>  {



