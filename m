Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6D46F7FA3
	for <lists+linux-pci@lfdr.de>; Fri,  5 May 2023 11:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjEEJMl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 May 2023 05:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbjEEJMk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 May 2023 05:12:40 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F685FDF
        for <linux-pci@vger.kernel.org>; Fri,  5 May 2023 02:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683277958; x=1714813958;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xs+hrgQXpKFchr+32T/H7blpD6rKaqn/LW/JYhk2whA=;
  b=UNOAlJ0gntOZp5bADj8p8ghRxxrrpAu94Q0TWquKaRDCj5srHJHDwvQv
   lEPTGQjKvZldkBL9ARoQX4wr3+arBaNCOHVGvSistY8xWHi/lFl4zxDiL
   J6eWXzI8BknpLZUSQqAbL1G9fvwC/WJ8XfX/aYsc99ERy3dDpO+AdbSEi
   0ezD7h31aWAjc9G0Evap5hwVWMRw1o4wmMUw12P9S4ab05Ixu+r+m5bK7
   CzfpcZmekCvLiZfSLLdCqZRoXMA5qVGeH3c1I8S3jeRuuyKlNdxAem7b7
   s/4kbrT0nHK874MUFZyAVX7NDsIaNdnpj9/au2mH4X5b4sl9cnLi9Wbj3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="333589283"
X-IronPort-AV: E=Sophos;i="5.99,251,1677571200"; 
   d="scan'208";a="333589283"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 02:12:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="809145376"
X-IronPort-AV: E=Sophos;i="5.99,251,1677571200"; 
   d="scan'208";a="809145376"
Received: from mtkaczyk-mobl.ger.corp.intel.com (HELO localhost) ([10.249.139.56])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 02:12:36 -0700
Date:   Fri, 5 May 2023 11:12:32 +0200
From:   Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        <stuart.w.hayes@gmail.com>
Subject: Re: [PATCH 0/3] Enclosure sysfs refactor
Message-ID: <20230505111232.000058dc@linux.intel.com>
In-Reply-To: <6453e874d1c0e_2ec5d2945f@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221117163407.28472-1-mariusz.tkaczyk@linux.intel.com>
        <20230504141048.00001ba6@linux.intel.com>
        <6453e874d1c0e_2ec5d2945f@dwillia2-xfh.jf.intel.com.notmuch>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 4 May 2023 10:16:36 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Mariusz Tkaczyk wrote:
> > On Thu, 17 Nov 2022 17:34:04 +0100
> > Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com> wrote:
> >   
> > > Hi Bjorn,
> > > I agreed with Stuart to take over the NPEM implementation[1].
> > > First part I want to share is a small refactor around enclosure interface.
> > > 
> > > The one sysfs change introduced is changing active LED to write-only.
> > > get_active() callback is not implemented for SES which is the
> > > only one enclosure API consumer now.
> > > 
> > > [1]
> > > https://lore.kernel.org/linux-pci/cover.1643822289.git.stuart.w.hayes@gmail.com/
> > > 
> > > Mariusz Tkaczyk (3):
> > >   misc: enclosure: remove get_active() callback
> > >   misc: enclosure, ses: simplify some get callbacks
> > >   misc: enclosure: update sysfs api
> > > 
> > >  drivers/misc/enclosure.c  | 96 ++++++++++++++++-----------------------
> > >  drivers/scsi/ses.c        | 33 ++++++++------
> > >  include/linux/enclosure.h | 14 ++----
> > >  3 files changed, 61 insertions(+), 82 deletions(-)
> > >   
> > 
> > Hi Bjorn,
> > Could you please take a look? Let me know if you against this cleanup.
> > I would like to get back to NPEM, I based my patches on top of it.  
> 
> Hi Mariusz,
> 
> I don't expect Bjorn to handle enclosure updates. I expect the upstream
> path for these patches is through the SCSI tree. Going forward you can
> use get_maintainer.pl for this routing information.
> 
> $ ./scripts/get_maintainer.pl drivers/scsi/ses.c 
> "James E.J. Bottomley" <jejb@linux.ibm.com> (maintainer:SCSI SUBSYSTEM)
> "Martin K. Petersen" <martin.petersen@oracle.com> (maintainer:SCSI SUBSYSTEM)
> linux-scsi@vger.kernel.org (open list:SCSI SUBSYSTEM)
> linux-kernel@vger.kernel.org (open list)
> 
> I'll take a look and then you can resend to linux-scsi. I do like this
> stat line:
> 
> 3 files changed, 61 insertions(+), 82 deletions(-)
> 
> ...makes it compelling to take a look.

Ohh...my bad. Apologize for noise. Thanks Dan for clarification.

Mariusz
