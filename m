Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5D42F6928
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jan 2021 19:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbhANSJv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jan 2021 13:09:51 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2350 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727533AbhANSJu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jan 2021 13:09:50 -0500
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DGsfc4sVyz67bdg;
        Fri, 15 Jan 2021 02:05:12 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 14 Jan 2021 19:09:08 +0100
Received: from localhost (10.47.30.252) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2106.2; Thu, 14 Jan
 2021 18:09:07 +0000
Date:   Thu, 14 Jan 2021 18:08:26 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>,
        "linux-acpi@vger.kernel.org, Ira Weiny" <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        "Bjorn Helgaas" <helgaas@kernel.org>,
        Jon Masters <jcm@jonmasters.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        <daniel.lll@alibaba-inc.com>
Subject: Re: [RFC PATCH v3 15/16] cxl/mem: Add limited Get Log command
 (0401h)
Message-ID: <20210114180826.000072f0@Huawei.com>
In-Reply-To: <20210111225121.820014-17-ben.widawsky@intel.com>
References: <20210111225121.820014-1-ben.widawsky@intel.com>
        <20210111225121.820014-17-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.30.252]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 11 Jan 2021 14:51:20 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> The Get Log command returns the actual log entries that are advertised
> via the Get Supported Logs command (0400h). CXL device logs are selected
> by UUID which is part of the CXL spec. Because the driver tries to
> sanitize what is sent to hardware, there becomes a need to restrict the
> types of logs which can be accessed by userspace. For example, the
> vendor specific log might only be consumable by proprietary, or offline
> applications, and therefore a good candidate for userspace.
> 
> The current driver infrastructure does allow basic validation for all
> commands, but doesn't inspect any of the payload data. Along with Get
> Log support comes new infrastructure to add a hook for payload
> validation. This infrastructure is used to filter out the CEL UUID,
> which the userspace driver doesn't have business knowing, and taints on
> invalid UUIDs being sent to hardware.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

Just a minor question for this one.

Thanks, J
...                                              \
> @@ -515,6 +529,15 @@ static int handle_mailbox_cmd_from_user(struct cxl_memdev *cxlmd,
>  	int rc;
>  
>  	if (cmd->info.size_in) {
> +		if (cmd->validate_payload) {
> +			rc = cmd->validate_payload(u64_to_user_ptr(in_payload),
> +						   cmd->info.size_in);

Is it worth moving this out of the region in which we hold the mbox?
(after fixing the bug that I think means we don't actually hold it at this point)

Perhaps not, but it does feel odd to do validation under the lock.


> +			if (rc) {
> +				cxl_mem_mbox_put(cxlmd->cxlm);
> +				return -EFAULT;
> +			}
> +		}
> +
>  		/*
>  		 * Directly copy the userspace payload into the hardware. UAPI
>  		 * states that the buffer must already be little endian.
