Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075972B2904
	for <lists+linux-pci@lfdr.de>; Sat, 14 Nov 2020 00:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgKMXOd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Nov 2020 18:14:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:43410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726240AbgKMXOW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Nov 2020 18:14:22 -0500
Received: from localhost (230.sub-72-107-127.myvzw.com [72.107.127.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A5C722256;
        Fri, 13 Nov 2020 23:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605309261;
        bh=o0aH3JmdpLC8cCY0An4gxRn166tgYgLye5gA7I1JN9M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=uHSORV4tEWIaYlRd991Lw6EdZg7IQDc7I8p8zyukS1eVZxYSWX2uwUMMCIBSLd4/L
         R1N2dujrrva+2KruVehKxhlgwwcoVfdR9b0cHxJm/dF5JyzLCgzWAtfkTForm0nGGd
         dzYYVIciD7vVfy3pIWd5IIBXmnbmo8HB90JJjB64=
Date:   Fri, 13 Nov 2020 17:14:19 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [RFC PATCH 7/9] cxl/mem: Implement polled mode mailbox
Message-ID: <20201113231419.GA1122445@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111054356.793390-8-ben.widawsky@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 10, 2020 at 09:43:54PM -0800, Ben Widawsky wrote:
> Create a function to handle sending a command, optionally with a
> payload, to the memory device, polling on a result, and then optionally
> copying out the payload. The algorithm for doing this come straight out
> of the CXL 2.0 specification.
> 
> Primary mailboxes are capable of generating an interrupt when submitting
> a command in the background. That implementation is saved for a later
> time.
> 
> Secondary mailboxes aren't implemented at this time.
> 
> WARNING: This is untested with actual timeouts occurring.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/cxl/cxl.h |  16 +++++++
>  drivers/cxl/mem.c | 107 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 123 insertions(+)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 482fc9cdc890..f49ab80f68bd 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -21,8 +21,12 @@
>  #define CXLDEV_MB_CTRL 0x04
>  #define   CXLDEV_MB_CTRL_DOORBELL BIT(0)
>  #define CXLDEV_MB_CMD 0x08
> +#define   CXLDEV_MB_CMD_PAYLOAD_LENGTH_SHIFT 16
>  #define CXLDEV_MB_STATUS 0x10
> +#define   CXLDEV_MB_STATUS_RET_CODE_SHIFT 32
> +#define   CXLDEV_MB_STATUS_RET_CODE_MASK 0xffff
>  #define CXLDEV_MB_BG_CMD_STATUS 0x18
> +#define CXLDEV_MB_PAYLOAD 0x20
>  
>  /* Memory Device */
>  #define CXLMDEV_STATUS 0
> @@ -114,4 +118,16 @@ static inline u64 __cxl_raw_read_reg64(struct cxl_mem *cxlm, u32 reg)
>  
>  	return readq(reg_addr + reg);
>  }
> +
> +static inline void cxl_mbox_payload_fill(struct cxl_mem *cxlm, u8 *input,
> +					    unsigned int length)
> +{
> +	memcpy_toio(cxlm->mbox.regs + CXLDEV_MB_PAYLOAD, input, length);
> +}
> +
> +static inline void cxl_mbox_payload_drain(struct cxl_mem *cxlm,
> +					     u8 *output, unsigned int length)
> +{
> +	memcpy_fromio(output, cxlm->mbox.regs + CXLDEV_MB_PAYLOAD, length);
> +}
>  #endif /* __CXL_H__ */
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 9fd2d1daa534..08913360d500 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  // Copyright(c) 2020 Intel Corporation. All rights reserved.

/* Copyright ... */

> +#include <linux/sched/clock.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
>  #include <linux/io.h>
> @@ -7,6 +8,112 @@
>  #include "pci.h"
>  #include "cxl.h"
>  
> +struct mbox_cmd {
> +	u16 cmd;
> +	u8 *payload;
> +	size_t payload_size;
> +	u16 return_code;
> +};
> +
> +static int cxldev_wait_for_doorbell(struct cxl_mem *cxlm)
> +{
> +	u64 start, now;
> +	int cpu, ret, timeout = 2000000000;

It'd be nice to have a hint about where this timeout comes from and
what the units are.  local_clock(), sched_clock_cpu(), etc don't have
any hints either and I got tired of following the chain.

Several callers use ns_to_ktime(local_clock()), so I guess it must be
in ns?

> +	start = local_clock();
> +	preempt_disable();
> +	cpu = smp_processor_id();
> +	for (;;) {
> +		now = local_clock();
> +		preempt_enable();
> +		if ((cxl_read_mbox_reg32(cxlm, CXLDEV_MB_CTRL) &
> +		     CXLDEV_MB_CTRL_DOORBELL) == 0) {
> +			ret = 0;
> +			break;
> +		}
> +
> +		if (now - start >= timeout) {
> +			ret = -ETIMEDOUT;
> +			break;
> +		}
> +
> +		cpu_relax();
> +		preempt_disable();
> +		if (unlikely(cpu != smp_processor_id())) {
> +			timeout -= (now - start);
> +			cpu = smp_processor_id();
> +			start = local_clock();
> +		}
> +	}
