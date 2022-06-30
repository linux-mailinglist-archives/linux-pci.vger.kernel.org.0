Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D352561CBE
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jun 2022 16:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235990AbiF3ONb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jun 2022 10:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237201AbiF3OMq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jun 2022 10:12:46 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C58187346;
        Thu, 30 Jun 2022 06:56:41 -0700 (PDT)
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LYfxL5y3Cz67kFH;
        Thu, 30 Jun 2022 21:55:50 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Thu, 30 Jun 2022 15:56:39 +0200
Received: from localhost (10.81.200.250) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 30 Jun
 2022 14:56:38 +0100
Date:   Thu, 30 Jun 2022 14:56:36 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>,
        <hch@lst.de>, "Ben Widawsky" <bwidawsk@kernel.org>
Subject: Re: [PATCH 37/46] cxl/region: Allocate host physical address (HPA)
 capacity to new regions
Message-ID: <20220630145636.00002f12@Huawei.com>
In-Reply-To: <20220624041950.559155-12-dan.j.williams@intel.com>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
        <20220624041950.559155-12-dan.j.williams@intel.com>
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

On Thu, 23 Jun 2022 21:19:41 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> After a region's interleave parameters (ways and granularity) are set,
> add a way for regions to allocate HPA from the free capacity in their
> decoder. The allocator for this capacity reuses the 'struct resource'
> based allocator used for CONFIG_DEVICE_PRIVATE.
> 
> Once the tuple of "ways, granularity, and size" is set the
> region configuration transitions to the CXL_CONFIG_INTERLEAVE_ACTIVE
> state which is a precursor to allowing endpoint decoders to be added to
> a region.
> 
> Co-developed-by: Ben Widawsky <bwidawsk@kernel.org>
> Signed-off-by: Ben Widawsky <bwidawsk@kernel.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

A few comments on the interface inline.

Thanks,

Jonathan

> ---
>  Documentation/ABI/testing/sysfs-bus-cxl |  25 ++++
>  drivers/cxl/Kconfig                     |   3 +
>  drivers/cxl/core/region.c               | 148 +++++++++++++++++++++++-
>  drivers/cxl/cxl.h                       |   2 +
>  4 files changed, 177 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 46d5295c1149..3658facc9944 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -294,3 +294,28 @@ Description:
>  		(RW) Configures the number of devices participating in the
>  		region is set by writing this value. Each device will provide
>  		1/interleave_ways of storage for the region.
> +
> +
> +What:		/sys/bus/cxl/devices/regionZ/size
> +Date:		May, 2022
> +KernelVersion:	v5.20
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RW) System physical address space to be consumed by the region.
> +		When written to, this attribute will allocate space out of the
> +		CXL root decoder's address space. When read the size of the
> +		address space is reported and should match the span of the
> +		region's resource attribute. Size shall be set after the
> +		interleave configuration parameters.

There seem to be constraints that say you have to set this to 0 and then something
else later to force a resize. That should be mentioned here or gotten rid of.


> +
> +
> +What:		/sys/bus/cxl/devices/regionZ/resource
> +Date:		May, 2022
> +KernelVersion:	v5.20
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) A region is a contiguous partition of a CXL root decoder
> +		address space. Region capacity is allocated by writing to the
> +		size attribute, the resulting physical address space determined
> +		by the driver is reflected here. It is therefore not useful to
> +		read this before writing a value to the size attribute.

I don't much like naming a "base address" resource.  I'd expect resource to contain
both base and size whereas this only has the base address of the region.


