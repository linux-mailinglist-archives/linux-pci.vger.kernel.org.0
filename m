Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E272B2F3A1C
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jan 2021 20:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436905AbhALTXn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Jan 2021 14:23:43 -0500
Received: from mga07.intel.com ([134.134.136.100]:24185 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436841AbhALTXm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Jan 2021 14:23:42 -0500
IronPort-SDR: YPT0wXNWfru/hvhwWhGJ3JLqK/xCZ6G6GCz32wV2T/sopgOWSrHH4pX1G5jn4vmi26fiNTDBZb
 1ZUinCcYTyng==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="242166399"
X-IronPort-AV: E=Sophos;i="5.79,342,1602572400"; 
   d="scan'208";a="242166399"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 11:23:01 -0800
IronPort-SDR: Di3yZCEWVNme9WZglDAaNAzcqXmxj2/R2QhYFms0cY8D57LS9jw+s5gEJwPey/5COoXz74C0n2
 ut9QLpKDLVEQ==
X-IronPort-AV: E=Sophos;i="5.79,342,1602572400"; 
   d="scan'208";a="567618520"
Received: from reyesjon-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.129.71])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 11:23:01 -0800
Date:   Tue, 12 Jan 2021 11:22:59 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jon Masters <jcm@jonmasters.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        daniel.lll@alibaba-inc.com
Subject: Re: [RFC PATCH v3 06/16] cxl/mem: Find device capabilities
Message-ID: <20210112192259.2fnvlv2bmwkhd52s@intel.com>
References: <20210111225121.820014-1-ben.widawsky@intel.com>
 <20210111225121.820014-7-ben.widawsky@intel.com>
 <20210112191744.00007d61@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112191744.00007d61@Huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-01-12 19:17:44, Jonathan Cameron wrote:
> On Mon, 11 Jan 2021 14:51:10 -0800
> Ben Widawsky <ben.widawsky@intel.com> wrote:
> 
> > CXL devices contain an array of capabilities that describe the
> > interactions software can have with the device or firmware running on
> > the device. A CXL compliant device must implement the device status and
> > the mailbox capability. A CXL compliant memory device must implement the
> > memory device capability.
> > 
> > Each of the capabilities can [will] provide an offset within the MMIO
> > region for interacting with the CXL device.
> > 
> > For more details see 8.2.8 of the CXL 2.0 specification.
> > 
> > Link: Link: https://www.computeexpresslink.org/download-the-specification
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> 
> 
> ...
> 
> >  /**
> >   * cxl_mem_create() - Create a new &struct cxl_mem.
> >   * @pdev: The pci device associated with the new &struct cxl_mem.
> > @@ -129,8 +214,20 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  	if (rc)
> >  		return rc;
> >  
> > +	rc = cxl_mem_setup_regs(cxlm);
> > +	if (rc)
> > +		goto err;
> > +
> > +	rc = cxl_mem_setup_mailbox(cxlm);
> > +	if (rc)
> > +		goto err;
> > +
> >  	pci_set_drvdata(pdev, cxlm);
> >  	return 0;
> > +
> > +err:
> > +	kfree(cxlm);
> 
> From previous patch that was created using devm_kzalloc in which case
> this free just introduced a double free if you hit this error path.
> Having go rid of that you can do direct returns instead of goto.

Ah okay. Ignore my last email then. I admit I looked really hard to figure out
how it ultimately gets freed and couldn't convince myself it does.

If someone more familiar with devm says it just works, then I'll rip out all of
remove (as it was in v2).

Dan did fix this all up for me previously and I regretfully undid it.

> 
> 
> > +	return rc;
> >  }
> >  
> >  static void cxl_mem_remove(struct pci_dev *pdev)
> 
