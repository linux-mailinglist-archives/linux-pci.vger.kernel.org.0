Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2C96338E6
	for <lists+linux-pci@lfdr.de>; Tue, 22 Nov 2022 10:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbiKVJqg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Nov 2022 04:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbiKVJqc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Nov 2022 04:46:32 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6034B1B1ED;
        Tue, 22 Nov 2022 01:46:31 -0800 (PST)
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NGfTd0WRvz67yhs;
        Tue, 22 Nov 2022 17:43:49 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 10:46:29 +0100
Received: from localhost (10.45.149.88) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 22 Nov
 2022 09:46:28 +0000
Date:   Tue, 22 Nov 2022 09:46:27 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     "Li, Ming" <ming4.li@intel.com>,
        Gregory Price <gregory.price@memverge.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Lukas Wunner" <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>
Subject: Re: [PATCH] PCI/DOE: Remove asynchronous task support
Message-ID: <20221122094627.00003f2c@Huawei.com>
In-Reply-To: <Y3wC4kX6SCr90FGY@iweiny-desk3>
References: <20221119222527.1799836-1-ira.weiny@intel.com>
        <750c2096-fe2f-0597-a635-78cbe6b0ee0d@intel.com>
        <e7db6aea-4146-33f2-9490-9b5b902e0ec1@intel.com>
        <Y3wC4kX6SCr90FGY@iweiny-desk3>
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

On Mon, 21 Nov 2022 14:59:46 -0800
Ira Weiny <ira.weiny@intel.com> wrote:

> On Mon, Nov 21, 2022 at 10:07:56AM +0800, Li, Ming wrote:
> > On 11/21/2022 9:39 AM, Li, Ming wrote:  
> 
> [snip]
> 
> > >> @@ -529,8 +492,18 @@ int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
> > >>  		return -EIO;
> > >>  
> > >>  	task->doe_mb = doe_mb;
> > >> -	INIT_WORK(&task->work, doe_statemachine_work);
> > >> -	queue_work(doe_mb->work_queue, &task->work);
> > >> +
> > >> +again:
> > >> +	if (!mutex_trylock(&doe_mb->exec_lock)) {
> > >> +		if (wait_event_timeout(task->doe_mb->wq,
> > >> +				test_bit(PCI_DOE_FLAG_CANCEL, &doe_mb->flags),
> > >> +				PCI_DOE_POLL_INTERVAL))
> > >> +			return -EIO;  
> > > 
> > > We already implemented a pci_doe_wait(), I think we can use it to instead of this wait_event_timeout.
> > > 
> > > Thanks
> > > Ming
> > >   
> > 
> > This wait_event_timeout() only check PCI_DOE_FLAG_CANCEL, that means it only detects the signal which the doe_mb has being destroyed.
> > If current doe task is done correctly, I think we should wake up next task. Current implementation just waits utill timeout happens and try it again.
> > Besides, If two threads are waiting a same doe_mb, thread #1 waited firstly, thread #2 waited secondly, there is a chance that thread #2 is processed before thread #1.
> >   
> 
> Agreed.
> 
> However, the real problem is that the doe_mb is probably free'ed at this point
> and all this is going to crash and burn anyway.  The implementation of
> PCI_DOE_FLAG_CANCEL was fundamentally flawed even for the current work queue
> implementation.
> 
> This patch incorrectly tried to use that mechanism but upon looking closer I
> see it does not work.
> 
> I saw in another thread Jonathan discussing some sort of get/put on the doe_mb.
> That is not currently necessary as the creators of doe_mb objects currently
> hold references to the PCI device any time they call submit.

The get / put would only matter if we wanted to manage the DOE resources separately
from those of the PCI device.  It may well never make sense to do so as they
aren't substantial anyway.
> 
> :-(
> 
> For now all PCI_DOE_FLAG_CANCEL stuff needs to go away,
> Ira
> 
> > Thanks
> > Ming
> >   
> > >> +		goto again;
> > >> +	}
> > >> +	exec_task(task);
> > >> +	mutex_unlock(&doe_mb->exec_lock);
> > >> +
> > >>  	return 0;
> > >>  }
> > >> -EXPORT_SYMBOL_GPL(pci_doe_submit_task);
> > >> +EXPORT_SYMBOL_GPL(pci_doe_submit_task_wait);
> > >> diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
> > >> index ed9b4df792b8..c94122a66221 100644
> > >> --- a/include/linux/pci-doe.h
> > >> +++ b/include/linux/pci-doe.h
> > >> @@ -30,8 +30,6 @@ struct pci_doe_mb;
> > >>   * @response_pl_sz: Size of the response payload (bytes)
> > >>   * @rv: Return value.  Length of received response or error (bytes)
> > >>   * @complete: Called when task is complete
> > >> - * @private: Private data for the consumer
> > >> - * @work: Used internally by the mailbox
> > >>   * @doe_mb: Used internally by the mailbox
> > >>   *
> > >>   * The payload sizes and rv are specified in bytes with the following
> > >> @@ -50,11 +48,6 @@ struct pci_doe_task {
> > >>  	u32 *response_pl;
> > >>  	size_t response_pl_sz;
> > >>  	int rv;
> > >> -	void (*complete)(struct pci_doe_task *task);
> > >> -	void *private;
> > >> -
> > >> -	/* No need for the user to initialize these fields */
> > >> -	struct work_struct work;
> > >>  	struct pci_doe_mb *doe_mb;
> > >>  };
> > >>  
> > >> @@ -72,6 +65,5 @@ struct pci_doe_task {
> > >>  
> > >>  struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset);
> > >>  bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type);
> > >> -int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task);
> > >> -
> > >> +int pci_doe_submit_task_wait(struct pci_doe_mb *doe_mb, struct pci_doe_task *task);
> > >>  #endif
> > >>
> > >> base-commit: b6e7fdfd6f6a8bf88fcdb4a45da52c42ba238c25  

