Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 139BF4562E4
	for <lists+linux-pci@lfdr.de>; Thu, 18 Nov 2021 19:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbhKRSvV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Nov 2021 13:51:21 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4111 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhKRSvU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Nov 2021 13:51:20 -0500
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Hw81w4Vdvz67H9S;
        Fri, 19 Nov 2021 02:48:04 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Thu, 18 Nov 2021 19:48:18 +0100
Received: from localhost (10.52.127.148) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Thu, 18 Nov
 2021 18:48:17 +0000
Date:   Thu, 18 Nov 2021 18:48:14 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <ben.widawsky@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/5] PCI/DOE: Add Data Object Exchange Aux Driver
Message-ID: <20211118184814.000045dd@Huawei.com>
In-Reply-To: <20211110054541.GI3538886@iweiny-DESK2.sc.intel.com>
References: <20211105235056.3711389-1-ira.weiny@intel.com>
        <20211105235056.3711389-3-ira.weiny@intel.com>
        <20211108121546.000034b2@Huawei.com>
        <20211110054541.GI3538886@iweiny-DESK2.sc.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.127.148]
X-ClientProxiedBy: lhreml749-chm.china.huawei.com (10.201.108.199) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

....

Sorry for the delay, I managed to miss this email.
Only realized I hadn't replied because I wanted to point out the docs
issue I'd missed in original review... See below.

> > I was carrying a rework of this locally because I managed
> > to convince myself this is wrong.  It's been a while and naturally
> > I didn't write a comprehensive set of notes on why it was wrong...
> > (Note you can't trigger the problem paths in QEMU without some
> > nasty hacks as it relies on opening up race windows that make
> > limited sense for the QEMU implementation).
> > 
> > It's all centered on some details of exactly what causes an interrupt
> > on a DOE.  Section 6.xx.3 Interrupt Generation states:
> > 
> > If enabled, an interrupt message must be triggered every time the
> > logical AND of the following conditions transitions from FALSE to TRUE:
> > 
> > * The associated vector is unmasked ...
> > * The value of the DOE interrupt enable bit is 1b
> > * The value of the DOE interrupt status bit is 1b
> > (only last one really maters to us I think).
> > 
> > The interrupt status bit is an OR conditional.
> > 
> > Must be set.. Data Object Read bit or DOE error bit set or DOE busy bit cleared.
> >   
> > > +{
> > > +	struct pci_doe *doe = data;
> > > +	struct pci_dev *pdev = doe->doe_dev->pdev;
> > > +	int offset = doe->doe_dev->cap_offset;
> > > +	u32 val;
> > > +
> > > +	pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
> > > +	if (FIELD_GET(PCI_DOE_STATUS_INT_STATUS, val)) {  
> > 
> > So this bit is set on any of: BUSY dropped, READY or ERROR.
> > If it's set on BUSY drop, but then in between the read above and this clear
> > READY becomes true, then my reading is that we will not get another interrupt.
> > That is fine because we will read it again in the state machine and see the
> > new state. We could do more of the dance in the interrupt controller by doing
> > a reread after clear of INT_STATUS but I think it's cleaner to leave
> > it in the state machine.
> > 
> > It might look nicer here to only write BIT(1) - RW1C, but that doesn't matter as
> > all the rest of the register is RO.
> >   
> > > +		pci_write_config_dword(pdev, offset + PCI_DOE_STATUS, val);
> > > +		mod_delayed_work(system_wq, &doe->statemachine, 0);
> > > +		return IRQ_HANDLED;
> > > +	}
> > > +	/* Leave the error case to be handled outside IRQ */
> > > +	if (FIELD_GET(PCI_DOE_STATUS_ERROR, val)) {  
> > 
> > I don't think we can get here because int status already true.
> > So should do this before the above general check to avoid clearning
> > the interrupt (we don't want more interrupts during the abort though
> > I'd hope the hardware wouldn't generate them).
> > 
> > So move this before the previous check.
> >   
> > > +		mod_delayed_work(system_wq, &doe->statemachine, 0);
> > > +		return IRQ_HANDLED;
> > > +	}
> > > +
> > > +	/*
> > > +	 * Busy being cleared can result in an interrupt, but as
> > > +	 * the original Busy may not have been detected, there is no
> > > +	 * way to separate such an interrupt from a spurious interrupt.
> > > +	 */  
> > 
> > This is misleading - as Busy bit clear would have resulted in INT_STATUS being true above
> > (that was a misread of the spec from me in v4).
> > So I don't think we can get here in any valid path.
> > 
> > return IRQ_NONE; should be safe.
> > 
> >   
> > > +	return IRQ_HANDLED;
> > > +}  
> > 
> > Summary of above suggested changes:
> > 1) Move the DOE_STATUS_ERROR block before the DOE_STATUS_INT_STATUS one
> > 2) Possibly uses
> >    pci_write_config_dword(pdev, offset + PCI_DOE_STATUS, PCI_DOE_STATUS_INT_STATUS);
> >    to be explicit on the write one to clear bit.
> > 3) IRQ_NONE for the final return path as I'm fairly sure there is no valid route to that.
> >      
> 
> Done.
> 
> But just to ensure that I understand.  If STATUS_ERROR is indicated we are
> basically not clearing the irq because we are resetting the mailbox?  Because
> with this new code I don't see a pci_write_config_dword to clear INT_STATUS.

Exactly.

> 
> But if we are resetting the mailbox I think that is ok.
> 
> > ...
> >   
...

> > > +/**
> > > + * pci_doe_exchange_sync() - Send a request, then wait for and receive a response
> > > + * @doe: DOE mailbox state structure

This should be doe_dev,  another thing during build tests of a rebase as
I wanted to put the CMA stuff on top of this.


> > > + * @ex: Description of the buffers and Vendor ID + type used in this
> > > + *      request/response pair
> > > + *
> > > + * Excess data will be discarded.
> > > + *
> > > + * RETURNS: payload in bytes on success, < 0 on error
> > > + */
> > > +int pci_doe_exchange_sync(struct pci_doe_dev *doe_dev, struct pci_doe_exchange *ex)
> > > +{
> > > +	struct pci_doe *doe = dev_get_drvdata(&doe_dev->adev.dev);
> > > +	struct pci_doe_task task;
> > > +	DECLARE_COMPLETION_ONSTACK(c);
> > > +
> > > +	if (!doe)
> > > +		return -EAGAIN;
> > > +
> > > +	/* DOE requests must be a whole number of DW */
> > > +	if (ex->request_pl_sz % sizeof(u32))
> > > +		return -EINVAL;
> > > +
> > > +	task.ex = ex;
> > > +	task.cb = pci_doe_task_complete;
> > > +	task.private = &c;
> > > +
> > > +again:  
> > 
> > Hmm.   Whether having this code at this layer makes sense hinges on
> > whether we want to easily support async use of the DOE in future.  
> 
> I struggled with this.  I was trying to strike a balance with making this a
> synchronous call with only 1 outstanding task while leaving the statemachine
> alone.
> 
> FWIW I think the queue you had was just fine even though there was only this
> synchronous call.

We can put it back easily if we ever need it. Until then this is fine.

I'm not convinced any DOE use will be sufficiently high bandwidth that
it really matters if we support async accessors


> 
> > 
> > In v4 some of the async handling had ended up in this function and
> > should probably have been factored out to give us a 
> > 'queue up work' then 'wait for completion' sequence.
> > 
> > Given there is now more to be done in here perhaps we need to think
> > about such a separation to keep it clear that this is fundamentally
> > a synchronous wrapper around an asynchronous operation.  
> 
> I think that would be moving back in a direction of having a queue like you
> defined in V4.  Eliminating the queue really defined this function to sleep
> waiting for the state machine to be available.  Doing anything more would have
> messed with the state machine you wrote and I did not want to do that.
> 
> Dan should we move back to having a queue_task/wait_task like Jonathan had
> before?
> 
> >   
> > > +	mutex_lock(&doe->state_lock);
> > > +	if (doe->cur_task) {
> > > +		mutex_unlock(&doe->state_lock);
> > > +		wait_event_interruptible(doe->wq, doe->cur_task == NULL);
> > > +		goto again;
> > > +	}
> > > +
> > > +	if (doe->dead) {
> > > +		mutex_unlock(&doe->state_lock);
> > > +		return -EIO;
> > > +	}
> > > +	doe->cur_task = &task;
> > > +	schedule_delayed_work(&doe->statemachine, 0);
> > > +	mutex_unlock(&doe->state_lock);
> > > +
> > > +	wait_for_completion(&c);
> > > +
> > > +	return task.rv;
> > > +}
> > > +EXPORT_SYMBOL_GPL(pci_doe_exchange_sync);

> > ...
> >   
> > > +
> > > +static void pci_doe_unregister(struct pci_doe *doe)
> > > +{
> > > +	pci_doe_release_irq(doe);
> > > +	kfree(doe->irq_name);
> > > +	put_device(&doe->doe_dev->pdev->dev);  
> > 
> > This makes me wonder if we should be doing the get_device()
> > earlier in probe?  Limited harm in moving it to near the start
> > and then ending up with it being 'obviously' correct...  
> 
> Well...  get_device() is in pci_doe_register...  And it does it's own irq
> unwinding.
> 
> I guess we could call pci_doe_unregister() from that if we refactored this...
> 
> How about this?  (Diff to this code)

While it should work, I think I'd keep the error handling paths explicit
and not rely on irq_name == 0 and doe->irq == 0 making the error path
calls of pci_doe_unregister() safe.  That takes some thought when reviewing
(a little bit) whereas explicit error handling doesn't take as much.

I just don't like unregister having put_device() last when it isn't
the first thing done in register().  So moving that first perhaps gets
a reference before we strictly speaking need one, but it makes it clear
we can definitely release that reference where it's done in unregister.


> 
> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> index 76acf4063b6b..6f2a419b3c93 100644
> --- a/drivers/pci/doe.c
> +++ b/drivers/pci/doe.c
> @@ -545,10 +545,12 @@ static int pci_doe_abort(struct pci_doe *doe)
>         return 0;
>  }
>  
> -static void pci_doe_release_irq(struct pci_doe *doe)
> +static void pci_doe_unregister(struct pci_doe *doe)
>  {
>         if (doe->irq > 0)
>                 free_irq(doe->irq, doe);
> +       kfree(doe->irq_name);
> +       put_device(&doe->doe_dev->pdev->dev);
>  }
>  
>  static int pci_doe_register(struct pci_doe *doe)
> @@ -559,21 +561,28 @@ static int pci_doe_register(struct pci_doe *doe)
>         int rc, irq;
>         u32 val;
>  
> +       /* Ensure the pci device remains until this driver is done with it */
> +       get_device(&pdev->dev);
> +
>         pci_read_config_dword(pdev, offset + PCI_DOE_CAP, &val);
>  
>         if (!poll && FIELD_GET(PCI_DOE_CAP_INT, val)) {
>                 irq = pci_irq_vector(pdev, FIELD_GET(PCI_DOE_CAP_IRQ, val));
> -               if (irq < 0)
> -                       return irq;
> +               if (irq < 0) {
> +                       rc = irq;
> +                       goto unregister;
> +               }
>  
>                 doe->irq_name = kasprintf(GFP_KERNEL, "DOE[%s]",
>                                           doe->doe_dev->adev.name);
> -               if (!doe->irq_name)
> -                       return -ENOMEM;
> +               if (!doe->irq_name) {
> +                       rc = -ENOMEM;
> +                       goto unregister;
> +               }
>  
>                 rc = request_irq(irq, pci_doe_irq, 0, doe->irq_name, doe);
>                 if (rc)
> -                       goto err_free_name;
> +                       goto unregister;
>  
>                 doe->irq = irq;
>                 pci_write_config_dword(pdev, offset + PCI_DOE_CTRL,
> @@ -583,27 +592,15 @@ static int pci_doe_register(struct pci_doe *doe)
>         /* Reset the mailbox by issuing an abort */
>         rc = pci_doe_abort(doe);
>         if (rc)
> -               goto err_free_irq;
> -
> -       /* Ensure the pci device remains until this driver is done with it */
> -       get_device(&pdev->dev);
> +               goto unregister;
>  
>         return 0;
>  
> -err_free_irq:
> -       pci_doe_release_irq(doe);
> -err_free_name:
> -       kfree(doe->irq_name);
> +unregister:
> +       pci_doe_unregister(doe);
>         return rc;
>  }
>  
> -static void pci_doe_unregister(struct pci_doe *doe)
> -{
> -       pci_doe_release_irq(doe);
> -       kfree(doe->irq_name);
> -       put_device(&doe->doe_dev->pdev->dev);
> -}
> -
>  /*
>   * pci_doe_probe() - Set up the Mailbox
>   * @aux_dev: Auxiliary Device
> 
> 
> >   
> > > +}
> > > +
> > > +/*
> > > + * pci_doe_probe() - Set up the Mailbox
> > > + * @aux_dev: Auxiliary Device
> > > + * @id: Auxiliary device ID
> > > + *
> > > + * Probe the mailbox found for all protocols and set up the Mailbox
> > > + *
> > > + * RETURNS: 0 on success, < 0 on error
> > > + */
> > > +static int pci_doe_probe(struct auxiliary_device *aux_dev,
> > > +			 const struct auxiliary_device_id *id)
> > > +{
> > > +	struct pci_doe_dev *doe_dev = container_of(aux_dev,
> > > +					struct pci_doe_dev,
> > > +					adev);
> > > +	struct pci_doe *doe;
> > > +	int rc;
> > > +
> > > +	doe = kzalloc(sizeof(*doe), GFP_KERNEL);  
> > 
> > Could go devm_ for this I think, though may not be worthwhile.  
> 
> Yes I think it is worth it...  I should use it more.
> 
> BTW why did you not use devm_krealloc() for the protocols?

I have a sneaky suspicion this has been around long enough it predates
devm_krealloc.

> 
> I did not realize that call existed before you mentioned it in the other patch
> review.

It is rather new and shiny :)

> 
> Any issue with using it there?

Should be fine I think.

> 
> >   
> > > +	if (!doe)
> > > +		return -ENOMEM;
> > > +
> > > +	mutex_init(&doe->state_lock);
> > > +	init_completion(&doe->abort_c);
> > > +	doe->doe_dev = doe_dev;
> > > +	init_waitqueue_head(&doe->wq);
> > > +	INIT_DELAYED_WORK(&doe->statemachine, doe_statemachine_work);
> > > +	dev_set_drvdata(&aux_dev->dev, doe);
> > > +
> > > +	rc = pci_doe_register(doe);
> > > +	if (rc)
> > > +		goto err_free;
> > > +
> > > +	rc = pci_doe_cache_protocols(doe);
> > > +	if (rc) {
> > > +		pci_doe_unregister(doe);  
> > 
> > Mixture of different forms of error handling here.
> > I'd move this below and add an err_unregister label.  
> 
> Actually with the devm_kzalloc() we don't need the goto at all.  We can just
> return.  I _think_?  Right?

yes

> 
> >   
> > > +		goto err_free;
> > > +	}
> > > +
> > > +	return 0;
> > > +
> > > +err_free:
> > > +	kfree(doe);
> > > +	return rc;
> > > +}
> > > +
> > > +static void pci_doe_remove(struct auxiliary_device *aux_dev)
> > > +{
> > > +	struct pci_doe *doe = dev_get_drvdata(&aux_dev->dev);
> > > +
> > > +	/* First halt the state machine */
> > > +	cancel_delayed_work_sync(&doe->statemachine);
> > > +	kfree(doe->prots);  
> > 
> > Logical flow to me is unregister first, free protocols second
> > (to reverse what we do in probe)  
> 
> No this is the reverse of the probe order I think.
> 
> Order is
> 	register
> 	cache protocols
> 
> Then we
> 	free 'uncache' protocols
> 	unregister
> 
> Right?

Huh. No idea what I was going on about.

> 
> >   
> > > +	pci_doe_unregister(doe);
> > > +	kfree(doe);
> > > +}
> > > +
> > > +static const struct auxiliary_device_id pci_doe_auxiliary_id_table[] = {
> > > +	{.name = "cxl_pci.doe", },  
> > 
> > I'd like to hear from Bjorn on whether registering this from the CXL
> > device is the right approach or if we should perhaps just do it directly from
> > somewhere in PCI. (really applies to patch 3) I'll talk more about this there.  
> 
> Actually I think this could be left blank until the next patch...  It's just
> odd to define an empty table in the next few structures.  But technically this
> is not needed until the devices are defined.
> 
> I'm ok waiting to see what Bjorn thinks regarding the CXL vs PCI placement
> though.
> 
> >   
> > > +	{},
> > > +};
> > > +
> > > +MODULE_DEVICE_TABLE(auxiliary, pci_doe_auxiliary_id_table);
> > > +
> > > +struct auxiliary_driver pci_doe_auxiliary_drv = {
> > > +	.name = "pci_doe_drv",  
> > 
> > I would assume this is only used in contexts where the _drv is
> > obvious?  I would go with "pci_doe".  
> 
> Sure. done.
> 
> >   
> > > +	.id_table = pci_doe_auxiliary_id_table,
> > > +	.probe = pci_doe_probe,
> > > +	.remove = pci_doe_remove
> > > +};
> > > +
> > > +static int __init pci_doe_init_module(void)
> > > +{
> > > +	int ret;
> > > +
> > > +	ret = auxiliary_driver_register(&pci_doe_auxiliary_drv);
> > > +	if (ret) {
> > > +		pr_err("Failed pci_doe auxiliary_driver_register() ret=%d\n",
> > > +		       ret);
> > > +		return ret;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static void __exit pci_doe_exit_module(void)
> > > +{
> > > +	auxiliary_driver_unregister(&pci_doe_auxiliary_drv);
> > > +}
> > > +
> > > +module_init(pci_doe_init_module);
> > > +module_exit(pci_doe_exit_module);  
> > 
> > Seems like the auxiliary bus would benefit from a
> > module_auxiliary_driver() macro to cover this simple registration stuff
> > similar to module_i2c_driver() etc.
> > 
> > Mind you, looking at 5.15 this would be the only user, so maybe one
> > for the 'next' case on basis two instances proves it's 'common' ;)  
> 
> I'm inclined to leave this alone ATM.  I tried to clean up the auxiliary device
> documentation and got a bunch more work asked of me by Greg KH.  So I'm behind
> on that ATM.
> 
> Later we can investigate that a bit I think.

Sure. No rush on that.

> 
> >   
> > > +MODULE_LICENSE("GPL v2");
> > > diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
> > > new file mode 100644
> > > index 000000000000..8380b7ad33d4
> > > --- /dev/null
> > > +++ b/include/linux/pci-doe.h
> > > @@ -0,0 +1,63 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/*
> > > + * Data Object Exchange was added as an ECN to the PCIe r5.0 spec.
> > > + *
> > > + * Copyright (C) 2021 Huawei
> > > + *     Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > + */
> > > +
> > > +#include <linux/completion.h>
> > > +#include <linux/list.h>
> > > +#include <linux/mutex.h>  
> > 
> > Not used in this header that I can see, so push down to the c files.  
> 
> oops...  thanks.
> 
> >   
> > > +#include <linux/auxiliary_bus.h>
> > > +
> > > +#ifndef LINUX_PCI_DOE_H
> > > +#define LINUX_PCI_DOE_H
> > > +
> > > +#define DOE_DEV_NAME "doe"  
> > 
> > Not sure this is used?  
> 
> Used in the next patch...  and it kind of goes along with the table_id name...
> 
> I'll see about moving both of those to the next patch where it makes more sense
> for now.
> 
> Thanks for the review,
> Ira
> 
Thanks,

Jonathan

