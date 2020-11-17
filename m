Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39002B6A61
	for <lists+linux-pci@lfdr.de>; Tue, 17 Nov 2020 17:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbgKQQfA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Nov 2020 11:35:00 -0500
Received: from mga18.intel.com ([134.134.136.126]:25203 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727388AbgKQQfA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Nov 2020 11:35:00 -0500
IronPort-SDR: Qzmmd8EU6GuMdLDKA7FANVzxuvd0v329TN25mO7THOFXN2XLgm76oBTXbjNJ0P6oGp3CZcIuVZ
 tefCymDyHjJw==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="158733445"
X-IronPort-AV: E=Sophos;i="5.77,485,1596524400"; 
   d="scan'208";a="158733445"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 08:34:41 -0800
IronPort-SDR: J6822doQKRsj9l6A4VwA94PHbZk9rQQyveINjJxCtLsGQR/s13D6cnjdga1nVT3svUpkVShWys
 rim2ubUusKTQ==
X-IronPort-AV: E=Sophos;i="5.77,485,1596524400"; 
   d="scan'208";a="533873576"
Received: from sturner2-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.135.20])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 08:34:40 -0800
Date:   Tue, 17 Nov 2020 08:34:38 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [RFC PATCH 7/9] cxl/mem: Implement polled mode mailbox
Message-ID: <20201117163438.co63em73mmil5xm5@intel.com>
References: <20201111054356.793390-1-ben.widawsky@intel.com>
 <20201111054356.793390-8-ben.widawsky@intel.com>
 <20201117153122.00001a5a@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117153122.00001a5a@Huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 20-11-17 15:31:22, Jonathan Cameron wrote:
> On Tue, 10 Nov 2020 21:43:54 -0800
> Ben Widawsky <ben.widawsky@intel.com> wrote:
> 
> > Create a function to handle sending a command, optionally with a
> > payload, to the memory device, polling on a result, and then optionally
> > copying out the payload. The algorithm for doing this come straight out
> > of the CXL 2.0 specification.
> > 
> > Primary mailboxes are capable of generating an interrupt when submitting
> > a command in the background. That implementation is saved for a later
> > time.
> > 
> > Secondary mailboxes aren't implemented at this time.
> > 
> > WARNING: This is untested with actual timeouts occurring.
> > 
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> 
> Question inline for why the preempt / local timer dance is worth bothering with.
> What am I missing?
> 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  drivers/cxl/cxl.h |  16 +++++++
> >  drivers/cxl/mem.c | 107 ++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 123 insertions(+)
> > 
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index 482fc9cdc890..f49ab80f68bd 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -21,8 +21,12 @@
> >  #define CXLDEV_MB_CTRL 0x04
> >  #define   CXLDEV_MB_CTRL_DOORBELL BIT(0)
> >  #define CXLDEV_MB_CMD 0x08
> > +#define   CXLDEV_MB_CMD_PAYLOAD_LENGTH_SHIFT 16
> >  #define CXLDEV_MB_STATUS 0x10
> > +#define   CXLDEV_MB_STATUS_RET_CODE_SHIFT 32
> > +#define   CXLDEV_MB_STATUS_RET_CODE_MASK 0xffff
> >  #define CXLDEV_MB_BG_CMD_STATUS 0x18
> > +#define CXLDEV_MB_PAYLOAD 0x20
> >  
> >  /* Memory Device */
> >  #define CXLMDEV_STATUS 0
> > @@ -114,4 +118,16 @@ static inline u64 __cxl_raw_read_reg64(struct cxl_mem *cxlm, u32 reg)
> >  
> >  	return readq(reg_addr + reg);
> >  }
> > +
> > +static inline void cxl_mbox_payload_fill(struct cxl_mem *cxlm, u8 *input,
> > +					    unsigned int length)
> > +{
> > +	memcpy_toio(cxlm->mbox.regs + CXLDEV_MB_PAYLOAD, input, length);
> > +}
> > +
> > +static inline void cxl_mbox_payload_drain(struct cxl_mem *cxlm,
> > +					     u8 *output, unsigned int length)
> > +{
> > +	memcpy_fromio(output, cxlm->mbox.regs + CXLDEV_MB_PAYLOAD, length);
> > +}
> >  #endif /* __CXL_H__ */
> > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > index 9fd2d1daa534..08913360d500 100644
> > --- a/drivers/cxl/mem.c
> > +++ b/drivers/cxl/mem.c
> > @@ -1,5 +1,6 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> >  // Copyright(c) 2020 Intel Corporation. All rights reserved.
> > +#include <linux/sched/clock.h>
> >  #include <linux/module.h>
> >  #include <linux/pci.h>
> >  #include <linux/io.h>
> > @@ -7,6 +8,112 @@
> >  #include "pci.h"
> >  #include "cxl.h"
> >  
> > +struct mbox_cmd {
> > +	u16 cmd;
> > +	u8 *payload;
> > +	size_t payload_size;
> > +	u16 return_code;
> > +};
> > +
> > +static int cxldev_wait_for_doorbell(struct cxl_mem *cxlm)
> > +{
> > +	u64 start, now;
> > +	int cpu, ret, timeout = 2000000000;
> > +
> > +	start = local_clock();
> > +	preempt_disable();
> > +	cpu = smp_processor_id();
> > +	for (;;) {
> > +		now = local_clock();
> > +		preempt_enable();
> 
> What do we ever do with this mailbox that is particularly
> performance critical? I'd like to understand why we care enough
> to mess around with the preemption changes and local clock etc.
> 

It is quite obviously a premature optimization at this point (since we only
support a single command in QEMU). However, the polling can be anywhere from
instant to 2 seconds. QEMU implementation aside again, some devices may never
support interrupts on completion, and so I thought providing a poll function now
that is capable of working for most [all?] cases was wise.

> > +		if ((cxl_read_mbox_reg32(cxlm, CXLDEV_MB_CTRL) &
> > +		     CXLDEV_MB_CTRL_DOORBELL) == 0) {
> > +			ret = 0;
> > +			break;
> > +		}
> > +
> > +		if (now - start >= timeout) {
> > +			ret = -ETIMEDOUT;
> > +			break;
> > +		}
> > +
> > +		cpu_relax();
> > +		preempt_disable();
> > +		if (unlikely(cpu != smp_processor_id())) {
> > +			timeout -= (now - start);
> > +			cpu = smp_processor_id();
> > +			start = local_clock();
> > +		}
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +/*
> > + * Returns 0 if the doorbell transaction was successful from a protocol level.
> > + * Caller should check the return code in @mbox_cmd to make sure it succeeded.
> > + */
> > +static int __maybe_unused cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm, struct mbox_cmd *mbox_cmd)
> > +{
> > +	u64 cmd, status;
> > +	int rc;
> > +
> > +	lockdep_assert_held(&cxlm->mbox_lock);
> > +
> > +	/*
> > +	 * Here are the steps from 8.2.8.4 of the CXL 2.0 spec.
> > +	 *   1. Caller reads MB Control Register to verify doorbell is clear
> > +	 *   2. Caller writes Command Register
> > +	 *   3. Caller writes Command Payload Registers if input payload is non-empty
> > +	 *   4. Caller writes MB Control Register to set doorbell
> > +	 *   5. Caller either polls for doorbell to be clear or waits for interrupt if configured
> > +	 *   6. Caller reads MB Status Register to fetch Return code
> > +	 *   7. If command successful, Caller reads Command Register to get Payload Length
> > +	 *   8. If output payload is non-empty, host reads Command Payload Registers
> > +	 */
> > +
> > +	cmd = mbox_cmd->cmd;
> > +	if (mbox_cmd->payload_size) {
> > +		/* #3 */
> 
> Having just given the steps above, having them out of order feels like it needs
> a comment to state why.
> 
> > +		cmd |= mbox_cmd->payload_size
> > +		       << CXLDEV_MB_CMD_PAYLOAD_LENGTH_SHIFT;
> > +		cxl_mbox_payload_fill(cxlm, mbox_cmd->payload, mbox_cmd->payload_size);
> > +	}
> > +
> > +	/* #2 */
> > +	cxl_write_mbox_reg64(cxlm, CXLDEV_MB_CMD, cmd);
> > +
> > +	/* #4 */
> > +	cxl_write_mbox_reg32(cxlm, CXLDEV_MB_CTRL, CXLDEV_MB_CTRL_DOORBELL);
> > +
> > +	/* #5 */
> > +	rc = cxldev_wait_for_doorbell(cxlm);
> > +	if (rc == -ETIMEDOUT) {
> > +		dev_warn(&cxlm->pdev->dev, "Mailbox command timed out\n");
> > +		return rc;
> > +	}
> > +
> > +	/* #6 */
> > +	status = cxl_read_mbox_reg64(cxlm, CXLDEV_MB_STATUS);
> > +	cmd = cxl_read_mbox_reg64(cxlm, CXLDEV_MB_CMD);
> > +
> > +	mbox_cmd->return_code = (status >> CXLDEV_MB_STATUS_RET_CODE_SHIFT) &
> > +				CXLDEV_MB_STATUS_RET_CODE_MASK;
> > +
> > +	/* There was a problem, let the caller deal with it */
> > +	if (mbox_cmd->return_code != 0)
> > +		return 0;
> > +
> > +	/* #7 */
> > +	mbox_cmd->payload_size = cmd >> CXLDEV_MB_CMD_PAYLOAD_LENGTH_SHIFT;
> > +
> > +	/* #8 */
> > +	if (mbox_cmd->payload_size)
> > +		cxl_mbox_payload_drain(cxlm, mbox_cmd->payload, mbox_cmd->payload_size);
> > +
> > +	return 0;
> > +}
> > +
> >  static int cxl_mem_mbox_get(struct cxl_mem *cxlm)
> >  {
> >  	u64 md_status;
> 
