Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD86F696282
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 12:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjBNLdS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 06:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjBNLdR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 06:33:17 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AF14C1F;
        Tue, 14 Feb 2023 03:33:15 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PGJr33XQPz67bHh;
        Tue, 14 Feb 2023 19:28:51 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Tue, 14 Feb
 2023 11:33:12 +0000
Date:   Tue, 14 Feb 2023 11:33:11 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Lukas Wunner <lukas@wunner.de>
CC:     Bjorn Helgaas <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        "Gregory Price" <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, "Hillf Danton" <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <linuxarm@huawei.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 04/16] cxl/pci: Handle excessive CDAT length
Message-ID: <20230214113311.00000825@Huawei.com>
In-Reply-To: <4834ceab1c3e00d3ec957e6c8beb13ddaa9877a2.1676043318.git.lukas@wunner.de>
References: <cover.1676043318.git.lukas@wunner.de>
        <4834ceab1c3e00d3ec957e6c8beb13ddaa9877a2.1676043318.git.lukas@wunner.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
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

On Fri, 10 Feb 2023 21:25:04 +0100
Lukas Wunner <lukas@wunner.de> wrote:

> If the length in the CDAT header is larger than the concatenation of the
> header and all table entries, then the CDAT exposed to user space
> contains trailing null bytes.
> 
> Not every consumer may be able to handle that.  Per Postel's robustness
> principle, "be liberal in what you accept" and silently reduce the
> cached length to avoid exposing those null bytes.
> 
> Fixes: c97006046c79 ("cxl/port: Read CDAT table")
> Tested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v6.0+

Fair enough. I'd argue that we are papering over broken hardware if
we hit these conditions, so given we aren't aware of any (I hope)
not sure this is stable material.  Argument in favor of stable being
that if we do get broken hardware we don't want an ABI change when
we paper over the garbage... hmm.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  Changes v2 -> v3:
>  * Newly added patch in v3
> 
>  drivers/cxl/core/pci.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index a3fb6bd68d17..c37c41d7acb6 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -582,6 +582,9 @@ static int cxl_cdat_read_table(struct device *dev,
>  		}
>  	} while (entry_handle != CXL_DOE_TABLE_ACCESS_LAST_ENTRY);
>  
> +	/* Length in CDAT header may exceed concatenation of CDAT entries */
> +	cdat->length -= length;
> +
>  	return 0;
>  }
>  

