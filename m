Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C807C56057D
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 18:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbiF2QLP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 12:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233595AbiF2QLP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 12:11:15 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B42F2FFCB;
        Wed, 29 Jun 2022 09:11:14 -0700 (PDT)
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LY5z62B87z67PwL;
        Thu, 30 Jun 2022 00:10:26 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 29 Jun 2022 18:11:12 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.24; Wed, 29 Jun
 2022 17:11:11 +0100
Date:   Wed, 29 Jun 2022 17:11:10 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <hch@infradead.org>,
        <alison.schofield@intel.com>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH 21/46] tools/testing/cxl: Move cxl_test resources to the
 top of memory
Message-ID: <20220629171110.000009b4@Huawei.com>
In-Reply-To: <165603886021.551046.12395967874222763381.stgit@dwillia2-xfh>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
        <165603886021.551046.12395967874222763381.stgit@dwillia2-xfh>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
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

On Thu, 23 Jun 2022 19:47:40 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> A recent QEMU upgrade resulted in collisions between QEMU's chosen
> location for PCI MMIO and cxl_test's fake address location for emulated
> CXL purposes. This was great for testing resource collisions, but not so
> great for continuing to test the nominal cases. Move cxl_test to the
> top-of-memory where it is less likely to collide with other resources.
*snigger*

Seems reasonable, though I'm sure someone else will have the same
idea for some other usecase and we'll keep moving this around...
Ah well.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  tools/testing/cxl/test/cxl.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index f52a5dd69d36..b6e6bc02a507 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -632,7 +632,8 @@ static __init int cxl_test_init(void)
>  		goto err_gen_pool_create;
>  	}
>  
> -	rc = gen_pool_add(cxl_mock_pool, SZ_512G, SZ_64G, NUMA_NO_NODE);
> +	rc = gen_pool_add(cxl_mock_pool, iomem_resource.end + 1 - SZ_64G,
> +			  SZ_64G, NUMA_NO_NODE);
>  	if (rc)
>  		goto err_gen_pool_add;
>  
> 

