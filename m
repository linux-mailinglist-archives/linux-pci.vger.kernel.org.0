Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD6D4358B5F
	for <lists+linux-pci@lfdr.de>; Thu,  8 Apr 2021 19:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbhDHR3s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Apr 2021 13:29:48 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2813 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbhDHR3q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Apr 2021 13:29:46 -0400
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FGSkZ6Qhrz686KW;
        Fri,  9 Apr 2021 01:22:30 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 8 Apr 2021 19:29:33 +0200
Received: from localhost (10.47.93.239) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 8 Apr 2021
 18:29:32 +0100
Date:   Thu, 8 Apr 2021 18:28:08 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <dan.j.williams@intel.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/7] cxl/mem: Move device register setup
Message-ID: <20210408182808.00007f69@Huawei.com>
In-Reply-To: <20210407222625.320177-6-ben.widawsky@intel.com>
References: <20210407222625.320177-1-ben.widawsky@intel.com>
        <20210407222625.320177-6-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.93.239]
X-ClientProxiedBy: lhreml750-chm.china.huawei.com (10.201.108.200) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 7 Apr 2021 15:26:23 -0700
Ben Widawsky <ben.widawsky@intel.com> wrote:

> Support expansion of register block types that the driver will attempt
> to recognize by pulling the code up into the register block scanning
> loop. Subsequent code can easily add in new register block types with
> this.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>>

> ---
>  drivers/cxl/mem.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 60b95c524c3e..49f651694cb0 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -1020,6 +1020,15 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
>  			base = cxl_mem_map_regblock(cxlm, reg_lo, reg_hi);
>  			if (IS_ERR(base))
>  				return PTR_ERR(base);
> +
> +			cxl_setup_device_regs(dev, base, &regs->device_regs);
> +			if (!regs->status || !regs->mbox || !regs->memdev) {
> +				dev_err(dev, "registers not found: %s%s%s\n",
> +						!regs->status ? "status " : "",
> +						!regs->mbox ? "mbox " : "",
> +						!regs->memdev ? "memdev" : "");
> +				return -ENXIO;
> +			}
>  			break;
>  		}
>  	}
> @@ -1029,16 +1038,6 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
>  		return -ENXIO;
>  	}
>  
> -	cxl_setup_device_regs(dev, base, &regs->device_regs);
> -
> -	if (!regs->status || !regs->mbox || !regs->memdev) {
> -		dev_err(dev, "registers not found: %s%s%s\n",
> -			!regs->status ? "status " : "",
> -			!regs->mbox ? "mbox " : "",
> -			!regs->memdev ? "memdev" : "");
> -		return -ENXIO;
> -	}
> -
>  	return 0;
>  }
>  

