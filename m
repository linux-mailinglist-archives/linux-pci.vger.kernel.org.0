Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769FA4A6DFA
	for <lists+linux-pci@lfdr.de>; Wed,  2 Feb 2022 10:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245529AbiBBJjY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Feb 2022 04:39:24 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4614 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244735AbiBBJjY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Feb 2022 04:39:24 -0500
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jpc9M0T83z67Xk3;
        Wed,  2 Feb 2022 17:35:35 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Feb 2022 10:39:22 +0100
Received: from localhost (10.47.70.124) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 2 Feb
 2022 09:39:22 +0000
Date:   Wed, 2 Feb 2022 09:39:21 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, kernel test robot <lkp@intel.com>,
        "Ben Widawsky" <ben.widawsky@intel.com>,
        <linux-pci@vger.kernel.org>, <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v4 28/40] cxl/pci: Retrieve CXL DVSEC memory info
Message-ID: <20220202093921.00004687@Huawei.com>
In-Reply-To: <164375911821.559935.7375160041663453400.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298426829.3018233.15215948891228582221.stgit@dwillia2-desk3.amr.corp.intel.com>
        <164375911821.559935.7375160041663453400.stgit@dwillia2-desk3.amr.corp.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.70.124]
X-ClientProxiedBy: lhreml715-chm.china.huawei.com (10.201.108.66) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 01 Feb 2022 15:48:56 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> From: Ben Widawsky <ben.widawsky@intel.com>
> 
> Before CXL 2.0 HDM Decoder Capability mechanisms can be utilized in a
> device the driver must determine that the device is ready for CXL.mem
> operation and that platform firmware, or some other agent, has
> established an active decode via the legacy CXL 1.1 decoder mechanism.
> 
> This legacy mechanism is defined in the CXL DVSEC as a set of range
> registers and status bits that take time to settle after a reset.
> 
> Validate the CXL memory decode setup via the DVSEC and cache it for
> later consideration by the cxl_mem driver (to be added). Failure to
> validate is not fatal to the cxl_pci driver since that is only providing
> CXL command support over PCI.mmio, and might be needed to rectify CXL
> DVSEC validation problems.
> 
> Any potential ranges that the device is already claiming via DVSEC need
> to be reconciled with the dynamic provisioning ranges provided by
> platform firmware (like ACPI CEDT.CFMWS). Leave that reconciliation to
> the cxl_mem driver.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> [djbw: clarify changelog]
> [djbw: shorten defines]
> [djbw: change precise spin wait to generous msleep]
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
