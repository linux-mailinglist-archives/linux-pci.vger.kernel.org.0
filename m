Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31CE690CF7
	for <lists+linux-pci@lfdr.de>; Thu,  9 Feb 2023 16:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbjBIP3v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Feb 2023 10:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjBIP3p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Feb 2023 10:29:45 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2825F38B55;
        Thu,  9 Feb 2023 07:29:45 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PCLK762vLz67W0D;
        Thu,  9 Feb 2023 23:25:15 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Thu, 9 Feb
 2023 15:29:42 +0000
Date:   Thu, 9 Feb 2023 15:29:42 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <rafael@kernel.org>,
        <bhelgaas@google.com>, <robert.moore@intel.com>
Subject: Re: [PATCH 15/18] cxl: Move identify and partition query from pci
 probe to port probe
Message-ID: <20230209152942.0000584f@Huawei.com>
In-Reply-To: <167571669593.587790.12939497495344674151.stgit@djiang5-mobl3.local>
References: <167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local>
        <167571669593.587790.12939497495344674151.stgit@djiang5-mobl3.local>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 06 Feb 2023 13:51:37 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Move the enumeration of device capacity to cxl_port_probe() from
> cxl_pci_probe(). The size and capacity information should be read
> after cxl_await_media_ready() so the data is valid.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Fix?

> ---
>  drivers/cxl/pci.c  |    8 --------
>  drivers/cxl/port.c |    8 ++++++++
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 258004f34281..e35ed250214e 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -484,14 +484,6 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> -	rc = cxl_dev_state_identify(cxlds);
> -	if (rc)
> -		return rc;
> -
> -	rc = cxl_mem_create_range_info(cxlds);
> -	if (rc)
> -		return rc;
> -
>  	cxlmd = devm_cxl_add_memdev(cxlds);
>  	if (IS_ERR(cxlmd))
>  		return PTR_ERR(cxlmd);
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 03380c18fc52..b7a4a1be2945 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -127,6 +127,14 @@ static int cxl_port_probe(struct device *dev)
>  			if (rc)
>  				dev_dbg(dev, "Failed to do QoS calculations\n");
>  		}
> +
> +		rc = cxl_dev_state_identify(cxlds);
> +		if (rc)
> +			return rc;
> +
> +		rc = cxl_mem_create_range_info(cxlds);
> +		if (rc)
> +			return rc;
>  	}
>  
>  	rc = devm_cxl_enumerate_decoders(cxlhdm);
> 
> 

