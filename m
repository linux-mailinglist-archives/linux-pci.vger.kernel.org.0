Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4BC512070
	for <lists+linux-pci@lfdr.de>; Wed, 27 Apr 2022 20:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbiD0R72 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Apr 2022 13:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244508AbiD0R71 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Apr 2022 13:59:27 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9486E2FC89A;
        Wed, 27 Apr 2022 10:56:15 -0700 (PDT)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KpRCZ106zz67gQT;
        Thu, 28 Apr 2022 01:52:10 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Apr 2022 19:56:13 +0200
Received: from localhost (10.81.200.74) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.24; Wed, 27 Apr
 2022 18:56:12 +0100
Date:   Wed, 27 Apr 2022 18:56:10 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V8 08/10] cxl/cdat: Introduce cxl_cdat_valid()
Message-ID: <20220427185610.0000201a@Huawei.com>
In-Reply-To: <20220414203237.2198665-9-ira.weiny@intel.com>
References: <20220414203237.2198665-1-ira.weiny@intel.com>
        <20220414203237.2198665-9-ira.weiny@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.200.74]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 14 Apr 2022 13:32:35 -0700
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

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> Changes from V6
> 	Change name to cxl_cdat_valid() as this validates all the CDAT
> 		data not just the header
> 	Add error and debug prints
> 
> Changes from V5
> 	New patch, split out
> 	Update cdat_hdr_valid()
> 		Remove revision and cs field parsing
> 			There is no point in these
> 		Add seq check and debug print.
> ---
>  drivers/cxl/cdat.h |  2 ++
>  drivers/cxl/pci.c  | 36 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/drivers/cxl/cdat.h b/drivers/cxl/cdat.h
> index 4722b6bbbaf0..a7725d26f2d2 100644
> --- a/drivers/cxl/cdat.h
> +++ b/drivers/cxl/cdat.h
> @@ -88,10 +88,12 @@
>   *
>   * @table: cache of CDAT table
>   * @length: length of cached CDAT table
> + * @seq: Last read Sequence number of the CDAT table
>   */
>  struct cxl_cdat {
>  	void *table;
>  	size_t length;
> +	u32 seq;
>  };
>  
>  #endif /* !__CXL_CDAT_H__ */
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index aecb327911a0..d7952156dd02 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -781,6 +781,40 @@ static int cxl_setup_doe_devices(struct cxl_dev_state *cxlds)
>  	return 0;
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
> +		dev_err(dev, "Invalid length %u (%lu-%lu)\n", length,
> +			CDAT_HEADER_LENGTH_BYTES, cdat->length);
> +		return false;
> +	}
> +
> +	for (check = 0, i = 0; i < length; i++)
> +		check += data8[i];
> +
> +	dev_dbg(dev, "CDAT length %u CS %u\n", length, check);
> +	if (check != 0) {
> +		dev_err(dev, "Invalid checksum %u\n", check);
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
>  #define CDAT_DOE_REQ(entry_handle)					\
>  	(FIELD_PREP(CXL_DOE_TABLE_ACCESS_REQ_CODE,			\
>  		    CXL_DOE_TABLE_ACCESS_REQ_CODE_READ) |		\
> @@ -892,6 +926,8 @@ static int cxl_cdat_read_table(struct cxl_dev_state *cxlds,
>  
>  release_driver:
>  	cxl_pci_doe_put_drv(doe_dev);
> +	if (!rc && !cxl_cdat_valid(cxlds->dev, cdat))
> +		return -EIO;
>  	return rc;
>  }
>  

