Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F5355E947
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 18:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347566AbiF1Otw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 10:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347570AbiF1Otu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 10:49:50 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27053139A;
        Tue, 28 Jun 2022 07:49:48 -0700 (PDT)
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LXS9s3pcfz6H6pP;
        Tue, 28 Jun 2022 22:47:29 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 28 Jun 2022 16:49:46 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 28 Jun
 2022 15:49:46 +0100
Date:   Tue, 28 Jun 2022 15:49:42 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V12 7/9] cxl/port: Introduce cxl_cdat_valid()
Message-ID: <20220628154942.00002064@Huawei.com>
In-Reply-To: <20220628041527.742333-8-ira.weiny@intel.com>
References: <20220628041527.742333-1-ira.weiny@intel.com>
        <20220628041527.742333-8-ira.weiny@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 27 Jun 2022 21:15:25 -0700
ira.weiny@intel.com wrote:

> From: Ira Weiny <ira.weiny@intel.com>
> 
> The CDAT data is protected by a checksum and should be the proper
> length.
> 
> Introduce cxl_cdat_valid() to validate the data.  While at it check and
> store the sequence number.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
Minor ordering comment.  With that tidied up
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 4bd479ec0253..6d775cc3dca1 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -532,6 +532,40 @@ static int cxl_cdat_get_length(struct device *dev,
>  	return rc;
>  }
>  
> +static bool cxl_cdat_valid(struct device *dev, struct cxl_cdat *cdat)
> +{
> +	u32 *table = cdat->table;
> +	u8 *data8 = cdat->table;
> +	u32 length, seq;
> +	u8 check;
> +	int i;
> +
> +	length = FIELD_GET(CDAT_HEADER_DW0_LENGTH, table[0]);
> +	if ((length < CDAT_HEADER_LENGTH_BYTES) || (length > cdat->length)) {
> +		dev_err(dev, "CDAT Invalid length %u (%zu-%zu)\n", length,
> +			CDAT_HEADER_LENGTH_BYTES, cdat->length);
> +		return false;
> +	}
> +
> +	for (check = 0, i = 0; i < length; i++)
> +		check += data8[i];
> +
> +	dev_dbg(dev, "CDAT length %u CS %u\n", length, check);
> +	if (check != 0) {
> +		dev_err(dev, "CDAT Invalid checksum %u\n", check);
> +		return false;
> +	}
> +
> +	seq = FIELD_GET(CDAT_HEADER_DW3_SEQUENCE, table[3]);
> +	/* Store the sequence for now. */
> +	if (cdat->seq != seq) {
> +		dev_info(dev, "CDAT seq change %x -> %x\n", cdat->seq, seq);
> +		cdat->seq = seq;
> +	}
> +
> +	return true;
> +}
> +
>  static int cxl_cdat_read_table(struct device *dev,
>  			       struct pci_doe_mb *cdat_mb,
>  			       struct cxl_cdat *cdat)
> @@ -579,6 +613,8 @@ static int cxl_cdat_read_table(struct device *dev,
>  
>  	} while (entry_handle != CXL_DOE_TABLE_ACCESS_LAST_ENTRY);
>  
> +	if (!rc && !cxl_cdat_valid(dev, cdat))
> +		return -EIO;

I'd prefer those handled separately as flow is more readable if error
handling always out of line.

	if (rc)
		return rc;

	if (!cxl_cdata_valid)
		return -EIO;

	return 0;

>  	return rc;
>  }
>  

