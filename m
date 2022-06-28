Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E4755EA95
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 19:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbiF1REc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 13:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbiF1REU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 13:04:20 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AAF252BB;
        Tue, 28 Jun 2022 10:04:14 -0700 (PDT)
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LXW6z1gZ7z67MLx;
        Wed, 29 Jun 2022 01:00:11 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 28 Jun 2022 19:04:12 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 28 Jun
 2022 18:04:12 +0100
Date:   Tue, 28 Jun 2022 18:04:10 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <bwidawsk@kernel.org>,
        <hch@infradead.org>, <alison.schofield@intel.com>,
        <nvdimm@lists.linux.dev>, <linux-pci@vger.kernel.org>,
        <patches@lists.linux.dev>
Subject: Re: [PATCH 13/46] cxl/hdm: Require all decoders to be enumerated
Message-ID: <20220628180410.000042dd@Huawei.com>
In-Reply-To: <165603879664.551046.6863805202478861026.stgit@dwillia2-xfh>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
        <165603879664.551046.6863805202478861026.stgit@dwillia2-xfh>
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

On Thu, 23 Jun 2022 19:46:36 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> From: Ben Widawsky <bwidawsk@kernel.org>
> 
> In preparation for region provisioning all device decoders need to be
> enumerated since DPA allocations are calculated by summing the
> capacities of all decoders in a set. I.e. the programming for decoder[N]
> depends on the state of decoder[N-1], so skipping over decoders that
> fail to initialize prevents accurate DPA accounting.
> 
> Signed-off-by: Ben Widawsky <bwidawsk@kernel.org>
> [djbw: reword changelog]
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Good to see this tidied up the handling always felt a bit odd..

> ---
>  drivers/cxl/core/hdm.c |   12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 2223d151b61b..c940a4911fee 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -199,7 +199,7 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
>  {
>  	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
>  	struct cxl_port *port = cxlhdm->port;
> -	int i, committed, failed;
> +	int i, committed;
>  	u32 ctrl;
>  
>  	/*
> @@ -219,7 +219,7 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
>  	if (committed != cxlhdm->decoder_count)
>  		msleep(20);
>  
> -	for (i = 0, failed = 0; i < cxlhdm->decoder_count; i++) {
> +	for (i = 0; i < cxlhdm->decoder_count; i++) {
>  		int target_map[CXL_DECODER_MAX_INTERLEAVE] = { 0 };
>  		int rc, target_count = cxlhdm->target_count;
>  		struct cxl_decoder *cxld;
> @@ -250,8 +250,7 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
>  		rc = init_hdm_decoder(port, cxld, target_map, hdm, i);
>  		if (rc) {
>  			put_device(&cxld->dev);
> -			failed++;
> -			continue;
> +			return rc;
>  		}
>  		rc = add_hdm_decoder(port, cxld, target_map);
>  		if (rc) {
> @@ -261,11 +260,6 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
>  		}
>  	}
>  
> -	if (failed == cxlhdm->decoder_count) {
> -		dev_err(&port->dev, "No valid decoders found\n");
> -		return -ENXIO;
> -	}
> -
>  	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_enumerate_decoders, CXL);
> 

