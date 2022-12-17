Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F2A64FB0D
	for <lists+linux-pci@lfdr.de>; Sat, 17 Dec 2022 17:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiLQQi7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 17 Dec 2022 11:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiLQQi6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 17 Dec 2022 11:38:58 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BD610B58;
        Sat, 17 Dec 2022 08:38:55 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NZBTW08S1z67m28;
        Sun, 18 Dec 2022 00:37:34 +0800 (CST)
Received: from localhost (10.81.207.254) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sat, 17 Dec
 2022 16:38:51 +0000
Date:   Sat, 17 Dec 2022 16:38:50 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V4 2/9] cxl/mem: Read, trace, and clear events on driver
 load
Message-ID: <20221217163850.00000bc4@Huawei.com>
In-Reply-To: <Y5zo+UqOmGCE4ObC@iweiny-desk3>
References: <20221212070627.1372402-1-ira.weiny@intel.com>
        <20221212070627.1372402-3-ira.weiny@intel.com>
        <20221216153939.00007c41@Huawei.com>
        <Y5zo+UqOmGCE4ObC@iweiny-desk3>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.207.254]
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

On Fri, 16 Dec 2022 13:54:01 -0800
Ira Weiny <ira.weiny@intel.com> wrote:

> On Fri, Dec 16, 2022 at 03:39:39PM +0000, Jonathan Cameron wrote:
> > On Sun, 11 Dec 2022 23:06:20 -0800
> > ira.weiny@intel.com wrote:
> >   
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > CXL devices have multiple event logs which can be queried for CXL event
> > > records.  Devices are required to support the storage of at least one
> > > event record in each event log type.
> > > 
> > > Devices track event log overflow by incrementing a counter and tracking
> > > the time of the first and last overflow event seen.
> > > 
> > > Software queries events via the Get Event Record mailbox command; CXL
> > > rev 3.0 section 8.2.9.2.2 and clears events via CXL rev 3.0 section
> > > 8.2.9.2.3 Clear Event Records mailbox command.
> > > 
> > > If the result of negotiating CXL Error Reporting Control is OS control,
> > > read and clear all event logs on driver load.
> > > 
> > > Ensure a clean slate of events by reading and clearing the events on
> > > driver load.
> > > 
> > > The status register is not used because a device may continue to trigger
> > > events and the only requirement is to empty the log at least once.  This
> > > allows for the required transition from empty to non-empty for interrupt
> > > generation.  Handling of interrupts is in a follow on patch.
> > > 
> > > The device can return up to 1MB worth of event records per query.
> > > Allocate a shared large buffer to handle the max number of records based
> > > on the mailbox payload size.
> > > 
> > > This patch traces a raw event record and leaves specific event record
> > > type tracing to subsequent patches.  Macros are created to aid in
> > > tracing the common CXL Event header fields.
> > > 
> > > Each record is cleared explicitly.  A clear all bit is specified but is
> > > only valid when the log overflows.
> > > 
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>  
> > 
> > A few things noticed inline.  I've tightened the QEMU code to reject the
> > case of the input payload claims to be bigger than the mailbox size
> > and hacked the size down to 256 bytes so it triggers the problem
> > highlighted below.  
> 
> I'm not sure what you did here.

Nor am I. I think this might have been a case of chasing the undersized
length bug in QEMU because it was the CXL 3.0 issue and misunderstanding
one of the debug prints I got.

Friday silliness. Sorry about that!

However, the over sized payload communicated to the hardware is still
a potential problem. See below.

> 
> >   
> > > 
> > > ---
> > > Changes from V3:
> > > 	Dan
> > > 		Split off _OSC pcie bits
> > > 			Use existing style for host bridge flag in that
> > > 			patch
> > > 		Clean up event processing loop
> > > 		Use dev_err_ratelimited()
> > > 		Clean up version change log
> > > 		Delete 'EVENT LOG OVERFLOW'
> > > 		Remove cxl_clear_event_logs()
> > > 		Add comment for native cxl control
> > > 		Fail driver load on event buf allocation failure
> > > 		Comment why events are not processed without _OSC flag
> > > ---
> > >  drivers/cxl/core/mbox.c  | 136 +++++++++++++++++++++++++++++++++++++++
> > >  drivers/cxl/core/trace.h | 120 ++++++++++++++++++++++++++++++++++
> > >  drivers/cxl/cxl.h        |  12 ++++
> > >  drivers/cxl/cxlmem.h     |  84 ++++++++++++++++++++++++
> > >  drivers/cxl/pci.c        |  40 ++++++++++++
> > >  5 files changed, 392 insertions(+)
> > > 
> > > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > > index b03fba212799..9fb327370e08 100644
> > > --- a/drivers/cxl/core/mbox.c
> > > +++ b/drivers/cxl/core/mbox.c  
> >   
> > > +static int cxl_clear_event_record(struct cxl_dev_state *cxlds,
> > > +				  enum cxl_event_log_type log,
> > > +				  struct cxl_get_event_payload *get_pl)
> > > +{
> > > +	struct cxl_mbox_clear_event_payload payload = {
> > > +		.event_log = log,
> > > +	};
> > > +	u16 total = le16_to_cpu(get_pl->record_count);
> > > +	u8 max_handles = CXL_CLEAR_EVENT_MAX_HANDLES;
> > > +	size_t pl_size = sizeof(payload);
> > > +	struct cxl_mbox_cmd mbox_cmd;
> > > +	u16 cnt;
> > > +	int rc;
> > > +	int i;
> > > +
> > > +	/* Payload size may limit the max handles */
> > > +	if (pl_size > cxlds->payload_size) {
> > > +		max_handles = CXL_CLEAR_EVENT_LIMIT_HANDLES(cxlds->payload_size);

Definition of that is more complex than it needs to be - see below.

> > > +		pl_size = cxlds->payload_size;  
> 
> pl_size is only the max size possible if that size was smaller than the size of
> the record [sizeof(payload) above].

Sorry. For some reason my eyes skipped over this completely.
So we are fine for all my comments on overflowing.  On plus side
will now check if that happens in QEMU and return an error which we
weren't doing before.

> 
> > > +	}
> > > +
> > > +	mbox_cmd = (struct cxl_mbox_cmd) {
> > > +		.opcode = CXL_MBOX_OP_CLEAR_EVENT_RECORD,
> > > +		.payload_in = &payload,
> > > +		.size_in = pl_size,  
> > 
> > This payload size should be whatever we need to store the records,
> > not the max size possible.  Particularly as that size is currently
> > bigger than the mailbox might be.  
> 
> But the above check and set ensures that does not happen.
> 
> > 
> > It shouldn't fail (I think) simply because a later version of the spec might
> > add more to this message and things should still work, but definitely not
> > good practice to tell the hardware this is much longer than it actually is.  
> 
> I don't follow.
> 
> The full payload is going to be sent even if we are just clearing 1 record
> which is inefficient but it should never overflow the hardware because it is
> limited by the check above.
> 
> So why would this be a problem?
I'm struggling to find a clear spec statement on if this allowed, so the following
is a thought experiment. There is language in definition of the "invalid payload length"
error code "The input payload length is not valid for the specified command", but it
doesn't go into what counts as valid.

What you have looks fine because a device can't fail on the basis it's told the
payload is longer than it expects, because you might be sending a CXL 4.0 spec
payload that is backwards compatible with CXL 3.0 - hence the fact the sizes
don't match up with that expected can't be considered an error.
So far so good... However, we may have a situation not dissimilar to the
change in record length for the set event interrupt policy payload between CXL 2.0
and CXL 3.0. The only way the endpoint knows what version of message it got is because the
record is 4 bytes or 5 bytes.  If we have extra stuff on the end of this record
in future the end point can assume that it is a new version of the spec and interpret
what is in that payload space.

Say the future structure looks like

struct cxl_mbox_clear_event_payload_future {
	u8 event_log;		/* enum cxl_event_log_type */
	u8 clear_flags;
	u8 nr_recs;
	u8 reserved[3];
	__le16 handle[nr_recs]; 
	__le16 otherdata[nr_recs];
}

Endpoint receiving your 'overly long payload' will assume all those otherdata fields
are 0, not necessarily the same as non present.
For the set event interrupt policy, if we sent an overlong payload like you've done here
with assumption of the CXL 2.0 spec we would be turning off the DCD interrupt rather
that doing nothing (unlikely to be a problem in that particularly case as that one
doesn't have a FW Interrupt option - but that's more luck than design).

I'm not sure why we'd have extra stuff for this payload, but it 'might' happen'.

> > 
> 
> > 
> >   
> > > +	};
> > > +
> > > +	/*
> > > +	 * Clear Event Records uses u8 for the handle cnt while Get Event
> > > +	 * Record can return up to 0xffff records.
> > > +	 */
> > > +	i = 0;
> > > +	for (cnt = 0; cnt < total; cnt++) {
> > > +		payload.handle[i++] = get_pl->records[cnt].hdr.handle;
> > > +		dev_dbg(cxlds->dev, "Event log '%d': Clearing %u\n",
> > > +			log, le16_to_cpu(payload.handle[i]));
> > > +
> > > +		if (i == max_handles) {
> > > +			payload.nr_recs = i;
> > > +			rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> > > +			if (rc)
> > > +				return rc;
> > > +			i = 0;
> > > +		}
> > > +	}
> > > +
> > > +	/* Clear what is left if any */
> > > +	if (i) {
> > > +		payload.nr_recs = i;
> > > +		rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> > > +		if (rc)
> > > +			return rc;
> > > +	}
> > > +
> > > +	return 0;
> > > +}  
> > 
> > 
> > ...
> >   
> > > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > > index ab138004f644..dd9aa3dd738e 100644
> > > --- a/drivers/cxl/cxlmem.h
> > > +++ b/drivers/cxl/cxlmem.h  
> > 
> > ...
> >   
> > > +
> > > +/*
> > > + * Clear Event Records input payload
> > > + * CXL rev 3.0 section 8.2.9.2.3; Table 8-51
> > > + */
> > > +#define CXL_CLEAR_EVENT_MAX_HANDLES (0xff)
> > > +struct cxl_mbox_clear_event_payload {
> > > +	u8 event_log;		/* enum cxl_event_log_type */
> > > +	u8 clear_flags;
> > > +	u8 nr_recs;
> > > +	u8 reserved[3];
> > > +	__le16 handle[CXL_CLEAR_EVENT_MAX_HANDLES];  
> > 
> > Doesn't fit in the smallest possible payload buffer.
> > It's 526 bytes long.  Payload buffer might be 256 bytes in total.
> > (8.2.8.4.3 Mailbox capabilities)
> > 
> > Lazy approach, make this smaller and do more loops when clearing.
> > If we want to optimize this later can expand it to this size.  
> 
> I agree but the code already checks for and adjusts this on the fly based on
> cxlds->payload_size?
> 
>  +	/* Payload size may limit the max handles */
>  +	if (pl_size > cxlds->payload_size) {
>  +		max_handles = CXL_CLEAR_EVENT_LIMIT_HANDLES(cxlds->payload_size);
>  +		pl_size = cxlds->payload_size;
>  +	}
> 
> Why is this not ok?  [Other than being potentially inefficient.]
> 
> Do you have a patch to qemu which causes this?

Two issues crossing I think on my side and me thinking this one was obviously
the problem when it wasn't.

> 
> Ira
> 
> > > +} __packed;
> > > +#define CXL_CLEAR_EVENT_LIMIT_HANDLES(payload_size)			\
> > > +	(((payload_size) -						\
> > > +		(sizeof(struct cxl_mbox_clear_event_payload) -		\
> > > +		 (sizeof(__le16) * CXL_CLEAR_EVENT_MAX_HANDLES))) /	\

Could use offsetof() to simplify this

> > > +		sizeof(__le16))
> > > +  
> > 
> > ...
> >   

