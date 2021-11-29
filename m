Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97BDF461F8D
	for <lists+linux-pci@lfdr.de>; Mon, 29 Nov 2021 19:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbhK2Sso (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Nov 2021 13:48:44 -0500
Received: from mga11.intel.com ([192.55.52.93]:13114 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1380350AbhK2SqS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Nov 2021 13:46:18 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="233545285"
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="233545285"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 10:33:31 -0800
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="676469965"
Received: from ajsteine-mobl13.amr.corp.intel.com (HELO intel.com) ([10.252.141.244])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 10:33:31 -0800
Date:   Mon, 29 Nov 2021 10:33:30 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 05/23] cxl/pci: Don't poll doorbell for mailbox access
Message-ID: <20211129183330.svptvcystceazgwc@intel.com>
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
 <20211120000250.1663391-6-ben.widawsky@intel.com>
 <CAPcyv4jUExKbFhTXQGs_ayUvQqrp_76Z5Wywf7=ADXKcTF3DnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jUExKbFhTXQGs_ayUvQqrp_76Z5Wywf7=ADXKcTF3DnQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-11-24 13:55:03, Dan Williams wrote:
> On Fri, Nov 19, 2021 at 4:03 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > The expectation is that the mailbox interface ready bit is the first
> > step in access through the mailbox interface. Therefore, waiting for the
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
> >         /*
> >          * XXX: There is some amount of ambiguity in the 2.0 version of the spec
> > -        * around the mailbox interface ready (8.2.8.5.1.1).  The purpose of the
> > +        * around the mailbox interface ready (8.2.8.5.1.1). The purpose of the
> >          * bit is to allow firmware running on the device to notify the driver
> > -        * that it's ready to receive commands. It is unclear if the bit needs
> > -        * to be read for each transaction mailbox, ie. the firmware can switch
> > -        * it on and off as needed. Second, there is no defined timeout for
> > -        * mailbox ready, like there is for the doorbell interface.
> > -        *
> > -        * Assumptions:
> > -        * 1. The firmware might toggle the Mailbox Interface Ready bit, check
> > -        *    it for every command.
> > -        *
> > -        * 2. If the doorbell is clear, the firmware should have first set the
> > -        *    Mailbox Interface Ready bit. Therefore, waiting for the doorbell
> > -        *    to be ready is sufficient.
> > +        * that it's ready to receive commands. The spec does not clearly define
> > +        * under what conditions the bit may get set or cleared. As of the 2.0
> > +        * base specification there was no defined timeout for mailbox ready,
> > +        * like there is for the doorbell interface. This was fixed with an ECN,
> > +        * but it's possible early devices implemented this before the ECN.
> 
> Can we just drop comment block altogether? Outside of
> cxl_pci_setup_mailbox() the only time the mailbox status should be
> checked is after a doorbell timeout after submitting a command.
> 

Yes, I think it's fine to drop it.

> >          */
> > -       rc = cxl_pci_mbox_wait_for_doorbell(cxlds);
> > -       if (rc) {
> > -               dev_warn(dev, "Mailbox interface not ready\n");
> > -               goto out;
> > -       }
> > -
> >         md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
> >         if (!(md_status & CXLMDEV_MBOX_IF_READY && CXLMDEV_READY(md_status))) {
> >                 dev_err(dev, "mbox: reported doorbell ready, but not mbox ready\n");
> 
> This error message is obsolete since nothing is pre-checking the
> mailbox anymore, and per above I see no problem waiting to check the
> status until after the mailbox has failed to respond after a timeout.

The message is wrong, but I think the logic is still valuable. How about:
"mbox: reported interface ready, but mbox not ready"
