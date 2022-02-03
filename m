Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6A94A8391
	for <lists+linux-pci@lfdr.de>; Thu,  3 Feb 2022 13:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbiBCMH0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Feb 2022 07:07:26 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4667 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbiBCMHZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Feb 2022 07:07:25 -0500
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JqHTN5srwz67bcp;
        Thu,  3 Feb 2022 20:06:48 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 3 Feb 2022 13:07:23 +0100
Received: from localhost (10.47.78.15) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 3 Feb
 2022 12:07:22 +0000
Date:   Thu, 3 Feb 2022 12:07:18 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
        "Ben Widawsky" <ben.widawsky@intel.com>,
        <linux-pci@vger.kernel.org>, <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v5 33/40] cxl/mem: Add the cxl_mem driver
Message-ID: <20220203120718.00004fce@Huawei.com>
In-Reply-To: <164386009471.764789.4921759340860835924.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164316691403.3437657.5374419213236572727.stgit@dwillia2-desk3.amr.corp.intel.com>
        <164386009471.764789.4921759340860835924.stgit@dwillia2-desk3.amr.corp.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.78.15]
X-ClientProxiedBy: lhreml731-chm.china.huawei.com (10.201.108.82) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 02 Feb 2022 19:56:14 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> From: Ben Widawsky <ben.widawsky@intel.com>
> 
> At this point the subsystem can enumerate all CXL ports (CXL.mem decode
> resources in upstream switch ports and host bridges) in a system. The
> last mile is connecting those ports to endpoints.
> 
> The cxl_mem driver connects an endpoint device to the platform CXL.mem
> protoctol decode-topology. At ->probe() time it walks its
> device-topology-ancestry and adds a CXL Port object at every Upstream
> Port hop until it gets to CXL root. The CXL root object is only present
> after a platform firmware driver registers platform CXL resources. For
> ACPI based platform this is managed by the ACPI0017 device and the
> cxl_acpi driver.
> 
> The ports are registered such that disabling a given port automatically
> unregisters all descendant ports, and the chain can only be registered
> after the root is established.
> 
> Given ACPI device scanning may run asynchronously compared to PCI device
> scanning the root driver is tasked with rescanning the bus after the
> root successfully probes.
> 
> Conversely if any ports in a chain between the root and an endpoint
> becomes disconnected it subsequently triggers the endpoint to
> unregister. Given lock dependencies the endpoint unregistration happens
> in a workqueue asynchronously. If userspace cares about synchronizing
> delayed work after port events the /sys/bus/cxl/flush attribute is
> available for that purpose.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> [djbw: clarify changelog, rework hotplug support]
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
