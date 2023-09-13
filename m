Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00AB579E8E9
	for <lists+linux-pci@lfdr.de>; Wed, 13 Sep 2023 15:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240727AbjIMNPg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 13 Sep 2023 09:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240817AbjIMNPf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Sep 2023 09:15:35 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADF419BF;
        Wed, 13 Sep 2023 06:15:31 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rm16L129gz6D9BZ;
        Wed, 13 Sep 2023 21:10:50 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 13 Sep
 2023 14:15:29 +0100
Date:   Wed, 13 Sep 2023 14:15:28 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        "Bradley Grove" <linuxdrivers@attotech.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 07/10] scsi: esas2r: Use FIELD_GET() to extract PCIe
 capability fields
Message-ID: <20230913141528.00000781@Huawei.com>
In-Reply-To: <20230913122748.29530-8-ilpo.jarvinen@linux.intel.com>
References: <20230913122748.29530-1-ilpo.jarvinen@linux.intel.com>
        <20230913122748.29530-8-ilpo.jarvinen@linux.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 13 Sep 2023 15:27:45 +0300
Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> wrote:

> Use FIELD_GET() to extract PCIe capability register fields instead of
> custom masking and shifting. Also remove the unnecessary cast to u8,
> the value in those fields always fits to u8.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/scsi/esas2r/esas2r_ioctl.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/scsi/esas2r/esas2r_ioctl.c b/drivers/scsi/esas2r/esas2r_ioctl.c
> index 055d2e87a2c8..3f7c1d131ec3 100644
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
> @@ -792,16 +794,10 @@ static int hba_ioctl_callback(struct esas2r_adapter *a,
>  			pcie_capability_read_dword(a->pcid, PCI_EXP_LNKCAP,
>  						   &caps);
>  
> -			gai->pci.link_speed_curr =
> -				(u8)(stat & PCI_EXP_LNKSTA_CLS);
> -			gai->pci.link_speed_max =
> -				(u8)(caps & PCI_EXP_LNKCAP_SLS);
> -			gai->pci.link_width_curr =
> -				(u8)((stat & PCI_EXP_LNKSTA_NLW)
> -				     >> PCI_EXP_LNKSTA_NLW_SHIFT);  
> -			gai->pci.link_width_max =
> -				(u8)((caps & PCI_EXP_LNKCAP_MLW)
> -				     >> 4);  
> +			gai->pci.link_speed_curr = FIELD_GET(PCI_EXP_LNKSTA_CLS, stat);
> +			gai->pci.link_speed_max = FIELD_GET(PCI_EXP_LNKCAP_SLS, caps);
> +			gai->pci.link_width_curr = FIELD_GET(PCI_EXP_LNKSTA_NLW, stat);
> +			gai->pci.link_width_max = FIELD_GET(PCI_EXP_LNKCAP_MLW, caps);
>  		}
>  
>  		gai->pci.msi_vector_cnt = 1;

