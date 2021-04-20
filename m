Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C1A36521A
	for <lists+linux-pci@lfdr.de>; Tue, 20 Apr 2021 08:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbhDTGLx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Apr 2021 02:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhDTGLw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Apr 2021 02:11:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E19C06174A;
        Mon, 19 Apr 2021 23:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VtGKwlLzt3o9NMgYENh3GoR2m2ntsi4c0i/iVk3g+b0=; b=KJc8dDKOso7aewyB5hdF/M9Udy
        MJFlVN+fw0/ovRszP9qlI2D1dVX1Unx0DlfQMBXu/8B5zNzja2NRAwcbv9Hax+2208lVnYl4EQzDM
        dDzsBnXkPcIrhbt5+GGxdQJlZuNRSWdk9PSwFdbm6nVnfM/B33tSPYZnJiMGwJagLpEIHv1V8EMc9
        1b9DQtuLk+/Pcvpad9gemSkgNe83axRZwq+6+OR1iQs0SNSXPvBD4i6rQ4JEOOle03Lvr0PMVkRvb
        ajK7yNVB5eB6QHGkIW8XCyA1iHit+L7KevaB89YmWSGSnlyCRRHH0+L6CvPAGBksDlK26hvVKwwue
        8e6w2fhQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lYjaI-00EmxI-EI; Tue, 20 Apr 2021 06:10:11 +0000
Date:   Tue, 20 Apr 2021 07:10:06 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, helgaas@kernel.org, rajatxjain@gmail.com
Subject: Re: [PATCH] pci: Rename pci_dev->untrusted to pci_dev->external
Message-ID: <20210420061006.GA3523612@infradead.org>
References: <20210420003049.1635027-1-rajatja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420003049.1635027-1-rajatja@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 19, 2021 at 05:30:49PM -0700, Rajat Jain wrote:
> The current flag name "untrusted" is not correct as it is populated
> using the firmware property "external-facing" for the parent ports. In
> other words, the firmware only says which ports are external facing, so
> the field really identifies the devices as external (vs internal).
> 
> Only field renaming. No functional change intended.

I don't think this is a good idea.  First the field should have been
added to the generic struct device as requested multiple times before.
Right now this requires horrible hacks in the IOMMU code to get at the
pci_dev, and also doesn't scale to various other potential users.

Second the untrusted is objectively a better name.  Because untrusted
is how we treat the device, which is what mattes.  External is just
how we come to that conclusion.
