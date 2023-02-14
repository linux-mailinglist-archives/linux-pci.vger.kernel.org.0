Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131E569622E
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 12:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjBNLQg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 06:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjBNLQd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 06:16:33 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2484C00;
        Tue, 14 Feb 2023 03:16:32 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PGJSW58J4z688J2;
        Tue, 14 Feb 2023 19:11:55 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Tue, 14 Feb
 2023 11:16:29 +0000
Date:   Tue, 14 Feb 2023 11:16:28 +0000
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
Subject: Re: [PATCH v3 02/16] cxl/pci: Handle truncated CDAT header
Message-ID: <20230214111628.000044ae@Huawei.com>
In-Reply-To: <7f7030bb14ad7c8e0e051319cf473ab3197da5be.1676043318.git.lukas@wunner.de>
References: <cover.1676043318.git.lukas@wunner.de>
        <7f7030bb14ad7c8e0e051319cf473ab3197da5be.1676043318.git.lukas@wunner.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
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

On Fri, 10 Feb 2023 21:25:02 +0100
Lukas Wunner <lukas@wunner.de> wrote:

> cxl_cdat_get_length() only checks whether the DOE response size is
> sufficient for the Table Access response header (1 dword), but not the
> succeeding CDAT header (1 dword length plus other fields).
> 
> It thus returns whatever uninitialized memory happens to be on the stack
> if a truncated DOE response with only 1 dword was received.  Fix it.
> 
> Fixes: c97006046c79 ("cxl/port: Read CDAT table")
> Reported-by: Ming Li <ming4.li@intel.com>
> Tested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v6.0+
Oops + thanks for fixing.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  Changes v2 -> v3:
>  * Newly added patch in v3
> 
>  drivers/cxl/core/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index d3cf1d9d67d4..11a85b3a9a0b 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -528,7 +528,7 @@ static int cxl_cdat_get_length(struct device *dev,
>  		return rc;
>  	}
>  	wait_for_completion(&t.c);
> -	if (t.task.rv < sizeof(u32))
> +	if (t.task.rv < 2 * sizeof(u32))
>  		return -EIO;
>  
>  	*length = le32_to_cpu(t.response_pl[1]);

