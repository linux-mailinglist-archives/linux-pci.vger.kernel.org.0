Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB6AC346780
	for <lists+linux-pci@lfdr.de>; Tue, 23 Mar 2021 19:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbhCWSXv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Mar 2021 14:23:51 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2735 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbhCWSXk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Mar 2021 14:23:40 -0400
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4F4fj24n7jz67yjh;
        Wed, 24 Mar 2021 02:17:10 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 23 Mar 2021 19:23:38 +0100
Received: from localhost (10.47.84.123) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2106.2; Tue, 23 Mar
 2021 18:23:36 +0000
Date:   Tue, 23 Mar 2021 18:22:18 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>,
        "Ben Widawsky" <ben.widawsky@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Chris Browy" <cbrowy@avery-design.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        Linuxarm <linuxarm@huawei.com>, Fangjian <f.fangjian@huawei.com>
Subject: Re: [RFC PATCH 1/2] PCI/doe: Initial support PCI Data Object
 Exchange
Message-ID: <20210323182218.000049cf@Huawei.com>
In-Reply-To: <CAPcyv4h6hHCuO=0vHbPz2m4qw6-0=wW9swBrWimBsz6_GJu4Aw@mail.gmail.com>
References: <20210310180306.1588376-1-Jonathan.Cameron@huawei.com>
 <20210310180306.1588376-2-Jonathan.Cameron@huawei.com>
 <CAPcyv4gG-==Vj9w3d7=gRRSPaoD5eZHZZ2hAA0h3c07eMT_x1A@mail.gmail.com>
 <20210316162952.00001ab7@Huawei.com>
 <CAPcyv4h6hHCuO=0vHbPz2m4qw6-0=wW9swBrWimBsz6_GJu4Aw@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.84.123]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 16 Mar 2021 11:14:05 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

...

> >  
> > >  
> > > >   that to be implemented when support for such a protocol is added?  
> > >
> > > If the timeout is property of the protocol then perhaps it should wait
> > > and not be modeled at the transport level, but that's just an initial
> > > reaction. I have not spent quality time with the DOE spec.  
> >
> > I'm not sure it's possible to do so without breaking the abstraction of
> > DOE request / response into a bunch of messy sub steps.  Perhaps there is
> > a clean way of doing it but I can't immediately think of it.
> >
> > If a protocol comes along that varies the timeout we can just add
> > a parameter to say what it is on a call by call basis.  
> 
> Now that I've had a chance to take a look the spec seems to
> unequivocally mandate the timeouts in "6.xx.1 Operation", where was
> the per-protocol timeout implied?

That paragraph starts with
"For request/response protocols, unless there is a protocol-specific
 requirement, a DOE instance must complete processing a received data object
 and, if a data object is required in response, must generate the response
 and Set the Data Object Ready bit in the DOE Status register within 1
 second after the DOE Go bit was Set in the DOE Control register...."

I read that as allowing a wealth of flexibility in what a protocol can specify
differently from the main DOE spec including the timeout.
Let's ignore it until it matters.

...

> > > > +obj-$(CONFIG_PCIE_DOE)         += doe.o
> > > > diff --git a/drivers/pci/pcie/doe.c b/drivers/pci/pcie/doe.c
> > > > new file mode 100644
> > > > index 000000000000..b091ef379362
> > > > --- /dev/null
> > > > +++ b/drivers/pci/pcie/doe.c
> > > > @@ -0,0 +1,284 @@

> >  
> > >  
> > > > + *
> > > > + * Copyright (C) 2021 Huawei
> > > > + *     Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > + */
> > > > +
> > > > +#include <linux/bitfield.h>
> > > > +#include <linux/delay.h>
> > > > +#include <linux/jiffies.h>
> > > > +#include <linux/mutex.h>
> > > > +#include <linux/pci.h>
> > > > +#include <linux/pcie-doe.h>
> > > > +
> > > > +static irqreturn_t doe_irq(int irq, void *data)
> > > > +{
> > > > +       struct pcie_doe *doe = data;
> > > > +       struct pci_dev *pdev = doe->pdev;
> > > > +       u32 val;
> > > > +
> > > > +       pci_read_config_dword(pdev, doe->cap_offset + PCI_DOE_STATUS, &val);
> > > > +       if (FIELD_GET(PCI_DOE_STATUS_INT_STATUS, val)) {
> > > > +               pci_write_config_dword(pdev, doe->cap_offset + PCI_DOE_STATUS,
> > > > +                                      val);
> > > > +               complete(&doe->c);
> > > > +               return IRQ_HANDLED;
> > > > +       }
> > > > +       /* Leave the error case to be handled outside irq */
> > > > +       if (FIELD_GET(PCI_DOE_STATUS_ERROR, val)) {
> > > > +               complete(&doe->c);
> > > > +               return IRQ_HANDLED;
> > > > +       }  
> > >
> > > Only one DOE command can be outstanding at a time per PCI device?  
> >
> > No, unless I'm missing something, that is one command per DOE mailbox at a time.
> > The completion is part of the pcie_doe structure, not the pci_dev.
> > That represents a single DOE mailbox.
> >
> > There can be multiple commands in flight to multiple DOE mailboxes. Not clear
> > that there ever will be in real use cases however.
> >
> > This comes up later wrt to async operation.  The mailbox only
> > supports one request / response cycle at a time, they cannot be overlapped.  
> 
> "6.xx.1 Operation" says "If a single DOE instance supports multiple
> data object protocols, system firmware/software is permitted to
> interleave requests/responses with different data object protocols."
> 
> ...although I must say I don't understand how system software tracks
> which response belongs to which request if the transactions are
> interleaved.

Ouch, I read that as meaning you could use the mailbox for
request protocol A / response protocol A ... request protocol B / response protocol B.

You are correct it is more general.  Still we don't have to use it
and I strongly suggest we don't.  It's a layer of complexity we probably
will never really need and it is fiddly to handle.

For tracking: you could do it, as the response carries the protocol ID.
That is enough to let you match against the protocol and each protocol can
only issue one request before it has to wait for a response.

One nasty element is that there is no interrupt to let you know BUSY bit has
fallen and you can send a new requests (as long as different protocol),
so this would need polling in all cases.

I think it would be a valid implementation to hold BUSY high until the
response to the previous response has been read out from the DOE.
Such an implementation would be enforcing no interleaving of different protocols
and we would have had to poll pointlessly whilst the previous message was being
handled and response read.

My current thought is to simply not support multi protocol interleaving.
If it turns out to be necessary sometime in the future we can look at
how to do it.

I see DOE as simple and lower performance so want to keep software
at a similar level.

> 
> > > This
> > > seems insufficient in the multi-mailbox case / feels like there should
> > > be a 'struct pcie_doe_request' object to track what it is to be
> > > completed.  
> >
> > No need for the complexity with one request / response in flight per
> > mailbox at a time and each mailbox having separate state maintenance.  
> 
> I think the workqueue proposal removes the need for pcie_doe_request,
> but still allows for the possibility of interleaving requests.

OK at some abstract level it allows for interleaving and we can try
to figure out how to actually do it if a need ever comes along.

> 
> >  
> > >  
> > > > +
> > > > +       return IRQ_NONE;
> > > > +}
> > > > +
> > > > +static int pcie_doe_abort(struct pcie_doe *doe)
> > > > +{
> > > > +       struct pci_dev *pdev = doe->pdev;
> > > > +       int retry = 0;
> > > > +       u32 val;
> > > > +
> > > > +       pci_write_config_dword(pdev, doe->cap_offset + PCI_DOE_CTRL,
> > > > +                              PCI_DOE_CTRL_ABORT);
> > > > +       /* Abort is allowed to take up to 1 second */
> > > > +       do {
> > > > +               retry++;
> > > > +               pci_read_config_dword(pdev, doe->cap_offset + PCI_DOE_STATUS,
> > > > +                                     &val);
> > > > +               if (FIELD_GET(PCI_DOE_STATUS_ERROR, val) &&
> > > > +                   !FIELD_GET(PCI_DOE_STATUS_BUSY, val))
> > > > +                       return 0;
> > > > +               usleep_range(1000, 2000);
> > > > +       } while (retry < 1000);
> > > > +
> > > > +       return -EIO;  
> > >
> > > What's the state of the mailbox after an abort failure?  
> >
> > Good question.  I think the answer to that is dead device, reboot the machine
> > or at least the device if you can do a hard enough slot reset.  
> 
> ...and hopefully that device is not part of an active interleave
> otherwise a reset can take down "System RAM".

Well - I suspect in most cases DOE death either breaks IDE in which case
likely *boom* anyway or it's informational stuff life CDAT in which case
print lots of warnings to suggest a smooth shutdown is a really good idea.

> 
> >
> > The specification goes with...
> > "It is strongly recommend that implementations ensure that the functionality
> > of the DOE Abort bit is resilient, including that DOE Abort functionality is
> > maintained even in cases where device firmware is malfunctioning"  
> 
> Ok.
> 
> >
> > So cross our fingers everyone obeys that strong recommendation or try to
> > work out what to do?  
> 
> What's the worst that can happen? </famous last words>

:)


> > >  
> > > > +                                     pci_irq_vector(pdev,
> > > > +                                                    FIELD_GET(PCI_DOE_CAP_IRQ, val)),
> > > > +                                     doe_irq, 0, "DOE", doe);
> > > > +               if (rc)
> > > > +                       return rc;
> > > > +
> > > > +               doe->use_int = use_int;
> > > > +               pci_write_config_dword(pdev, doe_offset + PCI_DOE_CTRL,
> > > > +                                      FIELD_PREP(PCI_DOE_CTRL_INT_EN, 1));
> > > > +       }
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +
> > > > +/**
> > > > + * pcie_doe_exchange() - Send a request and receive a response
> > > > + * @doe: DOE mailbox state structure
> > > > + * @request: request data to be sent
> > > > + * @request_sz: size of request in bytes
> > > > + * @response: buffer into which to place the response
> > > > + * @response_sz: size of available response buffer in bytes
> > > > + *
> > > > + * Return: 0 on success, < 0 on error
> > > > + * Excess data will be discarded.
> > > > + */
> > > > +int pcie_doe_exchange(struct pcie_doe *doe, u32 *request, size_t request_sz,
> > > > +                     u32 *response, size_t response_sz)  
> > >
> > > Are requests made against a specific protocol?  
> >
> > Yes, but the descriptive header is very brea.
> >  
> > >
> > > This interface feels under-decorated for a public API for host-drivers to use.  
> >
> > I'll see what I can come up with for v2.
> > Likely to look something like
> >
> > int pcie_doe_exchange(struct pci_doe *doe, u16 vid, u8 type,
> >                       u32 *request_pl, size_t request_pl_sz,
> >                       u32 *response_pl, size_t response_pl_sz)  
> 
> I was thinking something like 'struct pcie_doe_object' pointers rather
> than u32 arrays.

Possibly... I'm not convinced that it doesn't end up being
struct pcie_doe_object doe_obj;
DOE_OBJ_INIT(&doe_obj, vid, type, request_pl, request_pl_sz,
	     response_pl, response_pl_sz)

ret = pcie_doe_exchange(doe, &doe_obj);

If that's the pattern we see, why split it?
We might well have a struct pcie_doe_object internally but it doesn't
seem like a sensible external interface to me simply because we'd
just be filling it in and immediately passing it to a 'send' function.

> 
> >
> > and return received length or negative on error.
> >
> > The disadvantage is that at least some of the specs just have the
> > header as their first few DW.  So there isn't a clear distinction
> > between header and payload. May lead to people getting offsets wrong
> > in a way they wouldn't do if driver was responsible for building the
> > whole message.  
> 
> Aren't they more likely to get offsets wrong with u32 arrays rather
> than data structures?

I'm not sure what level you mean this at.  The CDAT patch review you
followed this with suggested just breaking out vid and type which is
fine because those are always packed the same and we can do appropriate
special handling.

If you meant the whole object as packed structure, then it is a whole
different matter.

Easy one to point is that u64 values are going to end up with their
top and bottom halves swapped.  Things get even messier if we break
up below the u32 level.

We can do this at a higher level by having wrappers that deal with
each protocol and do a serialize / deserialize for the protocol.
I'm not sure if that will make sense or not yet though.

> 
> >  
> > >  
> > > > +{
> > > > +       struct pci_dev *pdev = doe->pdev;
> > > > +       int ret = 0;
> > > > +       int i;
> > > > +       u32 val;
> > > > +       int retry = -1;
> > > > +       size_t length;
> > > > +
> > > > +       /* DOE requests must be a whole number of DW */
> > > > +       if (request_sz % sizeof(u32))
> > > > +               return -EINVAL;
> > > > +
> > > > +       /* Need at least 2 DW to get the length */
> > > > +       if (response_sz < 2 * sizeof(u32))
> > > > +               return -EINVAL;
> > > > +
> > > > +       mutex_lock(&doe->lock);
> > > > +       /*
> > > > +        * Check the DOE busy bit is not set.
> > > > +        * If it is set, this could indicate someone other than Linux is
> > > > +        * using the mailbox.
> > > > +        */  
> > >
> > > Ugh, makes me think we need to extend the support for blocking pci
> > > device MMIO while a driver is attached to config-space as well. How
> > > can a communication protocol work if initiators can trample each
> > > other's state?  
> >
> > Agreed. It is crazy. At very least we need a means of saying
> > keep your hands off this DOE to the OS.
> >
> > We can't do it on a per protocol basis, which was what I was previously
> > thinking, because we can't call the discovery protocol to see what
> > a given DOE is for.  
> 
> I'm specifically thinking of a mechanism that blocks pci-sysfs from
> initiating config-cycles if a driver has claimed that range.
> 
> However, these MCTP to DOE tunnels that the SPDM presentation alluded
> to make me nervous as there is no protocol to prevent an OS driver
> agent and an MCTP agent from clobbering each other.

Agreed.


> >  
> > >  
> > > > +                       ret = -ETIMEDOUT;
> > > > +                       goto unlock;
> > > > +               }
> > > > +
> > > > +               pci_read_config_dword(pdev,
> > > > +                                     doe->cap_offset + PCI_DOE_STATUS,
> > > > +                                     &val);
> > > > +               if (FIELD_GET(PCI_DOE_STATUS_ERROR, val)) {
> > > > +                       pcie_doe_abort(doe);
> > > > +                       ret = -EIO;
> > > > +                       goto unlock;
> > > > +               }
> > > > +       } else {
> > > > +               do {
> > > > +                       retry++;
> > > > +                       pci_read_config_dword(pdev,
> > > > +                                             doe->cap_offset + PCI_DOE_STATUS,
> > > > +                                             &val);
> > > > +                       if (FIELD_GET(PCI_DOE_STATUS_ERROR, val)) {
> > > > +                               pcie_doe_abort(doe);
> > > > +                               ret = -EIO;
> > > > +                               goto unlock;
> > > > +                       }
> > > > +
> > > > +                       if (FIELD_GET(PCI_DOE_STATUS_DATA_OBJECT_READY, val))
> > > > +                               break;
> > > > +                       usleep_range(1000, 2000);
> > > > +               } while (retry < 1000);
> > > > +               if (!FIELD_GET(PCI_DOE_STATUS_DATA_OBJECT_READY, val)) {
> > > > +                       ret = -ETIMEDOUT;
> > > > +                       goto unlock;  
> > >
> > > Rather than a lock and polling loop I'd organize this as a single
> > > threaded delayed_workqueue that periodically services requests or
> > > immediately runs the workqueue upon receipt of an interrupt. This
> > > provides a software queuing model that can optionally be treated as
> > > async / sync depending on the use case.  
> >
> > Given it's single element in flight I don't think there is any benefit
> > to enabling async.  The lock has to be held throughout anyway.
> > It is always possible a particular caller wants to overlap this
> > transaction with some other actions, but I'd rather put the burden
> > on that clever caller which can spin this out to a thread of one type
> > or another.
> >
> > We can revisit and split this in half if we have a user who benefits
> > from the complexity.  
> 
> I don't think it's complex. I think it's simpler to rationalize than
> this pattern of taking a lock and going to sleep with the lock held.
> You can eliminate the lock completely if the only access to a given
> DOE is a single dedicated kthread. There are other examples of this
> single-thread protocol handler pattern in the kernel, like libsas SMP
> protocol.

So for this, I've implemented a simple single threaded workqueue.
As I'm not supporting interleaving for now, it ends up being very similar
to the body of pcie_doe_exchange().  The lock is gone.

Async is trivial to implement (I haven't done so yet as don't have a user)
but there is a requirement for the caller to ensure lifetimes of the buffers
because we probably don't want to take copies when not necessary.  That
shouldn't be to onerous for the drivers.

One thing I don't understand is why you proposed a delayed work queue
above?  I'm not seeing that model in the libsas SMP for example.  As far
as I can tell that just processes work items asap.

Can you point to a more specific example if you thinks that we should
use one?

> 
> > > > +               }
> > > > +       }
> > > > +
> > > > +       /* Read the first two dwords to get the length */
> > > > +       pci_read_config_dword(pdev, doe->cap_offset + PCI_DOE_READ,
> > > > +                             &response[0]);
> > > > +       pci_write_config_dword(pdev, doe->cap_offset + PCI_DOE_READ, 0);
> > > > +       pci_read_config_dword(pdev, doe->cap_offset + PCI_DOE_READ,
> > > > +                             &response[1]);
> > > > +       pci_write_config_dword(pdev, doe->cap_offset + PCI_DOE_READ, 0);
> > > > +       length = FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH,
> > > > +                          response[1]);
> > > > +       if (length > SZ_1M)  
> >
> > oops. That's exiting with mutex held. Fixed in v2.
> >  
> > > > +               return -EIO;
> > > > +
> > > > +       for (i = 2; i < min(length, response_sz / 4); i++) {
> > > > +               pci_read_config_dword(pdev, doe->cap_offset + PCI_DOE_READ,
> > > > +                                     &response[i]);
> > > > +               pci_write_config_dword(pdev, doe->cap_offset + PCI_DOE_READ, 0);
> > > > +       }
> > > > +       /* flush excess length */
> > > > +       for (; i < length; i++) {
> > > > +               pci_read_config_dword(pdev, doe->cap_offset + PCI_DOE_READ,
> > > > +                                     &val);
> > > > +               pci_write_config_dword(pdev, doe->cap_offset + PCI_DOE_READ, 0);
> > > > +       }
> > > > +       /* Final error check to pick up on any since Data Object Ready */
> > > > +       pci_read_config_dword(pdev, doe->cap_offset + PCI_DOE_STATUS, &val);
> > > > +       if (FIELD_GET(PCI_DOE_STATUS_ERROR, val)) {
> > > > +               pcie_doe_abort(doe);
> > > > +               ret = -EIO;
> > > > +       }
> > > > +unlock:
> > > > +       mutex_unlock(&doe->lock);
> > > > +
> > > > +       return ret;
> > > > +}
> > > > +
> > > > +
> > > > +static int pcie_doe_discovery(struct pcie_doe *doe, u8 *index, u16 *vid, u8 *protocol)
> > > > +{
> > > > +       u32 request[3] = {  
> > >
> > > Should this be a proper struct with named fields rather than an array?  
> >
> > Well the field names are going to end up as dw0 dw1 etc as there isn't a lot more
> > meaningful to call them.  We also want to keep them as u32 values throughout to
> > avoid fiddly packing manipulation on different endian machines.  
> 
> The DOE object format has dedicated space for type and length.
> 
> If anything the endian issue is more reason to have a proper data structure.

I'm fine with doing that for the first 2 DW but after that it's a lot messier
as mentioned above. It is protocol specific.  Of course we can always wrap the
individual protocols up with serializer / deserializer code to actually pack
the dwords.

> 
> >
> > This becomes rather simpler when it's just the payload due to changes in the
> > interface in v2.
> >  
> > >  
> > > > +               [0] = FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_1_VID, 0001) |
> > > > +               FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, 0),
> > > > +               [1] = FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH, 3),
> > > > +               [2] = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX, *index)
> > > > +       };
> > > > +       u32 response[3];
> > > > +       int ret;
> > > > +
> > > > +       ret = pcie_doe_exchange(doe, request, sizeof(request), response, sizeof(response));
> > > > +       if (ret)
> > > > +               return ret;
> > > > +
> > > > +       *vid = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID, response[2]);
> > > > +       *protocol = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL, response[2]);
> > > > +       *index = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX, response[2]);
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +/**
> > > > + * pcie_doe_protocol_check() - check if this DOE mailbox supports specific protocol
> > > > + * @doe: DOE state structure
> > > > + * @vid: Vendor ID
> > > > + * @protocol: Protocol number as defined by Vendor
> > > > + * Returns: 0 on success, <0 on error
> > > > + */
> > > > +int pcie_doe_protocol_check(struct pcie_doe *doe, u16 vid, u8 protocol)  
> > >
> > > Not clear to me that this is a comfortable API for a driver. I would
> > > expect that at registration time all the supported protocols would be
> > > retrieved and cached in the 'struct pcie_doe' context and then the
> > > host driver could query from there without going back to the device
> > > again.  
> >
> > I'm not sure I follow.
> >
> > Any driver will fall into one of the following categories:
> > a) Already knows what protocols are available on a
> >    given DOE instance perhaps because that's a characteristic of the hardware
> >    supported, in which case it has no reason to check (unless driver writer
> >    is paranoid)
> > b) It has no way to know (e.g. class driver), then it makes sense to query
> >    the DOE instance to find out what protocols are available.  
> 
> I was more thinking that the public interface is a protocol rather
> than the raw DOE. So the library knows CDAT, SPDM, IDE... and drivers
> never need to query the interface.
> 
> So this more of a question about where to draw the line of common code.
> 
> For example in the nfit driver there is usage of:
> 
> acpi_label_write()
> 
> ...and:
> 
> acpi_evaluate_dsm()
> 
> ...where the former abstracts the protocol and the latter is the raw
> interface. Both can write to a label area, but only one is idiomatic.

Ah. Got it. Makes sense to have another layer for at least commonly reused
protocols.  Exactly what that looks like is going to be protocol specific.

I've reworked the internal handling to do DOE mailboxes a bit like
pci_alloc_irq_vectors().  Basically if a driver uses a DOE at all it issues
one call to get them all and one call to free them all.  That call
goes and gets the protocols supported and caches their [vid type].

That lets a driver not care which protocols share a DOE and simply use:

struct pcie_doe *cdat_doe = pci_doe_find(pci_dev, vid, prot); etc.
struct pcie_doe *cma_doe = ...
struct pcie_doe *ide_doe;
struct pcie_doe *vendors_own_magic_doe;

Some of which happen to point to the same DOEs.  It's simpler than
reference counting, which we shouldn't need as lifetimes of these
should all be the same.

Jonathan


