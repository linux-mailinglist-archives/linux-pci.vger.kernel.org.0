Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35D354A4EBF
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jan 2022 19:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357451AbiAaSpm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jan 2022 13:45:42 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4588 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357491AbiAaSpl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jan 2022 13:45:41 -0500
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JncSN2DVHz67ycM;
        Tue,  1 Feb 2022 02:45:08 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Mon, 31 Jan 2022 19:45:39 +0100
Received: from localhost (10.47.73.212) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.21; Mon, 31 Jan
 2022 18:45:38 +0000
Date:   Mon, 31 Jan 2022 18:45:32 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v3 34/40] cxl/core: Move target_list out of base decoder
 attributes
Message-ID: <20220131184532.000072b5@Huawei.com>
In-Reply-To: <164298430100.3018233.4715072508880290970.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
        <164298430100.3018233.4715072508880290970.stgit@dwillia2-desk3.amr.corp.intel.com>
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

On Sun, 23 Jan 2022 16:31:41 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> In preparation for introducing endpoint decoder objects, move the
> target_list attribute out of the common set since it has no meaning for
> endpoint decoders.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/port.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 13027fc2441d..39ce0fa7b285 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -186,7 +186,6 @@ static struct attribute *cxl_decoder_base_attrs[] = {
>  	&dev_attr_start.attr,
>  	&dev_attr_size.attr,
>  	&dev_attr_locked.attr,
> -	&dev_attr_target_list.attr,
>  	NULL,
>  };
>  
> @@ -199,6 +198,7 @@ static struct attribute *cxl_decoder_root_attrs[] = {
>  	&dev_attr_cap_ram.attr,
>  	&dev_attr_cap_type2.attr,
>  	&dev_attr_cap_type3.attr,
> +	&dev_attr_target_list.attr,
>  	NULL,
>  };
>  
> @@ -215,6 +215,7 @@ static const struct attribute_group *cxl_decoder_root_attribute_groups[] = {
>  
>  static struct attribute *cxl_decoder_switch_attrs[] = {
>  	&dev_attr_target_type.attr,
> +	&dev_attr_target_list.attr,
>  	NULL,
>  };
>  
> 

