Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B707B30AE6F
	for <lists+linux-pci@lfdr.de>; Mon,  1 Feb 2021 18:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbhBARve (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Feb 2021 12:51:34 -0500
Received: from mga18.intel.com ([134.134.136.126]:1039 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232434AbhBARv2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Feb 2021 12:51:28 -0500
IronPort-SDR: o0ynsxVmxUQiox3lOqK6ZMvrb1mku85W86+fZTRH8hO+8QilqN8CySbtMRJbNVaCCRAAIj/79G
 kqOuQmlvmrNQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="168405657"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="168405657"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 09:50:43 -0800
IronPort-SDR: vwkcuvc/K6/0HYC/dswoUfGzMUtTJ5RCPPD/dQMvTDarAcRp8pDLdNzcYlXlojKNViGybtDGXQ
 /w90aWaQLK/g==
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="371637150"
Received: from jambrizm-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.133.15])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 09:50:42 -0800
Date:   Mon, 1 Feb 2021 09:50:41 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
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
Message-ID: <20210201175041.qs56jk5tdbgn2zia@intel.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-4-ben.widawsky@intel.com>
 <20210201174136.GF197521@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201174136.GF197521@fedora>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-02-01 12:41:36, Konrad Rzeszutek Wilk wrote:
> > +static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
> > +{
> > +	struct device *dev = &cxlm->pdev->dev;
> > +	int cap, cap_count;
> > +	u64 cap_array;
> > +
> > +	cap_array = readq(cxlm->regs + CXLDEV_CAP_ARRAY_OFFSET);
> > +	if (CXL_GET_FIELD(cap_array, CXLDEV_CAP_ARRAY_ID) != CXLDEV_CAP_ARRAY_CAP_ID)
> > +		return -ENODEV;
> > +
> > +	cap_count = CXL_GET_FIELD(cap_array, CXLDEV_CAP_ARRAY_COUNT);
> > +
> > +	for (cap = 1; cap <= cap_count; cap++) {
> > +		void __iomem *register_block;
> > +		u32 offset;
> > +		u16 cap_id;
> > +
> > +		cap_id = readl(cxlm->regs + cap * 0x10) & 0xffff;
> > +		offset = readl(cxlm->regs + cap * 0x10 + 0x4);
> > +		register_block = cxlm->regs + offset;
> > +
> > +		switch (cap_id) {
> > +		case CXLDEV_CAP_CAP_ID_DEVICE_STATUS:
> > +			dev_dbg(dev, "found Status capability (0x%x)\n",
> > +				offset);
> 
> That 80 character limit is no longer a requirement. Can you just make
> this one line? And perhaps change 'found' to 'Found' ?
> 

Funny that.
https://lore.kernel.org/linux-cxl/20201111073449.GA16235@infradead.org/

> > +			cxlm->status.regs = register_block;
> > +			break;
> > +		case CXLDEV_CAP_CAP_ID_PRIMARY_MAILBOX:
> > +			dev_dbg(dev, "found Mailbox capability (0x%x)\n",
> > +				offset);
> > +			cxlm->mbox.regs = register_block;
> > +			break;
> > +		case CXLDEV_CAP_CAP_ID_SECONDARY_MAILBOX:
> > +			dev_dbg(dev,
> > +				"found Secondary Mailbox capability (0x%x)\n",
> > +				offset);
> > +			break;
> > +		case CXLDEV_CAP_CAP_ID_MEMDEV:
> > +			dev_dbg(dev, "found Memory Device capability (0x%x)\n",
> > +				offset);
> > +			cxlm->mem.regs = register_block;
> > +			break;
> > +		default:
> > +			dev_warn(dev, "Unknown cap ID: %d (0x%x)\n", cap_id,
> > +				 offset);
> > +			break;
> > +		}
> > +	}
> > +
> > +	if (!cxlm->status.regs || !cxlm->mbox.regs || !cxlm->mem.regs) {
> > +		dev_err(dev, "registers not found: %s%s%s\n",
> > +			!cxlm->status.regs ? "status " : "",
> > +			!cxlm->mbox.regs ? "mbox " : "",
> > +			!cxlm->mem.regs ? "mem" : "");
> > +		return -ENXIO;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int cxl_mem_setup_mailbox(struct cxl_mem *cxlm)
> > +{
> > +	const int cap = cxl_read_mbox_reg32(cxlm, CXLDEV_MB_CAPS_OFFSET);
> > +
> > +	cxlm->mbox.payload_size =
> > +		1 << CXL_GET_FIELD(cap, CXLDEV_MB_CAP_PAYLOAD_SIZE);
> > +
> 
> I think the static analyzers are not going to be happy that you are not
> checking the value of `cap` before using it.
> 
> Perhaps you should check that first before doing the manipulations?
> 

I'm not following the request. CXL_GET_FIELD is just doing the shift and mask on
cap.

Can you explain what you're hoping to see?

> > +	/* 8.2.8.4.3 */
> > +	if (cxlm->mbox.payload_size < 256) {
> 
> #define for 256?
