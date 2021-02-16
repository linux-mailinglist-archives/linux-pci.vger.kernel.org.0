Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF25831CD34
	for <lists+linux-pci@lfdr.de>; Tue, 16 Feb 2021 16:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhBPPus (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Feb 2021 10:50:48 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2573 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbhBPPur (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Feb 2021 10:50:47 -0500
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Dg4xW0tBwz67pRK;
        Tue, 16 Feb 2021 23:43:11 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 16 Feb 2021 16:50:05 +0100
Received: from localhost (10.47.75.223) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 16 Feb
 2021 15:50:03 +0000
Date:   Tue, 16 Feb 2021 15:48:57 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-nvdimm@lists.01.org>,
        <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        "Chris Browy" <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Dan Williams" <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Jon Masters" <jcm@jonmasters.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>
Subject: Re: [PATCH v4 9/9] cxl/mem: Add payload dumping for debug
Message-ID: <20210216154857.0000261d@Huawei.com>
In-Reply-To: <20210216014538.268106-10-ben.widawsky@intel.com>
References: <20210216014538.268106-1-ben.widawsky@intel.com>
        <20210216014538.268106-10-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.75.223]
X-ClientProxiedBy: lhreml717-chm.china.huawei.com (10.201.108.68) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 15 Feb 2021 17:45:38 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> It's often useful in debug scenarios to see what the hardware has dumped
> out. As it stands today, any device error will result in the payload not
> being copied out, so there is no way to triage commands which weren't
> expected to fail (and sometimes the payload may have that information).
> 
> The functionality is protected by normal kernel security mechanisms as
> well as a CONFIG option in the CXL driver.
> 
> This was extracted from the original version of the CXL enabling patch
> series.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

My gut feeling here is use a tracepoint rather than spamming the kernel
log.  Alternatively just don't bother merging this patch - it's on the list
now anyway so trivial for anyone doing such debug to pick it up.

Jonathan



> ---
>  drivers/cxl/Kconfig | 13 +++++++++++++
>  drivers/cxl/mem.c   |  8 ++++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 97dc4d751651..3eec9276e586 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -50,4 +50,17 @@ config CXL_MEM_RAW_COMMANDS
>  	  potential impact to memory currently in use by the kernel.
>  
>  	  If developing CXL hardware or the driver say Y, otherwise say N.
> +
> +config CXL_MEM_INSECURE_DEBUG
> +	bool "CXL.mem debugging"
> +	depends on CXL_MEM
> +	help
> +	  Enable debug of all CXL command payloads.
> +
> +	  Some CXL devices and controllers support encryption and other
> +	  security features. The payloads for the commands that enable
> +	  those features may contain sensitive clear-text security
> +	  material. Disable debug of those command payloads by default.
> +	  If you are a kernel developer actively working on CXL
> +	  security enabling say Y, otherwise say N.
>  endif
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index dc608bb20a31..237b956f0be0 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -342,6 +342,14 @@ static int __cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm,
>  
>  	/* #5 */
>  	rc = cxl_mem_wait_for_doorbell(cxlm);
> +
> +	if (!cxl_is_security_command(mbox_cmd->opcode) ||
> +	    IS_ENABLED(CONFIG_CXL_MEM_INSECURE_DEBUG)) {
> +		print_hex_dump_debug("Payload ", DUMP_PREFIX_OFFSET, 16, 1,
> +				     mbox_cmd->payload_in, mbox_cmd->size_in,
> +				     true);
> +	}
> +
>  	if (rc == -ETIMEDOUT) {
>  		cxl_mem_mbox_timeout(cxlm, mbox_cmd);
>  		return rc;

