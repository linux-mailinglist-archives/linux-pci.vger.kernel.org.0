Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06DB34590CB
	for <lists+linux-pci@lfdr.de>; Mon, 22 Nov 2021 16:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238665AbhKVPFl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Nov 2021 10:05:41 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4129 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237699AbhKVPFj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Nov 2021 10:05:39 -0500
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HyVqL4QPTz67LfL;
        Mon, 22 Nov 2021 23:02:06 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 22 Nov 2021 16:02:30 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 22 Nov
 2021 15:02:28 +0000
Date:   Mon, 22 Nov 2021 15:02:27 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 04/23] cxl/pci: Implement Interface Ready Timeout
Message-ID: <20211122150227.00000020@Huawei.com>
In-Reply-To: <20211120000250.1663391-5-ben.widawsky@intel.com>
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
        <20211120000250.1663391-5-ben.widawsky@intel.com>
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

On Fri, 19 Nov 2021 16:02:31 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> The original driver implementation used the doorbell timeout for the
> Mailbox Interface Ready bit to piggy back off of, since the latter
> doesn't have a defined timeout. This functionality, introduced in
> 8adaf747c9f0 ("cxl/mem: Find device capabilities"), can now be improved
> since a timeout has been defined with an ECN to the 2.0 spec.
> 
> While devices implemented prior to the ECN could have an arbitrarily
> long wait and still be within spec, the max ECN value (256s) is chosen
> as the default for all devices. All vendors in the consortium agreed to
> this amount and so it is reasonable to assume no devices made will
> exceed this amount.

Optimistic :)

> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
> This patch did not exist in RFCv2
> ---
>  drivers/cxl/pci.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 6c8d09fb3a17..2cef9fec8599 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -2,6 +2,7 @@
>  /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/module.h>
> +#include <linux/delay.h>
>  #include <linux/sizes.h>
>  #include <linux/mutex.h>
>  #include <linux/list.h>
> @@ -298,6 +299,34 @@ static int cxl_pci_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *c
>  static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
>  {
>  	const int cap = readl(cxlds->regs.mbox + CXLDEV_MBOX_CAPS_OFFSET);
> +	unsigned long timeout;
> +	u64 md_status;
> +	int rc;
> +
> +	/*
> +	 * CXL 2.0 ECN "Add Mailbox Ready Time" defines a capability field to
> +	 * dictate how long to wait for the mailbox to become ready. For
> +	 * simplicity, and to handle devices that might have been implemented

I'm not keen on the 'for simplicity' argument here.  If the device is advertising
a lower value, then that is what we should use.  It's fine to wait the max time
if nothing is specified.  It'll cost us a few lines of code at most unless
I am missing something...

Jonathan

> +	 * prior to the ECN, wait the max amount of time no matter what the
> +	 * device says.
> +	 */
> +	timeout = jiffies + 256 * HZ;
> +
> +	rc = check_device_status(cxlds);
> +	if (rc)
> +		return rc;
> +
> +	do {
> +		md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
> +		if (md_status & CXLMDEV_MBOX_IF_READY)
> +			break;
> +		if (msleep_interruptible(100))
> +			break;
> +	} while (!time_after(jiffies, timeout));
> +
> +	/* It's assumed that once the interface is ready, it will remain ready. */
> +	if (!(md_status & CXLMDEV_MBOX_IF_READY))
> +		return -EIO;
>  
>  	cxlds->mbox_send = cxl_pci_mbox_send;
>  	cxlds->payload_size =

