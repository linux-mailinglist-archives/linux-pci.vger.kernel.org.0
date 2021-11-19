Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7EC4570EC
	for <lists+linux-pci@lfdr.de>; Fri, 19 Nov 2021 15:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235997AbhKSOnl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 09:43:41 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4112 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbhKSOnl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Nov 2021 09:43:41 -0500
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HwfT155wQz67tVr;
        Fri, 19 Nov 2021 22:39:49 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 19 Nov 2021 15:40:37 +0100
Received: from localhost (10.52.121.45) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 19 Nov
 2021 14:40:36 +0000
Date:   Fri, 19 Nov 2021 14:40:30 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <ben.widawsky@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 4/5] cxl/mem: Add CDAT table reading from DOE
Message-ID: <20211119144030.00002f86@Huawei.com>
In-Reply-To: <20211105235056.3711389-5-ira.weiny@intel.com>
References: <20211105235056.3711389-1-ira.weiny@intel.com>
        <20211105235056.3711389-5-ira.weiny@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.121.45]
X-ClientProxiedBy: lhreml737-chm.china.huawei.com (10.201.108.187) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 5 Nov 2021 16:50:55 -0700
<ira.weiny@intel.com> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Read CDAT raw table data from the cxl_mem state object.  Currently this
> is only supported by a PCI CXL object through a DOE mailbox which supports
> CDAT.  But any cxl_mem type object can provide this data later if need
> be.  For example for testing.
> 
> Cache this data for later parsing.  Provide a sysfs binary attribute to
> allow dumping of the CDAT.
> 
> Binary dumping is modeled on /sys/firmware/ACPI/tables/
> 
> The ability to dump this table will be very useful for emulation of real
> devices once they become available as QEMU CXL type 3 device emulation will
> be able to load this file in.
> 
> This does not support table updates at runtime. It will always provide
> whatever was there when first cached. Handling of table updates can be
> implemented later.
> 
> Once there are more users, this code can move out to driver/cxl/cdat.c
> or similar.
> 
> Finally create a complete list of DOE defines within cdat.h for anyone
> wishing to decode the CDAT table.
> 
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 

>  
>  static struct attribute_group cxl_memdev_ram_attribute_group = {
> @@ -293,6 +329,16 @@ devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
>  	if (rc)
>  		goto err;
>  
> +	/* Cache the data early to ensure is_visible() works */
> +	if (!cxl_mem_cdat_get_length(cxlds, &cxlmd->cdat_length)) {
> +		cxlmd->cdat_table = devm_kzalloc(dev, cxlmd->cdat_length, GFP_KERNEL);

I think this devm_ call should be using the parent device, not this one.

As it stands it breaks Ben's mem.c driver which probes for this device
and fails because you can't call probe for a device that already has things
in it's devres queue.

Too many patches in flight at the same time makes for some entertaining
rebases if you want them all at once..

Jonathan

> +		if (!cxlmd->cdat_table) {
> +			rc = -ENOMEM;
> +			goto err;
> +		}
> +		cxl_mem_cdat_read_table(cxlds, cxlmd->cdat_table, cxlmd->cdat_length);
> +	}
> +
>  	/*
>  	 * Activate ioctl operations, no cxl_memdev_rwsem manipulation
>  	 * needed as this is ordered with cdev_add() publishing the device.
