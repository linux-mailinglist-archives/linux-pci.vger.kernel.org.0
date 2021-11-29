Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD03462110
	for <lists+linux-pci@lfdr.de>; Mon, 29 Nov 2021 20:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236186AbhK2Tzm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Nov 2021 14:55:42 -0500
Received: from mga07.intel.com ([134.134.136.100]:34941 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1379911AbhK2Txk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Nov 2021 14:53:40 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="299458726"
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="299458726"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 11:50:06 -0800
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="511836547"
Received: from ajsteine-mobl13.amr.corp.intel.com (HELO intel.com) ([10.252.141.244])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 11:50:06 -0800
Date:   Mon, 29 Nov 2021 11:50:05 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 05/23] cxl/pci: Don't poll doorbell for mailbox access
Message-ID: <20211129195005.72m4pt4h2vql4tk6@intel.com>
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
 <20211120000250.1663391-6-ben.widawsky@intel.com>
 <CAPcyv4jUExKbFhTXQGs_ayUvQqrp_76Z5Wywf7=ADXKcTF3DnQ@mail.gmail.com>
 <20211129183330.svptvcystceazgwc@intel.com>
 <CAPcyv4hPP8KYXD-6mrpHRpLYLqSQb22Lie2_m1Nc=Y5NqqfJgQ@mail.gmail.com>
 <20211129191146.vhiwkf5jsegil4aa@intel.com>
 <CAPcyv4gboiSXq1zCtmnP7oWzjaoMG=RL5sgmhFtXuxsTTPf3fA@mail.gmail.com>
 <20211129193156.wtm7p7cdpn7iedqa@intel.com>
 <CAPcyv4jT_5x7itJovgjRyfsRsjWqPghRYshxqvga=af8GJ6Nmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jT_5x7itJovgjRyfsRsjWqPghRYshxqvga=af8GJ6Nmw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-11-29 11:37:34, Dan Williams wrote:
> On Mon, Nov 29, 2021 at 11:32 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> [..]
> > >
> > > Right, there's no harm in the check, it just seems overly paranoid to
> > > me if it was already checked once. Until a doorbell timeout happens
> > > it's an extra MMIO cycle that can saved for a "what happened?" check
> > > after a timeout.
> >
> > Well I suspect we're just rearranging the deck chairs on the Titanic now, but...
> 
> Not so much, just trying to get this driver in line with other error
> handling designs.

Okay. I shall remove it then.

> 
> > I see doorbell timeouts as disconnected from whether or not the mailbox
> > interface is ready. If they were the same, we wouldn't need both bits and we
> > could just wait extra long for the doorbell when probing.
> >
> > In other words, I expect if the interface goes unready, doorbell timeout will
> > occur, but I don't think we should assume if doorbell timeout occurs, the
> > interface is no longer ready. I don't purport to know why a doorbell timeout
> > might occur while the interface remains available (likely a firmware bug, I
> > presume).
> >
> > It does seem interesting to check if the interface is no longer ready on timeout
> > though.
> 
> So I'm just modeling this off of NVME error handling where there is a
> Controller Fatal Status bit that could be checked every transaction,
> but instead the driver waits until a command timeout to collect if the
> device went fatal / not-ready.

No error interrupts?
