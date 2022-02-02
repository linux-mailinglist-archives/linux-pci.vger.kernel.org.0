Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38D44A6DD2
	for <lists+linux-pci@lfdr.de>; Wed,  2 Feb 2022 10:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbiBBJbx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Feb 2022 04:31:53 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4610 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiBBJbx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Feb 2022 04:31:53 -0500
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jpc4Q13RFz67kws;
        Wed,  2 Feb 2022 17:31:18 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Feb 2022 10:31:51 +0100
Received: from localhost (10.47.70.124) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 2 Feb
 2022 09:31:50 +0000
Date:   Wed, 2 Feb 2022 09:31:49 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        <linux-pci@vger.kernel.org>, <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v5 22/40] cxl/core/hdm: Add CXL standard decoder
 enumeration to the core
Message-ID: <20220202093149.00006594@Huawei.com>
In-Reply-To: <164374688404.395335.9239248252443123526.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164316647461.3437452.7695738236907745246.stgit@dwillia2-desk3.amr.corp.intel.com>
        <164374688404.395335.9239248252443123526.stgit@dwillia2-desk3.amr.corp.intel.com>
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

On Tue, 01 Feb 2022 12:24:30 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Unlike the decoder enumeration for "root decoders" described by platform
> firmware, standard decoders can be enumerated from the component
> registers space once the base address has been identified (via PCI,
> ACPI, or another mechanism).
> 
> Add common infrastructure for HDM (Host-managed-Device-Memory) Decoder
> enumeration and share it between host-bridge, upstream switch port, and
> cxl_test defined decoders.
> 
> The locking model for switch level decoders is to hold the port lock
> over the enumeration. This facilitates moving the dport and decoder
> enumeration to a 'port' driver. For now, the only enumerator of decoder
> resources is the cxl_acpi root driver.
> 
> Co-developed-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
> Changes since v4:
> - Fix kdoc for @host arg, for real this time (Jonathan and Ben)
> - Drop unused cxl_register_map from map_hdm_decoder_regs (Jonathan)
> - s/coders/decoders/ in changelog (Ben)
> - Add Ben's co-developed-by
> 
LGTM

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


