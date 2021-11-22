Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAA044593F4
	for <lists+linux-pci@lfdr.de>; Mon, 22 Nov 2021 18:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237615AbhKVR1V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Nov 2021 12:27:21 -0500
Received: from mga03.intel.com ([134.134.136.65]:22210 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232880AbhKVR1U (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Nov 2021 12:27:20 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="234780087"
X-IronPort-AV: E=Sophos;i="5.87,255,1631602800"; 
   d="scan'208";a="234780087"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 09:24:13 -0800
X-IronPort-AV: E=Sophos;i="5.87,255,1631602800"; 
   d="scan'208";a="674136841"
Received: from wqiu6-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.143.45])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 09:24:13 -0800
Date:   Mon, 22 Nov 2021 09:24:12 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 05/23] cxl/pci: Don't poll doorbell for mailbox access
Message-ID: <20211122172412.l4pw2vjnemoqkvqz@intel.com>
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
 <20211120000250.1663391-6-ben.widawsky@intel.com>
 <20211122151131.00003a02@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122151131.00003a02@Huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-11-22 15:11:31, Jonathan Cameron wrote:
> On Fri, 19 Nov 2021 16:02:32 -0800
> Ben Widawsky <ben.widawsky@intel.com> wrote:
> 
> > The expectation is that the mailbox interface ready bit is the first
> > step in access through the mailbox interface.
> 
> Reword this? Perhaps
> "The expectation is that the mailbox interface ready bit will be set
>  at the start of any access through the mailbox interface."
> 
> > Therefore, waiting for the
> > doorbell busy bit to be clear would imply that the mailbox interface is
> > ready. The original driver implementation used the doorbell timeout for
> > the Mailbox Interface Ready bit to piggyback off of, since the latter
> > doesn't have a defined timeout (introduced in 8adaf747c9f0 ("cxl/mem:
> > Find device capabilities"), a timeout has since been defined with an ECN
> > to the 2.0 spec). With the current driver waiting for mailbox interface
> > ready as a part of probe() it's no longer necessary to use the
> > piggyback.
> > 
> > With the piggybacking no longer necessary it doesn't make sense to check
> > doorbell status when acquiring the mailbox. It will be checked during
> > the normal mailbox exchange protocol.
> > 
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Trivial comment inline - with that fixed either by calling it out, or by
> pulling it out of this patch.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> > ---
> > This patch did not exist in RFCv2
> > ---
> >  drivers/cxl/pci.c | 25 ++++++-------------------
> >  1 file changed, 6 insertions(+), 19 deletions(-)
> > 
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index 2cef9fec8599..869b4fc18e27 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -221,27 +221,14 @@ static int cxl_pci_mbox_get(struct cxl_dev_state *cxlds)
> >  
> >  	/*
> >  	 * XXX: There is some amount of ambiguity in the 2.0 version of the spec
> > -	 * around the mailbox interface ready (8.2.8.5.1.1).  The purpose of the
> > +	 * around the mailbox interface ready (8.2.8.5.1.1). The purpose of the
> 
> Whilst it's trivial, I'd prefer white space cleanup in separate patches.
> I guess this one is obvious enough to just call out in the patch description
> though.
> 

Okay. I'll keep this in mind for the future, and just fixup the commit messages
with your suggestion and this, now.

Thanks.
Ben

> >  	 * bit is to allow firmware running on the device to notify the driver
> > -	 * that it's ready to receive commands. It is unclear if the bit needs
> > -	 * to be read for each transaction mailbox, ie. the firmware can switch
> > -	 * it on and off as needed. Second, there is no defined timeout for
> > -	 * mailbox ready, like there is for the doorbell interface.
> > -	 *
> > -	 * Assumptions:
> > -	 * 1. The firmware might toggle the Mailbox Interface Ready bit, check
> > -	 *    it for every command.
> > -	 *
> > -	 * 2. If the doorbell is clear, the firmware should have first set the
> > -	 *    Mailbox Interface Ready bit. Therefore, waiting for the doorbell
> > -	 *    to be ready is sufficient.
> > +	 * that it's ready to receive commands. The spec does not clearly define
> > +	 * under what conditions the bit may get set or cleared. As of the 2.0
> > +	 * base specification there was no defined timeout for mailbox ready,
> > +	 * like there is for the doorbell interface. This was fixed with an ECN,
> > +	 * but it's possible early devices implemented this before the ECN.
> >  	 */
> > -	rc = cxl_pci_mbox_wait_for_doorbell(cxlds);
> > -	if (rc) {
> > -		dev_warn(dev, "Mailbox interface not ready\n");
> > -		goto out;
> > -	}
> > -
> >  	md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
> >  	if (!(md_status & CXLMDEV_MBOX_IF_READY && CXLMDEV_READY(md_status))) {
> >  		dev_err(dev, "mbox: reported doorbell ready, but not mbox ready\n");
> 
