Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3AC561663
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jun 2022 11:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbiF3Jda (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jun 2022 05:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbiF3Jda (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jun 2022 05:33:30 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF7315FC7;
        Thu, 30 Jun 2022 02:33:28 -0700 (PDT)
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LYY5f1gwrz6GD2T;
        Thu, 30 Jun 2022 17:32:38 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Thu, 30 Jun 2022 11:33:26 +0200
Received: from localhost (10.81.200.250) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 30 Jun
 2022 10:33:24 +0100
Date:   Thu, 30 Jun 2022 10:33:11 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>,
        <hch@lst.de>
Subject: Re: [PATCH 31/46] cxl/hdm: Initialize decoder type for memory
 expander devices
Message-ID: <20220630103311.00004d94@Huawei.com>
In-Reply-To: <20220624041950.559155-6-dan.j.williams@intel.com>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
        <20220624041950.559155-6-dan.j.williams@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.200.250]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
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

On Thu, 23 Jun 2022 21:19:35 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Unless and until accelerator (type-2) drivers start registering for
> CXL.mem mapping services from the CXL subsystem core, initialize idle
> HDM decoders to the "expander" type. I.e. the only CXL devices using the
> CXL core presently are those implementing the CXL 2.0 Type-3 memory
> expander device class code that the cxl_pci driver claims.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/hdm.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 672bf3e97811..7b58f6911523 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -474,6 +474,17 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  		cxld->flags |= CXL_DECODER_F_ENABLE;
>  		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
>  			cxld->flags |= CXL_DECODER_F_LOCK;
> +		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_TYPE, ctrl))
> +			cxld->target_type = CXL_DECODER_EXPANDER;
> +		else
> +			cxld->target_type = CXL_DECODER_ACCELERATOR;
> +	} else {
> +		/* unless / until type-2 drivers arrive, assume type-3 */
> +		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_TYPE, ctrl) == 0) {
> +			ctrl |= CXL_HDM_DECODER0_CTRL_TYPE;
> +			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
> +		}
> +		cxld->target_type = CXL_DECODER_EXPANDER;
>  	}
>  	rc = cxl_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
>  			 &cxld->interleave_ways);
> @@ -488,11 +499,6 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  	if (rc)
>  		return rc;
>  
> -	if (FIELD_GET(CXL_HDM_DECODER0_CTRL_TYPE, ctrl))
> -		cxld->target_type = CXL_DECODER_EXPANDER;
> -	else
> -		cxld->target_type = CXL_DECODER_ACCELERATOR;
> -
>  	if (!cxled) {
>  		target_list.value =
>  			ioread64_hi_lo(hdm + CXL_HDM_DECODER0_TL_LOW(which));

