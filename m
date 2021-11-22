Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21577459135
	for <lists+linux-pci@lfdr.de>; Mon, 22 Nov 2021 16:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbhKVPZf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Nov 2021 10:25:35 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4133 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbhKVPZf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Nov 2021 10:25:35 -0500
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HyWGL2DKmz6GDMq;
        Mon, 22 Nov 2021 23:22:02 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Mon, 22 Nov 2021 16:22:26 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 22 Nov
 2021 15:22:26 +0000
Date:   Mon, 22 Nov 2021 15:22:24 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 07/23] cxl/pci: Add new DVSEC definitions
Message-ID: <20211122152224.0000467e@Huawei.com>
In-Reply-To: <20211120000250.1663391-8-ben.widawsky@intel.com>
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
        <20211120000250.1663391-8-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml737-chm.china.huawei.com (10.201.108.187) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 19 Nov 2021 16:02:34 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> While the new definitions are yet necessary at this point, they are
> introduced at this point to help solidify the newly minted schema for
> naming registers.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huwei.com>

> 
> ---
> This was split from
> https://lore.kernel.org/linux-cxl/20211103170552.55ae5u7uvurkync6@intel.com/T/#u
> per Dan's request.
> ---
>  drivers/cxl/pci.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
> index 29b8eaef3a0a..8ae2b4adc59d 100644
> --- a/drivers/cxl/pci.h
> +++ b/drivers/cxl/pci.h
> @@ -16,6 +16,21 @@
>  /* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
>  #define CXL_DVSEC_PCIE_DEVICE					0
>  
> +/* CXL 2.0 8.1.4: Non-CXL Function Map DVSEC */
> +#define CXL_DVSEC_FUNCTION_MAP					2
> +
> +/* CXL 2.0 8.1.5: CXL 2.0 Extensions DVSEC for Ports */
> +#define CXL_DVSEC_PORT_EXTENSIONS				3
> +
> +/* CXL 2.0 8.1.6: GPF DVSEC for CXL Port */
> +#define CXL_DVSEC_PORT_GPF					4
> +
> +/* CXL 2.0 8.1.7: GPF DVSEC for CXL Device */
> +#define CXL_DVSEC_DEVICE_GPF					5
> +
> +/* CXL 2.0 8.1.8: PCIe DVSEC for Flex Bus Port */
> +#define CXL_DVSEC_PCIE_FLEXBUS_PORT				7
> +
>  /* CXL 2.0 8.1.9: Register Locator DVSEC */
>  #define CXL_DVSEC_REG_LOCATOR					8
>  #define   CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET			0xC

