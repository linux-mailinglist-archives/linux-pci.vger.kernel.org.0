Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A637E31D95A
	for <lists+linux-pci@lfdr.de>; Wed, 17 Feb 2021 13:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbhBQMYo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Feb 2021 07:24:44 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2580 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbhBQMYn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Feb 2021 07:24:43 -0500
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DgcMF4f0Yz67q1Q;
        Wed, 17 Feb 2021 20:18:49 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 17 Feb 2021 13:24:00 +0100
Received: from localhost (10.47.29.73) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2106.2; Wed, 17 Feb
 2021 12:23:59 +0000
Date:   Wed, 17 Feb 2021 12:22:53 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-nvdimm@lists.01.org>,
        <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        "Chris Browy" <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Dan Williams" <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Jon Masters" <jcm@jonmasters.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Colin Ian King <colin.king@canonical.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v5 2/9] cxl/mem: Find device capabilities
Message-ID: <20210217122253.00007bc2@Huawei.com>
In-Reply-To: <20210217040958.1354670-3-ben.widawsky@intel.com>
References: <20210217040958.1354670-1-ben.widawsky@intel.com>
        <20210217040958.1354670-3-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.29.73]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 16 Feb 2021 20:09:51 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> Provide enough functionality to utilize the mailbox of a memory device.
> The mailbox is used to interact with the firmware running on the memory
> device. The flow is proven with one implemented command, "identify".
> Because the class code has already told the driver this is a memory
> device and the identify command is mandatory.
> 
> CXL devices contain an array of capabilities that describe the
> interactions software can have with the device or firmware running on
> the device. A CXL compliant device must implement the device status and
> the mailbox capability. Additionally, a CXL compliant memory device must
> implement the memory device capability. Each of the capabilities can
> [will] provide an offset within the MMIO region for interacting with the
> CXL device.
> 
> The capabilities tell the driver how to find and map the register space
> for CXL Memory Devices. The registers are required to utilize the CXL
> spec defined mailbox interface. The spec outlines two mailboxes, primary
> and secondary. The secondary mailbox is earmarked for system firmware,
> and not handled in this driver.
> 
> Primary mailboxes are capable of generating an interrupt when submitting
> a background command. That implementation is saved for a later time.
> 
> Reported-by: Colin Ian King <colin.king@canonical.com> (coverity)
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com> (smatch)
> Link: https://www.computeexpresslink.org/download-the-specification
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com> (v2)

Looks good to me. 

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

