Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 126CC2F39E8
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jan 2021 20:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406752AbhALTTG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 12 Jan 2021 14:19:06 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2327 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406399AbhALTTG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jan 2021 14:19:06 -0500
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DFgHX1G61z67TR3;
        Wed, 13 Jan 2021 03:14:32 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 12 Jan 2021 20:18:24 +0100
Received: from localhost (10.47.65.219) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 12 Jan
 2021 19:18:23 +0000
Date:   Tue, 12 Jan 2021 19:17:44 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>,
        "linux-acpi@vger.kernel.org, Ira Weiny" <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        "Bjorn Helgaas" <helgaas@kernel.org>,
        Jon Masters <jcm@jonmasters.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        <daniel.lll@alibaba-inc.com>
Subject: Re: [RFC PATCH v3 06/16] cxl/mem: Find device capabilities
Message-ID: <20210112191744.00007d61@Huawei.com>
In-Reply-To: <20210111225121.820014-7-ben.widawsky@intel.com>
References: <20210111225121.820014-1-ben.widawsky@intel.com>
        <20210111225121.820014-7-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.47.65.219]
X-ClientProxiedBy: lhreml752-chm.china.huawei.com (10.201.108.202) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 11 Jan 2021 14:51:10 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> CXL devices contain an array of capabilities that describe the
> interactions software can have with the device or firmware running on
> the device. A CXL compliant device must implement the device status and
> the mailbox capability. A CXL compliant memory device must implement the
> memory device capability.
> 
> Each of the capabilities can [will] provide an offset within the MMIO
> region for interacting with the CXL device.
> 
> For more details see 8.2.8 of the CXL 2.0 specification.
> 
> Link: Link: https://www.computeexpresslink.org/download-the-specification
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>


...

>  /**
>   * cxl_mem_create() - Create a new &struct cxl_mem.
>   * @pdev: The pci device associated with the new &struct cxl_mem.
> @@ -129,8 +214,20 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> +	rc = cxl_mem_setup_regs(cxlm);
> +	if (rc)
> +		goto err;
> +
> +	rc = cxl_mem_setup_mailbox(cxlm);
> +	if (rc)
> +		goto err;
> +
>  	pci_set_drvdata(pdev, cxlm);
>  	return 0;
> +
> +err:
> +	kfree(cxlm);

From previous patch that was created using devm_kzalloc in which case
this free just introduced a double free if you hit this error path.
Having go rid of that you can do direct returns instead of goto.


> +	return rc;
>  }
>  
>  static void cxl_mem_remove(struct pci_dev *pdev)

