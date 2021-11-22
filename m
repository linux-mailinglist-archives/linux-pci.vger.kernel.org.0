Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80EC54593BB
	for <lists+linux-pci@lfdr.de>; Mon, 22 Nov 2021 18:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239849AbhKVROy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Nov 2021 12:14:54 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4143 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239798AbhKVROx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Nov 2021 12:14:53 -0500
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HyYhS1M5Cz6GDN1;
        Tue, 23 Nov 2021 01:11:20 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 22 Nov 2021 18:11:44 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 22 Nov
 2021 17:11:44 +0000
Date:   Mon, 22 Nov 2021 17:11:42 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 19/23] cxl/pci: Store component register base in cxlds
Message-ID: <20211122171142.000002c4@Huawei.com>
In-Reply-To: <20211120000250.1663391-20-ben.widawsky@intel.com>
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
        <20211120000250.1663391-20-ben.widawsky@intel.com>
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

On Fri, 19 Nov 2021 16:02:46 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> The component register base address is enumerated and stored in the
> cxl_device_state structure for use by the endpoint driver.
> 
> Component register base addresses are obtained through PCI mechanisms.
> As such it makes most sense for the cxl_pci driver to obtain that
> address. In order to reuse the port driver for enumerating decoder
> resources for an endpoint, it is desirable to be able to add the
> endpoint as a port. The endpoint does know of the cxlds and can pull the
> component register base from there and pass it along to port creation.

This feels like a lot of explanation in for trivial caching of an address.
I'm not sure you need to be that detailed, though I guess it does no real
harm.

Another one where I'm unsure why we are muddling on after an error...


> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
> Changes since RFCv2:
> This patch was originally named, "cxl/core: Store component register
> base for memdevs". It plumbed the component registers through memdev
> creation. After more work, it became apparent we needed to plumb other
> stuff from the pci driver, so going forward, cxlds will just be
> referenced by the cxl_mem driver. This also allows us to ignore the
> change needed to cxl_test
> 
> - Rework patch to store the base in cxlds
> - Remove defunct comment (Dan)
> ---
>  drivers/cxl/cxlmem.h |  2 ++
>  drivers/cxl/pci.c    | 11 +++++++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index a9424dd4e5c3..b1d753541f4e 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -134,6 +134,7 @@ struct cxl_endpoint_dvsec_info {
>   * @next_volatile_bytes: volatile capacity change pending device reset
>   * @next_persistent_bytes: persistent capacity change pending device reset
>   * @info: Cached DVSEC information about the device.
> + * @component_reg_phys: register base of component registers
>   * @mbox_send: @dev specific transport for transmitting mailbox commands
>   *
>   * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
> @@ -165,6 +166,7 @@ struct cxl_dev_state {
>  	u64 next_persistent_bytes;
>  
>  	struct cxl_endpoint_dvsec_info *info;
> +	resource_size_t component_reg_phys;
>  
>  	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
>  	int (*wait_media_ready)(struct cxl_dev_state *cxlds);
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index f1a68bfe5f77..a8e375950514 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -663,6 +663,17 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> +	/*
> +	 * If the component registers can't be found, the cxl_pci driver may
> +	 * still be useful for management functions so don't return an error.
> +	 */
> +	cxlds->component_reg_phys = CXL_RESOURCE_NONE;
> +	rc = cxl_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
> +	if (rc)
> +		dev_warn(&cxlmd->dev, "No component registers (%d)\n", rc);
> +	else
> +		cxlds->component_reg_phys = cxl_reg_block(pdev, &map);
> +
>  	rc = cxl_pci_setup_mailbox(cxlds);
>  	if (rc)
>  		return rc;

