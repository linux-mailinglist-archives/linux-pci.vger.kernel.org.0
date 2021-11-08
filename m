Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAFC5448033
	for <lists+linux-pci@lfdr.de>; Mon,  8 Nov 2021 14:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239890AbhKHNYn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Nov 2021 08:24:43 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4070 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239905AbhKHNYk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Nov 2021 08:24:40 -0500
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Hns8j2jJ6z685Z9;
        Mon,  8 Nov 2021 21:17:09 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Mon, 8 Nov 2021 14:21:53 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 8 Nov
 2021 13:21:52 +0000
Date:   Mon, 8 Nov 2021 13:21:51 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <ben.widawsky@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 4/5] cxl/mem: Add CDAT table reading from DOE
Message-ID: <20211108132151.0000319c@Huawei.com>
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

Hi Ira,

A few other comments inline, some of which are really updates of
earlier comments now I see how it is fitting together.

Jonathan

> 
> ---
> Changes from V4:
> 	Split this into it's own patch
> 	Rearchitect this such that the memdev driver calls into the DOE
> 	driver via the cxl_mem state object.  This allows CDAT data to
> 	come from any type of cxl_mem object not just PCI DOE.

Ah.  Is this to allow mocking? Or is there another architected source
of this information that I've missed?

> 	Rebase on new struct cxl_dev_state
> ---

...

> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index df524b74f1d2..086532a42480 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -11,6 +11,7 @@
>  #include "cxlmem.h"
>  #include "pci.h"
>  #include "cxl.h"
> +#include "cdat.h"
>  
>  /**
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

Ah. If we did try to make this block generic, we'd then need a look
up function to call after the generic part.  I guess it is getting more
complex so maybe not having it generic is the right choice for now.

Also, this explains why you passed cxlds in.  So ignore that comment on
the previous.

>  
> +next:
>  		pos = pci_find_next_ext_capability(pdev, pos, PCI_EXT_CAP_ID_DOE);
>  	}
>  
>  	return 0;
>  }
>  
> +#define CDAT_DOE_REQ(entry_handle)					\
> +	(FIELD_PREP(CXL_DOE_TABLE_ACCESS_REQ_CODE,			\
> +		    CXL_DOE_TABLE_ACCESS_REQ_CODE_READ) |		\
> +	 FIELD_PREP(CXL_DOE_TABLE_ACCESS_TABLE_TYPE,			\
> +		    CXL_DOE_TABLE_ACCESS_TABLE_TYPE_CDATA) |		\
> +	 FIELD_PREP(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE, (entry_handle)))
> +
> +static int cxl_cdat_get_length(struct cxl_dev_state *cxlds, size_t *length)
> +{
> +	struct pci_doe_dev *doe_dev = cxlds->cdat_doe;
> +	u32 cdat_request_pl = CDAT_DOE_REQ(0);
> +	u32 cdat_response_pl[32];
> +	struct pci_doe_exchange ex = {
> +		.prot.vid = PCI_DVSEC_VENDOR_ID_CXL,
> +		.prot.type = CXL_DOE_PROTOCOL_TABLE_ACCESS,
> +		.request_pl = &cdat_request_pl,
> +		.request_pl_sz = sizeof(cdat_request_pl),
> +		.response_pl = cdat_response_pl,
> +		.response_pl_sz = sizeof(cdat_response_pl),
> +	};
> +
> +	ssize_t rc;
> +
> +	rc = pci_doe_exchange_sync(doe_dev, &ex);
> +	if (rc < 0)
> +		return rc;
> +	if (rc < 1)
> +		return -EIO;
> +
> +	*length = cdat_response_pl[1];
> +	dev_dbg(cxlds->dev, "CDAT length %zu\n", *length);

Probably not useful any more... 

> +	return 0;
> +}
> +

