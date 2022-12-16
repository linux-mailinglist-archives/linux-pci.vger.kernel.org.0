Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8A864ECAB
	for <lists+linux-pci@lfdr.de>; Fri, 16 Dec 2022 15:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiLPOKg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Dec 2022 09:10:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiLPOKT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Dec 2022 09:10:19 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883675C777;
        Fri, 16 Dec 2022 06:09:53 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NYWD46Dxxz67Q1X;
        Fri, 16 Dec 2022 22:08:36 +0800 (CST)
Received: from localhost (10.45.152.125) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 16 Dec
 2022 14:09:50 +0000
Date:   Fri, 16 Dec 2022 14:09:47 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V4 1/9] PCI/CXL: Export native CXL error reporting
 control
Message-ID: <20221216140947.00002f22@Huawei.com>
In-Reply-To: <20221212070627.1372402-2-ira.weiny@intel.com>
References: <20221212070627.1372402-1-ira.weiny@intel.com>
        <20221212070627.1372402-2-ira.weiny@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.45.152.125]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 11 Dec 2022 23:06:19 -0800
ira.weiny@intel.com wrote:

> From: Ira Weiny <ira.weiny@intel.com>
> 
> CXL _OSC Error Reporting Control is used by the OS to determine if
> Firmware has control of various CXL error reporting capabilities
> including the event logs.
> 
> Expose the result of negotiating CXL Error Reporting Control in struct
> pci_host_bridge for consumption by the CXL drivers.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-acpi@vger.kernel.org
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> Changes from V3:
> 	New patch split out
> ---
>  drivers/acpi/pci_root.c | 3 +++
>  drivers/pci/probe.c     | 1 +
>  include/linux/pci.h     | 1 +
>  3 files changed, 5 insertions(+)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index b3c202d2a433..84030804a763 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -1047,6 +1047,9 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
>  	if (!(root->osc_control_set & OSC_PCI_EXPRESS_DPC_CONTROL))
>  		host_bridge->native_dpc = 0;
>  
> +	if (!(root->osc_ext_control_set & OSC_CXL_ERROR_REPORTING_CONTROL))
> +		host_bridge->native_cxl_error = 0;
> +
>  	/*
>  	 * Evaluate the "PCI Boot Configuration" _DSM Function.  If it
>  	 * exists and returns 0, we must preserve any PCI resource
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 2f4e88a44e8b..34c9fd6840c4 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -596,6 +596,7 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
>  	bridge->native_ltr = 1;
>  	bridge->native_dpc = 1;
>  	bridge->domain_nr = PCI_DOMAIN_NR_NOT_SET;
> +	bridge->native_cxl_error = 1;
>  
>  	device_initialize(&bridge->dev);
>  }
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 1f81807492ef..08c3ccd2617b 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -577,6 +577,7 @@ struct pci_host_bridge {
>  	unsigned int	native_pme:1;		/* OS may use PCIe PME */
>  	unsigned int	native_ltr:1;		/* OS may use PCIe LTR */
>  	unsigned int	native_dpc:1;		/* OS may use PCIe DPC */
> +	unsigned int	native_cxl_error:1;	/* OS may use CXL RAS/Events */
>  	unsigned int	preserve_config:1;	/* Preserve FW resource setup */
>  	unsigned int	size_windows:1;		/* Enable root bus sizing */
>  	unsigned int	msi_domain:1;		/* Bridge wants MSI domain */

