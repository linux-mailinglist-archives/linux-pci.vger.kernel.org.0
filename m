Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58AAB30E0B8
	for <lists+linux-pci@lfdr.de>; Wed,  3 Feb 2021 18:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbhBCRQU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Feb 2021 12:16:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbhBCRQT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Feb 2021 12:16:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8B4C061573;
        Wed,  3 Feb 2021 09:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YmKmmagLDCrQhzRpPfDJ+a00KLQE0WO4rpCVn+BQlfs=; b=e7DnxtuelhIqa4xqq/20eW5NIV
        f6NQ/p3AbDn7kMc1Eh5KhHWRPFOR3pB6zqYoAYD01L0UpUijgN/V1I/HVrmG1epr54eKrvFTrFvaH
        65Q6rWhaCSUMyXUU8/OJ+Xzy1MrM/m2n8WCwIrqqMtvwypMFmT4iX0Ed779qjPdOrBOSy850iA/YH
        I1CeYIgZonhF5NTYnX9OjXQwoXTFjawggcLcVigEjXEZVFf6hAaHXMrRXM22eOa9yDAKs9GjT1zKi
        JooUNm+8NvBvP1LfobZMZyTjuxdilI0DqLEbR5IdOARjbf89TUwLjJyxusqeB3ZLsnfeQnOABBYEq
        q8lU1bTA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l7Lkc-00HEut-2e; Wed, 03 Feb 2021 17:15:34 +0000
Date:   Wed, 3 Feb 2021 17:15:34 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-cxl@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Dan Williams <dan.j.williams@intel.com>,
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
Message-ID: <20210203171534.GB4104698@infradead.org>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-4-ben.widawsky@intel.com>
 <20210202181016.GD3708021@infradead.org>
 <20210202182418.3wyxnm6rqeoeclu2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202182418.3wyxnm6rqeoeclu2@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 02, 2021 at 10:24:18AM -0800, Ben Widawsky wrote:
> > > +	/* Cap 4000h - CXL_CAP_CAP_ID_MEMDEV */
> > > +	struct {
> > > +		void __iomem *regs;
> > > +	} mem;
> > 
> > This style looks massively obsfucated.  For one the comments look like
> > absolute gibberish, but also what is the point of all these anonymous
> > structures?
> 
> They're not anonymous, and their names are for the below register functions. The
> comments are connected spec reference 'Cap XXXXh' to definitions in cxl.h. I can
> articulate that if it helps.

But why no simply a

	void __iomem *mem_regs;

field vs the extra struct?

> The register space for CXL devices is a bit weird since it's all subdivided
> under 1 BAR for now. To clearly distinguish over the different subregions, these
> helpers exist. It's really easy to mess this up as the developer and I actually
> would disagree that it makes debugging quite a bit easier. It also gets more
> convoluted when you add the other 2 BARs which also each have their own
> subregions.
> 
> For example. if my mailbox function does:
> cxl_read_status_reg32(cxlm, CXLDEV_MB_CAPS_OFFSET);
> 
> instead of:
> cxl_read_mbox_reg32(cxlm, CXLDEV_MB_CAPS_OFFSET);
> 
> It's easier to spot than:
> readl(cxlm->regs + cxlm->status_offset + CXLDEV_MB_CAPS_OFFSET)

Well, what I think would be the most obvious is:

readl(cxlm->status_regs + CXLDEV_MB_CAPS_OFFSET);

> > > +	/* 8.2.8.4.3 */
> > 
> > ????
> > 
> 
> I had been trying to be consistent with 'CXL2.0 - ' in front of all spec
> reference. I obviously missed this one.

FYI, I generally find section names much easier to find than section
numbers.  Especially as the numbers change very frequently, some times
even for very minor updates to the spec.  E.g. in NVMe the numbers might
even change from NVMe 1.X to NVMe 1.Xa because an errata had to add
a clarification as its own section.
