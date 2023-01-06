Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A2B6603E4
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jan 2023 17:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbjAFQFf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Jan 2023 11:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234484AbjAFQFb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Jan 2023 11:05:31 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF6E831BE;
        Fri,  6 Jan 2023 08:05:19 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NpSjS0YZKz6HJW4;
        Sat,  7 Jan 2023 00:00:28 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 6 Jan
 2023 16:05:16 +0000
Date:   Fri, 6 Jan 2023 16:05:15 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <rostedt@goodmis.org>, <terry.bowman@amd.com>,
        <bhelgaas@google.com>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <shiju.jose@huawei.com>
Subject: Re: [PATCH v4 09/11] cxl/pci: Add (hopeful) error handling support
Message-ID: <20230106160515.000046b8@huawei.com>
In-Reply-To: <166974413966.1608150.15522782911404473932.stgit@djiang5-desk3.ch.intel.com>
References: <166974401763.1608150.5424589924034481387.stgit@djiang5-desk3.ch.intel.com>
        <166974413966.1608150.15522782911404473932.stgit@djiang5-desk3.ch.intel.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
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

On Tue, 29 Nov 2022 10:48:59 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> From: Dan Williams <dan.j.williams@intel.com>
> 
> Add nominal error handling that tears down CXL.mem in response to error
> notifications that imply a device reset. Given some CXL.mem may be
> operating as System RAM, there is a high likelihood that these error
> events are fatal. However, if the system survives the notification the
> expectation is that the driver behavior is equivalent to a hot-unplug
> and re-plug of an endpoint.
> 
> Note that this does not change the mask values from the default. That
> awaits CXL _OSC support to determine whether platform firmware is in
> control of the mask registers.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

I've been messing around with improving the qemu injection to do multiple
errors and ran into a bug...

I'll send a patch next week, but in meantime...


> ---

> +/*
> + * Log the state of the RAS status registers and prepare them to log the
> + * next error status. Return 1 if reset needed.
> + */
> +static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
> +{
> +	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> +	struct device *dev = &cxlmd->dev;
> +	u32 hl[CXL_HEADERLOG_SIZE_U32];
> +	void __iomem *addr;
> +	u32 status;
> +	u32 fe;
> +
> +	if (!cxlds->regs.ras)
> +		return false;
> +
> +	addr = cxlds->regs.ras + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
> +	status = le32_to_cpu((__force __le32)readl(addr));
> +	if (!(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK))
> +		return false;
> +
> +	/* If multiple errors, log header points to first error from ctrl reg */
> +	if (hweight32(status) > 1) {
> +		addr = cxlds->regs.ras + CXL_RAS_CAP_CONTROL_OFFSET;
> +		fe = BIT(le32_to_cpu((__force __le32)readl(addr)) &
> +				     CXL_RAS_CAP_CONTROL_FE_MASK);
> +	} else {
> +		fe = status;
> +	}
> +
> +	header_log_copy(cxlds, hl);
> +	trace_cxl_aer_uncorrectable_error(dev_name(dev), status, fe, hl);
> +	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);

This address is meant to be that of the CXL_RAS_UNCORRECTABLE_STATUS register
but in the event hweight32(status) > 1 it's been ovewritten with the
address of CXL_RAS_CAP_CONTROL.


> +
> +	return true;
> +}
> +
