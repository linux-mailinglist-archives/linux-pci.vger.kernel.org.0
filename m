Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEF053C0FE
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jun 2022 00:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239049AbiFBWrl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jun 2022 18:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbiFBWrk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jun 2022 18:47:40 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77ABBBCAA;
        Thu,  2 Jun 2022 15:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654210059; x=1685746059;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0scndvUqgpJ+WslX7Mk2ISgiLRNjcAhaYsETtmdMtlM=;
  b=O2JxNE+c4mFLJdkQ4UKUQ+LLWdZiFaLUyYqEiwKWYvKTZE3BQNmCCTPY
   1WdDSUwKQvRLp4w8FfEOfgr7TVRJErp9AQrQcmI7AYs8pLpxOYdpTFIKJ
   xScQngpV4YmfVz2LOFRnU2GDt1FvOSHSYn2tRLgjVITAgkTV9wWqm+RH8
   nF3csnl8h4HOF/TluPf7jW5HPzd5lUL7Z0Pb5iN9cIH1kiWdX+iw9G9Cv
   D/OfZlZ3CucC+XvdlEaFK3tttjN+n/wtuXUpkAtJitc4rGhePrsULrEY5
   qRT5KLiRG2n+ng+8rc4yrO97b754Xk45nvVj6OepWIcFWDu9WUynDf+Hx
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10366"; a="263746901"
X-IronPort-AV: E=Sophos;i="5.91,272,1647327600"; 
   d="scan'208";a="263746901"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 15:47:38 -0700
X-IronPort-AV: E=Sophos;i="5.91,272,1647327600"; 
   d="scan'208";a="757218548"
Received: from liqiong-mobl.amr.corp.intel.com (HELO localhost) ([10.209.7.136])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 15:47:37 -0700
Date:   Thu, 2 Jun 2022 15:47:37 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <ben@bwidawsk.net>, linux-kernel@vger.kernel.org,
        linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH V9 6/9] cxl/port: Read CDAT table
Message-ID: <Ypk+Cc0fWelIcamX@iweiny-desk3>
References: <20220531152632.1397976-1-ira.weiny@intel.com>
 <20220531152632.1397976-7-ira.weiny@intel.com>
 <20220601163540.00006978@Huawei.com>
 <20220601173113.000005a6@Huawei.com>
 <YpkCHADvGv6i3jVP@iweiny-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpkCHADvGv6i3jVP@iweiny-desk3>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 02, 2022 at 11:31:56AM -0700, Ira wrote:
> On Wed, Jun 01, 2022 at 05:31:13PM +0100, Jonathan Cameron wrote:
> > On Wed, 1 Jun 2022 16:35:40 +0100
> > Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> > 
> > > On Tue, 31 May 2022 08:26:29 -0700
> > > ira.weiny@intel.com wrote:
> > > 
> > > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > 
> > > > The OS will need CDAT data from CXL devices to properly set up
> > > > interleave sets.  Currently this is supported through a DOE mailbox
> > > > which supports CDAT.
> > > > 
> > > > Cache the CDAT data for later parsing.  Provide a sysfs binary attribute
> > > > to allow dumping of the CDAT.
> > > > 
> > > > Binary dumping is modeled on /sys/firmware/ACPI/tables/
> > > > 
> > > > The ability to dump this table will be very useful for emulation of real
> > > > devices once they become available as QEMU CXL type 3 device emulation will
> > > > be able to load this file in.
> > > > 
> > > > This does not support table updates at runtime. It will always provide
> > > > whatever was there when first cached. Handling of table updates can be
> > > > implemented later.
> > > > 
> > > > Finally create a complete list of DOE defines within cdat.h for code
> > > > wishing to decode the CDAT table.
> > > > 
> > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> > > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > >   
> > > 
> > > Fun question of ownership inline...
> > 
> > And a follow up due to triggering a bug that predated this series...
> > 
> > I'd send a fix, but I'm off on a long weekend shortly :)
> 
> NP I discussed with Dan and the use of dev_groups should allow me to move this
> to port probe where it belongs.  I put it here for the sysfs stuff.

Not to make a habit of replying to my own mails but this works.

So I'm going to go forward with spinning this again.

Ira
