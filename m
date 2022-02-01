Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C883B4A5AD3
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 12:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237053AbiBALDt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 06:03:49 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4595 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236837AbiBALDt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Feb 2022 06:03:49 -0500
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jp25G6BzCz67XhV;
        Tue,  1 Feb 2022 19:00:02 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Tue, 1 Feb 2022 12:03:47 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 1 Feb
 2022 11:03:47 +0000
Date:   Tue, 1 Feb 2022 11:03:45 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v4 21/40] cxl/core: Generalize dport enumeration in the
 core
Message-ID: <20220201110345.0000689e@Huawei.com>
In-Reply-To: <164368114191.354031.5270501846455462665.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298423047.3018233.6769866347542494809.stgit@dwillia2-desk3.amr.corp.intel.com>
        <164368114191.354031.5270501846455462665.stgit@dwillia2-desk3.amr.corp.intel.com>
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

On Mon, 31 Jan 2022 18:10:04 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> The core houses infrastructure for decoder resources. A CXL port's
> dports are more closely related to decoder infrastructure than topology
> enumeration. Implement generic PCI based dport enumeration in the core,
> i.e. arrange for existing root port enumeration from cxl_acpi to share
> code with switch port enumeration which just amounts to a small
> difference in a pci_walk_bus() invocation once the appropriate 'struct
> pci_bus' has been retrieved.
> 
> Set the convention that decoder objects are registered after all dports
> are enumerated. This enables userspace to know when the CXL core is
> finished establishing 'dportX' links underneath the 'portX' object.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>



