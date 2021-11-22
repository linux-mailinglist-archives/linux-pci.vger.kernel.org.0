Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8C6E459498
	for <lists+linux-pci@lfdr.de>; Mon, 22 Nov 2021 19:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237533AbhKVSWR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Nov 2021 13:22:17 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4150 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbhKVSWM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Nov 2021 13:22:12 -0500
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HybB64r1Qz67PwQ;
        Tue, 23 Nov 2021 02:18:38 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 22 Nov 2021 19:19:03 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 22 Nov
 2021 18:19:02 +0000
Date:   Mon, 22 Nov 2021 18:19:01 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 23/23] cxl/mem: Disable switch hierarchies for now
Message-ID: <20211122181901.000073cb@Huawei.com>
In-Reply-To: <20211120000250.1663391-24-ben.widawsky@intel.com>
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
        <20211120000250.1663391-24-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml737-chm.china.huawei.com (10.201.108.187) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 19 Nov 2021 16:02:50 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> Switches aren't supported by the region driver yet. If a device finds
> itself under a switch it will not bind a driver so that it cannot be
> used later for region creation/configuration.

What's the reasoning in have this in this patch set rather than the region one?

I was rather hoping you'd have it working when the region set is ready :)

Jonathan

> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/cxl/mem.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index e954144af4b8..997898e78d63 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -155,6 +155,11 @@ static int cxl_mem_probe(struct device *dev)
>  		goto out;
>  	}
>  
> +	/* FIXME: Add true switch support */
> +	dev_err(dev, "Devices behind switches are currently unsupported\n");
> +	rc = -ENODEV;
> +	goto err_out;
> +
>  	/* Walk down from the root port and add all switches */
>  	cxl_scan_ports(ctx.root_port);
>  

