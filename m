Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26CF64A49B4
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jan 2022 15:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242342AbiAaOyG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jan 2022 09:54:06 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4564 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238037AbiAaOyG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jan 2022 09:54:06 -0500
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JnWFV3F7Mz67WSN;
        Mon, 31 Jan 2022 22:50:22 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 31 Jan 2022 15:54:04 +0100
Received: from localhost (10.47.73.212) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.21; Mon, 31 Jan
 2022 14:54:04 +0000
Date:   Mon, 31 Jan 2022 14:53:58 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v3 12/40] cxl/core: Fix cxl_probe_component_regs() error
 message
Message-ID: <20220131145358.0000322a@Huawei.com>
In-Reply-To: <164298418268.3018233.17790073375430834911.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
        <164298418268.3018233.17790073375430834911.stgit@dwillia2-desk3.amr.corp.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.73.212]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 23 Jan 2022 16:29:42 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Fix a '\n' vs '/n' typo.
> 
> Fixes: 08422378c4ad ("cxl/pci: Add HDM decoder capabilities")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
FWIW 

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Possibly worth pulling this out and sending separately.

Jonathan

> ---
>  drivers/cxl/core/regs.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 0d63758e2605..12a6cbddf110 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -50,7 +50,7 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>  
>  	if (FIELD_GET(CXL_CM_CAP_HDR_ID_MASK, cap_array) != CM_CAP_HDR_CAP_ID) {
>  		dev_err(dev,
> -			"Couldn't locate the CXL.cache and CXL.mem capability array header./n");
> +			"Couldn't locate the CXL.cache and CXL.mem capability array header.\n");
>  		return;
>  	}
>  
> 

