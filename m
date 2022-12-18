Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7508E64FD3B
	for <lists+linux-pci@lfdr.de>; Sun, 18 Dec 2022 01:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiLRA3R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 17 Dec 2022 19:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiLRA3Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 17 Dec 2022 19:29:16 -0500
Received: from usmail.montage-tech.com (usmail.montage-tech.com [12.176.92.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A9D6AEE0C;
        Sat, 17 Dec 2022 16:29:14 -0800 (PST)
X-MDAV-Result: clean
X-MDAV-Processed: usmail.montage-tech.com, Sat, 17 Dec 2022 16:29:13 -0800
Received: from shmail.montage-tech.com by usmail.montage-tech.com with ESMTP id md5001006412535.msg; 
        Sat, 17 Dec 2022 16:29:12 -0800
X-Spam-Processed: usmail.montage-tech.com, Sat, 17 Dec 2022 16:29:12 -0800
        (not processed: message from trusted or authenticated source)
X-MDArrival-Date: Sat, 17 Dec 2022 16:29:12 -0800
X-Return-Path: prvs=13518b01c8=johnny.li@montage-tech.com
X-Envelope-From: johnny.li@montage-tech.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=montage-tech.com;
        s=MDaemon; t=1671323346; x=1671928146;
        i=johnny.li@montage-tech.com; q=dns/txt; h=Date:From:To:Cc:
        Subject:Message-ID:References:MIME-Version:Content-Type:
        Content-Disposition:In-Reply-To; bh=nIZh5pvV5wUcd5REWbKDG9FNxcui
        3pcJd5IFhSG+5N4=; b=Z9cej9Q+1MO5NvBfWJi8leymokGx2+9v+/YbRihA3MwW
        odKn7Lo4JrTYBQ6NcYDI1dXIER2CGV+JfuEe+GJTtYXH5Qs3t5lw2GNlbXr548NM
        sxhXzrvaMFEa2oSYFWFhTOI0qvvNexze6blw3Sugz1vksgJwEV6GORQIoq/ETJ+r
        vO5kzG/wxsgN0gVo42asTjlwmk3piAO2EWNSy03EoSQOSk3g5R5yk6HIudLv+0+6
        imjEtVM4TsWMK4fUwz8CQHhX1++RSUi31iG3Iyu3tkFDo8udFmlAJ7g0l1n3Fd13
        ecw+VJ/LVcQDHIoM2Aqe14xm/5gVn8z7yXZfzJUxvw==
X-MDAV-Result: clean
X-MDAV-Processed: shmail.montage-tech.com, Sun, 18 Dec 2022 08:29:06 +0800
Received: from SR651 by shmail.montage-tech.com with ESMTPA id pp5001019887938.msg; 
        Sun, 18 Dec 2022 08:29:05 +0800
X-Spam-Processed: shmail.montage-tech.com, Sun, 18 Dec 2022 08:29:05 +0800
        (not processed: message from trusted or authenticated source)
Date:   Sun, 18 Dec 2022 08:25:34 +0800
From:   johnny <johnny.li@montage-tech.com>
To:     "Ira Weiny (ira.weiny@intel.com)" <ira.weiny@intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH V4 2/9] cxl/mem: Read, trace, and clear events on driver
 load
Message-ID: <Y55d/l1nTfpTX/1A@SR651>
References: <20221212070627.1372402-1-ira.weiny@intel.com>
 <20221212070627.1372402-3-ira.weiny@intel.com>
 <20221216153939.00007c41@Huawei.com>
 <Y5zo+UqOmGCE4ObC@iweiny-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5zo+UqOmGCE4ObC@iweiny-desk3>
X-MDCFSigsAdded: montage-tech.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 16, 2022 at 01:54:01PM -0800, Ira Weiny (ira.weiny@intel.com) wrote:
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
> > > +		pl_size = cxlds->payload_size;
> 
> pl_size is only the max size possible if that size was smaller than the size of
> the record [sizeof(payload) above].
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
> 

per spec3.0, Event Record Handles field is "A list of Event Record Handles the 
host has consumed and the device shall now remove from its internal Event Log 
store.". Extra unused handle list does not folow above description. And also 
spec mentions "All event record handles shall be nonzero value. A value of 0 
shall be treated by the device as an invalid handle.". So if there is value 0 
in extra unused handles, device shall return invalid handle error code


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
> 
> Ira
> 
> > > +} __packed;
> > > +#define CXL_CLEAR_EVENT_LIMIT_HANDLES(payload_size)			\
> > > +	(((payload_size) -						\
> > > +		(sizeof(struct cxl_mbox_clear_event_payload) -		\
> > > +		 (sizeof(__le16) * CXL_CLEAR_EVENT_MAX_HANDLES))) /	\
> > > +		sizeof(__le16))
> > > +
> > 
> > ...
> > 
> 


