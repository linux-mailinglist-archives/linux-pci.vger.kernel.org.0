Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26FCC4A4E4B
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jan 2022 19:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355721AbiAaS3t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jan 2022 13:29:49 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4585 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350968AbiAaS3s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jan 2022 13:29:48 -0500
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jnc631qgnz67Z4k;
        Tue,  1 Feb 2022 02:29:15 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 31 Jan 2022 19:29:46 +0100
Received: from localhost (10.47.73.212) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.21; Mon, 31 Jan
 2022 18:29:45 +0000
Date:   Mon, 31 Jan 2022 18:29:39 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        <linux-pci@vger.kernel.org>, <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v3 29/40] cxl/pci: Implement wait for media active
Message-ID: <20220131182939.000001db@Huawei.com>
In-Reply-To: <164298427373.3018233.9309741847039301834.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
        <164298427373.3018233.9309741847039301834.stgit@dwillia2-desk3.amr.corp.intel.com>
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

On Sun, 23 Jan 2022 16:31:13 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> From: Ben Widawsky <ben.widawsky@intel.com>
> 
> CXL 2.0 8.1.3.8.2 states:
> 
>   Memory_Active: When set, indicates that the CXL Range 1 memory is
>   fully initialized and available for software use. Must be set within
>   Range 1. Memory_Active_Timeout of deassertion of reset to CXL device
>   if CXL.mem HwInit Mode=1
> 
> Unfortunately, Memory_Active can take quite a long time depending on
> media size (up to 256s per 2.0 spec). Provide a callback for the
> eventual establishment of CXL.mem operations via the 'cxl_mem' driver
> the 'struct cxl_memdev'. The implementation waits for 60s by default for
> now and can be overridden by the mbox_ready_time module parameter.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> [djbw: switch to sleeping wait]
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Not being a memory device person, I'm not sure whether my query below
is realistic but I worry a little that minimum sleep if not immediately
ready of 1 second is a bit long.

Perhaps that's something to optimize once there are a large number
of implementations to assess if it is worth bothering or not.


Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 5c43886dc2af..513cb0e2a70a 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -49,7 +49,7 @@
>  static unsigned short mbox_ready_timeout = 60;
>  module_param(mbox_ready_timeout, ushort, 0600);
>  MODULE_PARM_DESC(mbox_ready_timeout,
> -		 "seconds to wait for mailbox ready status");
> +		 "seconds to wait for mailbox ready / memory active status");
>  
>  static int cxl_pci_mbox_wait_for_doorbell(struct cxl_dev_state *cxlds)
>  {
> @@ -417,6 +417,51 @@ static int wait_for_valid(struct cxl_dev_state *cxlds)
>  	return -ETIMEDOUT;
>  }
>  
> +/*
> + * Wait up to @mbox_ready_timeout for the device to report memory
> + * active.
> + */
> +static int wait_for_media_ready(struct cxl_dev_state *cxlds)
> +{
> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> +	int d = cxlds->cxl_dvsec;
> +	bool active = false;
> +	u64 md_status;
> +	int rc, i;
> +
> +	rc = wait_for_valid(cxlds);
> +	if (rc)
> +		return rc;
> +
> +	for (i = mbox_ready_timeout; i; i--) {
> +		u32 temp;
> +		int rc;
> +
> +		rc = pci_read_config_dword(
> +			pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(0), &temp);
> +		if (rc)
> +			return rc;
> +
> +		active = FIELD_GET(CXL_DVSEC_MEM_ACTIVE, temp);
> +		if (active)
> +			break;
> +		msleep(1000);
Whilst it can be a while, this seems a bit of an excessive step to me.
If the thing is ready in 10msecs we stil end up waiting a second.
Might be worth checking more often, or doing some sort of fall off
in frequency of checking.

> +	}
> +
> +	if (!active) {
> +		dev_err(&pdev->dev,
> +			"timeout awaiting memory active after %d seconds\n",
> +			mbox_ready_timeout);
> +		return -ETIMEDOUT;
> +	}
> +
> +	md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
> +	if (!CXLMDEV_READY(md_status))
> +		return -EIO;
> +
> +	return 0;
> +}
> +


