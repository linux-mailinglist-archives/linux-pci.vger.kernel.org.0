Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51ECB4590D7
	for <lists+linux-pci@lfdr.de>; Mon, 22 Nov 2021 16:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239573AbhKVPGl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Nov 2021 10:06:41 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4130 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239534AbhKVPGk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Nov 2021 10:06:40 -0500
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HyVqt6lPSz6H83C;
        Mon, 22 Nov 2021 23:02:34 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 22 Nov 2021 16:03:32 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 22 Nov
 2021 15:03:31 +0000
Date:   Mon, 22 Nov 2021 15:03:30 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 03/23] cxl/pci: Extract device status check
Message-ID: <20211122150330.0000635c@Huawei.com>
In-Reply-To: <20211120000250.1663391-4-ben.widawsky@intel.com>
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
        <20211120000250.1663391-4-ben.widawsky@intel.com>
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

On Fri, 19 Nov 2021 16:02:30 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> The Memory Device Status register is inspected in the same way for at
> least two flows in the CXL Type 3 Memory Device Software Guide
> (Revision: 1.0): 2.13.9 Device discovery and mailbox ready sequence,
> and 2.13.10 Media ready sequence. Extract this common functionality for
> use by both.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> This patch did not exist in RFCv2
> ---
>  drivers/cxl/pci.c | 33 +++++++++++++++++++++++++--------
>  1 file changed, 25 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index a6ea9811a05b..6c8d09fb3a17 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -182,6 +182,27 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
>  	return 0;
>  }
>  
> +/*
> + * Implements roughly the bottom half of Figure 42 of the CXL Type 3 Memory
> + * Device Software Guide
> + */
> +static int check_device_status(struct cxl_dev_state *cxlds)
> +{
> +	const u64 md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
> +
> +	if (md_status & CXLMDEV_DEV_FATAL) {
> +		dev_err(cxlds->dev, "Fatal: replace device\n");
> +		return -EIO;
> +	}
> +
> +	if (md_status & CXLMDEV_FW_HALT) {
> +		dev_err(cxlds->dev, "FWHalt: reset or replace device\n");
> +		return -EBUSY;
> +	}
> +
> +	return 0;
> +}
> +
>  /**
>   * cxl_pci_mbox_get() - Acquire exclusive access to the mailbox.
>   * @cxlds: The device state to gain access to.
> @@ -231,17 +252,13 @@ static int cxl_pci_mbox_get(struct cxl_dev_state *cxlds)
>  	 * Hardware shouldn't allow a ready status but also have failure bits
>  	 * set. Spit out an error, this should be a bug report
>  	 */
> -	rc = -EFAULT;
> -	if (md_status & CXLMDEV_DEV_FATAL) {
> -		dev_err(dev, "mbox: reported ready, but fatal\n");
> +	rc = check_device_status(cxlds);
> +	if (rc)
>  		goto out;
> -	}
> -	if (md_status & CXLMDEV_FW_HALT) {
> -		dev_err(dev, "mbox: reported ready, but halted\n");
> -		goto out;
> -	}
> +
>  	if (CXLMDEV_RESET_NEEDED(md_status)) {
>  		dev_err(dev, "mbox: reported ready, but reset needed\n");
> +		rc = -EFAULT;
>  		goto out;
>  	}
>  

