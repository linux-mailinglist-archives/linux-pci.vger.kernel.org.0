Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A564539A18
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jun 2022 01:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348687AbiEaXnL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 May 2022 19:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241462AbiEaXnK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 May 2022 19:43:10 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9386C0CF;
        Tue, 31 May 2022 16:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654040589; x=1685576589;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1RPTB2MbClkXo6d6NveMB2OujJGHsYe4JAnZGSgCbDw=;
  b=K2K8JpnhNqctOPNgYYBsFJiVLT+aBFlb3C3ZKq2omZnjPUIpsEK7XR3s
   kmxysuHX0AScJIBBTtAp1xc3nwjHjpMBQqxn2RbFjfFzeQpfU/qYt3YcB
   wFCNvdaORefdUP03rYi2/u7dnWM8dP+uP7UT+0bf7vL2yiJwxjYACbsoW
   XzcmRotap1WbgIuano0h4JZ9BIvmda5jDfECHNyLyHVlm099zwoEhoFBi
   FZi/Pp967oW3F00XJbCfPU351H5Ax0zoQSSQMFxkps5IuhVhVhaRpp+Uc
   Yz99nrZ6xTEQFHq0Rofhl/LP5+yU79OtmU7ms6pdfHVHKUZDv3lfAHYVy
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="263054015"
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="263054015"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 16:43:08 -0700
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="755369377"
Received: from mdossant-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.154.135])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 16:43:06 -0700
Date:   Tue, 31 May 2022 16:43:05 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH V8 03/10] PCI: Create PCI library functions in support of
 DOE mailboxes.
Message-ID: <YpaoCYcnuG1jLMWe@iweiny-desk3>
References: <20220414203237.2198665-1-ira.weiny@intel.com>
 <20220414203237.2198665-4-ira.weiny@intel.com>
 <20220530190657.GA14765@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220530190657.GA14765@wunner.de>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 30, 2022 at 09:06:57PM +0200, Lukas Wunner wrote:
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

I'm not comfortable with PCI allocating memory.  Especially optionally
allocating memory.  And I'm not sure this really saves the extra queries.  The
PCI layer will have to query first to determine response length.

If the community does want PCI to allocate memory then I think the interface
should be to always allocate it.

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

If an FLR happens then truncation does not seem like a problem.

> 
> If you're concerned about performance when checking the bit on every
> loop iteration, checking it only on the last but one iteration should
> be sufficient to detect truncation.

I'll review.  I don't think this is a fast path.

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

I'm ok with renaming.  Jonathan chose the names and no one has complained yet.

> 
> 
> > +#define  PCI_DOE_STATUS_INT_STATUS		0x00000002  /* DOE Interrupt Status */
> 
> Another redundancy, I would get rid of the second "_STATUS".
> 
> 
> > +#define  PCI_DOE_STATUS_DATA_OBJECT_READY	0x80000000  /* Data Object Ready */
> 
> I would shorten to PCI_DOE_STATUS_READY.
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

This was discussed a couple of times and it was decided to keep the
synchronicity out of the library functions and allow users to decide how to
handle it.

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

I think it depends on which driver one is considering.

> 
> Moreover, the above API doesn't allow different drivers to access
> the same DOE mailbox concurrently, e.g. if that mailbox supports
> multiple protocols.  There's no locking to serialize access to the
> mailbox by the drivers.

Correct it is up to the higher level code to do this.

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

All that could be done above these calls.  I've abandoned the aux bus stuff
after discussions with Dan.  So perhaps burring this away from the CXL drivers
is a good idea.  But I still think this can serve as a base within the PCIe
code.

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

Again this was discussed and we settled on task.  I'm not married to the term
and s/task/exchange/ is fine with me.  But IFRC Dan was not happy with
exchange.

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

I could do that.  It just did not seem important enough to make it that strict.

> 
> 
> > + * @pdev: PCI device this belongs to mailbox belongs to
>                              ^^^^^^^^^^
> Typo.

oops... yea slipped by in v9 as well.

>
> 
> > + * @prots: Array of protocols supported on this DOE
> > + * @num_prots: Size of prots array
> 
> Use @prots instead of prots everywhere in the kernel-doc.

Ok.

> 
> 
> > +	/*
> > +	 * NOTE: doe_mb_prots is freed by pci_doe_free_mb automatically on
> > +	 * error if pci_doe_cache_protocols() fails past this point.
> > +	 */
> 
> s/doe_mb_prots/doe_mb->prots/
> s/pci_doe_free_mb/pci_doe_free_mb()/

This note has changed.

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

Are you suggesting that this layer PAD the request?  I hear your concern but
users of this layer will need to understand this in the request payload
allocated anyway.

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

I thought Jonathan and I had work through how this was correct.  I'll have to
review those threads.

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

Sure if struct pci_doe_mb is moved.

Lets see how V9 looks from other perspectives.  I've incorporated some of this
feedback for V10.

Ira

> Thanks,
> 
> Lukas
