Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F2A4620B7
	for <lists+linux-pci@lfdr.de>; Mon, 29 Nov 2021 20:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352293AbhK2Toq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Nov 2021 14:44:46 -0500
Received: from mga02.intel.com ([134.134.136.20]:40138 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233335AbhK2Tmq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Nov 2021 14:42:46 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="223285089"
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="223285089"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 11:31:58 -0800
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="511114997"
Received: from dsshah-mobl2.amr.corp.intel.com (HELO intel.com) ([10.252.141.244])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 11:31:57 -0800
Date:   Mon, 29 Nov 2021 11:31:56 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 05/23] cxl/pci: Don't poll doorbell for mailbox access
Message-ID: <20211129193156.wtm7p7cdpn7iedqa@intel.com>
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
 <20211120000250.1663391-6-ben.widawsky@intel.com>
 <CAPcyv4jUExKbFhTXQGs_ayUvQqrp_76Z5Wywf7=ADXKcTF3DnQ@mail.gmail.com>
 <20211129183330.svptvcystceazgwc@intel.com>
 <CAPcyv4hPP8KYXD-6mrpHRpLYLqSQb22Lie2_m1Nc=Y5NqqfJgQ@mail.gmail.com>
 <20211129191146.vhiwkf5jsegil4aa@intel.com>
 <CAPcyv4gboiSXq1zCtmnP7oWzjaoMG=RL5sgmhFtXuxsTTPf3fA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gboiSXq1zCtmnP7oWzjaoMG=RL5sgmhFtXuxsTTPf3fA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-11-29 11:18:36, Dan Williams wrote:

[snip]

> > > > > > -       rc = cxl_pci_mbox_wait_for_doorbell(cxlds);
> > > > > > -       if (rc) {
> > > > > > -               dev_warn(dev, "Mailbox interface not ready\n");
> > > > > > -               goto out;
> > > > > > -       }
> > > > > > -
> > > > > >         md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
> > > > > >         if (!(md_status & CXLMDEV_MBOX_IF_READY && CXLMDEV_READY(md_status))) {
> > > > > >                 dev_err(dev, "mbox: reported doorbell ready, but not mbox ready\n");
> > > > >
> > > > > This error message is obsolete since nothing is pre-checking the
> > > > > mailbox anymore, and per above I see no problem waiting to check the
> > > > > status until after the mailbox has failed to respond after a timeout.
> > > >
> > > > The message is wrong, but I think the logic is still valuable. How about:
> > > > "mbox: reported interface ready, but mbox not ready"
> > >
> > > You mean check this every time even though the spec says the driver
> > > only needs to check it once per-reset?
> >
> > Unfortunately it does not say that. "... it shall remain set until the next
> > reset or the device encounters an error that prevents any mailbox
> > communication."
> >
> > Once we have real error checking in place, this could go away, though I see no
> > harm in leaving it.
> 
> Right, there's no harm in the check, it just seems overly paranoid to
> me if it was already checked once. Until a doorbell timeout happens
> it's an extra MMIO cycle that can saved for a "what happened?" check
> after a timeout.

Well I suspect we're just rearranging the deck chairs on the Titanic now, but...

I see doorbell timeouts as disconnected from whether or not the mailbox
interface is ready. If they were the same, we wouldn't need both bits and we
could just wait extra long for the doorbell when probing.

In other words, I expect if the interface goes unready, doorbell timeout will
occur, but I don't think we should assume if doorbell timeout occurs, the
interface is no longer ready. I don't purport to know why a doorbell timeout
might occur while the interface remains available (likely a firmware bug, I
presume).

It does seem interesting to check if the interface is no longer ready on timeout
though.
