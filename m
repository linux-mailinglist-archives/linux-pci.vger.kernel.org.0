Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873F06341B6
	for <lists+linux-pci@lfdr.de>; Tue, 22 Nov 2022 17:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234289AbiKVQnK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Nov 2022 11:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234291AbiKVQnI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Nov 2022 11:43:08 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD65445ED8;
        Tue, 22 Nov 2022 08:43:05 -0800 (PST)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NGqkQ2BJyz67NJj;
        Wed, 23 Nov 2022 00:40:30 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 17:43:03 +0100
Received: from localhost (10.45.149.88) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 22 Nov
 2022 16:43:02 +0000
Date:   Tue, 22 Nov 2022 16:43:01 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gregory Price <gregory.price@memverge.com>,
        "Li, Ming" <ming4.li@intel.com>, Lukas Wunner <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V2 2/2] PCI/DOE: Remove asynchronous task support
Message-ID: <20221122164301.00002346@Huawei.com>
In-Reply-To: <20221122155324.1878416-3-ira.weiny@intel.com>
References: <20221122155324.1878416-1-ira.weiny@intel.com>
        <20221122155324.1878416-3-ira.weiny@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.45.149.88]
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

On Tue, 22 Nov 2022 07:53:24 -0800
ira.weiny@intel.com wrote:

> From: Ira Weiny <ira.weiny@intel.com>
> 
> Gregory Price and Jonathan Cameron reported a bug within
> pci_doe_submit_task().[1]  The issue was that work item initialization
> needs to be done with either INIT_WORK_ONSTACK() or INIT_WORK()
> depending on how the work item is allocated.
> 
> Initially, it was anticipated that DOE tasks were going to need to be
> submitted asynchronously and the code was designed thusly.  Many
> alternatives were discussed to fix the work initialization issue.[2]
> 
> However, all current users submit tasks synchronously and this has
> therefore become an unneeded maintenance burden.  Remove the extra
> maintenance burden by replacing asynchronous task submission with
> a synchronous wait function.[3]
> 
> [1] https://lore.kernel.org/linux-cxl/20221014151045.24781-1-Jonathan.Cameron@huawei.com/T/#m88a7f50dcce52f30c8bf5c3dcc06fa9843b54a2d
> [2] https://lore.kernel.org/linux-cxl/Y3kSDQDur+IUDs2O@iweiny-mobl/T/#m0f057773d9c75432fcfcc54a2604483fe82abe92
> [3] https://lore.kernel.org/linux-cxl/Y3kSDQDur+IUDs2O@iweiny-mobl/T/#m32d3f9b208ef7486bc148d94a326b26b2d3e69ff
> 
> Reported-by: Gregory Price <gregory.price@memverge.com>
> Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Suggested-by: "Li, Ming" <ming4.li@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
Hi Ira,

A few things inline.

Jonathan


> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> index 260313e9052e..41c7bf5794a5 100644
> --- a/drivers/pci/doe.c
> +++ b/drivers/pci/doe.c
> @@ -18,7 +18,6 @@
>  #include <linux/mutex.h>
>  #include <linux/pci.h>
>  #include <linux/pci-doe.h>
> -#include <linux/workqueue.h>
>  
>  #define PCI_DOE_PROTOCOL_DISCOVERY 0
>  
> @@ -39,7 +38,7 @@
>   * @cap_offset: Capability offset
>   * @prots: Array of protocols supported (encoded as long values)
>   * @wq: Wait queue for work item
> - * @work_queue: Queue of pci_doe_work items
> + * @lock: Lock state of doe_mb during task processing
>   * @flags: Bit array of PCI_DOE_FLAG_* flags
>   */
>  struct pci_doe_mb {
> @@ -48,7 +47,7 @@ struct pci_doe_mb {
>  	struct xarray prots;
>  
>  	wait_queue_head_t wq;
> -	struct workqueue_struct *work_queue;
> +	struct mutex lock;
>  	unsigned long flags;
>  };
>  
> @@ -198,7 +197,6 @@ static int pci_doe_recv_resp(struct pci_doe_mb *doe_mb, struct pci_doe_task *tas
>  static void signal_task_complete(struct pci_doe_task *task, int rv)

Given this doesn't signal anything any more, perhaps rename the function,
or just push the task->rv = ... inline.?

>  {
>  	task->rv = rv;
> -	task->complete(task);
>  }

...

> diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
> index ed9b4df792b8..c94122a66221 100644
> --- a/include/linux/pci-doe.h
> +++ b/include/linux/pci-doe.h
> @@ -30,8 +30,6 @@ struct pci_doe_mb;
>   * @response_pl_sz: Size of the response payload (bytes)
>   * @rv: Return value.  Length of received response or error (bytes)
>   * @complete: Called when task is complete

complete is gone as well.

> - * @private: Private data for the consumer
> - * @work: Used internally by the mailbox
>   * @doe_mb: Used internally by the mailbox
>   *
>   * The payload sizes and rv are specified in bytes with the following
> @@ -50,11 +48,6 @@ struct pci_doe_task {
>  	u32 *response_pl;
>  	size_t response_pl_sz;
>  	int rv;
> -	void (*complete)(struct pci_doe_task *task);
> -	void *private;
> -
> -	/* No need for the user to initialize these fields */
> -	struct work_struct work;
>  	struct pci_doe_mb *doe_mb;
>  };
...
