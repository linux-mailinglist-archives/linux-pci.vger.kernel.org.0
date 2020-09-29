Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5DF27D4D9
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 19:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730160AbgI2RsX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Sep 2020 13:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728198AbgI2RsX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Sep 2020 13:48:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6225C061755
        for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2020 10:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xeDknh21KEiWqQD6tRTesKOBoYEM7I9cFxibiUaf9cI=; b=uZ67wgKPSNi3FwUuFRScitGM4E
        87CQ7tI9maGnIirJMIAWZn5cM7xGkviWXPDnJlHDTJgA77ifvA8eOoXEf4VMrmYVqh2vzsUiURvo+
        Zx1tc2pL9tzo8/Le004H3HxkkqTZCl6GNJdRhVlhU293J5sICrsAZ2ckcRJuujiUCsoIXqzlF22OE
        7mZVMyZBa0lhquRsHblilhbgsy2f4I7XFYtcyKED6mftvTOWg6I5ziYtEXp4PMO8Sub5Dqlu4sAv9
        phwi+qvrgsiZo7i/hvzX9vxCTuC9cXHV5RUH/FdymsXdZuVD54WN0VPgg1dVlotSmvDl8p+p4bO0B
        ZVvdJxdA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNJjg-0000Ly-LI; Tue, 29 Sep 2020 17:48:20 +0000
Date:   Tue, 29 Sep 2020 18:48:20 +0100
From:   "hch@infradead.org" <hch@infradead.org>
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "andrzej.jakowski@linux.intel.com" <andrzej.jakowski@linux.intel.com>,
        "Fugate, David" <david.fugate@intel.com>
Subject: Re: [PATCH 2/3] PCI: Introduce a minimizing assignment algorithm
Message-ID: <20200929174820.GA1113@infradead.org>
References: <20200928010609.5375-1-jonathan.derrick@intel.com>
 <20200928010609.5375-3-jonathan.derrick@intel.com>
 <20200928071755.GB24862@infradead.org>
 <5062649eee1c179245c435a415da8dad87ef6325.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5062649eee1c179245c435a415da8dad87ef6325.camel@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 28, 2020 at 01:34:50PM +0000, Derrick, Jonathan wrote:
> Well this fix in particular may not be needed once the dynamic hotplug
> resource resizing set is in and build on that. But frankly the generic
> resource assignment code itself is very difficult to work within and
> has been discussed at several LPC over the years. I don't see a problem
> with another algorithm which could be relied upon by other host bridge
> controller drivers if they want it.
> 
> I also spent a good deal of time trying to get the minimizing algorithm
> into pci_assign_unassigned_root_bus_resources, where the only instance
> of pci=realloc detection takes place (who knew there were so many
> originating different paths for resource assignment?). I couldn't make
> headway there so started fresh. Maybe someone talented could refactor
> mine into it and save a few instruction bytes.

If the maintainers think there might be other use cases we could
also just make it conditional and let VMD select it.  I'm just a little
worried but all kinds of cruft slipping into core code to work around
the various problems vmd creates.
