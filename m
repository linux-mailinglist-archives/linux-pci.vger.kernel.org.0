Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D8156056D
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 18:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbiF2QIt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 12:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbiF2QIs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 12:08:48 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43974205D7;
        Wed, 29 Jun 2022 09:08:46 -0700 (PDT)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LY5rT0GcFz67NYn;
        Thu, 30 Jun 2022 00:04:41 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 29 Jun 2022 18:08:43 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.24; Wed, 29 Jun
 2022 17:08:43 +0100
Date:   Wed, 29 Jun 2022 17:08:41 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <hch@infradead.org>,
        <alison.schofield@intel.com>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH 20/46] cxl/mem: Add a debugfs version of 'iomem' for
 DPA, 'dpamem'
Message-ID: <20220629170841.000078e5@Huawei.com>
In-Reply-To: <165603885318.551046.8308248564880066726.stgit@dwillia2-xfh>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
        <165603885318.551046.8308248564880066726.stgit@dwillia2-xfh>
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

On Thu, 23 Jun 2022 19:47:33 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Dump the device-physial-address map for a CXL expander in /proc/iomem
> style format. E.g.:
> 
>   cat /sys/kernel/debug/cxl/mem1/dpamem
>   00000000-0fffffff : ram
>   10000000-1fffffff : pmem

Nice in general, but...

When I just checked what this looked like on my test setup. I'm 
seeing
00000000-0ffffff : pmem
  00000000-0fffff : endpoint3

Seems odd to see an endpoint nested below a pmem.  Wrong name somewhere
in a later patch. I'd expect that to be a decoder rather than the endpoint...
If I spot where that comes from whilst reviewing I'll call it out, but
didn't want to forget to raise it.

This patch is fine.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/core.h |    1 -
>  drivers/cxl/core/hdm.c  |   23 +++++++++++++++++++++++
>  drivers/cxl/core/port.c |    1 +
>  drivers/cxl/cxlmem.h    |    4 ++++
>  drivers/cxl/mem.c       |   23 +++++++++++++++++++++++
>  5 files changed, 51 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index c242fa02d5e8..472ec9cb1018 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -24,7 +24,6 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
>  resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled);
>  resource_size_t cxl_dpa_resource(struct cxl_endpoint_decoder *cxled);
>  
> -struct dentry *cxl_debugfs_create_dir(const char *dir);
>  int cxl_memdev_init(void);
>  void cxl_memdev_exit(void);
>  void cxl_mbox_init(void);
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index ceb4c28abc1b..c0164f9b2195 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
>  #include <linux/io-64-nonatomic-hi-lo.h>
> +#include <linux/seq_file.h>
>  #include <linux/device.h>
>  #include <linux/delay.h>
>  
> @@ -248,6 +249,28 @@ static int cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
>  }
>  
> +static void __cxl_dpa_debug(struct seq_file *file, struct resource *r, int depth)
> +{
> +	unsigned long long start = r->start, end = r->end;
> +
> +	seq_printf(file, "%*s%08llx-%08llx : %s\n", depth * 2, "", start, end,
> +		   r->name);
> +}
> +
> +void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds)
> +{
> +	struct resource *p1, *p2;
> +
> +	down_read(&cxl_dpa_rwsem);
> +	for (p1 = cxlds->dpa_res.child; p1; p1 = p1->sibling) {
> +		__cxl_dpa_debug(file, p1, 0);
> +		for (p2 = p1->child; p2; p2 = p2->sibling)
> +			__cxl_dpa_debug(file, p2, 1);
> +	}
> +	up_read(&cxl_dpa_rwsem);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_dpa_debug, CXL);
> +
>  resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled)
>  {
>  	resource_size_t size = 0;
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index f02b7470c20e..4e4e26ca507c 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1702,6 +1702,7 @@ struct dentry *cxl_debugfs_create_dir(const char *dir)
>  {
>  	return debugfs_create_dir(dir, cxl_debugfs);
>  }
> +EXPORT_SYMBOL_NS_GPL(cxl_debugfs_create_dir, CXL);
>  
>  static __init int cxl_core_init(void)
>  {
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index b4e5ed9eabc9..db9c889f42ab 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -385,4 +385,8 @@ struct cxl_hdm {
>  	unsigned int interleave_mask;
>  	struct cxl_port *port;
>  };
> +
> +struct seq_file;
> +struct dentry *cxl_debugfs_create_dir(const char *dir);
> +void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds);
>  #endif /* __CXL_MEM_H__ */
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index a979d0b484d5..7513bea55145 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
> +#include <linux/debugfs.h>
>  #include <linux/device.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> @@ -56,10 +57,26 @@ static void enable_suspend(void *data)
>  	cxl_mem_active_dec();
>  }
>  
> +static void remove_debugfs(void *dentry)
> +{
> +	debugfs_remove_recursive(dentry);
> +}
> +
> +static int cxl_mem_dpa_show(struct seq_file *file, void *data)
> +{
> +	struct device *dev = file->private;
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +
> +	cxl_dpa_debug(file, cxlmd->cxlds);
> +
> +	return 0;
> +}
> +
>  static int cxl_mem_probe(struct device *dev)
>  {
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  	struct cxl_port *parent_port;
> +	struct dentry *dentry;
>  	int rc;
>  
>  	/*
> @@ -73,6 +90,12 @@ static int cxl_mem_probe(struct device *dev)
>  	if (work_pending(&cxlmd->detach_work))
>  		return -EBUSY;
>  
> +	dentry = cxl_debugfs_create_dir(dev_name(dev));
> +	debugfs_create_devm_seqfile(dev, "dpamem", dentry, cxl_mem_dpa_show);
> +	rc = devm_add_action_or_reset(dev, remove_debugfs, dentry);
> +	if (rc)
> +		return rc;
> +
>  	rc = devm_cxl_enumerate_ports(cxlmd);
>  	if (rc)
>  		return rc;
> 

