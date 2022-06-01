Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A62353A932
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jun 2022 16:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355373AbiFAO2S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Jun 2022 10:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354839AbiFAO1z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Jun 2022 10:27:55 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBC62C105;
        Wed,  1 Jun 2022 07:23:28 -0700 (PDT)
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LCrrg3xmHz685x5;
        Wed,  1 Jun 2022 22:20:03 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 1 Jun 2022 16:23:26 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 1 Jun
 2022 15:23:25 +0100
Date:   Wed, 1 Jun 2022 15:23:23 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Lukas Wunner <lukas@wunner.de>
CC:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V8 03/10] PCI: Create PCI library functions in support
 of DOE mailboxes.
Message-ID: <20220601152323.00004b9e@Huawei.com>
In-Reply-To: <20220601071808.GA19924@wunner.de>
References: <20220414203237.2198665-1-ira.weiny@intel.com>
        <20220414203237.2198665-4-ira.weiny@intel.com>
        <20220530190657.GA14765@wunner.de>
        <20220531113350.0000421e@Huawei.com>
        <YpbWCYujYDEkMm1B@iweiny-desk3>
        <20220601071808.GA19924@wunner.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml739-chm.china.huawei.com (10.201.108.189) To
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

On Wed, 1 Jun 2022 09:18:08 +0200
Lukas Wunner <lukas@wunner.de> wrote:

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
> 
> So, the entire object is available for reading, not just one dword.

Agreed

> 
> You've already got checks in place for the first two dwords which
> cover reading an "all zeroes" response.  No need to amend them.
> 
> You only need to re-check the Data Object Ready bit on the last-but-one
> dword in case the function was reset concurrently.  Per sec. 6.30.2,
> "An FLR to a Function must result in the aborting of any DOE transfer
> in progress."

Ouch, isn't that racy as you can only check it slightly before reading the
last dword and a reset could occur in between?

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

Ah. Makes sense - managed to confuse me too ;)
I really don't like the absence of a status bit for the DOE busy bit has
cleared interrupt source, but glad we did handle it.

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
> 
> No mention of the DOE Interrupt Status bit, so we cannot assume that
> it's cleared by a DOE Abort and we must clear it explicitly.

Gah.

Jonathan

> 
> Thanks,
> 
> Lukas
> 

