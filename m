Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B36E4A4DDF
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jan 2022 19:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343720AbiAaSPx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jan 2022 13:15:53 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4582 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344000AbiAaSPx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jan 2022 13:15:53 -0500
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JnbjH5QC6z67MSd;
        Tue,  1 Feb 2022 02:11:15 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 31 Jan 2022 19:15:51 +0100
Received: from localhost (10.47.73.212) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.21; Mon, 31 Jan
 2022 18:15:50 +0000
Date:   Mon, 31 Jan 2022 18:15:44 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        kernel test robot <lkp@intel.com>,
        <linux-pci@vger.kernel.org>, <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v3 26/40] cxl/pci: Store component register base in
 cxlds
Message-ID: <20220131181544.0000268a@Huawei.com>
In-Reply-To: <164298425711.3018233.16653457511648347954.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
        <164298425711.3018233.16653457511648347954.stgit@dwillia2-desk3.amr.corp.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.73.212]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 23 Jan 2022 16:30:57 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> From: Ben Widawsky <ben.widawsky@intel.com>
> 
> In preparation for defining a cxl_port object to represent the decoder
> resources of a memory expander capture the compont register base

component

> address.
> 
> The port driver uses the component register base to enumerate the HDM
> Decoder Capability structure. Unlike other cxl_port objects the endpoint
> port decodes from upstream SPA to downstream DPA rather than upstream
> port to downstream port.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Reported-by: kernel test robot <lkp@intel.com>
> [djbw: clarify changelog]
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/cxlmem.h |    3 +++
>  drivers/cxl/pci.c    |   11 +++++++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index fca2d1b5f6ff..90d67fff5bed 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -116,6 +116,7 @@ struct cxl_mbox_cmd {
>   * @active_persistent_bytes: sum of hard + soft persistent
>   * @next_volatile_bytes: volatile capacity change pending device reset
>   * @next_persistent_bytes: persistent capacity change pending device reset
> + * @component_reg_phys: register base of component registers
>   * @mbox_send: @dev specific transport for transmitting mailbox commands
>   *
>   * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
> @@ -145,6 +146,8 @@ struct cxl_dev_state {
>  	u64 next_volatile_bytes;
>  	u64 next_persistent_bytes;
>  
> +	resource_size_t component_reg_phys;
> +
>  	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
>  };
>  
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index c29d50660c21..e54dbdf9ac15 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -416,6 +416,17 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
> +		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
> +
> +	cxlds->component_reg_phys = cxl_regmap_to_base(pdev, &map);
> +
>  	rc = cxl_pci_setup_mailbox(cxlds);
>  	if (rc)
>  		return rc;
> 

