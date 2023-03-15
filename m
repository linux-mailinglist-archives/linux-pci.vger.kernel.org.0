Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234D86BBA26
	for <lists+linux-pci@lfdr.de>; Wed, 15 Mar 2023 17:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbjCOQse (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Mar 2023 12:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjCOQsc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Mar 2023 12:48:32 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B631D31E2B;
        Wed, 15 Mar 2023 09:48:12 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PcGX33Y4Dz6J6j2;
        Thu, 16 Mar 2023 00:47:15 +0800 (CST)
Received: from localhost (10.126.171.21) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 15 Mar
 2023 16:48:09 +0000
Date:   Wed, 15 Mar 2023 16:48:08 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Lukas Wunner <lukas@wunner.de>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Alexey Kardashevskiy" <aik@amd.com>,
        Davidlohr Bueso <dave@stgolabs.net>, <linuxarm@huawei.com>
Subject: Re: [PATCH v4 16/17] cxl/pci: Simplify CDAT retrieval error path
Message-ID: <20230315164808.00003c7b@Huawei.com>
In-Reply-To: <7a5c7104fb6a3016dbaec1c5d0ed34619ea11a0c.1678543498.git.lukas@wunner.de>
References: <cover.1678543498.git.lukas@wunner.de>
        <7a5c7104fb6a3016dbaec1c5d0ed34619ea11a0c.1678543498.git.lukas@wunner.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.171.21]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
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

On Sat, 11 Mar 2023 15:40:16 +0100
Lukas Wunner <lukas@wunner.de> wrote:

> From: Dave Jiang <dave.jiang@intel.com>
> 
> The cdat.table and cdat.length fields in struct cxl_port are set before
> CDAT retrieval and must therefore be unset on failure.
> 
> Simplify by setting only on success.
> 
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Link: https://lore.kernel.org/linux-cxl/20230209113422.00007017@Huawei.com/
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> [lukas: rebase and rephrase commit message]
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> Changes v3 -> v4:
>  * Newly added patch in v4 on popular request (Jonathan, Dave)
> 
>  drivers/cxl/core/pci.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index c868f4a2f1de..0609bd629073 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -475,10 +475,10 @@ static int cxl_cdat_get_length(struct device *dev,
>  
>  static int cxl_cdat_read_table(struct device *dev,
>  			       struct pci_doe_mb *cdat_doe,
> -			       struct cxl_cdat *cdat)
> +			       void *cdat_table, size_t *cdat_length)
>  {
> -	size_t length = cdat->length;
> -	__le32 *data = cdat->table;
> +	size_t length = *cdat_length;
> +	__le32 *data = cdat_table;
>  	int entry_handle = 0;
>  
>  	do {
> @@ -522,7 +522,7 @@ static int cxl_cdat_read_table(struct device *dev,
>  	} while (entry_handle != CXL_DOE_TABLE_ACCESS_LAST_ENTRY);
>  
>  	/* Length in CDAT header may exceed concatenation of CDAT entries */
> -	cdat->length -= length;
> +	*cdat_length -= length;
>  
>  	return 0;
>  }
> @@ -542,6 +542,7 @@ void read_cdat_data(struct cxl_port *port)
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>  	size_t cdat_length;
> +	void *cdat_table;
>  	int rc;
>  
>  	cdat_doe = pci_find_doe_mailbox(pdev, PCI_DVSEC_VENDOR_ID_CXL,
> @@ -558,19 +559,19 @@ void read_cdat_data(struct cxl_port *port)
>  		return;
>  	}
>  
> -	port->cdat.table = devm_kzalloc(dev, cdat_length, GFP_KERNEL);
> -	if (!port->cdat.table)
> +	cdat_table = devm_kzalloc(dev, cdat_length, GFP_KERNEL);
> +	if (!cdat_table)
>  		return;
>  
> -	port->cdat.length = cdat_length;
> -	rc = cxl_cdat_read_table(dev, cdat_doe, &port->cdat);
> +	rc = cxl_cdat_read_table(dev, cdat_doe, cdat_table, &cdat_length);
>  	if (rc) {
>  		/* Don't leave table data allocated on error */
> -		devm_kfree(dev, port->cdat.table);
> -		port->cdat.table = NULL;
> -		port->cdat.length = 0;
> +		devm_kfree(dev, cdat_table);
>  		dev_err(dev, "CDAT data read error\n");
>  	}
> +
> +	port->cdat.table = cdat_table;
> +	port->cdat.length = cdat_length;
>  }
>  EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
>  

