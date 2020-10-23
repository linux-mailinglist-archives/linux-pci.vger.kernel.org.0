Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8899D2969E3
	for <lists+linux-pci@lfdr.de>; Fri, 23 Oct 2020 08:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S375404AbgJWGro (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Oct 2020 02:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S375401AbgJWGro (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Oct 2020 02:47:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B64C0613CE;
        Thu, 22 Oct 2020 23:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BpKyPUKBRmupv+ADoXZ2WKJ98lsRlSNLBOv4kS8Twyc=; b=Lo756IB6V4p3RdlJwmiIy6xbvn
        Ls602AVHxUgwIak6/ZqYxeI7y0RbWN8s3jIOk7Y5uM2tBQIoL2c72xeJSJqcBT2878VgPLWTn4yEG
        TrBMtrLYvdHyvjwQmX75RuBokNricbhwv/0fJvLK8IB8INKytNNlI+ZoVYSHtxmiajfg9qkknhGWQ
        m5OdyGXAW0o+4/UvBg4ccCR7DoDm7OMBrzjtVN6FS4mzXUQbGZTyi2AHmGzH+BS68T5/fGoD4d4Fn
        SRkIWKzZqRZ51LvQnKrpOnBY5u/8trY24u/byG0830jsdz0zaENzwM9NXugPWCh+4TQMHe2l1VFPH
        P6K4Webg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVqrU-00062s-9u; Fri, 23 Oct 2020 06:47:40 +0000
Date:   Fri, 23 Oct 2020 07:47:40 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Paul Burton <paulburton@kernel.org>,
        linux-mips@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: export pci_find_host_bridge() to fix MFD build error
Message-ID: <20201023064740.GB22405@infradead.org>
References: <20201019061453.32295-1-rdunlap@infradead.org>
 <20201020080219.GA21011@infradead.org>
 <20201021100844.GA3693@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021100844.GA3693@alpha.franken.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 21, 2020 at 12:08:45PM +0200, Thomas Bogendoerfer wrote:
> On Tue, Oct 20, 2020 at 09:02:19AM +0100, Christoph Hellwig wrote:
> > On Sun, Oct 18, 2020 at 11:14:53PM -0700, Randy Dunlap wrote:
> > > Fix a build error in drivers/mfd/ioc.o by exporting
> > > pci_find_host_bridge().
> > > 
> > > ERROR: modpost: "pci_find_host_bridge" [drivers/mfd/ioc3.ko] undefined!
> > 
> > I think the mfd code should be fixed to not depend on such an internal
> > symbol instead.
> 
> are you talking about the EXPORT_SYMBOL or the usage of
> pci_find_host_bridge() outside of drivers/pci ? If the latter the
> function is used in arm/arm64 code and pci controller code... so
> I doesn't look like a pure internal symbol to me.

All of those are built-in and related bits aren't exported at all, or
at best EXPORT_SYMBOL_GPL.  I think just not allowing the ioc3 mfd to
be built modular might be the easiest fix here.  Especially as for IP27
and co kernel it is everything but optional anyway.
