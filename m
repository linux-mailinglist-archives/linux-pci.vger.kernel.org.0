Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0088F690CD6
	for <lists+linux-pci@lfdr.de>; Thu,  9 Feb 2023 16:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjBIPYY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Feb 2023 10:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjBIPYX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Feb 2023 10:24:23 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E463CB4;
        Thu,  9 Feb 2023 07:24:21 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PCLGP0p3Gz6J9dv;
        Thu,  9 Feb 2023 23:22:53 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Thu, 9 Feb
 2023 15:24:18 +0000
Date:   Thu, 9 Feb 2023 15:24:17 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <rafael@kernel.org>,
        <bhelgaas@google.com>, <robert.moore@intel.com>
Subject: Re: [PATCH 13/18] cxl: Add latency and bandwidth calculations for
 the CXL path
Message-ID: <20230209152417.00007f47@Huawei.com>
In-Reply-To: <167571667794.587790.14172786993094257614.stgit@djiang5-mobl3.local>
References: <167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local>
        <167571667794.587790.14172786993094257614.stgit@djiang5-mobl3.local>
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

On Mon, 06 Feb 2023 13:51:19 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> CXL Memory Device SW Guide rev1.0 2.11.2 provides instruction on how to
> caluclate latency and bandwidth for CXL memory device. Calculate minimum

Spell check your descriptions (I often forget to do this as well!
)
> bandwidth and total latency for the path from the CXL device to the root
> port. The calculates values are stored in the cached DSMAS entries attached
> to the cxl_port of the CXL device.
> 
> For example for a device that is directly attached to a host bus:
> Total Latency = Device Latency (from CDAT) + Dev to Host Bus (HB) Link
> 		Latency
> Min Bandwidth = Link Bandwidth between Host Bus and CXL device
> 
> For a device that has a switch in between host bus and CXL device:
> Total Latency = Device (CDAT) Latency + Dev to Switch Link Latency +
> 		Switch (CDAT) Latency + Switch to HB Link Latency

For QTG purposes, are we also supposed to take into account HB to
system interconnect type latency (or maybe nearest CPU?).
That is likely to be non trivial.

> Min Bandwidth = min(dev to switch bandwidth, switch to HB bandwidth)
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Stray sign off.

> 
> The internal latency for a switch can be retrieved from the CDAT of the
> switch PCI device. However, since there's no easy way to retrieve that
> right now on Linux, a guesstimated constant is used per switch to simplify
> the driver code.

I'd like to see that gap closed asap. I think it is fairly obvious how to do
it, so shouldn't be too hard, just needs a dance to get the DOE for a switch
port using Lukas' updated handling of DOE mailboxes. 

> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/port.c |   60 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h       |    9 +++++++
>  drivers/cxl/port.c      |   42 +++++++++++++++++++++++++++++++++
>  3 files changed, 111 insertions(+)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 2b27319cfd42..aa260361ba7d 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1899,6 +1899,66 @@ bool schedule_cxl_memdev_detach(struct cxl_memdev *cxlmd)
>  }
>  EXPORT_SYMBOL_NS_GPL(schedule_cxl_memdev_detach, CXL);
>  
> +int cxl_port_get_downstream_qos(struct cxl_port *port, long *bw, long *lat)
> +{
> +	long total_lat = 0, latency;

Similar to before, not good for readability to hide asignments in a list all on one line.

