Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4506F4A5373
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 00:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiAaXnC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jan 2022 18:43:02 -0500
Received: from mga03.intel.com ([134.134.136.65]:57022 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229691AbiAaXnB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 Jan 2022 18:43:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643672581; x=1675208581;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qdzEUz3Vy5nL8fXM959mD9qxO22pWQ+WVhRG5qmI174=;
  b=ewnckePD5PY0u8sM3umYrJnX4Vx3xoSmGkExBOhYdM6HFwkuWHRu5FEk
   bW9izY445w0xFYzta5RphVVahMZPApKknjcu4ZHPcC0Qbsu60nul8IVHT
   XcCECtXOFKvyueHN33rmyCcsW1VPxWl/7HwHk6QdJXvHTXzuAdaNjT4y5
   FQwpz8uCcVe09sVk5vZXvw7qPhNfVWpINBUyhA5UoutVa7xhfi64ELpON
   Ltzfe/n80ZGRVqiBR0Qx3vSD0Z/5cB2aXRFWkDB2Uu+R2u7+6cJF54unt
   Bu4G66L0ihNdGP3qWrv+raARh0lIvhhuvimx9IZi9gZm4roYnbjla1ZKF
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="247529530"
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="247529530"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 15:43:01 -0800
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="768754074"
Received: from sssheth-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.130.247])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 15:43:00 -0800
Date:   Mon, 31 Jan 2022 15:42:59 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v4 16/40] cxl/core/port: Use dedicated lock for decoder
 target list
Message-ID: <20220131234259.twqkexaq7emp5ml4@intel.com>
References: <164298420439.3018233.5113217660229718675.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164316562430.3437160.122223070771602475.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220131233422.xo6sugw4bvoyh6ia@intel.com>
 <CAPcyv4hD9jPaTJZE47hx1mg66T44KWCyiaCZGrqG1i-mNAfKqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hD9jPaTJZE47hx1mg66T44KWCyiaCZGrqG1i-mNAfKqA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22-01-31 15:38:44, Dan Williams wrote:
> On Mon, Jan 31, 2022 at 3:34 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > On 22-01-25 18:54:36, Dan Williams wrote:
> > > Lockdep reports:
> > >
> > >  ======================================================
> > >  WARNING: possible circular locking dependency detected
> > >  5.16.0-rc1+ #142 Tainted: G           OE
> > >  ------------------------------------------------------
> > >  cxl/1220 is trying to acquire lock:
> > >  ffff979b85475460 (kn->active#144){++++}-{0:0}, at: __kernfs_remove+0x1ab/0x1e0
> > >
> > >  but task is already holding lock:
> > >  ffff979b87ab38e8 (&dev->lockdep_mutex#2/4){+.+.}-{3:3}, at: cxl_remove_ep+0x50c/0x5c0 [cxl_core]
> > >
> > > ...where cxl_remove_ep() is a helper that wants to delete ports while
> > > holding a lock on the host device for that port. That sets up a lockdep
> > > violation whereby target_list_show() can not rely holding the decoder's
> > > device lock while walking the target_list. Switch to a dedicated seqlock
> > > for this purpose.
> > >
> > > Reported-by: Ben Widawsky <ben.widawsky@intel.com>
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > ---
> > > Changes in v4:
> > > - Fix missing unlock in error exit case (Ben)
> >
> > Could you help me understand why we need a lock at all for the target list? I
> > thought the target list remains static throughout the lifetime of the decoder at
> > which point, the only issue would be reading the sysfs entries while the decoder
> > is being destroyed. Is that possible?
> 
> This is emitting the target list per the current configuration. If
> another thread or the kernel is configuring the decoder and while the
> target list is being read it should get a coherent snapshot, not the
> intermediate settings.

How can you see the decoder in sysfs before it is finished being configured?
