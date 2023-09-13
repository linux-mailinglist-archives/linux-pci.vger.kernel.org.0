Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC2379E8EE
	for <lists+linux-pci@lfdr.de>; Wed, 13 Sep 2023 15:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240829AbjIMNQZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 13 Sep 2023 09:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240852AbjIMNQQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Sep 2023 09:16:16 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6927C19B4;
        Wed, 13 Sep 2023 06:16:12 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rm1770cw6z6D9CR;
        Wed, 13 Sep 2023 21:11:31 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 13 Sep
 2023 14:16:10 +0100
Date:   Wed, 13 Sep 2023 14:16:09 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        "Nilesh Javali" <njavali@marvell.com>,
        <GR-QLogic-Storage-Upstream@marvell.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 08/10] scsi: qla2xxx: Use FIELD_GET() to extract PCIe
 capability fields
Message-ID: <20230913141609.000030cd@Huawei.com>
In-Reply-To: <20230913122748.29530-9-ilpo.jarvinen@linux.intel.com>
References: <20230913122748.29530-1-ilpo.jarvinen@linux.intel.com>
        <20230913122748.29530-9-ilpo.jarvinen@linux.intel.com>
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

On Wed, 13 Sep 2023 15:27:46 +0300
Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> wrote:

> Use FIELD_GET() to extract PCIe capability registers field instead of
> custom masking and shifting.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/scsi/qla2xxx/qla_os.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
> index 50db08265c51..7e103d711825 100644
> --- a/drivers/scsi/qla2xxx/qla_os.c
> +++ b/drivers/scsi/qla2xxx/qla_os.c
> @@ -5,6 +5,7 @@
>   */
>  #include "qla_def.h"
>  
> +#include <linux/bitfield.h>
>  #include <linux/moduleparam.h>
>  #include <linux/vmalloc.h>
>  #include <linux/delay.h>
> @@ -633,8 +634,8 @@ qla24xx_pci_info_str(struct scsi_qla_host *vha, char *str, size_t str_len)
>  		const char *speed_str;
>  
>  		pcie_capability_read_dword(ha->pdev, PCI_EXP_LNKCAP, &lstat);
> -		lspeed = lstat & PCI_EXP_LNKCAP_SLS;
> -		lwidth = (lstat & PCI_EXP_LNKCAP_MLW) >> 4;
> +		lspeed = FIELD_GET(PCI_EXP_LNKCAP_SLS, lstat);
> +		lwidth = FIELD_GET(PCI_EXP_LNKCAP_MLW, lstat);
>  
>  		switch (lspeed) {
>  		case 1:

