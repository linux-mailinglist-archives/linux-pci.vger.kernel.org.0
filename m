Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5AF55EA61
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 18:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbiF1Q4q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 12:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbiF1Q4E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 12:56:04 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584CF1A052;
        Tue, 28 Jun 2022 09:55:38 -0700 (PDT)
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LXW0r6DH6z6GD51;
        Wed, 29 Jun 2022 00:54:52 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 28 Jun 2022 18:55:36 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 28 Jun
 2022 17:55:35 +0100
Date:   Tue, 28 Jun 2022 17:55:33 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <bwidawsk@kernel.org>,
        <hch@infradead.org>, <alison.schofield@intel.com>,
        <nvdimm@lists.linux.dev>, <linux-pci@vger.kernel.org>,
        <patches@lists.linux.dev>
Subject: Re: [PATCH 11/46] cxl/core: Define a 'struct cxl_endpoint_decoder'
 for tracking DPA resources
Message-ID: <20220628175533.00005da6@Huawei.com>
In-Reply-To: <165603878173.551046.17541236959392713646.stgit@dwillia2-xfh>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
        <165603878173.551046.17541236959392713646.stgit@dwillia2-xfh>
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

On Thu, 23 Jun 2022 19:46:21 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Previously the target routing specifics of switch decoders and platfom
> CXL window resource tracking of root decoders were factored out of
> 'struct cxl_decoder'. While switch decoders translate from SPA to
> downstream ports, endpoint decoders translate from SPA to DPA.
> 
> This patch, 3 of 3, adds a 'struct cxl_endpoint_decoder' that tracks an
> endpoint-specific Device Physical Address (DPA) resource. For now this
> just defines ->dpa_res, a follow-on patch will handle requesting DPA
> resource ranges from a device-DPA resource tree.
> 
> Co-developed-by: Ben Widawsky <bwidawsk@kernel.org>
> Signed-off-by: Ben Widawsky <bwidawsk@kernel.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/hdm.c       |   12 +++++++++---
>  drivers/cxl/core/port.c      |   36 +++++++++++++++++++++++++++---------
>  drivers/cxl/cxl.h            |   15 ++++++++++++++-
>  tools/testing/cxl/test/cxl.c |   11 +++++++++--
>  4 files changed, 59 insertions(+), 15 deletions(-)
> 



> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 6dd1e4c57a67..579f2d802396 100644


>  int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map);
> -struct cxl_decoder *cxl_endpoint_decoder_alloc(struct cxl_port *port);
> +struct cxl_endpoint_decoder *cxl_endpoint_decoder_alloc(struct cxl_port *port);
>  int cxl_decoder_add_locked(struct cxl_decoder *cxld, int *target_map);
>  int cxl_decoder_autoremove(struct device *host, struct cxl_decoder *cxld);
>  int cxl_endpoint_autoremove(struct cxl_memdev *cxlmd, struct cxl_port *endpoint);
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 68288354b419..f52a5dd69d36 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -459,8 +459,15 @@ static int mock_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
>  				cxld = ERR_CAST(cxlsd);
>  			else
>  				cxld = &cxlsd->cxld;
> -		} else
> -			cxld = cxl_endpoint_decoder_alloc(port);
> +		} else {
> +			struct cxl_endpoint_decoder *cxled;
> +
> +			cxled = cxl_endpoint_decoder_alloc(port);
> +			if (IS_ERR(cxled))
> +				cxld = ERR_CAST(cxled);

It's my favourite code pattern to moan about today :)
Same thing - just handle error here and it'll be easier to read for cost of a few
lines of additional code.  Few other cases of it in here.


> +			else
> +				cxld = &cxled->cxld;
> +		}
>  		if (IS_ERR(cxld)) {
>  			dev_warn(&port->dev,
>  				 "Failed to allocate the decoder\n");
> 

