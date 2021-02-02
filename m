Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B40D130C9BE
	for <lists+linux-pci@lfdr.de>; Tue,  2 Feb 2021 19:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbhBBS1X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Feb 2021 13:27:23 -0500
Received: from mga11.intel.com ([192.55.52.93]:64452 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238289AbhBBSZE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Feb 2021 13:25:04 -0500
IronPort-SDR: e23cfKNk14nG+y+GcyHumJmOm8EhyYG6TNHiBXm9to+MOhS9nO8oLkKqcfi0UubNcoZ/kkYyzC
 goFY6vFohgZw==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="177397682"
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="177397682"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 10:24:21 -0800
IronPort-SDR: rlVOr+F59Dm93VedZPbkRLa3d7C9TiDXpbtmq3k0WVsbXYLMphar3MgWZ1t5VZzywr2UW91/TO
 FbLUWuM8GdVQ==
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="391610338"
Received: from joship1x-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.131.202])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 10:24:20 -0800
Date:   Tue, 2 Feb 2021 10:24:18 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
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
Message-ID: <20210202182418.3wyxnm6rqeoeclu2@intel.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-4-ben.widawsky@intel.com>
 <20210202181016.GD3708021@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202181016.GD3708021@infradead.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-02-02 18:10:16, Christoph Hellwig wrote:
> On Fri, Jan 29, 2021 at 04:24:27PM -0800, Ben Widawsky wrote:
> >  #ifndef __CXL_H__
> >  #define __CXL_H__
> >  
> > +#include <linux/bitfield.h>
> > +#include <linux/bitops.h>
> > +#include <linux/io.h>
> > +
> > +#define CXL_SET_FIELD(value, field)                                            \
> > +	({                                                                     \
> > +		WARN_ON(!FIELD_FIT(field##_MASK, value));                      \
> > +		FIELD_PREP(field##_MASK, value);                               \
> > +	})
> > +
> > +#define CXL_GET_FIELD(word, field) FIELD_GET(field##_MASK, word)
> 
> This looks like some massive obsfucation.  What is the intent
> here?
> 

I will drop these. I don't recall why I did this to be honest.

> > +	/* Cap 0001h - CXL_CAP_CAP_ID_DEVICE_STATUS */
> > +	struct {
> > +		void __iomem *regs;
> > +	} status;
> > +
> > +	/* Cap 0002h - CXL_CAP_CAP_ID_PRIMARY_MAILBOX */
> > +	struct {
> > +		void __iomem *regs;
> > +		size_t payload_size;
> > +	} mbox;
> > +
> > +	/* Cap 4000h - CXL_CAP_CAP_ID_MEMDEV */
> > +	struct {
> > +		void __iomem *regs;
> > +	} mem;
> 
> This style looks massively obsfucated.  For one the comments look like
> absolute gibberish, but also what is the point of all these anonymous
> structures?

They're not anonymous, and their names are for the below register functions. The
comments are connected spec reference 'Cap XXXXh' to definitions in cxl.h. I can
articulate that if it helps.

> 
> > +#define cxl_reg(type)                                                          \
> > +	static inline void cxl_write_##type##_reg32(struct cxl_mem *cxlm,      \
> > +						    u32 reg, u32 value)        \
> > +	{                                                                      \
> > +		void __iomem *reg_addr = cxlm->type.regs;                      \
> > +		writel(value, reg_addr + reg);                                 \
> > +	}                                                                      \
> > +	static inline void cxl_write_##type##_reg64(struct cxl_mem *cxlm,      \
> > +						    u32 reg, u64 value)        \
> > +	{                                                                      \
> > +		void __iomem *reg_addr = cxlm->type.regs;                      \
> > +		writeq(value, reg_addr + reg);                                 \
> > +	}                                                                      \
> 
> What is the value add of all this obsfucation over the trivial
> calls to the write*/read* functions, possible with a locally
> declarate "void __iomem *" variable in the callers like in all
> normall drivers?  Except for making the life of the poor soul trying
> to debug this code some time in the future really hard, of course.
> 

The register space for CXL devices is a bit weird since it's all subdivided
under 1 BAR for now. To clearly distinguish over the different subregions, these
helpers exist. It's really easy to mess this up as the developer and I actually
would disagree that it makes debugging quite a bit easier. It also gets more
convoluted when you add the other 2 BARs which also each have their own
subregions.

For example. if my mailbox function does:
cxl_read_status_reg32(cxlm, CXLDEV_MB_CAPS_OFFSET);

instead of:
cxl_read_mbox_reg32(cxlm, CXLDEV_MB_CAPS_OFFSET);

It's easier to spot than:
readl(cxlm->regs + cxlm->status_offset + CXLDEV_MB_CAPS_OFFSET)


> > +	/* 8.2.8.4.3 */
> 
> ????
> 

I had been trying to be consistent with 'CXL2.0 - ' in front of all spec
reference. I obviously missed this one.

