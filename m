Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519A5254AA0
	for <lists+linux-pci@lfdr.de>; Thu, 27 Aug 2020 18:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgH0QXu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Aug 2020 12:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgH0QXt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Aug 2020 12:23:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665B2C061264;
        Thu, 27 Aug 2020 09:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=15+7ZeGTiVqYsgGTf8WTKBRYLUjS9SNNpRwCigns3M8=; b=QB4W7D5eRkbr7yQH+De6JSrJuO
        42UzsVfF3G+jIeAwpPRr1+Ut+b2uV/aVPqBzgeA8pFVqHeMq3Qn4KsG9zgBkoJWf+iCottELfWkXJ
        ny2zfnEQ9QUqFo7D7raiPaBaCuudqTz7wY8fGXmA2AElFX8XO3pV2XxOM4xsJc8KGwURzwbJ8Q6VT
        dwOxzuZC+/7GuoAHEIqSARpB/NQcdvmwoToRAehicBxQvQdztKrnN6mp8NHuqHTNOI4nbJ67MMjRv
        R21/cL36QHF8U6HYqQy2qir2GHIda/+oDojfskBBUHi1YiSPZ8t7dGbLwzX4wwcJ+XgEdTl54x9kg
        FbrJO33g==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBKgX-0001up-DA; Thu, 27 Aug 2020 16:23:33 +0000
Date:   Thu, 27 Aug 2020 17:23:33 +0100
From:   "hch@infradead.org" <hch@infradead.org>
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        "wangxiongfeng2@huawei.com" <wangxiongfeng2@huawei.com>,
        "kw@linux.com" <kw@linux.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "kai.heng.feng@canonical.com" <kai.heng.feng@canonical.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "Mario.Limonciello@dell.com" <Mario.Limonciello@dell.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "Huffman, Amber" <amber.huffman@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] PCI/ASPM: Enable ASPM for links under VMD domain
Message-ID: <20200827162333.GA6822@infradead.org>
References: <20200821123222.32093-1-kai.heng.feng@canonical.com>
 <20200825062320.GA27116@infradead.org>
 <cd5aa2fef13f14b30c139d03d5256cf93c7195dc.camel@intel.com>
 <20200827063406.GA13738@infradead.org>
 <660c8671a51eec447dc7fab22bacbc9c600508d9.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <660c8671a51eec447dc7fab22bacbc9c600508d9.camel@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 27, 2020 at 04:13:44PM +0000, Derrick, Jonathan wrote:
> On Thu, 2020-08-27 at 06:34 +0000, hch@infradead.org wrote:
> > On Wed, Aug 26, 2020 at 09:43:27PM +0000, Derrick, Jonathan wrote:
> > > Feel free to review my set to disable the MSI remapping which will
> > > make
> > > it perform as well as direct-attached:
> > > 
> > > https://patchwork.kernel.org/project/linux-pci/list/?series=325681
> > 
> > So that then we have to deal with your schemes to make individual
> > device direct assignment work in a convoluted way?
> 
> That's not the intent of that patchset -at all-. It was to address the
> performance bottlenecks with VMD that you constantly complain about. 

I know.  But once we fix that bottleneck we fix the next issue,
then to tackle the next.  While at the same time VMD brings zero
actual benefits.

> > Please just give us
> > a disable nob for VMD, which solves _all_ these problems without
> > adding
> > any.
> 
> I don't see the purpose of this line of discussion. VMD has been in the
> kernel for 5 years. We are constantly working on better support.

Please just work with the platform people to allow the host to disable
VMD.  That is the only really useful value add here.
