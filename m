Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774DF60CA83
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 13:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiJYLDW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 07:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiJYLDU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 07:03:20 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6831D1413B7;
        Tue, 25 Oct 2022 04:03:19 -0700 (PDT)
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MxTX449tBz6H76c;
        Tue, 25 Oct 2022 19:01:24 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Tue, 25 Oct 2022 13:03:17 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 25 Oct
 2022 12:03:16 +0100
Date:   Tue, 25 Oct 2022 12:03:15 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
        <linux-pci@vger.kernel.org>,
        Gregory Price <gregory.price@memverge.com>
Subject: Re: [PATCH V16 3/6] PCI/DOE: Add DOE mailbox support functions
Message-ID: <20221025120315.00006cc3@huawei.com>
In-Reply-To: <20220719205249.566684-4-ira.weiny@intel.com>
References: <20220719205249.566684-1-ira.weiny@intel.com>
        <20220719205249.566684-4-ira.weiny@intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
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

On Tue, 19 Jul 2022 13:52:46 -0700
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

FYI. Gregory Price reported an an issue that I think
is related to calling INIT_WORK() rather than INIT_WORK_ONSTACK()
and associated debug options in his build.

https://lore.kernel.org/linux-cxl/20221014151045.24781-1-Jonathan.Cameron@huawei.com/T/#m88a7f50dcce52f30c8bf5c3dcc06fa9843b54a2d

I've highlighted one path to this below.

> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> new file mode 100644
> index 000000000000..e402f05068a5
> --- /dev/null
> +++ b/drivers/pci/doe.c
> @@ -0,0 +1,536 @@


> +static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 *index, u16 *vid,
> +			     u8 *protocol)
> +{
> +	u32 request_pl = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX,
> +				    *index);
> +	u32 response_pl;
> +	DECLARE_COMPLETION_ONSTACK(c);
> +	struct pci_doe_task task = {
> +		.prot.vid = PCI_VENDOR_ID_PCI_SIG,
> +		.prot.type = PCI_DOE_PROTOCOL_DISCOVERY,
> +		.request_pl = &request_pl,
> +		.request_pl_sz = sizeof(request_pl),
> +		.response_pl = &response_pl,
> +		.response_pl_sz = sizeof(response_pl),
> +		.complete = pci_doe_task_complete,
> +		.private = &c,
> +	};
This structure contains a work_struct and is on the stack.  However...

> +	int rc;
> +
> +	rc = pci_doe_submit_task(doe_mb, &task);
> +	if (rc < 0)
> +		return rc;
> +
> +	wait_for_completion(&c);
> +
> +	if (task.rv != sizeof(response_pl))
> +		return -EIO;
> +
> +	*vid = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID, response_pl);
> +	*protocol = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL,
> +			      response_pl);
> +	*index = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX,
> +			   response_pl);
> +
> +	return 0;
> +}

...

> +int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
> +{
> +	if (!pci_doe_supports_prot(doe_mb, task->prot.vid, task->prot.type))
> +		return -EINVAL;
> +
> +	/*
> +	 * DOE requests must be a whole number of DW and the response needs to
> +	 * be big enough for at least 1 DW
> +	 */
> +	if (task->request_pl_sz % sizeof(u32) ||
> +	    task->response_pl_sz < sizeof(u32))
> +		return -EINVAL;
> +
> +	if (test_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags))
> +		return -EIO;
> +
> +	task->doe_mb = doe_mb;
> +	INIT_WORK(&task->work, doe_statemachine_work);

Here we don't call the INIT_WORK_ONSTACK() Variant.

> +	queue_work(doe_mb->work_queue, &task->work);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_doe_submit_task);
