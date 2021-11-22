Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD834591C5
	for <lists+linux-pci@lfdr.de>; Mon, 22 Nov 2021 16:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240173AbhKVP5y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Nov 2021 10:57:54 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4135 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240162AbhKVP5w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Nov 2021 10:57:52 -0500
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HyWvd1Ld0z67MLx;
        Mon, 22 Nov 2021 23:50:53 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Mon, 22 Nov 2021 16:54:44 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 22 Nov
 2021 15:54:43 +0000
Date:   Mon, 22 Nov 2021 15:54:42 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 09/23] cxl: Introduce module_cxl_driver
Message-ID: <20211122155442.00004cf6@Huawei.com>
In-Reply-To: <20211120000250.1663391-10-ben.widawsky@intel.com>
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
        <20211120000250.1663391-10-ben.widawsky@intel.com>
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

On Fri, 19 Nov 2021 16:02:36 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> Many CXL drivers simply want to register and unregister themselves.
> module_driver already supported this. A simple wrapper around that
> reduces a decent amount of boilerplate in upcoming patches.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

Makes sense although, when compared with using the module_driver macro
directly it's a fairly minor reduction in boilerplate.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/cxl.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 7150a9694f66..d39d45f4a770 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -308,6 +308,9 @@ int __cxl_driver_register(struct cxl_driver *cxl_drv, struct module *owner,
>  #define cxl_driver_register(x) __cxl_driver_register(x, THIS_MODULE, KBUILD_MODNAME)
>  void cxl_driver_unregister(struct cxl_driver *cxl_drv);
>  
> +#define module_cxl_driver(__cxl_driver) \
> +	module_driver(__cxl_driver, cxl_driver_register, cxl_driver_unregister)
> +
>  #define CXL_DEVICE_NVDIMM_BRIDGE	1
>  #define CXL_DEVICE_NVDIMM		2
>  

