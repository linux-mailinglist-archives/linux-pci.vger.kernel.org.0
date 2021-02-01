Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58B4230B270
	for <lists+linux-pci@lfdr.de>; Mon,  1 Feb 2021 23:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbhBAV7l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Feb 2021 16:59:41 -0500
Received: from mga11.intel.com ([192.55.52.93]:27683 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229483AbhBAV7k (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Feb 2021 16:59:40 -0500
IronPort-SDR: eLCfoLDdhlos3b4Ao8YPdh7YE0U5HcJeMSsuNpbW0yTbF8HUs9lqBM7CHt/FLoah+Ctp4Kz51E
 rAh6t/0vLt0w==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="177250819"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="177250819"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 13:59:00 -0800
IronPort-SDR: cUakMoBV72iSYfI+WSrEd7FpIYVvNSS1Zk4TNcCOl/X1KpUNi9OWgJiq3b5Ab61Yomtwjg+dKq
 d8Gyng7Rrnuw==
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="354640426"
Received: from jambrizm-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.133.15])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 13:58:59 -0800
Date:   Mon, 1 Feb 2021 13:58:57 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     David Rientjes <rientjes@google.com>
Cc:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
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
Message-ID: <20210201215857.ud5cpg7hbxj2j5bx@intel.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-4-ben.widawsky@intel.com>
 <234711bf-c03f-9aca-e0b5-ca677add3ea@google.com>
 <20210201165352.wi7tzpnd4ymxlms4@intel.com>
 <32f33dd-97a-8b1c-d488-e5198a3d7748@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32f33dd-97a-8b1c-d488-e5198a3d7748@google.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-02-01 13:51:16, David Rientjes wrote:
> On Mon, 1 Feb 2021, Ben Widawsky wrote:
> 
> > On 21-01-30 15:51:49, David Rientjes wrote:
> > > On Fri, 29 Jan 2021, Ben Widawsky wrote:
> > > 
> > > > +static int cxl_mem_setup_mailbox(struct cxl_mem *cxlm)
> > > > +{
> > > > +	const int cap = cxl_read_mbox_reg32(cxlm, CXLDEV_MB_CAPS_OFFSET);
> > > > +
> > > > +	cxlm->mbox.payload_size =
> > > > +		1 << CXL_GET_FIELD(cap, CXLDEV_MB_CAP_PAYLOAD_SIZE);
> > > > +
> > > > +	/* 8.2.8.4.3 */
> > > > +	if (cxlm->mbox.payload_size < 256) {
> > > > +		dev_err(&cxlm->pdev->dev, "Mailbox is too small (%zub)",
> > > > +			cxlm->mbox.payload_size);
> > > > +		return -ENXIO;
> > > > +	}
> > > 
> > > Any reason not to check cxlm->mbox.payload_size > (1 << 20) as well and 
> > > return ENXIO if true?
> > 
> > If some crazy vendor wanted to ship a mailbox larger than 1M, why should the
> > driver not allow it?
> > 
> 
> Because the spec disallows it :)

I don't see it being the driver's responsibility to enforce spec correctness
though. In certain cases, I need to use the spec, like I have to pick /some/
mailbox timeout. For other cases... 

I'm not too familiar with what other similar drivers may or may not do in
situations like this. The current 256 limit is mostly a reflection of that being
too small to even support advertised mandatory commands. So things can't work in
that scenario, but things can work if they have a larger register size (so long
as the BAR advertises enough space).
