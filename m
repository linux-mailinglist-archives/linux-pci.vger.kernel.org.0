Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743D14A5AC1
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 11:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236942AbiBAK76 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 05:59:58 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4593 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236807AbiBAK76 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Feb 2022 05:59:58 -0500
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jp20q2cqcz67wr1;
        Tue,  1 Feb 2022 18:56:11 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 1 Feb 2022 11:59:56 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 1 Feb
 2022 10:59:55 +0000
Date:   Tue, 1 Feb 2022 10:59:54 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        <linux-pci@vger.kernel.org>, <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v6 18/40] cxl/pmem: Introduce a find_cxl_root() helper
Message-ID: <20220201105954.00002c74@Huawei.com>
In-Reply-To: <164367562182.225521.9488555616768096049.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164324151672.3935633.11277011056733051668.stgit@dwillia2-desk3.amr.corp.intel.com>
        <164367562182.225521.9488555616768096049.stgit@dwillia2-desk3.amr.corp.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml733-chm.china.huawei.com (10.201.108.84) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 31 Jan 2022 16:34:40 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> In preparation for switch port enumeration while also preserving the
> potential for multi-domain / multi-root CXL topologies. Introduce a
> 'struct device' generic mechanism for retrieving a root CXL port, if one
> is registered. Note that the only known multi-domain CXL configurations
> are running the cxl_test unit test on a system that also publishes an
> ACPI0017 device.
> 
> With this in hand the nvdimm-bridge lookup can be with
> device_find_child() instead of bus_find_device() + custom mocked lookup
> infrastructure in cxl_test.
> 
> The mechanism looks for a 2nd level port since the root level topology
> is platform-firmware specific and the 2nd level down follows standard
> PCIe topology expectations. The cxl_acpi 2nd level is associated with a
> PCIe Root Port.
> 
> Reported-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
