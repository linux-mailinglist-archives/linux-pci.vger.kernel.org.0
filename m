Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04291592BBB
	for <lists+linux-pci@lfdr.de>; Mon, 15 Aug 2022 12:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242179AbiHOJuv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Aug 2022 05:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242230AbiHOJuo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Aug 2022 05:50:44 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F77710C4;
        Mon, 15 Aug 2022 02:50:42 -0700 (PDT)
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M5qK11dRlz67x0m;
        Mon, 15 Aug 2022 17:50:29 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 15 Aug 2022 11:50:39 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 15 Aug
 2022 10:50:39 +0100
Date:   Mon, 15 Aug 2022 10:50:38 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     "Li, Ming" <ming4.li@intel.com>
CC:     <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Matthew Wilcox" <willy@infradead.org>,
        Lukas Wunner <lukas@wunner.de>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V16 3/6] PCI/DOE: Add DOE mailbox support functions
Message-ID: <20220815105038.00000336@huawei.com>
In-Reply-To: <a3f72cdd-884d-efa1-89e8-f9d6660bf760@intel.com>
References: <20220719205249.566684-1-ira.weiny@intel.com>
        <20220719205249.566684-4-ira.weiny@intel.com>
        <a3f72cdd-884d-efa1-89e8-f9d6660bf760@intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 15 Aug 2022 10:17:00 +0800
"Li, Ming" <ming4.li@intel.com> wrote:

> On 7/20/2022 4:52 AM, ira.weiny@intel.com wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Introduced in a PCIe r6.0, sec 6.30, DOE provides a config space based
> > mailbox with standard protocol discovery.  Each mailbox is accessed
> > through a DOE Extended Capability.
> > 
> > Each DOE mailbox must support the DOE discovery protocol in addition to
> > any number of additional protocols.
> > 
> > Define core PCIe functionality to manage a single PCIe DOE mailbox at a
> > defined config space offset.  Functionality includes iterating,
> > creating, query of supported protocol, and task submission.  Destruction
> > of the mailboxes is device managed.
> > 
> > Cc: "Li, Ming" <ming4.li@intel.com>
> > Cc: Bjorn Helgaas <helgaas@kernel.org>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Acked-by: Bjorn Helgaas <helgaas@kernel.org>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > ---  
> 
> > +/**
> > + * pci_doe_submit_task() - Submit a task to be processed by the state machine
> > + *
> > + * @doe_mb: DOE mailbox capability to submit to
> > + * @task: task to be queued
> > + *
> > + * Submit a DOE task (request/response) to the DOE mailbox to be processed.
> > + * Returns upon queueing the task object.  If the queue is full this function
> > + * will sleep until there is room in the queue.
> > + *
> > + * task->complete will be called when the state machine is done processing this
> > + * task.
> > + *
> > + * Excess data will be discarded.
> > + *
> > + * RETURNS: 0 when task has been successfully queued, -ERRNO on error
> > + */
> > +int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
> > +{
> > +	if (!pci_doe_supports_prot(doe_mb, task->prot.vid, task->prot.type))
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * DOE requests must be a whole number of DW and the response needs to
> > +	 * be big enough for at least 1 DW
> > +	 */
> > +	if (task->request_pl_sz % sizeof(u32) ||
> > +	    task->response_pl_sz < sizeof(u32))
> > +		return -EINVAL;
> > +
> > +	if (test_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags))
> > +		return -EIO;
> > +
> > +	task->doe_mb = doe_mb;
> > +	INIT_WORK(&task->work, doe_statemachine_work);
> > +	queue_work(doe_mb->work_queue, &task->work);
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(pci_doe_submit_task);  
> 

> I'm curious why there is not a sychronous function for DOE users. I
> think some protocols over DOE need a DOE sychrounous interface(e.g.
> SPDM, TDISP, IDE...). These protocols have to implement an sychronous
> function over pci_doe_submit_task() by themselves, maybe we can
> implement an generic sychronous function in PCI/DOE for these DOE
> users.

This came up during discussions of earlier versions of the series.
IIRC we decided to postpone adding a synchronous wrapper function
until there were more use cases.

So if it is useful to you, go ahead and propose it as part of a
patch series supporting one of those protocols you reference.

Note there are a bunch of other changes that will be necessary
in this code to make it more generic anyway.  The plan is to
make those as and when they are useful.  E.g. interrupt support,
coupling some of the infrastructure more closely to the PCI core,
probably a few other things I've forgotten.

Jonathan




> 
> Thanks
> Ming
> 
> > diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
> > new file mode 100644
> > index 000000000000..ed9b4df792b8
> > --- /dev/null
> > +++ b/include/linux/pci-doe.h
> > @@ -0,0 +1,77 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Data Object Exchange
> > + *	PCIe r6.0, sec 6.30 DOE
> > + *
> > + * Copyright (C) 2021 Huawei
> > + *     Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > + *
> > + * Copyright (C) 2022 Intel Corporation
> > + *	Ira Weiny <ira.weiny@intel.com>
> > + */
> > +
> > +#ifndef LINUX_PCI_DOE_H
> > +#define LINUX_PCI_DOE_H
> > +
> > +struct pci_doe_protocol {
> > +	u16 vid;
> > +	u8 type;
> > +};
> > +
> > +struct pci_doe_mb;
> > +
> > +/**
> > + * struct pci_doe_task - represents a single query/response
> > + *
> > + * @prot: DOE Protocol
> > + * @request_pl: The request payload
> > + * @request_pl_sz: Size of the request payload (bytes)
> > + * @response_pl: The response payload
> > + * @response_pl_sz: Size of the response payload (bytes)
> > + * @rv: Return value.  Length of received response or error (bytes)
> > + * @complete: Called when task is complete
> > + * @private: Private data for the consumer
> > + * @work: Used internally by the mailbox
> > + * @doe_mb: Used internally by the mailbox
> > + *
> > + * The payload sizes and rv are specified in bytes with the following
> > + * restrictions concerning the protocol.
> > + *
> > + *	1) The request_pl_sz must be a multiple of double words (4 bytes)
> > + *	2) The response_pl_sz must be >= a single double word (4 bytes)
> > + *	3) rv is returned as bytes but it will be a multiple of double words
> > + *
> > + * NOTE there is no need for the caller to initialize work or doe_mb.
> > + */
> > +struct pci_doe_task {
> > +	struct pci_doe_protocol prot;
> > +	u32 *request_pl;
> > +	size_t request_pl_sz;
> > +	u32 *response_pl;
> > +	size_t response_pl_sz;
> > +	int rv;
> > +	void (*complete)(struct pci_doe_task *task);
> > +	void *private;
> > +
> > +	/* No need for the user to initialize these fields */
> > +	struct work_struct work;
> > +	struct pci_doe_mb *doe_mb;
> > +};
> > +
> > +/**
> > + * pci_doe_for_each_off - Iterate each DOE capability
> > + * @pdev: struct pci_dev to iterate
> > + * @off: u16 of config space offset of each mailbox capability found
> > + */
> > +#define pci_doe_for_each_off(pdev, off) \
> > +	for (off = pci_find_next_ext_capability(pdev, off, \
> > +					PCI_EXT_CAP_ID_DOE); \
> > +		off > 0; \
> > +		off = pci_find_next_ext_capability(pdev, off, \
> > +					PCI_EXT_CAP_ID_DOE))
> > +
> > +struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset);
> > +bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type);
> > +int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task);
> > +
> > +#endif
> > diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> > index 108f8523fa04..57b8e2ffb1dd 100644
> > --- a/include/uapi/linux/pci_regs.h
> > +++ b/include/uapi/linux/pci_regs.h
> > @@ -737,7 +737,8 @@
> >  #define PCI_EXT_CAP_ID_DVSEC	0x23	/* Designated Vendor-Specific */
> >  #define PCI_EXT_CAP_ID_DLF	0x25	/* Data Link Feature */
> >  #define PCI_EXT_CAP_ID_PL_16GT	0x26	/* Physical Layer 16.0 GT/s */
> > -#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PL_16GT
> > +#define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */
> > +#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_DOE
> >  
> >  #define PCI_EXT_CAP_DSN_SIZEOF	12
> >  #define PCI_EXT_CAP_MCAST_ENDPOINT_SIZEOF 40
> > @@ -1103,4 +1104,30 @@
> >  #define  PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_MASK		0x000000F0
> >  #define  PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_SHIFT	4
> >  
> > +/* Data Object Exchange */
> > +#define PCI_DOE_CAP		0x04    /* DOE Capabilities Register */
> > +#define  PCI_DOE_CAP_INT_SUP			0x00000001  /* Interrupt Support */
> > +#define  PCI_DOE_CAP_INT_MSG_NUM		0x00000ffe  /* Interrupt Message Number */
> > +#define PCI_DOE_CTRL		0x08    /* DOE Control Register */
> > +#define  PCI_DOE_CTRL_ABORT			0x00000001  /* DOE Abort */
> > +#define  PCI_DOE_CTRL_INT_EN			0x00000002  /* DOE Interrupt Enable */
> > +#define  PCI_DOE_CTRL_GO			0x80000000  /* DOE Go */
> > +#define PCI_DOE_STATUS		0x0c    /* DOE Status Register */
> > +#define  PCI_DOE_STATUS_BUSY			0x00000001  /* DOE Busy */
> > +#define  PCI_DOE_STATUS_INT_STATUS		0x00000002  /* DOE Interrupt Status */
> > +#define  PCI_DOE_STATUS_ERROR			0x00000004  /* DOE Error */
> > +#define  PCI_DOE_STATUS_DATA_OBJECT_READY	0x80000000  /* Data Object Ready */
> > +#define PCI_DOE_WRITE		0x10    /* DOE Write Data Mailbox Register */
> > +#define PCI_DOE_READ		0x14    /* DOE Read Data Mailbox Register */
> > +
> > +/* DOE Data Object - note not actually registers */
> > +#define PCI_DOE_DATA_OBJECT_HEADER_1_VID		0x0000ffff
> > +#define PCI_DOE_DATA_OBJECT_HEADER_1_TYPE		0x00ff0000
> > +#define PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH		0x0003ffff
> > +
> > +#define PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX		0x000000ff
> > +#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID		0x0000ffff
> > +#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		0x00ff0000
> > +#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX	0xff000000
> > +
> >  #endif /* LINUX_PCI_REGS_H */  
> 

