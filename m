Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C768459355
	for <lists+linux-pci@lfdr.de>; Mon, 22 Nov 2021 17:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbhKVQtc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Nov 2021 11:49:32 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4140 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238864AbhKVQtc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Nov 2021 11:49:32 -0500
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HyY6Y5jgjz6H6nV;
        Tue, 23 Nov 2021 00:45:25 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Mon, 22 Nov 2021 17:46:23 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 22 Nov
 2021 16:46:22 +0000
Date:   Mon, 22 Nov 2021 16:46:21 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 16/23] cxl/pci: Cache device DVSEC offset
Message-ID: <20211122164621.000059fc@Huawei.com>
In-Reply-To: <20211120000250.1663391-17-ben.widawsky@intel.com>
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
        <20211120000250.1663391-17-ben.widawsky@intel.com>
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

On Fri, 19 Nov 2021 16:02:43 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> The PCIe device DVSEC, defined in the CXL 2.0 spec, 8.1.3 is required to
> be implemented by CXL 2.0 endpoint devices. Since the information
> contained within this DVSEC will be critically important for region
> configuration, it makes sense to find the value early.
> 
> Since this DVSEC is not strictly required for mailbox functionality,
> failure to find this information does not result in the driver failing
> to bind.

That feels like a path we are going to forget to test sometime in the
future.  Given it's a specification requirement, I'd treat it as
an error and make our lives easier going forwards!

Otherwise looks good to me.

> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/cxl/cxlmem.h | 2 ++
>  drivers/cxl/pci.c    | 7 +++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 8d96d009ad90..3ef3c652599e 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -98,6 +98,7 @@ struct cxl_mbox_cmd {
>   *
>   * @dev: The device associated with this CXL state
>   * @regs: Parsed register blocks
> + * @device_dvsec: Offset to the PCIe device DVSEC
>   * @payload_size: Size of space for payload
>   *                (CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register)
>   * @lsa_size: Size of Label Storage Area
> @@ -125,6 +126,7 @@ struct cxl_dev_state {
>  	struct device *dev;
>  
>  	struct cxl_regs regs;
> +	int device_dvsec;
>  
>  	size_t payload_size;
>  	size_t lsa_size;
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index d2c743a31b0c..f3872cbee7f8 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -474,6 +474,13 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (IS_ERR(cxlds))
>  		return PTR_ERR(cxlds);
>  
> +	cxlds->device_dvsec = pci_find_dvsec_capability(pdev,
> +							PCI_DVSEC_VENDOR_ID_CXL,
> +							CXL_DVSEC_PCIE_DEVICE);
> +	if (!cxlds->device_dvsec)
> +		dev_warn(&pdev->dev,
> +			 "Device DVSEC not present. Expect limited functionality.\n");
> +
>  	rc = cxl_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
>  	if (rc)
>  		return rc;

