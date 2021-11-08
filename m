Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18ECA44975C
	for <lists+linux-pci@lfdr.de>; Mon,  8 Nov 2021 16:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbhKHPFZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Nov 2021 10:05:25 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4072 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbhKHPFY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Nov 2021 10:05:24 -0500
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HnvNx6RFNz67H9S;
        Mon,  8 Nov 2021 22:57:53 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Mon, 8 Nov 2021 16:02:37 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 8 Nov
 2021 15:02:37 +0000
Date:   Mon, 8 Nov 2021 15:02:36 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <ben.widawsky@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 4/5] cxl/mem: Add CDAT table reading from DOE
Message-ID: <20211108150236.00003a6c@Huawei.com>
In-Reply-To: <20211105235056.3711389-5-ira.weiny@intel.com>
References: <20211105235056.3711389-1-ira.weiny@intel.com>
        <20211105235056.3711389-5-ira.weiny@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
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

A few more things came to mind whilst reading the rest of the series. In particular
lifetime management for the doe structures.

>   * DOC: cxl pci
> @@ -575,17 +576,106 @@ static int cxl_setup_doe_devices(struct cxl_dev_state *cxlds)
>  		if (rc)
>  			return rc;
>  
> -		if (device_attach(&adev->dev) != 1)
> +		if (device_attach(&adev->dev) != 1) {
>  			dev_err(&adev->dev,
>  				"Failed to attach a driver to DOE device %d\n",
>  				adev->id);
> +			goto next;
> +		}
> +
> +		if (pci_doe_supports_prot(new_dev, PCI_DVSEC_VENDOR_ID_CXL,
> +					  CXL_DOE_PROTOCOL_TABLE_ACCESS))
> +			cxlds->cdat_doe = new_dev;

I'm probably missing something, but what prevents new_dev from going away after
this assignment?  Perhaps a force unbind or driver removal.  Should we get a
reference?

Also it's possible we'll have multiple CDAT supporting DOEs so
I'd suggest checking if cxlds->cdata_doe is already set before setting it.

We could break out of the loop early, but I want to bolt the CMA doe detection
in there so I'd rather we didn't.  This is all subject to whether we attempt
to generalize this support and move it over to the PCI side of things.

>  
> +next:
>  		pos = pci_find_next_ext_capability(pdev, pos, PCI_EXT_CAP_ID_DOE);
>  	}
>  
>  	return 0;
>  }
>  
