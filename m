Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E75462AE961
	for <lists+linux-pci@lfdr.de>; Wed, 11 Nov 2020 08:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725859AbgKKHKJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Nov 2020 02:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgKKHKJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Nov 2020 02:10:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CC8C0613D1;
        Tue, 10 Nov 2020 23:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qY6GsokNhT+EXzs5nQrwOVhDRZ4DEpog47vVj/s5f74=; b=ekNfnfmYL+you/M/HXdp4fwN1D
        E/jGSjNgqZgHOEhdrU6IBbZLY/KVbFadnyRB8Vs8JX9Hki9X87O418pPj4oSlVxedqp6Yv0IA2eyJ
        aDyrDVbzHRE6w1cI9Uydxiy74ax+uznsyudXBZXe9omCYy3yW/tnL6kKl5VzJZNy99+0PROUzaZym
        eNiO5Ufo58CFh2SZ/nXhnAPIZq3nYvKm/Owbt1RofmB8oQ45odlLITxJBMHoxUsUtsqLXpI9GxsgH
        Vkzb3EiJZx0VxUcHNkF5o9r9uFLDbKUK9uscus+dMNxeJ3yQ4OuAIdrejzHo3Qw6YYLxYFqMDR5/5
        vWYOgksQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kckGc-0002iV-7K; Wed, 11 Nov 2020 07:10:06 +0000
Date:   Wed, 11 Nov 2020 07:10:06 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [RFC PATCH 1/9] cxl/acpi: Add an acpi_cxl module for the CXL
 interconnect
Message-ID: <20201111071006.GB7829@infradead.org>
References: <20201111054356.793390-1-ben.widawsky@intel.com>
 <20201111054356.793390-2-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111054356.793390-2-ben.widawsky@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 10, 2020 at 09:43:48PM -0800, Ben Widawsky wrote:
> +menuconfig CXL_BUS
> +	tristate "CXL (Compute Express Link) Devices Support"
> +	help
> +	  CXL is a bus that is electrically compatible with PCI-E, but layers
> +	  three protocols on that signalling (CXL.io, CXL.cache, and CXL.mem). The
> +	  CXL.cache protocol allows devices to hold cachelines locally, the
> +	  CXL.mem protocol allows devices to be fully coherent memory targets, the
> +	  CXL.io protocol is equivalent to PCI-E. Say 'y' to enable support for
> +	  the configuration and management of devices supporting these protocols.
> +

Please fix the overly long lines.

> +static void acpi_cxl_desc_init(struct acpi_cxl_desc *acpi_desc, struct device *dev)


Another overly long line.

> +{
> +	dev_set_drvdata(dev, acpi_desc);
> +	acpi_desc->dev = dev;
> +}

But this helper seems pretty pointless to start with.

> +static int acpi_cxl_remove(struct acpi_device *adev)
> +{
> +	return 0;
> +}

The emptry remove callback is not needed.

> +/*
> + * If/when CXL support is defined by other platform firmware the kernel
> + * will need a mechanism to select between the platform specific version
> + * of this routine, until then, hard-code ACPI assumptions
> + */
> +int cxl_bus_prepared(struct pci_dev *pdev)
> +{
> +	struct acpi_device *adev;
> +	struct pci_dev *root_port;
> +	struct device *root;
> +
> +	root_port = pcie_find_root_port(pdev);
> +	if (!root_port)
> +		return -ENXIO;
> +
> +	root = root_port->dev.parent;
> +	if (!root)
> +		return -ENXIO;
> +
> +	adev = ACPI_COMPANION(root);
> +	if (!adev)
> +		return -ENXIO;
> +
> +	/* TODO: OSC enabling */
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(cxl_bus_prepared);

What is the point of this function?  I doesn't realy do anything,
not even a CXL specific check.  

>  
> +/*******************************************************************************
> + *
> + * CEDT - CXL Early Discovery Table (ACPI 6.4)
> + *        Version 1
> + *
> + ******************************************************************************/
> +

Pleae use the normal Linux comment style.


> +#define ACPI_CEDT_CHBS_VERSION_CXL11    (0)
> +#define ACPI_CEDT_CHBS_VERSION_CXL20    (1)
> +
> +/* Values for length field above */
> +
> +#define ACPI_CEDT_CHBS_LENGTH_CXL11     (0x2000)
> +#define ACPI_CEDT_CHBS_LENGTH_CXL20     (0x10000)

No need for the braces.
