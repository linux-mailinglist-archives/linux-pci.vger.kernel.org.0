Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C82379277
	for <lists+linux-pci@lfdr.de>; Mon, 10 May 2021 17:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236653AbhEJPWE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 May 2021 11:22:04 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3049 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235514AbhEJPVE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 May 2021 11:21:04 -0400
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ff4Jv1p9Cz6wjnc;
        Mon, 10 May 2021 23:11:43 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 10 May 2021 17:19:56 +0200
Received: from localhost (10.52.123.16) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 10 May
 2021 16:19:56 +0100
Date:   Mon, 10 May 2021 16:18:14 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 6/8] cxl/Kconfig: Default drivers to CONFIG_CXL_BUS
Message-ID: <20210510161814.00007e99@Huawei.com>
In-Reply-To: <162042791307.1202325.2513845748708305095.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <162042787450.1202325.5718541949681409566.stgit@dwillia2-desk3.amr.corp.intel.com>
        <162042791307.1202325.2513845748708305095.stgit@dwillia2-desk3.amr.corp.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.123.16]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 7 May 2021 15:51:53 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> CONFIG_CXL_BUS is default 'n' as expected for new functionality. When
> that is enabled do not make the end user hunt for all the expected
> sub-options to enable. For example CONFIG_CXL_BUS without CONFIG_CXL_MEM
> is an odd/expert configuration, so is CONFIG_CXL_MEM without
> CONFIG_CXL_ACPI (on ACPI capable platforms). Default CONFIG_CXL_MEM and
> CONFIG_CXL_ACPI to CONFIG_CXL_BUS.
> 
> Acked-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/Kconfig |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index fb282af84afd..1da7970a5e55 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -15,6 +15,7 @@ if CXL_BUS
>  
>  config CXL_MEM
>  	tristate "CXL.mem: Memory Devices"
> +	default CXL_BUS
>  	help
>  	  The CXL.mem protocol allows a device to act as a provider of
>  	  "System RAM" and/or "Persistent Memory" that is fully coherent
> @@ -54,6 +55,7 @@ config CXL_MEM_RAW_COMMANDS
>  config CXL_ACPI
>  	tristate "CXL ACPI: Platform Support"
>  	depends on ACPI
> +	default CXL_BUS
>  	help
>  	  Enable support for host managed device memory (HDM) resources
>  	  published by a platform's ACPI CXL memory layout description.
> 

