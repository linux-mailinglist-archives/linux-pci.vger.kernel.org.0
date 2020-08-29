Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 449E9256593
	for <lists+linux-pci@lfdr.de>; Sat, 29 Aug 2020 09:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgH2HXX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 29 Aug 2020 03:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgH2HXW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 29 Aug 2020 03:23:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF43C061236;
        Sat, 29 Aug 2020 00:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QNu7WskT6/ByA/SlTVpDtv1Uo1ftd0R0JFxhIta6WFQ=; b=gLbTnKYia/vcnmkitTXpw08E+d
        BXzQDIDN9FWHcHIFPvn3m+VIKNUT/mjS6WCSKr7xFlFPdv3K1NJlCab+ReyU6axduh7Lwyojbczx9
        Zz+fs7aFwQ1nPwxHf+RPMSWAcn546HEBogzq307eZQSkjnV04JoKSgQLNVtkrJZU95JddneQSvp/d
        K1Dq1cvPRYnhOhzeiIPosmjFNtvG4E/dGGWCjEUpIK/ARdm1qTzYljFVzrk+1+k51dVmgWet5sPxO
        fJtiB4wZDEo1OSA2C2yXq58SXFhEd8j55PQFO+DW7WWa42gF3+0PXteedleNdGAhxQhL4EQGsXXVo
        +Drd1k9A==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBvCZ-0001n6-TP; Sat, 29 Aug 2020 07:23:03 +0000
Date:   Sat, 29 Aug 2020 08:23:03 +0100
From:   "hch@infradead.org" <hch@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Derrick, Jonathan" <jonathan.derrick@intel.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "wangxiongfeng2@huawei.com" <wangxiongfeng2@huawei.com>,
        "kw@linux.com" <kw@linux.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "kai.heng.feng@canonical.com" <kai.heng.feng@canonical.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "Mario.Limonciello@dell.com" <Mario.Limonciello@dell.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "Huffman, Amber" <amber.huffman@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] PCI/ASPM: Enable ASPM for links under VMD domain
Message-ID: <20200829072303.GA6704@infradead.org>
References: <20200821123222.32093-1-kai.heng.feng@canonical.com>
 <20200825062320.GA27116@infradead.org>
 <cd5aa2fef13f14b30c139d03d5256cf93c7195dc.camel@intel.com>
 <20200827063406.GA13738@infradead.org>
 <660c8671a51eec447dc7fab22bacbc9c600508d9.camel@intel.com>
 <20200827162333.GA6822@infradead.org>
 <eb45485d9107440a667e598da99ad949320b77b1.camel@intel.com>
 <CAPcyv4ie53kswpk8E8=SCv4HBUAjCuFTNb6mLNUR+V-=cJ_XtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4ie53kswpk8E8=SCv4HBUAjCuFTNb6mLNUR+V-=cJ_XtA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 27, 2020 at 02:33:56PM -0700, Dan Williams wrote:
> > Just a few benefits and there are other users with unique use cases:
> > 1. Passthrough of the endpoint to OSes which don't natively support
> > hotplug can enable hotplug for that OS using the guest VMD driver
> > 2. Some hypervisors have a limit on the number of devices that can be
> > passed through. VMD endpoint is a single device that expands to many.
> > 3. Expansion of possible bus numbers beyond 256 by using other
> > segments.
> > 4. Custom RAID LED patterns driven by ledctl
> >
> > I'm not trying to market this. Just pointing out that this isn't
> > "bringing zero actual benefits" to many users.
> >
> 
> The initial intent of the VMD driver was to allow Linux to find and
> initialize devices behind a VMD configuration where VMD was required
> for a non-Linux OS. For Linux, if full native PCI-E is an available
> configuration option I think it makes sense to recommend Linux users
> to flip that knob rather than continue to wrestle with the caveats of
> the VMD driver. Where that knob isn't possible / available VMD can be
> a fallback, but full native PCI-E is what Linux wants in the end.

Agreed.  And the thing we need for this to really work is to turn VMD
off without a reboot when we find it.  That would solve all the problems
we have, and also allow an amazing kernel hacker like Derrick do more
productive work than coming up with one VMD workaround after another.
