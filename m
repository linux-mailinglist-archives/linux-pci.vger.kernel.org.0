Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B47538F19
	for <lists+linux-pci@lfdr.de>; Tue, 31 May 2022 12:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245744AbiEaKd6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 May 2022 06:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245724AbiEaKd5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 May 2022 06:33:57 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977749A998;
        Tue, 31 May 2022 03:33:55 -0700 (PDT)
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LC7pJ2zLdz683nW;
        Tue, 31 May 2022 18:30:32 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 31 May 2022 12:33:53 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 31 May
 2022 11:33:52 +0100
Date:   Tue, 31 May 2022 11:33:50 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Lukas Wunner <lukas@wunner.de>
CC:     <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V8 03/10] PCI: Create PCI library functions in support
 of DOE mailboxes.
Message-ID: <20220531113350.0000421e@Huawei.com>
In-Reply-To: <20220530190657.GA14765@wunner.de>
References: <20220414203237.2198665-1-ira.weiny@intel.com>
        <20220414203237.2198665-4-ira.weiny@intel.com>
        <20220530190657.GA14765@wunner.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml730-chm.china.huawei.com (10.201.108.81) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 30 May 2022 21:06:57 +0200
Lukas Wunner <lukas@wunner.de> wrote:

> On Thu, Apr 14, 2022 at 01:32:30PM -0700, ira.weiny@intel.com wrote:
> > +static int pci_doe_recv_resp(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)  
> [...]
> > +	pci_write_config_dword(pdev, offset + PCI_DOE_READ, 0);
> > +	/* Read the second dword to get the length */
> > +	pci_read_config_dword(pdev, offset + PCI_DOE_READ, &val);
> > +	pci_write_config_dword(pdev, offset + PCI_DOE_READ, 0);
> > +
> > +	length = FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH, val);
> > +	if (length > SZ_1M || length < 2)
> > +		return -EIO;
> > +  
> 
> This API requires consumers to know the size of the response in advance.
> That's not always the case, as exemplified by SPDM VERSION responses.
> Jonathan uses a kludge in his SPDM patch which submits a first request
> with a fixed size of 2 versions and, if that turns out to be too small,
> submits a second request.
> 
> It would be nice if consumers are allowed to set request_pl to NULL.
> Then a payload can be allocated here in pci_doe_recv_resp() with the
> size retrieved above.
> 
> A flag may be necessary to indicate that the response is heap-allocated
> and needs to be freed upon destruction of the pci_doe_task.

If possible I'd make that the callers problem. It should know it provided
NULL and expected a response.

I'd suggest making this a 'future' feature just to keep this initial
version simple.  Won't be hard to add later.

> 
> 
> > +	/* First 2 dwords have already been read */
> > +	length -= 2;
> > +	/* Read the rest of the response payload */
> > +	for (i = 0; i < min(length, task->response_pl_sz / sizeof(u32)); i++) {
> > +		pci_read_config_dword(pdev, offset + PCI_DOE_READ,
> > +				      &task->response_pl[i]);
> > +		pci_write_config_dword(pdev, offset + PCI_DOE_READ, 0);
> > +	}  
> 
> You need to check the Data Object Ready bit.  The device may clear the
> bit prematurely (e.g. as a result of a concurrent FLR or Conventional
> Reset).  You'll continue reading zero dwords from the mailbox and
> pretend success to the caller even though the response is truncated.
> 
> If you're concerned about performance when checking the bit on every
> loop iteration, checking it only on the last but one iteration should
> be sufficient to detect truncation.

Good catch - I hate corner cases.  Thankfully this one is trivial to
check for.

> 
> 
> > +	*vid = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID, response_pl);
> > +	*protocol = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL,
> > +			      response_pl);
> > +	*index = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX,
> > +			   response_pl);  
> 
> The fact that you need line breaks here is an indication that the
> macros are too long.
> 
> 
> > +/* DOE Data Object - note not actually registers */
> > +#define PCI_DOE_DATA_OBJECT_HEADER_1_VID		0x0000ffff
> > +#define PCI_DOE_DATA_OBJECT_HEADER_1_TYPE		0x00ff0000
> > +#define PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH		0x0003ffff
> > +
> > +#define PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX		0x000000ff
> > +#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID		0x0000ffff
> > +#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		0x00ff0000
> > +#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX	0xff000000  
> 
> I'd get rid of "DATA_OBJECT_" everywhere, it's redundant with the
> "Data Object" in "DOE".

We need something to make it clear these aren't DVSEC headers for
example, but definitely could be shorter.

PCI_DOE_OBJ_... 

perhaps?

> 
> 
> > +#define  PCI_DOE_STATUS_INT_STATUS		0x00000002  /* DOE Interrupt Status */  
> 
> Another redundancy, I would get rid of the second "_STATUS".

Hmm. I'll leave this one to Ira's discretion but I'm not keen on cropping
too much of naming given loss of alignment with the spec.

> 
> 
> > +#define  PCI_DOE_STATUS_DATA_OBJECT_READY	0x80000000  /* Data Object Ready */  
> 
> I would shorten to PCI_DOE_STATUS_READY.

Seems reasonable though always some burden in moving
away from full spec names.

> 
> 
> > 		Simplify submitting work to the mailbox
> > 			Replace pci_doe_exchange_sync() with
> > 			pci_doe_submit_task() Consumers of the mailbox
> > 			are now responsible for setting up callbacks
> > 			within a task object and submitting them to the
> > 			mailbox to be processed.  
> 
> I honestly think that's a mistake.  All consumers both in the CDAT
> as well as in the SPDM series just want to wait for completion of
> the task.  They have no need for an arbitrary callback and shouldn't
> be burdended with providing one.  It just unnecessarily complicates
> the API.
> 
> So only providing pci_doe_exchange_sync() and doing away with
> pci_doe_submit_task() would seem like a more appropriate approach.

We've gone around the houses with this.  At this stage I don't
care strongly either way and it's all in kernel code so we
can refine it later once we have lots of examples.

> 
> 
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
> > +struct pci_doe_mb *pci_doe_create_mb(struct pci_dev *pdev, u16 cap_offset,
> > +				     bool use_irq);
> > +void pci_doe_destroy_mb(struct pci_doe_mb *doe_mb);
> > +bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type);  
> 
> Drivers should not be concerned with the intricacies of DOE
> capabilities and mailboxes.
> 
> Moreover, the above API doesn't allow different drivers to access
> the same DOE mailbox concurrently, e.g. if that mailbox supports
> multiple protocols.  There's no locking to serialize access to the
> mailbox by the drivers.
> 
> This should be moved to the PCI core instead:  In pci_init_capabilities(),
> add a new call pci_doe_init() which enumerates all DOE capabilities.
> Add a list_head to struct pci_dev and add each DOE instance found
> to that list.  Destroy the list elements in pci_destroy_dev().
> No locking needed for the list_head, you only ever modify the list
> on device enumeration and destruction.
> 
> Then provide a pci_doe_find_mailbox() library function which drivers
> call to retrieve the pci_doe_mb for a given pci_dev/vid/type tuple.
> That avoids the need to traverse the list time and again.

I've lost track a bit as this thread has been running a long time,  but
I think we are moving back to something that looks more like this
(and the much earlier versions of the set which did more or less what you
describe - though they had their own issues resolved in the meantime)

There is an exciting corner around interrupts though that complicates
things.  Currently I think I'm right in saying the pci core never
sets up interrupts, that is always a job for the drivers.

My first thought is to do something similar to the hack I did for
the switch ports, and use polled mode to query support protocols.
Then later call from driver that will attempt to enable interrupts
if desired for a given DOE instance.


> 
> 
> > +/**
> > + * struct pci_doe_mb - State for a single DOE mailbox  
> 
> We generally use the same terms as the spec to make it easier for
> readers to connect the language in the spec to the implementation.
> 
> The spec uniformly refers to "DOE instance".  I guess "mailbox"
> is slightly more concise, so keep that, but please at least mention
> the term "instance" in the struct's kernel-doc.
> 
> This implementation uses the term "task" for one request/response.
> That term is not mentioned in the spec at all.  The spec refers to
> "exchange" and "transfer" on several occasions, so I would have chosen
> either one of those instead of the somewhat unfortunate "task".
> 
> 
> > + * This state is used to manage a single DOE mailbox capability.  All fields
> > + * should be considered opaque to the consumers and the structure passed into
> > + * the helpers below after being created by devm_pci_doe_create()  
> 
> If the struct is considered opaque, why is it exposed in a public
> header file?  Just use a forward declaration in the header
> so that consumers can pass around pointers to the struct,
> and hide the declaration proper in doe.c.
> 
> 
> > + * @pdev: PCI device this belongs to mailbox belongs to  
>                              ^^^^^^^^^^
> Typo.
> 
> > + * @prots: Array of protocols supported on this DOE
> > + * @num_prots: Size of prots array  
> 
> Use @prots instead of prots everywhere in the kernel-doc.
> 
> 
> > +	/*
> > +	 * NOTE: doe_mb_prots is freed by pci_doe_free_mb automatically on
> > +	 * error if pci_doe_cache_protocols() fails past this point.
> > +	 */  
> 
> s/doe_mb_prots/doe_mb->prots/
> s/pci_doe_free_mb/pci_doe_free_mb()/
> 
> 
> > +	/* DOE requests must be a whole number of DW */
> > +	if (task->request_pl_sz % sizeof(u32))
> > +		return -EINVAL;  
> 
> It would be nice if this restriction could be lifted.  SPDM uses
> requests which are not padded to dword-length.  It can run over other
> transports which may not impose such restrictions.  The SPDM layer
> should not need to worry about quirks of the transport layer.

This is a pain.  DOE absolutely requires 32 bit padding and
reads need to be 32 bit.   We can obviously do something nasty
with dealing with the tail via a bounce buffer though.

I'd pencil that in as a future feature though rather than worry
about it before we have any support at all in place.

> 
> 
> > +static irqreturn_t pci_doe_irq_handler(int irq, void *data)
> > +{
> > +	struct pci_doe_mb *doe_mb = data;
> > +	struct pci_dev *pdev = doe_mb->pdev;
> > +	int offset = doe_mb->cap_offset;
> > +	u32 val;
> > +
> > +	pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
> > +
> > +	/* Leave the error case to be handled outside IRQ */
> > +	if (FIELD_GET(PCI_DOE_STATUS_ERROR, val)) {
> > +		mod_delayed_work(system_wq, &doe_mb->statemachine, 0);
> > +		return IRQ_HANDLED;
> > +	}
> > +
> > +	if (FIELD_GET(PCI_DOE_STATUS_INT_STATUS, val)) {
> > +		pci_write_config_dword(pdev, offset + PCI_DOE_STATUS,
> > +					PCI_DOE_STATUS_INT_STATUS);
> > +		mod_delayed_work(system_wq, &doe_mb->statemachine, 0);
> > +		return IRQ_HANDLED;
> > +	}
> > +
> > +	return IRQ_NONE;
> > +}  
> 
> PCIe 6.0, table 7-316 says that an interrupt is also raised when
> "the DOE Busy bit has been Cleared", yet such an interrupt is
> not handled here.  It is incorrectly treated as a spurious
> interrupt by returning IRQ_NONE.  The right thing to do
> is probably to wake the state machine in case it's polling
> for the Busy flag to clear.

Ah. I remember testing this via a lot of hacking on the QEMU code
to inject the various races that can occur (it was really ugly to do).

Guess we lost the handling at some point.  I think your fix
is the right one.

> 
> 
> > +enum pci_doe_state {
> > +	DOE_IDLE,
> > +	DOE_WAIT_RESP,
> > +	DOE_WAIT_ABORT,
> > +	DOE_WAIT_ABORT_ON_ERR,
> > +};
> > +
> > +#define PCI_DOE_FLAG_ABORT	0
> > +#define PCI_DOE_FLAG_DEAD	1  
> 
> That's all internal and should live in doe.c, not the header file.
> 
> Thanks,
> 
> Lukas
> 

Thanks for the review and thanks again to Ira for taking this forwards.

Jonathan


