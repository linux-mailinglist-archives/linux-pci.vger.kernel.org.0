Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8037B690CFF
	for <lists+linux-pci@lfdr.de>; Thu,  9 Feb 2023 16:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjBIPbX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Feb 2023 10:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbjBIPbW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Feb 2023 10:31:22 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB765BA6A;
        Thu,  9 Feb 2023 07:31:20 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PCLMN2dLmz67KSc;
        Thu,  9 Feb 2023 23:27:12 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Thu, 9 Feb
 2023 15:31:18 +0000
Date:   Thu, 9 Feb 2023 15:31:17 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <rafael@kernel.org>,
        <bhelgaas@google.com>, <robert.moore@intel.com>
Subject: Re: [PATCH 16/18] cxl: Move reading of CDAT data from device to
 after media is ready
Message-ID: <20230209153117.00006cdf@Huawei.com>
In-Reply-To: <167571670516.587790.14112456054041985666.stgit@djiang5-mobl3.local>
References: <167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local>
        <167571670516.587790.14112456054041985666.stgit@djiang5-mobl3.local>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
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

On Mon, 06 Feb 2023 13:51:46 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> The CDAT data is only valid after the hardware signals the media is ready.
> Move the reading to after cxl_await_media_ready() has succeeded.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Fix?  Though I doubt we care about backporting this one as until
after this patch series, CDAT was mostly informational so hopefully
no one relies on it.

Jonathan

> ---
>  drivers/cxl/port.c |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index b7a4a1be2945..6b2ad22487f5 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -91,9 +91,6 @@ static int cxl_port_probe(struct device *dev)
>  		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport);
>  		struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  
> -		/* Cache the data early to ensure is_visible() works */
> -		read_cdat_data(port);
> -
>  		get_device(&cxlmd->dev);
>  		rc = devm_add_action_or_reset(dev, schedule_detach, cxlmd);
>  		if (rc)
> @@ -109,6 +106,8 @@ static int cxl_port_probe(struct device *dev)
>  			return rc;
>  		}
>  
> +		/* Cache the data early to ensure is_visible() works */
> +		read_cdat_data(port);
>  		if (port->cdat.table) {
>  			rc = cdat_table_parse_dsmas(port->cdat.table,
>  						    cxl_dsmas_parse_entry,
> 
> 

