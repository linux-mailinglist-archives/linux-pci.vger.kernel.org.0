Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A18B459131
	for <lists+linux-pci@lfdr.de>; Mon, 22 Nov 2021 16:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239678AbhKVPW0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Nov 2021 10:22:26 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4132 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbhKVPW0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Nov 2021 10:22:26 -0500
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HyWB43xW4z6H7yf;
        Mon, 22 Nov 2021 23:18:20 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Mon, 22 Nov 2021 16:19:17 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 22 Nov
 2021 15:19:16 +0000
Date:   Mon, 22 Nov 2021 15:19:15 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 06/23] cxl/pci: Don't check media status for mbox access
Message-ID: <20211122151915.000025ef@Huawei.com>
In-Reply-To: <20211120000250.1663391-7-ben.widawsky@intel.com>
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
        <20211120000250.1663391-7-ben.widawsky@intel.com>
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

On Fri, 19 Nov 2021 16:02:33 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> Media status is necessary for using HDM contained in a CXL device but is
> not needed for mailbox accesses. Therefore remove this check. It will be
> necessary to have this check (in a different place) when enabling HDM.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

One could perhaps argue this was a bug, but it was hopefully harmless on real devices.
Out of curiosity, did you find a clear definition of what 'User data' includes?
Obviously includes any data in the HDM region, but what about region meta data?

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> This patch did not exist in RFCv2
> ---
>  drivers/cxl/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 869b4fc18e27..711bf4514480 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -230,7 +230,7 @@ static int cxl_pci_mbox_get(struct cxl_dev_state *cxlds)
>  	 * but it's possible early devices implemented this before the ECN.
>  	 */
>  	md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
> -	if (!(md_status & CXLMDEV_MBOX_IF_READY && CXLMDEV_READY(md_status))) {
> +	if (!(md_status & CXLMDEV_MBOX_IF_READY)) {
>  		dev_err(dev, "mbox: reported doorbell ready, but not mbox ready\n");
>  		rc = -EBUSY;
>  		goto out;

