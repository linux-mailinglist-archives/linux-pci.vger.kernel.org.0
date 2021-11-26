Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D507345ECCB
	for <lists+linux-pci@lfdr.de>; Fri, 26 Nov 2021 12:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239298AbhKZLmx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Nov 2021 06:42:53 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4172 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbhKZLkx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Nov 2021 06:40:53 -0500
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4J0t125G6wz67NbR;
        Fri, 26 Nov 2021 19:33:42 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 26 Nov 2021 12:37:39 +0100
Received: from localhost (10.122.247.231) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 26 Nov
 2021 11:37:38 +0000
Date:   Fri, 26 Nov 2021 11:37:37 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 17/23] cxl: Cache and pass DVSEC ranges
Message-ID: <20211126113737.00000d91@huawei.com>
In-Reply-To: <20211120000250.1663391-18-ben.widawsky@intel.com>
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
        <20211120000250.1663391-18-ben.widawsky@intel.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml739-chm.china.huawei.com (10.201.108.189) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 19 Nov 2021 16:02:44 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> CXL 1.1 specification provided a mechanism for mapping an address space
> of a CXL device. That functionality is known as a "range" and can be
> programmed through PCIe DVSEC. In addition to this, the specification
> defines an active bit which a device will expose through the same DVSEC
> to notify system software that memory is initialized and ready.
> 
> While CXL 2.0 introduces a more powerful mechanism called HDM decoders
> that are controlled by MMIO behind a PCIe BAR, the spec does allow the
> 1.1 style mapping to still be present. In such a case, when the CXL
> driver takes over, if it were to enable HDM decoding and there was an
> actively used range, things would likely blow up, in particular if it
> wasn't an identical mapping.
> 
> This patch caches the relevant information which the cxl_mem driver will
> need to make the proper decision and passes it along.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/cxl/cxlmem.h |  19 +++++++
>  drivers/cxl/pci.c    | 126 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/pci.h    |  13 +++++
>  3 files changed, 158 insertions(+)
> 
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 3ef3c652599e..eac5528ccaae 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -89,6 +89,22 @@ struct cxl_mbox_cmd {
>   */
>  #define CXL_CAPACITY_MULTIPLIER SZ_256M
>  
> +/**
> + * struct cxl_endpoint_dvsec_info - Cached DVSEC info
> + * @mem_enabled: cached value of mem_enabled in the DVSEC, PCIE_DEVICE
> + * @ranges: Number of HDM ranges this device contains.
> + * @range.base: cached value of the range base in the DVSEC, PCIE_DEVICE
> + * @range.size: cached value of the range size in the DVSEC, PCIE_DEVICE
> + */
> +struct cxl_endpoint_dvsec_info {
> +	bool mem_enabled;
> +	int ranges;
> +	struct {
> +		u64 base;
> +		u64 size;
> +	} range[2];

kernel-doc wants documentation for range as well.

> +};
