Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE7057A43A
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jul 2022 18:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbiGSQgI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jul 2022 12:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235587AbiGSQgB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jul 2022 12:36:01 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FA9DEB9;
        Tue, 19 Jul 2022 09:35:59 -0700 (PDT)
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LnPYK5fc9z683Rr;
        Wed, 20 Jul 2022 00:34:13 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Jul 2022 18:35:56 +0200
Received: from localhost (10.81.209.49) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 19 Jul
 2022 17:35:55 +0100
Date:   Tue, 19 Jul 2022 17:35:53 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Li, Ming" <ming4.li@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Lukas Wunner <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V14 3/7] PCI/DOE: Add DOE mailbox support functions
Message-ID: <20220719173553.000067c6@Huawei.com>
In-Reply-To: <20220715030424.462963-4-ira.weiny@intel.com>
References: <20220715030424.462963-1-ira.weiny@intel.com>
        <20220715030424.462963-4-ira.weiny@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.209.49]
X-ClientProxiedBy: lhreml749-chm.china.huawei.com (10.201.108.199) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 14 Jul 2022 20:04:20 -0700
ira.weiny@intel.com wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Introduced in a PCIe r6.0, sec 6.30, DOE provides a config space based
> mailbox with standard protocol discovery.  Each mailbox is accessed
> through a DOE Extended Capability.
> 
> Each DOE mailbox must support the DOE discovery protocol in addition to
> any number of additional protocols.
> 
> Define core PCIe functionality to manage a single PCIe DOE mailbox at a
> defined config space offset.  Functionality includes iterating,
> creating, query of supported protocol, and task submission.  Destruction
> of the mailboxes is device managed.
> 
> Cc: "Li, Ming" <ming4.li@intel.com>
> Cc: Bjorn Helgaas <helgaas@kernel.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Acked-by: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Hi Ira,

Thanks for persisting with this!

So, I think this works, but there is at least one 'sleep' I can't
see a purpose for.  I think it's just a left over from refactoring.

A few other more trivial things inline.

Thanks,

Jonathan


> 
>>  # Endpoint library must be initialized before its users
>  obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> new file mode 100644
> index 000000000000..12c3762be22f
> --- /dev/null
> +++ b/drivers/pci/doe.c
> @@ -0,0 +1,546 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Data Object Exchange
> + *	PCIe r6.0, sec 6.30 DOE
> + *
> + * Copyright (C) 2021 Huawei
> + *	Jonathan Cameron <Jonathan.Cameron@huawei.com>
> + *
> + * Copyright (C) 2022 Intel Corporation
> + *	Ira Weiny <ira.weiny@intel.com>
> + */
> +
> +#define dev_fmt(fmt) "DOE: " fmt
> +
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/jiffies.h>
> +#include <linux/mutex.h>
> +#include <linux/pci.h>
> +#include <linux/pci-doe.h>
> +#include <linux/workqueue.h>
> +
> +#define PCI_DOE_PROTOCOL_DISCOVERY 0
> +
> +#define PCI_DOE_BUSY_MAX_RETRIES 16
Left over from removed code.

> +static int pci_doe_wait(struct pci_doe_mb *doe_mb, unsigned long timeout)

This feels misnamed to me now.  It's not waiting for the DOE, it's
just sleeping unless we cancel.  The actual poll / wait is handled
outside this.  pci_doe_sleep_unless_cancel() maybe?

> +{
> +	if (wait_event_timeout(doe_mb->wq,
> +			       test_bit(PCI_DOE_FLAG_CANCEL, &doe_mb->flags),
> +			       timeout))
> +		return -EIO;
> +	return 0;
> +}

> +static int pci_doe_send_req(struct pci_doe_mb *doe_mb,
> +			    struct pci_doe_task *task)
> +{
> +	struct pci_dev *pdev = doe_mb->pdev;
> +	int offset = doe_mb->cap_offset;
> +	u32 val;
> +	int i;
> +
> +	/*
> +	 * Check the DOE busy bit is not set. If it is set, this could indicate
> +	 * someone other than Linux (e.g. firmware) is using the mailbox. Note
> +	 * it is expected that firmware and OS will negotiate access rights via
> +	 * an, as yet to be defined method.

trivial: an, as yet to be defined, method.

> +	 */
> +	pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
> +	if (FIELD_GET(PCI_DOE_STATUS_BUSY, val))
> +		return -EBUSY;
> +
> +	if (FIELD_GET(PCI_DOE_STATUS_ERROR, val))
> +		return -EIO;
> +
> +	/* Write DOE Header */
> +	val = FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_1_VID, task->prot.vid) |
> +		FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, task->prot.type);
> +	pci_write_config_dword(pdev, offset + PCI_DOE_WRITE, val);
> +	/* Length is 2 DW of header + length of payload in DW */
> +	pci_write_config_dword(pdev, offset + PCI_DOE_WRITE,
> +			       FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH,
> +					  2 + task->request_pl_sz /
> +						sizeof(u32)));
> +	for (i = 0; i < task->request_pl_sz / sizeof(u32); i++)
> +		pci_write_config_dword(pdev, offset + PCI_DOE_WRITE,
> +				       task->request_pl[i]);
> +
> +	pci_doe_write_ctrl(doe_mb, PCI_DOE_CTRL_GO);
> +
> +	/* Request is sent - now wait for poll or IRQ */

Could drop the IRQ given not currently handling.  Though I suppose it's correct
documentation for this function, so can leave it if preferred.
More than possible we'll get a follow up patch dropping it though from
someone doing cleanup.

> +	return 0;
> +}
> +

...

> +
> +static void doe_statemachine_work(struct work_struct *work)
> +{
> +	struct pci_doe_task *task = container_of(work, struct pci_doe_task,
> +						 work);
> +	struct pci_doe_mb *doe_mb = task->doe_mb;
> +	struct pci_dev *pdev = doe_mb->pdev;
> +	int offset = doe_mb->cap_offset;
> +	unsigned long timeout_jiffies;
> +	u32 val;
> +	int rc;
> +
> +	if (test_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags)) {
> +		signal_task_complete(task, -EIO);
> +		return;
> +	}
> +
> +	/* Send request */
> +	rc = pci_doe_send_req(doe_mb, task);
> +
nitpick, but blank line separating call from error handling reduces
readability in my opinion.

> +	if (rc) {
> +		/*
> +		 * The specification does not provide any guidance on how to
> +		 * resolve conflicting requests from other entities.
> +		 * Furthermore, it is likely that busy will not be detected
> +		 * most of the time.  Flag any detection of status busy with an
> +		 * error.
> +		 */
> +		if (rc == -EBUSY)
> +			dev_err_ratelimited(&pdev->dev, "[%x] busy detected; another entity is sending conflicting requests\n",
> +					    offset);
> +		signal_task_abort(task, rc);
> +		return;
> +	}
> +
> +	timeout_jiffies = jiffies + PCI_DOE_TIMEOUT;
> +	rc = pci_doe_wait(doe_mb, PCI_DOE_POLL_INTERVAL);

What's this particular wait for?  I think you can just move directly to checking
if the response is ready.

> +	if (rc) {
> +		signal_task_abort(task, rc);
> +		return;
> +	}
> +
> +	/* Poll for response */
> +retry_resp:
> +	pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
> +	if (FIELD_GET(PCI_DOE_STATUS_ERROR, val)) {
> +		signal_task_abort(task, -EIO);
> +		return;
> +	}
> +
> +	if (!FIELD_GET(PCI_DOE_STATUS_DATA_OBJECT_READY, val)) {
> +		if (time_after(jiffies, timeout_jiffies)) {
> +			signal_task_abort(task, -EIO);
> +			return;
> +		}
> +		rc = pci_doe_wait(doe_mb, PCI_DOE_POLL_INTERVAL);
> +		if (rc) {
> +			signal_task_abort(task, rc);
> +			return;
> +		}
> +		goto retry_resp;
> +	}
> +
> +	rc  = pci_doe_recv_resp(doe_mb, task);
> +	if (rc < 0) {
> +		signal_task_abort(task, rc);
> +		return;
> +	}
> +
> +	signal_task_complete(task, rc);
> +}
> +

> +/**
> + * pci_doe_supports_prot() - Return if the DOE instance supports the given
> + *			     protocol
> + * @doe_mb: DOE mailbox capability to query
> + * @vid: Protocol Vendor ID
> + * @type: Protocol type
> + *
> + * RETURNS: True if the DOE mailbox supports the protocol specified
> + */
> +bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type)
> +{
> +	unsigned long index;
> +	void *entry;
> +
> +	/* The discovery protocol must always be supported */
> +	if (vid == PCI_VENDOR_ID_PCI_SIG && type == PCI_DOE_PROTOCOL_DISCOVERY)
> +		return true;

Given how cheap this look up is now it's all in xarray, we could drop this
'optimization'.  I'm fairly sure the discovery protocol will always be
discovered (spec says it must be returned when calling itself as the fist
protocol).

> +
> +	xa_for_each(&doe_mb->prots, index, entry)
> +		if (entry == pci_doe_xa_prot_entry(vid, type))
> +			return true;
> +
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(pci_doe_supports_prot);


> +EXPORT_SYMBOL_GPL(pci_doe_submit_task);
> diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
> new file mode 100644
> index 000000000000..c77f6258c996
> --- /dev/null
> +++ b/include/linux/pci-doe.h
> @@ -0,0 +1,79 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Data Object Exchange
> + *	PCIe r6.0, sec 6.30 DOE
> + *
> + * Copyright (C) 2021 Huawei
> + *     Jonathan Cameron <Jonathan.Cameron@huawei.com>
> + *
> + * Copyright (C) 2022 Intel Corporation
> + *	Ira Weiny <ira.weiny@intel.com>
> + */
> +
> +#ifndef LINUX_PCI_DOE_H
> +#define LINUX_PCI_DOE_H
> +
> +#include <linux/completion.h>

include not needed any more.

Thanks,

Jonathan

> +
> +struct pci_doe_protocol {
> +	u16 vid;
> +	u8 type;
> +};
> +
> +struct pci_doe_mb;
> +
> +/**
> + * struct pci_doe_task - represents a single query/response
> + *
> + * @prot: DOE Protocol
> + * @request_pl: The request payload
> + * @request_pl_sz: Size of the request payload (bytes)
> + * @response_pl: The response payload
> + * @response_pl_sz: Size of the response payload (bytes)
> + * @rv: Return value.  Length of received response or error (bytes)
> + * @complete: Called when task is complete
> + * @private: Private data for the consumer
> + * @work: Used internally by the mailbox
> + * @doe_mb: Used internally by the mailbox
> + *
> + * The payload sizes and rv are specified in bytes with the following
> + * restrictions concerning the protocol.
> + *
> + *	1) The request_pl_sz must be a multiple of double words (4 bytes)
> + *	2) The response_pl_sz must be >= a single double word (4 bytes)
> + *	3) rv is returned as bytes but it will be a multiple of double words
> + *
> + * NOTE there is no need for the caller to initialize work or doe_mb.
> + */
> +struct pci_doe_task {
> +	struct pci_doe_protocol prot;
> +	u32 *request_pl;
> +	size_t request_pl_sz;
> +	u32 *response_pl;
> +	size_t response_pl_sz;
> +	int rv;
> +	void (*complete)(struct pci_doe_task *task);
> +	void *private;
> +
> +	/* No need for the user to initialize these fields */
> +	struct work_struct work;
> +	struct pci_doe_mb *doe_mb;
> +};
> +
> +/**
> + * pci_doe_for_each_off - Iterate each DOE capability
> + * @pdev: struct pci_dev to iterate
> + * @off: u16 of config space offset of each mailbox capability found
> + */
> +#define pci_doe_for_each_off(pdev, off) \
> +	for (off = pci_find_next_ext_capability(pdev, off, \
> +					PCI_EXT_CAP_ID_DOE); \
> +		off > 0; \
> +		off = pci_find_next_ext_capability(pdev, off, \
> +					PCI_EXT_CAP_ID_DOE))
> +
> +struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset);
> +bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type);
> +int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task);
> +
> +#endif

