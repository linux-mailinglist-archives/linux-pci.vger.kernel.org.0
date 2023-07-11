Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A65074E8D0
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jul 2023 10:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjGKIPh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jul 2023 04:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjGKIPg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jul 2023 04:15:36 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5053E3;
        Tue, 11 Jul 2023 01:15:33 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4R0YWX1TFrz67q1F;
        Tue, 11 Jul 2023 16:12:24 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 11 Jul
 2023 09:15:30 +0100
Date:   Tue, 11 Jul 2023 09:15:29 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] cxl/pci: Remove unnecessary aer.h include
Message-ID: <20230711091529.00004d71@Huawei.com>
In-Reply-To: <20230710231416.232751-1-helgaas@kernel.org>
References: <20230710231416.232751-1-helgaas@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 10 Jul 2023 18:14:16 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> <linux/aer.h> is unused, so remove it.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ben Widawsky <bwidawsk@kernel.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
Was just working on splitting this file up as part of forward porting
the switch-cci and noticed this as well!

Lot of churn in this file in the recent past and I'll make it worse,
so good to keep on top of these includes.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/pci.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 1cb1494c28fe..8314cf2ac16a 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -8,7 +8,6 @@
>  #include <linux/mutex.h>
>  #include <linux/list.h>
>  #include <linux/pci.h>
> -#include <linux/aer.h>
>  #include <linux/io.h>
>  #include "cxlmem.h"
>  #include "cxlpci.h"

