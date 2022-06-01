Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036E853ABA1
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jun 2022 19:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352273AbiFARQs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Jun 2022 13:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356262AbiFARQq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Jun 2022 13:16:46 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EE3239;
        Wed,  1 Jun 2022 10:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654103800; x=1685639800;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6CCWbtmwTXKwNkdkuFIu1AEE3H2qr3eCSWyuXvbO9/s=;
  b=MLW0R8btstHS4VP4RhH2QCKf5pFy/p7KsUl/PHOPNEXTwfU43QXEuXlm
   dyI0n/ohrQ/krLQ6hVwpjgjQmMVRyOWOGiXC9HV73oFW7l5UAr3x1KBBY
   iJHBsNAiXQBFvYkcVAz7gAlesv0ArnleT0bZ4CAOo8o0Z44mFu2WmxaQ0
   +Soot0ci8LjA7KPnueZPFOiErMLaDI1EGrFossDOPNfMsjM6tuuLZ37ur
   5QoyU5LZ8Q4X+MBgF/Aa+37JUzmza9hfrBMpCCL3Ru4MxZ7sIefUu42Fw
   JsAP982UCrhq3eKRO/pId9NNt071MrXr1zv1ch4NUy8tXmZt8lWPi+dCO
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="275672001"
X-IronPort-AV: E=Sophos;i="5.91,269,1647327600"; 
   d="scan'208";a="275672001"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 10:16:16 -0700
X-IronPort-AV: E=Sophos;i="5.91,269,1647327600"; 
   d="scan'208";a="645586590"
Received: from cwmurphy-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.32.23])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 10:16:16 -0700
Date:   Wed, 1 Jun 2022 10:16:15 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH V8 03/10] PCI: Create PCI library functions in support of
 DOE mailboxes.
Message-ID: <Ypee328j+l6ZdbUT@iweiny-desk3>
References: <20220414203237.2198665-1-ira.weiny@intel.com>
 <20220414203237.2198665-4-ira.weiny@intel.com>
 <20220530190657.GA14765@wunner.de>
 <20220531113350.0000421e@Huawei.com>
 <YpbWCYujYDEkMm1B@iweiny-desk3>
 <20220601071808.GA19924@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601071808.GA19924@wunner.de>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 01, 2022 at 09:18:08AM +0200, Lukas Wunner wrote:
> On Tue, May 31, 2022 at 07:59:21PM -0700, Ira Weiny wrote:
> > On Tue, May 31, 2022 at 11:33:50AM +0100, Jonathan Cameron wrote:
> > > On Mon, 30 May 2022 21:06:57 +0200 Lukas Wunner <lukas@wunner.de> wrote:
> > > > On Thu, Apr 14, 2022 at 01:32:30PM -0700, ira.weiny@intel.com wrote:
> > > > > +	/* First 2 dwords have already been read */
> > > > > +	length -= 2;
> > > > > +	/* Read the rest of the response payload */
> > > > > +	for (i = 0; i < min(length, task->response_pl_sz / sizeof(u32)); i++) {
> > > > > +		pci_read_config_dword(pdev, offset + PCI_DOE_READ,
> > > > > +				      &task->response_pl[i]);
> > > > > +		pci_write_config_dword(pdev, offset + PCI_DOE_READ, 0);
> > > > > +	}  
> > > > 
> > > > You need to check the Data Object Ready bit.  The device may clear the
> > > > bit prematurely (e.g. as a result of a concurrent FLR or Conventional
> > > > Reset).  You'll continue reading zero dwords from the mailbox and
> > > > pretend success to the caller even though the response is truncated.
> > > > 
> > > > If you're concerned about performance when checking the bit on every
> > > > loop iteration, checking it only on the last but one iteration should
> > > > be sufficient to detect truncation.
> > > 
> > > Good catch - I hate corner cases.  Thankfully this one is trivial to
> > > check for.
> > 
> > Ok looking at the spec:  Strictly speaking this needs to happen multiple
> > times both in doe_statemachine_work() and inside pci_doe_recv_resp();
> > not just in this loop.  :-(
> > 
> > This is because, the check in doe_statemachine_work() only covers the
> > 1st dword read IIUC.
> 
> The spec says "this bit indicates the DOE instance has a *data object*
> available to be read by system firmware/software".

Ok yea.  I got confused by step 6 in sec 6.30.2.

> 
> So, the entire object is available for reading, not just one dword.

Yes cool!

> 
> You've already got checks in place for the first two dwords which
> cover reading an "all zeroes" response.  No need to amend them.
> 
> You only need to re-check the Data Object Ready bit on the last-but-one
> dword in case the function was reset concurrently.  Per sec. 6.30.2,
> "An FLR to a Function must result in the aborting of any DOE transfer
> in progress."

I think I disagree.  Even if we do that and an FLR comes before the last read
the last read could be 0's.

I think the interpretation of the data needs to happen above this and if an FLR
happens during this read we are going to have other issues.

But I can add the check if you feel strongly about it.

> 
> 
> > > > > +static irqreturn_t pci_doe_irq_handler(int irq, void *data)
> > > > > +{
> > > > > +	struct pci_doe_mb *doe_mb = data;
> > > > > +	struct pci_dev *pdev = doe_mb->pdev;
> > > > > +	int offset = doe_mb->cap_offset;
> > > > > +	u32 val;
> > > > > +
> > > > > +	pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
> > > > > +
> > > > > +	/* Leave the error case to be handled outside IRQ */
> > > > > +	if (FIELD_GET(PCI_DOE_STATUS_ERROR, val)) {
> > > > > +		mod_delayed_work(system_wq, &doe_mb->statemachine, 0);
> > > > > +		return IRQ_HANDLED;
> > > > > +	}
> > > > > +
> > > > > +	if (FIELD_GET(PCI_DOE_STATUS_INT_STATUS, val)) {
> > > > > +		pci_write_config_dword(pdev, offset + PCI_DOE_STATUS,
> > > > > +					PCI_DOE_STATUS_INT_STATUS);
> > > > > +		mod_delayed_work(system_wq, &doe_mb->statemachine, 0);
> > > > > +		return IRQ_HANDLED;
> > > > > +	}
> > > > > +
> > > > > +	return IRQ_NONE;
> > > > > +}  
> > > > 
> > > > PCIe 6.0, table 7-316 says that an interrupt is also raised when
> > > > "the DOE Busy bit has been Cleared", yet such an interrupt is
> > > > not handled here.  It is incorrectly treated as a spurious
> > > > interrupt by returning IRQ_NONE.  The right thing to do
> > > > is probably to wake the state machine in case it's polling
> > > > for the Busy flag to clear.
> > > 
> > > Ah. I remember testing this via a lot of hacking on the QEMU code
> > > to inject the various races that can occur (it was really ugly to do).
> > > 
> > > Guess we lost the handling at some point.  I think your fix
> > > is the right one.
> > 
> > Perhaps I am missing something but digging into this more.  I disagree
> > that the handler fails to handle this case.  If I read the spec correctly
> > DOE Interrupt Status must be set when an interrupt is generated.
> > The handler wakes the state machine in that case.  The state machine
> > then checks for busy if there is work to be done.
> 
> Right, I was mistaken, sorry for the noise.

NP I'm not always following this either.

> 
> 
> > Normally we would not even need to check for status error.  But that is
> > special cased because clearing that status is left to the state machine.
> 
> That however looks wrong because the DOE Interrupt Status bit is never
> cleared after a DOE Error is signaled.  The state machine performs an
> explicit abort upon an error by setting the DOE Abort bit, but that
> doesn't seem to clear DOE Interrupt Status:
> 
> Per section 6.30.2, "At any time, the system firmware/software is
> permitted to set the DOE Abort bit in the DOE Control Register,
> and the DOE instance must Clear the Data Object Ready bit,
> if not already Clear, and Clear the DOE Error bit, if already Set,
> in the DOE Status Register, within 1 second."

I thought that meant the hardware (the DOE instance) must clear those bits
within 1 second?

> 
> No mention of the DOE Interrupt Status bit, so we cannot assume that
> it's cleared by a DOE Abort and we must clear it explicitly.

Oh...  yea.  Jonathan?  We discussed this before and I was convinced it worked
but I think Lukas is correct here.

Should we drop the special case in pci_doe_irq_handler() and just clear the
status always?  Or should we wait and clear it is pci_doe_abort_start?

Ira

> 
> Thanks,
> 
> Lukas
