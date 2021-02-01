Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6412030AD34
	for <lists+linux-pci@lfdr.de>; Mon,  1 Feb 2021 17:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbhBAQ5N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Feb 2021 11:57:13 -0500
Received: from mga17.intel.com ([192.55.52.151]:37074 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231929AbhBAQyj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Feb 2021 11:54:39 -0500
IronPort-SDR: puVpU2U83B+BucCklR/QKoplpkxfMK/0uevQChpr5jqdIIT5dFicaEy3jPzZCrFKNtbx99mcO+
 2LaP9ocHyLRQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="160481762"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="160481762"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 08:53:54 -0800
IronPort-SDR: yFSgEt+mhM9fBwFjcN56znWBQoTvbYdQbzSwOQKVq4azQE//8pACLBc8Kf3fRvPDCMHvmBG5Zs
 xWa6SNj8pZKA==
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="577882409"
Received: from jambrizm-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.133.15])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 08:53:53 -0800
Date:   Mon, 1 Feb 2021 08:53:52 -0800
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
Message-ID: <20210201165352.wi7tzpnd4ymxlms4@intel.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-4-ben.widawsky@intel.com>
 <234711bf-c03f-9aca-e0b5-ca677add3ea@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <234711bf-c03f-9aca-e0b5-ca677add3ea@google.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-01-30 15:51:49, David Rientjes wrote:
> On Fri, 29 Jan 2021, Ben Widawsky wrote:
> 
> > +static int cxl_mem_setup_mailbox(struct cxl_mem *cxlm)
> > +{
> > +	const int cap = cxl_read_mbox_reg32(cxlm, CXLDEV_MB_CAPS_OFFSET);
> > +
> > +	cxlm->mbox.payload_size =
> > +		1 << CXL_GET_FIELD(cap, CXLDEV_MB_CAP_PAYLOAD_SIZE);
> > +
> > +	/* 8.2.8.4.3 */
> > +	if (cxlm->mbox.payload_size < 256) {
> > +		dev_err(&cxlm->pdev->dev, "Mailbox is too small (%zub)",
> > +			cxlm->mbox.payload_size);
> > +		return -ENXIO;
> > +	}
> 
> Any reason not to check cxlm->mbox.payload_size > (1 << 20) as well and 
> return ENXIO if true?

If some crazy vendor wanted to ship a mailbox larger than 1M, why should the
driver not allow it?

I'm open to changing it, it just seems like a larger mailbox wouldn't be fatal.
