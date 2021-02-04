Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C70F930F64E
	for <lists+linux-pci@lfdr.de>; Thu,  4 Feb 2021 16:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237335AbhBDPae (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Feb 2021 10:30:34 -0500
Received: from mga01.intel.com ([192.55.52.88]:24482 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237164AbhBDP3q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Feb 2021 10:29:46 -0500
IronPort-SDR: bUN6V2kV8PHVnv6VaDvCBP+aKJeCFaRSGUr302Rh8UZTSW2ykZwjjy2iZEUewGr7E8pKgUE32C
 nqxPGvyLbhJg==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="200252103"
X-IronPort-AV: E=Sophos;i="5.79,401,1602572400"; 
   d="scan'208";a="200252103"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 07:29:05 -0800
IronPort-SDR: e/5p4pSuQmOb/MbMZ2Wp1tEb+Ne2uaNCe7q0PWUrRotDCKEL57esF7lmORz7DWpIeTm1AgiK/R
 1fiQGYbuvEGA==
X-IronPort-AV: E=Sophos;i="5.79,401,1602572400"; 
   d="scan'208";a="415207885"
Received: from jguillor-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.133.14])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 07:29:03 -0800
Date:   Thu, 4 Feb 2021 07:29:01 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
        Linux ACPI <linux-acpi@vger.kernel.org>,
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
Message-ID: <20210204152901.pzjnyr64xlvo6yup@intel.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-4-ben.widawsky@intel.com>
 <20210202181016.GD3708021@infradead.org>
 <20210202182418.3wyxnm6rqeoeclu2@intel.com>
 <20210203171534.GB4104698@infradead.org>
 <20210203172342.fpn5vm4xj2xwh6fq@intel.com>
 <CAPcyv4hvFjs=QqmUYqPipuaLoFiZ-dr6qVhqbDupWuKTw3QDkg@mail.gmail.com>
 <20210204071646.GA122880@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204071646.GA122880@infradead.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-02-04 07:16:46, Christoph Hellwig wrote:
> On Wed, Feb 03, 2021 at 01:23:31PM -0800, Dan Williams wrote:
> > > I'd prefer to keep the helpers for now as I do find them helpful, and so far
> > > nobody else who has touched the code has complained. If you feel strongly, I
> > > will change it.
> > 
> > After seeing the options, I think I'd prefer to not have to worry what
> > extra magic is happening with cxl_read_mbox_reg32()
> > 
> > cxl_read_mbox_reg32(cxlm, CXLDEV_MB_CAPS_OFFSET);
> > 
> > readl(cxlm->mbox_regs + CXLDEV_MB_CAPS_OFFSET);
> > 
> > The latter is both shorter and more idiomatic.
> 
> Same here.  That being said I know some driver maintainers like
> wrappers, my real main irk was the macro magic to generate them.

I think the wrapper is often used as a means of trying to have cross OS
compatibility to some degree. Just to be clear, that was *not* the purpose here.

Stating I disagree for posterity, I'll begin reworking this code and it will be
changed for v2.

Thanks.
Ben
