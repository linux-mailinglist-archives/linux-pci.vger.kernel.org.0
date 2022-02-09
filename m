Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45EE64AF754
	for <lists+linux-pci@lfdr.de>; Wed,  9 Feb 2022 17:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237603AbiBIQ6B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Feb 2022 11:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237601AbiBIQ6A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Feb 2022 11:58:00 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66AEC05CB82;
        Wed,  9 Feb 2022 08:58:01 -0800 (PST)
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jv5fW3bR1z67yyp;
        Thu, 10 Feb 2022 00:57:55 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Wed, 9 Feb 2022 17:57:59 +0100
Received: from localhost (10.122.247.231) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 9 Feb
 2022 16:57:58 +0000
Date:   Wed, 9 Feb 2022 16:57:56 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     "Weiny, Ira" <ira.weiny@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V6 03/10] PCI/DOE: Add Data Object Exchange Aux Driver
Message-ID: <20220209165756.00002841@huawei.com>
In-Reply-To: <CAPcyv4g2nNHKPuYVOEH3TbJtCiB1rkRNCVbfDWHnWkotvTAcJg@mail.gmail.com>
References: <20220201071952.900068-1-ira.weiny@intel.com>
        <20220201071952.900068-4-ira.weiny@intel.com>
        <CAPcyv4hYAgyf-WcArGvbWHAJgc5+p=OO_6ah_dXJhNM5cXcVTw@mail.gmail.com>
        <20220209101320.00000473@Huawei.com>
        <CAPcyv4g2nNHKPuYVOEH3TbJtCiB1rkRNCVbfDWHnWkotvTAcJg@mail.gmail.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml743-chm.china.huawei.com (10.201.108.193) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 9 Feb 2022 08:26:43 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> On Wed, Feb 9, 2022 at 2:13 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> [..]

...

> 
> >  
> > >  
> > > > +}
> > > > +
> > > > +static int pci_doe_send_req(struct pci_doe *doe, struct pci_doe_exchange *ex)  
> > >
> > > The relationship between tasks, requests, responses, and exchanges is
> > > not immediately clear to me. For example, can this helper be renamed
> > > in terms of its relationship to a task? A theory of operation document
> > > would help, but it seems there is also room for the implementation to
> > > be more self documenting.  
> >
> > Not totally sure what such naming would be.
> >
> > A task is the management wrapper around an exchange which is a request
> > + response pair.  In the sense you queue a task which will carry out
> > and exchange by sending a request and receiving a response.
> >
> > Could rename this pci_doe_start_exchange() but that then obscures
> > that we mean send the request to the hardware and removes the resemblance
> > to what I recall the specification uses.  
> 
> I'm not a big fan of copying spec names *if* Linux has a more
> idiomatic name for the concept. I am mainly reviewing this from the
> perspective that 'struct bio' and 'struct request' naming /
> organization is idiomatic for Linux driver transaction flows. Up to
> this point in the review I was mapping tasks to bios and exchanges to
> requests but then the usage of "req" in this function name threw off
> my ontology. At a minimum a decoder ring style comment, like your
> reply, about the relationship between these terms would help avoid
> this exercise again.

OK. So up to Ira, but my suggestion is go with a comment unless
someone comes up with clearer naming.

Mind you, if we are now exposing the doe_exchange to callers anyway,
we could just squash the structure into the doe_task one and drop
the separation.

Intent before was doe_exchange was all the stuff related to the protocol
(so buffers etc0 whereas task was about the implementation but
if we expose struct doe_task anyway that separation becomes a bit pointless.

> 
> > > > +       case DOE_WAIT_ABORT:
> > > > +       case DOE_WAIT_ABORT_ON_ERR:
> > > > +               pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
> > > > +
> > > > +               if (!FIELD_GET(PCI_DOE_STATUS_ERROR, val) &&
> > > > +                   !FIELD_GET(PCI_DOE_STATUS_BUSY, val)) {
> > > > +                       /* Back to normal state - carry on */
> > > > +                       mutex_lock(&doe->state_lock);
> > > > +                       doe->cur_task = NULL;
> > > > +                       mutex_unlock(&doe->state_lock);
> > > > +                       wake_up_interruptible(&doe->wq);
> > > > +
> > > > +                       /*
> > > > +                        * For deliberately triggered abort, someone is
> > > > +                        * waiting.
> > > > +                        */
> > > > +                       if (doe->state == DOE_WAIT_ABORT)
> > > > +                               complete(&doe->abort_c);  
> > >
> > > Why is a completion and waitqueue needed? I.e. a waiter could simply
> > > look for an abort completion flag to be set instead.  
> >
> > You mean use the main completion (the one for the non abort case)
> > and a flag?
> >
> > Or a wait_event() with appropriate check?
> >
> > Could do that but I'm not sure I understand why we care either way?  
> 
> Just reduction in machinery that needs to be maintained /
> comprehended. 2 wait primitives when one will do will always be a
> tempting cleanup target.

Ah. Fair enough - it looks like using the same completion won't
be a huge addition in complexity.

> 
> [..]
> > > > +/**
> > > > + * pci_doe_exchange_sync() - Send a request, then wait for and receive a
> > > > + *                          response
> > > > + * @doe_dev: DOE mailbox state structure
> > > > + * @ex: Description of the buffers and Vendor ID + type used in this
> > > > + *      request/response pair
> > > > + *
> > > > + * Excess data will be discarded.
> > > > + *
> > > > + * RETURNS: payload in bytes on success, < 0 on error
> > > > + */
> > > > +int pci_doe_exchange_sync(struct pci_doe_dev *doe_dev,
> > > > +                         struct pci_doe_exchange *ex)
> > > > +{
> > > > +       struct pci_doe *doe = dev_get_drvdata(&doe_dev->adev.dev);
> > > > +       struct pci_doe_task task;
> > > > +       DECLARE_COMPLETION_ONSTACK(c);
> > > > +
> > > > +       if (!doe)
> > > > +               return -EAGAIN;
> > > > +
> > > > +       /* DOE requests must be a whole number of DW */
> > > > +       if (ex->request_pl_sz % sizeof(u32))
> > > > +               return -EINVAL;
> > > > +
> > > > +       task.ex = ex;
> > > > +       task.cb = pci_doe_task_complete;
> > > > +       task.private = &c;
> > > > +
> > > > +again:
> > > > +       mutex_lock(&doe->state_lock);
> > > > +       if (doe->cur_task) {
> > > > +               mutex_unlock(&doe->state_lock);
> > > > +               wait_event_interruptible(doe->wq, doe->cur_task == NULL);
> > > > +               goto again;
> > > > +       }
> > > > +
> > > > +       if (doe->dead) {
> > > > +               mutex_unlock(&doe->state_lock);
> > > > +               return -EIO;
> > > > +       }
> > > > +       doe->cur_task = &task;
> > > > +       schedule_delayed_work(&doe->statemachine, 0);
> > > > +       mutex_unlock(&doe->state_lock);
> > > > +
> > > > +       wait_for_completion(&c);  
> > >
> > > I would expect that the caller of this routine would want to specify
> > > the task and end_task() callback and use that as the completion
> > > signal. It may also want "no wait" behavior where it is prepared for
> > > the DOE result to come back sometime later. With that change the
> > > exchange fields can move into the task directly.  
> >
> > This is the simple synchronous wrapper around an async core.
> > If we want an async path at somepoint in the future where we have
> > someone using it then sure, we can have an async version that
> > takes the callback.  
> 
> It just seems an unnecessary hunk of code for the core to carry when
> it's trivial for a client of the core to do:
> 
> task->private = &completion;
> task->end_task = complete_completion;
> submit_task()
> wait_for_completion(&completion);

OK, we can move this to the callers though function obviously will
also need renaming - I guess to pci_doe_exchange() and now need to take a
task rather than the exchange.

I personally slightly prefer the layered approach, but don't care that
strongly.

> 
> > > > +       return task.rv;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(pci_doe_exchange_sync);
> > > > +
> > > > +/**
> > > > + * pci_doe_supports_prot() - Return if the DOE instance supports the given
> > > > + *                          protocol
> > > > + * @pdev: Device on which to find the DOE instance
> > > > + * @vid: Protocol Vendor ID
> > > > + * @type: protocol type
> > > > + *
> > > > + * This device can then be passed to pci_doe_exchange_sync() to execute a
> > > > + * mailbox exchange through that DOE mailbox.
> > > > + *
> > > > + * RETURNS: True if the DOE device supports the protocol specified
> > > > + */
> > > > +bool pci_doe_supports_prot(struct pci_doe_dev *doe_dev, u16 vid, u8 type)
> > > > +{
> > > > +       struct pci_doe *doe = dev_get_drvdata(&doe_dev->adev.dev);
> > > > +       int i;
> > > > +
> > > > +       if (!doe)
> > > > +               return false;
> > > > +
> > > > +       for (i = 0; i < doe->num_prots; i++)
> > > > +               if ((doe->prots[i].vid == vid) &&
> > > > +                   (doe->prots[i].type == type))
> > > > +                       return true;
> > > > +
> > > > +       return false;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(pci_doe_supports_prot);
> > > > +
> > > > +static int pci_doe_discovery(struct pci_doe *doe, u8 *index, u16 *vid,
> > > > +                            u8 *protocol)
> > > > +{
> > > > +       u32 request_pl = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX,
> > > > +                                   *index);
> > > > +       u32 response_pl;
> > > > +       struct pci_doe_exchange ex = {
> > > > +               .prot.vid = PCI_VENDOR_ID_PCI_SIG,
> > > > +               .prot.type = PCI_DOE_PROTOCOL_DISCOVERY,
> > > > +               .request_pl = &request_pl,
> > > > +               .request_pl_sz = sizeof(request_pl),
> > > > +               .response_pl = &response_pl,
> > > > +               .response_pl_sz = sizeof(response_pl),
> > > > +       };
> > > > +       int ret;
> > > > +
> > > > +       ret = pci_doe_exchange_sync(doe->doe_dev, &ex);
> > > > +       if (ret < 0)
> > > > +               return ret;
> > > > +
> > > > +       if (ret != sizeof(response_pl))
> > > > +               return -EIO;
> > > > +
> > > > +       *vid = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID, response_pl);
> > > > +       *protocol = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL,
> > > > +                             response_pl);
> > > > +       *index = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX,
> > > > +                          response_pl);
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +static int pci_doe_cache_protocols(struct pci_doe *doe)
> > > > +{
> > > > +       u8 index = 0;
> > > > +       int num_prots;
> > > > +       int rc;
> > > > +
> > > > +       /* Discovery protocol must always be supported and must report itself */
> > > > +       num_prots = 1;
> > > > +       doe->prots = devm_kcalloc(&doe->doe_dev->adev.dev, num_prots,
> > > > +                                 sizeof(*doe->prots), GFP_KERNEL);
> > > > +       if (doe->prots == NULL)
> > > > +               return -ENOMEM;
> > > > +
> > > > +       do {
> > > > +               struct pci_doe_protocol *prot;
> > > > +
> > > > +               prot = &doe->prots[num_prots - 1];
> > > > +               rc = pci_doe_discovery(doe, &index, &prot->vid, &prot->type);
> > > > +               if (rc)
> > > > +                       return rc;
> > > > +
> > > > +               if (index) {
> > > > +                       struct pci_doe_protocol *prot_new;
> > > > +
> > > > +                       num_prots++;
> > > > +                       prot_new = devm_krealloc(&doe->doe_dev->adev.dev,
> > > > +                                                doe->prots,
> > > > +                                                sizeof(*doe->prots) *
> > > > +                                                       num_prots,
> > > > +                                                GFP_KERNEL);
> > > > +                       if (prot_new == NULL)
> > > > +                               return -ENOMEM;
> > > > +                       doe->prots = prot_new;
> > > > +               }
> > > > +       } while (index);
> > > > +
> > > > +       doe->num_prots = num_prots;
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +static int pci_doe_abort(struct pci_doe *doe)
> > > > +{
> > > > +       reinit_completion(&doe->abort_c);
> > > > +       mutex_lock(&doe->state_lock);
> > > > +       doe->abort = true;  
> > >
> > > Why not a flags field where atomic bitops can be used without need for a mutex.  
> >
> > I'll go the other way, why bother with atomics when this isn't a high performance
> > path or something expected to happen often?  
> 
> It obfuscates what the lock is protecting if it's used for state
> management and atomic flag management, but I am not holding the pen
> here, so I can let this arbitrary trade-off go.

Sure, given Ira is now doing the leg work, up to Ira or other reviewers.

Jonathan


