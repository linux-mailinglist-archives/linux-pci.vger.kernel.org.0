Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C9E30ED22
	for <lists+linux-pci@lfdr.de>; Thu,  4 Feb 2021 08:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbhBDHRh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Feb 2021 02:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233253AbhBDHRf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Feb 2021 02:17:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79C3C0613D6;
        Wed,  3 Feb 2021 23:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QgfWxu4yt82JE/xIZ7oOgqgnaPHBT7dbTPo6JkGjbSA=; b=lwT7az+6ZMRVD6pMMGQeUxcGkz
        3sALDZXQnzoZAsV22q0sZB+6S/aKedsLuXCbgPrJ755mQQeczFZ3/OkCvIZaNAN1CpijxKmBvg872
        5+Dzv3/TXvRgYoYNI0fwjsd4wWwnvgiaKGwtH43/d+PMeW2C+pFw4V1KjDNnustdp1/7uD2knEK1p
        2ZqTmGENdZcvywP7ZnZSFdo+Azf3/Gieg5+M1xCdPooxSra5JG9Qe7BFX4IkCr0LbJeKyz0MJpxrd
        +rtljPjDSwGZkFQlZuyQQvP7Q0B3B0RBBv9nwpXRaHVzScnSqM6y4b/tUsWT6n88kcKSdYQvEM7nk
        s5pqCAlg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l7Ysg-000W3O-9s; Thu, 04 Feb 2021 07:16:46 +0000
Date:   Thu, 4 Feb 2021 07:16:46 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-cxl@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jon Masters <jcm@jonmasters.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        daniel.lll@alibaba-inc.com,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>
Subject: Re: [PATCH 03/14] cxl/mem: Find device capabilities
Message-ID: <20210204071646.GA122880@infradead.org>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-4-ben.widawsky@intel.com>
 <20210202181016.GD3708021@infradead.org>
 <20210202182418.3wyxnm6rqeoeclu2@intel.com>
 <20210203171534.GB4104698@infradead.org>
 <20210203172342.fpn5vm4xj2xwh6fq@intel.com>
 <CAPcyv4hvFjs=QqmUYqPipuaLoFiZ-dr6qVhqbDupWuKTw3QDkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hvFjs=QqmUYqPipuaLoFiZ-dr6qVhqbDupWuKTw3QDkg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 03, 2021 at 01:23:31PM -0800, Dan Williams wrote:
> > I'd prefer to keep the helpers for now as I do find them helpful, and so far
> > nobody else who has touched the code has complained. If you feel strongly, I
> > will change it.
> 
> After seeing the options, I think I'd prefer to not have to worry what
> extra magic is happening with cxl_read_mbox_reg32()
> 
> cxl_read_mbox_reg32(cxlm, CXLDEV_MB_CAPS_OFFSET);
> 
> readl(cxlm->mbox_regs + CXLDEV_MB_CAPS_OFFSET);
> 
> The latter is both shorter and more idiomatic.

Same here.  That being said I know some driver maintainers like
wrappers, my real main irk was the macro magic to generate them.
