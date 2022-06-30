Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A04561645
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jun 2022 11:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbiF3J0o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jun 2022 05:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbiF3J0m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jun 2022 05:26:42 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7D13E5FB;
        Thu, 30 Jun 2022 02:26:41 -0700 (PDT)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LYXw04MHsz6817f;
        Thu, 30 Jun 2022 17:24:16 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Thu, 30 Jun 2022 11:26:39 +0200
Received: from localhost (10.81.200.250) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 30 Jun
 2022 10:26:38 +0100
Date:   Thu, 30 Jun 2022 10:26:37 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>,
        <hch@lst.de>, "Ben Widawsky" <bwidawsk@kernel.org>
Subject: Re: [PATCH 30/46] cxl/hdm: Add sysfs attributes for interleave ways
 + granularity
Message-ID: <20220630102637.00001d53@Huawei.com>
In-Reply-To: <20220624041950.559155-5-dan.j.williams@intel.com>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
        <20220624041950.559155-5-dan.j.williams@intel.com>
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

On Thu, 23 Jun 2022 21:19:34 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> From: Ben Widawsky <bwidawsk@kernel.org>
> 
> The region provisioning flow involves selecting interleave ways +
> granularity settings for a region, and then programming the decoder
> topology to meet those constraints, if possible. For example, root
> decoders set the minimum interleave ways + granularity for any hosted
> regions.
> 
> Given decoder programming is not atomic and collisions can occur between
> multiple requesting regions userpace will be resonsible for conflict
> resolution and it needs these attributes to make those decisions.
> 
> Signed-off-by: Ben Widawsky <bwidawsk@kernel.org>
> [djbw: reword changelog, make read-only, add sysfs ABI documentaion]
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
some comments on docs.

> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 23 +++++++++++++++++++++++
>  drivers/cxl/core/port.c                 | 23 +++++++++++++++++++++++
>  2 files changed, 46 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 85844f9bc00b..2a4e4163879f 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -215,3 +215,26 @@ Description:
>  		allocations are enforced to occur in increasing 'decoderX.Y/id'
>  		order and frees are enforced to occur in decreasing
>  		'decoderX.Y/id' order.
> +
> +
> +What:		/sys/bus/cxl/devices/decoderX.Y/interleave_ways
> +Date:		May, 2022
> +KernelVersion:	v5.20
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) The number of targets across which this decoder's host
> +		physical address (HPA) memory range is interleaved. The device
> +		maps every Nth block of HPA (of size ==
> +		'interleave_granularity') to consecutive DPA addresses. The
> +		decoder's position in the interleave is determined by the
> +		device's (endpoint or switch) switch ancestry.

Perhaps make it clear what happens for host bridges (i.e. decoder position
in interleave defined by fixed memory window.

> +
> +
> +What:		/sys/bus/cxl/devices/decoderX.Y/interleave_granularity
> +Date:		May, 2022
> +KernelVersion:	v5.20
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) The number of consecutive bytes of host physical address
> +		space this decoder claims at address N before awaint the next

awaint?

> +		address (N + interleave_granularity * intereleave_ways).

interleave_ways

Even knowing exactly what this is, I don't understand the docs so
perhaps reword this :)

> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index c48f217e689a..08a380d20cf1 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -260,10 +260,33 @@ static ssize_t dpa_size_store(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RW(dpa_size);
>  
> +static ssize_t interleave_granularity_show(struct device *dev,
> +					   struct device_attribute *attr,
> +					   char *buf)
> +{
> +	struct cxl_decoder *cxld = to_cxl_decoder(dev);
> +
> +	return sysfs_emit(buf, "%d\n", cxld->interleave_granularity);
> +}
> +
> +static DEVICE_ATTR_RO(interleave_granularity);
> +
> +static ssize_t interleave_ways_show(struct device *dev,
> +				    struct device_attribute *attr, char *buf)
> +{
> +	struct cxl_decoder *cxld = to_cxl_decoder(dev);
> +
> +	return sysfs_emit(buf, "%d\n", cxld->interleave_ways);
> +}
> +
> +static DEVICE_ATTR_RO(interleave_ways);
> +
>  static struct attribute *cxl_decoder_base_attrs[] = {
>  	&dev_attr_start.attr,
>  	&dev_attr_size.attr,
>  	&dev_attr_locked.attr,
> +	&dev_attr_interleave_granularity.attr,
> +	&dev_attr_interleave_ways.attr,
>  	NULL,
>  };
>  

