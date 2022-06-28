Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75FA55D0BB
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 15:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiF1KhV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 06:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343572AbiF1KhV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 06:37:21 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CF831538;
        Tue, 28 Jun 2022 03:37:19 -0700 (PDT)
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LXLcL55CRz687rC;
        Tue, 28 Jun 2022 18:36:34 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 28 Jun 2022 12:37:17 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 28 Jun
 2022 11:37:16 +0100
Date:   Tue, 28 Jun 2022 11:37:15 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <hch@infradead.org>,
        <alison.schofield@intel.com>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH 01/46] tools/testing/cxl: Fix cxl_hdm_decode_init()
 calling convention
Message-ID: <20220628113715.00005857@Huawei.com>
In-Reply-To: <165603870776.551046.8709990108936497723.stgit@dwillia2-xfh>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
        <165603870776.551046.8709990108936497723.stgit@dwillia2-xfh>
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

On Thu, 23 Jun 2022 19:45:07 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> This failing signature:
> 
> [    8.392669] cxl_bus_probe: cxl_port endpoint2: probe: 970997760
> [    8.392670] cxl_port: probe of endpoint2 failed with error 970997760
> [    8.392719] create_endpoint: cxl_mem mem0: add: endpoint2
> [    8.392721] cxl_mem mem0: endpoint2 failed probe
> [    8.392725] cxl_bus_probe: cxl_mem mem0: probe: -6
> 
> ...shows cxl_hdm_decode_init() resulting in a return code ("970997760")
> that looks like stack corruption. The problem goes away if
> cxl_hdm_decode_init() is not mocked via __wrap_cxl_hdm_decode_init().
> 
> The corruption results from the mismatch that the calling convention for
> cxl_hdm_decode_init() is:
> 
> int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm)
> 
> ...and __wrap_cxl_hdm_decode_init() is:
> 
> bool __wrap_cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm)
> 
> ...i.e. an int is expected but __wrap_hdm_decode_init() returns bool.
> 
> Fix the convention and cleanup the organization to match
> __wrap_cxl_await_media_ready() as the difference was a red herring that
> distracted from finding the bug.
> 
> Fixes: 92804edb11f0 ("cxl/pci: Drop @info argument to cxl_hdm_decode_init()")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
LGTM

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  tools/testing/cxl/test/mock.c |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
> index f1f8c40948c5..bce6a21df0d5 100644
> --- a/tools/testing/cxl/test/mock.c
> +++ b/tools/testing/cxl/test/mock.c
> @@ -208,13 +208,15 @@ int __wrap_cxl_await_media_ready(struct cxl_dev_state *cxlds)
>  }
>  EXPORT_SYMBOL_NS_GPL(__wrap_cxl_await_media_ready, CXL);
>  
> -bool __wrap_cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
> -				struct cxl_hdm *cxlhdm)
> +int __wrap_cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
> +			       struct cxl_hdm *cxlhdm)
>  {
>  	int rc = 0, index;
>  	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
>  
> -	if (!ops || !ops->is_mock_dev(cxlds->dev))
> +	if (ops && ops->is_mock_dev(cxlds->dev))
> +		rc = 0;
> +	else
>  		rc = cxl_hdm_decode_init(cxlds, cxlhdm);
>  	put_cxl_mock_ops(index);
>  
> 

