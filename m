Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA746907B4
	for <lists+linux-pci@lfdr.de>; Thu,  9 Feb 2023 12:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjBILsb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Feb 2023 06:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjBILsC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Feb 2023 06:48:02 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C611455E6D;
        Thu,  9 Feb 2023 03:35:06 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PCF955Vj7z6JB0s;
        Thu,  9 Feb 2023 19:32:57 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Thu, 9 Feb
 2023 11:34:23 +0000
Date:   Thu, 9 Feb 2023 11:34:22 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <rafael@kernel.org>,
        <bhelgaas@google.com>, <robert.moore@intel.com>
Subject: Re: [PATCH 03/18] cxl: Add checksum verification to CDAT from CXL
Message-ID: <20230209113422.00007017@Huawei.com>
In-Reply-To: <167571658747.587790.17252249256706733075.stgit@djiang5-mobl3.local>
References: <167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local>
        <167571658747.587790.17252249256706733075.stgit@djiang5-mobl3.local>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
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

On Mon, 06 Feb 2023 13:49:48 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> A CDAT table is available from a CXL device. The table is read by the
> driver and cached in software. With the CXL subsystem needing to parse the
> CDAT table, the checksum should be verified. Add checksum verification
> after the CDAT table is read from device.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Hi Dave,

Some comments on this follow on from previous patch so may not
be relevant once you've updated how that is done.

Jonathan

> ---
>  drivers/cxl/core/pci.c |   11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 57764e9cd19d..a24dac36bedd 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -3,6 +3,7 @@
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/device.h>
>  #include <linux/delay.h>
> +#include <linux/acpi.h>
>  #include <linux/pci.h>
>  #include <linux/pci-doe.h>
>  #include <cxlpci.h>
> @@ -592,6 +593,7 @@ void read_cdat_data(struct cxl_port *port)
>  	struct device *dev = &port->dev;
>  	struct device *uport = port->uport;
>  	size_t cdat_length;
> +	acpi_status status;
>  	int rc;
>  
>  	cdat_doe = find_cdat_doe(uport);
> @@ -620,5 +622,14 @@ void read_cdat_data(struct cxl_port *port)
>  		port->cdat.length = 0;
>  		dev_err(dev, "CDAT data read error\n");
>  	}
> +
> +	status = acpi_ut_verify_cdat_checksum(port->cdat.table, port->cdat.length);
> +	if (status != AE_OK) {

if (ACPI_FAILURE(acpi_ut...))  or better still put that in the wrapper I suggeste
in previous patch so that we have normal kernel return code handling out here.


> +		/* Don't leave table data allocated on error */
> +		devm_kfree(dev, port->cdat.table);
> +		port->cdat.table = NULL;
> +		port->cdat.length = 0;

I'd rather see us manipulate a local copy of cdat_length, and cdat_table
then only assign them to the port->cdat fields the success path rather
than setting them then unsetting the on error.

Diff will be bigger, but nicer resulting code (and hopefully diff
won't be too big!)


> +		dev_err(dev, "CDAT data checksum error\n");
> +	}
>  }
>  EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
> 
> 

