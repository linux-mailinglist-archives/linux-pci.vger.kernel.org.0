Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9087879CE90
	for <lists+linux-pci@lfdr.de>; Tue, 12 Sep 2023 12:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbjILKjy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 12 Sep 2023 06:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjILKjy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Sep 2023 06:39:54 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E9E9F;
        Tue, 12 Sep 2023 03:39:50 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RlKny2mRzz6K6ZD;
        Tue, 12 Sep 2023 18:39:18 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 12 Sep
 2023 11:39:47 +0100
Date:   Tue, 12 Sep 2023 11:39:46 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        "Nilesh Javali" <njavali@marvell.com>,
        <GR-QLogic-Storage-Upstream@marvell.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 8/8] scsi: qla2xxx: Use FIELD_GET() to extract Link
 Width
Message-ID: <20230912113946.00001e7a@Huawei.com>
In-Reply-To: <20230911121501.21910-9-ilpo.jarvinen@linux.intel.com>
References: <20230911121501.21910-1-ilpo.jarvinen@linux.intel.com>
        <20230911121501.21910-9-ilpo.jarvinen@linux.intel.com>
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

On Mon, 11 Sep 2023 15:15:01 +0300
Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> wrote:

> Use FIELD_GET() to extract PCIe Maximum Link Width field instead of
> custom masking and shifting.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/scsi/qla2xxx/qla_os.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
> index 877e4f446709..0c97a5e4249c 100644
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
> @@ -632,7 +633,7 @@ qla24xx_pci_info_str(struct scsi_qla_host *vha, char *str, size_t str_len)
>  
>  		pcie_capability_read_dword(ha->pdev, PCI_EXP_LNKCAP, &lstat);
>  		lspeed = lstat & PCI_EXP_LNKCAP_SLS;
> -		lwidth = (lstat & PCI_EXP_LNKCAP_MLW) >> 4;
> +		lwidth = FIELD_GET(PCI_EXP_LNKCAP_MLW, lstat);

As previous.  Whilst I'm happy to see this change I'd prefer to see it
used in all similar cases so do the lspeed one just above as well.

As a reviewer I don't want to care about the alignment of a particular
field and hence whether it needs shifting or just masking.
I want to review the header once to see it matches the spec, then never
look at it again!

Jonathan

>  
>  		switch (lspeed) {
>  		case 1:

