Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7BA79CE88
	for <lists+linux-pci@lfdr.de>; Tue, 12 Sep 2023 12:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbjILKiY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 12 Sep 2023 06:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234124AbjILKiX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Sep 2023 06:38:23 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20496CC3;
        Tue, 12 Sep 2023 03:38:20 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RlKmD4RY8z6K5wg;
        Tue, 12 Sep 2023 18:37:48 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 12 Sep
 2023 11:38:17 +0100
Date:   Tue, 12 Sep 2023 11:38:17 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        "Bradley Grove" <linuxdrivers@attotech.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/8] scsi: esas2r: Use FIELD_GET() to extract Link Width
Message-ID: <20230912113817.000064db@Huawei.com>
In-Reply-To: <20230911121501.21910-8-ilpo.jarvinen@linux.intel.com>
References: <20230911121501.21910-1-ilpo.jarvinen@linux.intel.com>
        <20230911121501.21910-8-ilpo.jarvinen@linux.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 11 Sep 2023 15:15:00 +0300
Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> wrote:

> Use FIELD_GET() to extract PCIe Negotiated and Maximum Link Width fields
> instead of custom masking and shifting.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/scsi/esas2r/esas2r_ioctl.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/scsi/esas2r/esas2r_ioctl.c b/drivers/scsi/esas2r/esas2r_ioctl.c
> index 055d2e87a2c8..3252780fd099 100644
> --- a/drivers/scsi/esas2r/esas2r_ioctl.c
> +++ b/drivers/scsi/esas2r/esas2r_ioctl.c
> @@ -41,6 +41,8 @@
>   * USA.
>   */
>  
> +#include <linux/bitfield.h>
> +
>  #include "esas2r.h"
>  
>  /*
> @@ -797,11 +799,9 @@ static int hba_ioctl_callback(struct esas2r_adapter *a,
>  			gai->pci.link_speed_max =
>  				(u8)(caps & PCI_EXP_LNKCAP_SLS);
Better to convert the other field gets as well.

I'm curious as to why the u8 casts are here. The masking should have
kept the compiler happy that it is fine to assign these without
the casts and no chance of overflow.

>  			gai->pci.link_width_curr =
> -				(u8)((stat & PCI_EXP_LNKSTA_NLW)
> -				     >> PCI_EXP_LNKSTA_NLW_SHIFT);  
> +				(u8)FIELD_GET(PCI_EXP_LNKSTA_NLW, stat);
>  			gai->pci.link_width_max =
> -				(u8)((caps & PCI_EXP_LNKCAP_MLW)
> -				     >> 4);  
> +				(u8)FIELD_GET(PCI_EXP_LNKCAP_MLW, caps);
>  		}
>  
>  		gai->pci.msi_vector_cnt = 1;

