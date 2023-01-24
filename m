Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3717679784
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jan 2023 13:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233595AbjAXMST (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Jan 2023 07:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233585AbjAXMSS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Jan 2023 07:18:18 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF49442F0;
        Tue, 24 Jan 2023 04:18:16 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P1Qr20kr8z6J7Df;
        Tue, 24 Jan 2023 20:14:10 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 24 Jan
 2023 12:18:13 +0000
Date:   Tue, 24 Jan 2023 12:18:12 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Lukas Wunner <lukas@wunner.de>
CC:     Bjorn Helgaas <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 06/10] PCI/DOE: Allow mailbox creation without devres
 management
Message-ID: <20230124121759.00007793@huawei.com>
In-Reply-To: <20230124121543.00002600@Huawei.com>
References: <cover.1674468099.git.lukas@wunner.de>
        <291131574c9e625195e9c34591abf5fa75cd1279.1674468099.git.lukas@wunner.de>
        <20230124121543.00002600@Huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
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

On Tue, 24 Jan 2023 12:15:43 +0000
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Mon, 23 Jan 2023 11:16:00 +0100
> Lukas Wunner <lukas@wunner.de> wrote:
> 
> > DOE mailbox creation is currently only possible through a devres-managed
> > API.  The lifetime of mailboxes thus ends with driver unbinding.
> > 
> > An upcoming commit will create DOE mailboxes upon device enumeration by
> > the PCI core.  Their lifetime shall not be limited by a driver.
> > 
> > Therefore rework pcim_doe_create_mb() into the non-devres-managed
> > pci_doe_create_mb().  Add pci_doe_destroy_mb() for mailbox destruction
> > on device removal.
> > 
> > Provide a devres-managed wrapper under the existing pcim_doe_create_mb()
> > name.
> > 
> > Tested-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Lukas Wunner <lukas@wunner.de>  
> Hi Lukas,
> 
> A few comments inline.
> 
> In particular I'd like to understand why flushing in the tear down
> can't always be done as that makes the code more complex.
> 
> Might become clear in later patches though as I've not read ahead yet!
Ah.. It's in the patch description of the next patch. So ignore this question.

Thanks,

Jonathan

> 
> Jonathan
> 
> > ---
> >  drivers/pci/doe.c | 103 +++++++++++++++++++++++++++++++---------------
> >  1 file changed, 70 insertions(+), 33 deletions(-)
> > 
> > diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> > index 066400531d09..cc1fdd75ad2a 100644
> > --- a/drivers/pci/doe.c
> > +++ b/drivers/pci/doe.c
> > @@ -37,7 +37,7 @@
> >   *
> >   * This state is used to manage a single DOE mailbox capability.  All fields
> >   * should be considered opaque to the consumers and the structure passed into
> > - * the helpers below after being created by devm_pci_doe_create()
> > + * the helpers below after being created by pci_doe_create_mb().
> >   *
> >   * @pdev: PCI device this mailbox belongs to
> >   * @cap_offset: Capability offset
> > @@ -412,20 +412,6 @@ static int pci_doe_cache_protocols(struct pci_doe_mb *doe_mb)
> >  	return 0;
> >  }
> >  
> > -static void pci_doe_xa_destroy(void *mb)
> > -{
> > -	struct pci_doe_mb *doe_mb = mb;
> > -
> > -	xa_destroy(&doe_mb->prots);
> > -}
> > -
> > -static void pci_doe_destroy_workqueue(void *mb)
> > -{
> > -	struct pci_doe_mb *doe_mb = mb;
> > -
> > -	destroy_workqueue(doe_mb->work_queue);
> > -}
> > -
> >  static void pci_doe_flush_mb(void *mb)
> >  {
> >  	struct pci_doe_mb *doe_mb = mb;
> > @@ -442,7 +428,7 @@ static void pci_doe_flush_mb(void *mb)
> >  }
> >  
> >  /**
> > - * pcim_doe_create_mb() - Create a DOE mailbox object
> > + * pci_doe_create_mb() - Create a DOE mailbox object
> >   *
> >   * @pdev: PCI device to create the DOE mailbox for
> >   * @cap_offset: Offset of the DOE mailbox
> > @@ -453,24 +439,20 @@ static void pci_doe_flush_mb(void *mb)
> >   * RETURNS: created mailbox object on success
> >   *	    ERR_PTR(-errno) on failure
> >   */
> > -struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset)
> > +static struct pci_doe_mb *pci_doe_create_mb(struct pci_dev *pdev,
> > +					    u16 cap_offset)
> >  {
> >  	struct pci_doe_mb *doe_mb;
> > -	struct device *dev = &pdev->dev;
> >  	int rc;
> >  
> > -	doe_mb = devm_kzalloc(dev, sizeof(*doe_mb), GFP_KERNEL);
> > +	doe_mb = kzalloc(sizeof(*doe_mb), GFP_KERNEL);
> >  	if (!doe_mb)
> >  		return ERR_PTR(-ENOMEM);
> >  
> >  	doe_mb->pdev = pdev;
> >  	doe_mb->cap_offset = cap_offset;
> >  	init_waitqueue_head(&doe_mb->wq);
> > -
> >  	xa_init(&doe_mb->prots);  
> See below - I'd move xa_init() down to just above the pci_doe_cache_protocols()
> call.
> 
> > -	rc = devm_add_action(dev, pci_doe_xa_destroy, doe_mb);
> > -	if (rc)
> > -		return ERR_PTR(rc);
> >  
> >  	doe_mb->work_queue = alloc_ordered_workqueue("%s %s DOE [%x]", 0,
> >  						dev_driver_string(&pdev->dev),
> > @@ -479,35 +461,90 @@ struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset)
> >  	if (!doe_mb->work_queue) {
> >  		pci_err(pdev, "[%x] failed to allocate work queue\n",
> >  			doe_mb->cap_offset);
> > -		return ERR_PTR(-ENOMEM);
> > +		rc = -ENOMEM;
> > +		goto err_free;
> >  	}
> > -	rc = devm_add_action_or_reset(dev, pci_doe_destroy_workqueue, doe_mb);
> > -	if (rc)
> > -		return ERR_PTR(rc);
> >  
> >  	/* Reset the mailbox by issuing an abort */
> >  	rc = pci_doe_abort(doe_mb);
> >  	if (rc) {
> >  		pci_err(pdev, "[%x] failed to reset mailbox with abort command : %d\n",
> >  			doe_mb->cap_offset, rc);
> > -		return ERR_PTR(rc);
> > +		goto err_destroy_wq;
> >  	}
> >  
> >  	/*
> >  	 * The state machine and the mailbox should be in sync now;
> > -	 * Set up mailbox flush prior to using the mailbox to query protocols.
> > +	 * Use the mailbox to query protocols.
> >  	 */
> > -	rc = devm_add_action_or_reset(dev, pci_doe_flush_mb, doe_mb);
> > -	if (rc)
> > -		return ERR_PTR(rc);
> > -
> >  	rc = pci_doe_cache_protocols(doe_mb);
> >  	if (rc) {
> >  		pci_err(pdev, "[%x] failed to cache protocols : %d\n",
> >  			doe_mb->cap_offset, rc);
> > +		goto err_flush;
> > +	}
> > +
> > +	return doe_mb;
> > +
> > +err_flush:
> > +	pci_doe_flush_mb(doe_mb);
> > +	xa_destroy(&doe_mb->prots);  
> 
> Why the reorder wrt to the original devm managed cleanup?
> I'd expect this to happen on any error path after the xa_init.
> 
> It doesn't matter in practice because there isn't anything to
> do until after pci_doe_cache_protocols though.  Maybe
> simplest option would be move xa_init() down to just above
> the call to pci_doe_cache_protocols()?  That way the order
> you have here would meet the 'obviously correct' test.
> 
> 
> > +err_destroy_wq:
> > +	destroy_workqueue(doe_mb->work_queue);
> > +err_free:
> > +	kfree(doe_mb);
> > +	return ERR_PTR(rc);
> > +}
> > +
> > +/**
> > + * pci_doe_destroy_mb() - Destroy a DOE mailbox object
> > + *
> > + * @ptr: Pointer to DOE mailbox
> > + *
> > + * Destroy all internal data structures created for the DOE mailbox.  
> 
> Could you comment on why it doesn't make sense to flush the
> mb on this path?  Perhaps add a comment here to say what state
> we should be in before calling this?
> 
> Not flushing here means you need more complex handling in
> error paths.
> 
> > + */
> > +static void pci_doe_destroy_mb(void *ptr)
> > +{
> > +	struct pci_doe_mb *doe_mb = ptr;
> > +
> > +	xa_destroy(&doe_mb->prots);  
> 
> If making the change above, also push the xa_destroy() below
> the destroy_workqueue() here.
> 
> > +	destroy_workqueue(doe_mb->work_queue);
> > +	kfree(doe_mb);
> > +}
> > +
> > +/**
> > + * pcim_doe_create_mb() - Create a DOE mailbox object
> > + *
> > + * @pdev: PCI device to create the DOE mailbox for
> > + * @cap_offset: Offset of the DOE mailbox
> > + *
> > + * Create a single mailbox object to manage the mailbox protocol at the
> > + * cap_offset specified.  The mailbox will automatically be destroyed on
> > + * driver unbinding from @pdev.
> > + *
> > + * RETURNS: created mailbox object on success
> > + *	    ERR_PTR(-errno) on failure
> > + */
> > +struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset)
> > +{
> > +	struct pci_doe_mb *doe_mb;
> > +	int rc;
> > +
> > +	doe_mb = pci_doe_create_mb(pdev, cap_offset);
> > +	if (IS_ERR(doe_mb))
> > +		return doe_mb;
> > +
> > +	rc = devm_add_action(&pdev->dev, pci_doe_destroy_mb, doe_mb);
> > +	if (rc) {
> > +		pci_doe_flush_mb(doe_mb);
> > +		pci_doe_destroy_mb(doe_mb);
> >  		return ERR_PTR(rc);
> >  	}
> >  
> > +	rc = devm_add_action_or_reset(&pdev->dev, pci_doe_flush_mb, doe_mb);
> > +	if (rc)
> > +		return ERR_PTR(rc);
> > +
> >  	return doe_mb;
> >  }
> >  EXPORT_SYMBOL_GPL(pcim_doe_create_mb);  
> 

