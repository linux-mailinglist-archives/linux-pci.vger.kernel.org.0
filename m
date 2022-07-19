Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19EAD57A485
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jul 2022 19:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237694AbiGSREK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jul 2022 13:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237828AbiGSREG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jul 2022 13:04:06 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE8C57E33;
        Tue, 19 Jul 2022 10:04:04 -0700 (PDT)
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LnPjm1zldz684JJ;
        Wed, 20 Jul 2022 00:41:32 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Tue, 19 Jul 2022 18:46:03 +0200
Received: from localhost (10.81.209.49) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 19 Jul
 2022 17:46:02 +0100
Date:   Tue, 19 Jul 2022 17:46:01 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>,
        <linux-pci@vger.kernel.org>, <lukas@wunner.de>,
        <bhelgaas@google.com>
Subject: Re: [PATCH v15 6/7] cxl/port: Read CDAT table
Message-ID: <20220719174601.000020c4@Huawei.com>
In-Reply-To: <165819557164.881384.15799533765517431824.stgit@dwillia2-xfh.jf.intel.com>
References: <20220715030424.462963-7-ira.weiny@intel.com>
        <165819557164.881384.15799533765517431824.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.209.49]
X-ClientProxiedBy: lhreml749-chm.china.huawei.com (10.201.108.199) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 18 Jul 2022 18:55:01 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> From: Ira Weiny <ira.weiny@intel.com>
> 
> The per-device CDAT data provides performance data that is relevant for
> mapping which CXL devices can participate in which CXL ranges by QTG
> (QoS Throttling Group) (per ECN: CXL 2.0 CEDT CFMWS & QTG_DSM) [1]. The
> QTG association specified in the ECN is advisory. Until the
> cxl_acpi driver grows support for invoking the QTG _DSM method the CDAT
> data is only of interest to userspace that may need it for debug
> purposes.
> 
> Search the DOE mailboxes available, query CDAT data, cache the data and
> make it available via a sysfs binary attribute per endpoint at:
> 
> /sys/bus/cxl/devices/endpointX/CDAT
> 
> ...similar to other ACPI-structured table data in
> /sys/firmware/ACPI/tables. The CDAT is relative to 'struct cxl_port'
> objects since switches in addition to endpoints can host a CDAT
> instance. Switch CDAT support is not implemented.
> 
> This does not support table updates at runtime. It will always provide
> whatever was there when first cached. It is also the case that table
> updates are not expected outside of explicit DPA address map affecting
> commands like Set Partition with the immediate flag set. Given that the
> driver does not support Set Partition with the immediate flag set there
> is no current need for update support.
> 
> Link: https://www.computeexpresslink.org/spec-landing [1]
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> [djbw: drop in-kernel parsing infra for now, and other minor fixups]
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
One comment inline that basically says the error message will do for now
if we race with an autonomous update of CDAT by the device. (see response
to earlier version on why that can happen).

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 7672789c3225..9240df53ed87 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c


> +/**
> + * read_cdat_data - Read the CDAT data on this port
> + * @port: Port to read data from
> + *
> + * This call will sleep waiting for responses from the DOE mailbox.
> + */
> +void read_cdat_data(struct cxl_port *port)
> +{
> +	struct pci_doe_mb *cdat_doe;
> +	struct device *dev = &port->dev;
> +	struct device *uport = port->uport;
> +	size_t cdat_length;
> +	int rc;
> +
> +	cdat_doe = find_cdat_doe(uport);
> +	if (!cdat_doe) {
> +		dev_dbg(dev, "No CDAT mailbox\n");
> +		return;
> +	}
> +
> +	port->cdat_available = true;
> +
> +	if (cxl_cdat_get_length(dev, cdat_doe, &cdat_length)) {
> +		dev_dbg(dev, "No CDAT length\n");
> +		return;
> +	}
> +
> +	port->cdat.table = devm_kzalloc(dev, cdat_length, GFP_KERNEL);
> +	if (!port->cdat.table)
> +		return;
> +
> +	port->cdat.length = cdat_length;
> +	rc = cxl_cdat_read_table(dev, cdat_doe, &port->cdat);
> +	if (rc) {
> +		/* Don't leave table data allocated on error */
> +		devm_kfree(dev, port->cdat.table);
> +		port->cdat.table = NULL;
> +		port->cdat.length = 0;
> +		dev_err(dev, "CDAT data read error\n");

This will be sufficient for now for the race against autonomous CDAT
update potential issue mentioned in earlier review.  If it happens
and someone really cares they can unbind and rebind the device.

> +	}
> +}
> +EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);


>  

