Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3724593FF
	for <lists+linux-pci@lfdr.de>; Mon, 22 Nov 2021 18:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240252AbhKVRff (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Nov 2021 12:35:35 -0500
Received: from mga01.intel.com ([192.55.52.88]:54350 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234361AbhKVRff (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Nov 2021 12:35:35 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="258672698"
X-IronPort-AV: E=Sophos;i="5.87,255,1631602800"; 
   d="scan'208";a="258672698"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 09:32:28 -0800
X-IronPort-AV: E=Sophos;i="5.87,255,1631602800"; 
   d="scan'208";a="508636727"
Received: from wqiu6-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.143.45])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 09:32:27 -0800
Date:   Mon, 22 Nov 2021 09:32:26 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 07/23] cxl/pci: Add new DVSEC definitions
Message-ID: <20211122173226.f72gy2ipbf7awuqw@intel.com>
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
 <20211120000250.1663391-8-ben.widawsky@intel.com>
 <20211122152224.0000467e@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122152224.0000467e@Huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-11-22 15:22:24, Jonathan Cameron wrote:
> On Fri, 19 Nov 2021 16:02:34 -0800
> Ben Widawsky <ben.widawsky@intel.com> wrote:
> 
> > While the new definitions are yet necessary at this point, they are
> > introduced at this point to help solidify the newly minted schema for
> > naming registers.
> > 
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huwei.com>

Thanks. I realized on re-reading this I didn't like the commit message. I
reworded to this:

While the new definitions are not yet necessary at this point, they are
introduced to help solidify the newly minted schema for naming
registers.

Please let me know if you'd like me to drop your reviewed-by tag.

> 
> > 
> > ---
> > This was split from
> > https://lore.kernel.org/linux-cxl/20211103170552.55ae5u7uvurkync6@intel.com/T/#u
> > per Dan's request.
> > ---
> >  drivers/cxl/pci.h | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> > 
> > diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
> > index 29b8eaef3a0a..8ae2b4adc59d 100644
> > --- a/drivers/cxl/pci.h
> > +++ b/drivers/cxl/pci.h
> > @@ -16,6 +16,21 @@
> >  /* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
> >  #define CXL_DVSEC_PCIE_DEVICE					0
> >  
> > +/* CXL 2.0 8.1.4: Non-CXL Function Map DVSEC */
> > +#define CXL_DVSEC_FUNCTION_MAP					2
> > +
> > +/* CXL 2.0 8.1.5: CXL 2.0 Extensions DVSEC for Ports */
> > +#define CXL_DVSEC_PORT_EXTENSIONS				3
> > +
> > +/* CXL 2.0 8.1.6: GPF DVSEC for CXL Port */
> > +#define CXL_DVSEC_PORT_GPF					4
> > +
> > +/* CXL 2.0 8.1.7: GPF DVSEC for CXL Device */
> > +#define CXL_DVSEC_DEVICE_GPF					5
> > +
> > +/* CXL 2.0 8.1.8: PCIe DVSEC for Flex Bus Port */
> > +#define CXL_DVSEC_PCIE_FLEXBUS_PORT				7
> > +
> >  /* CXL 2.0 8.1.9: Register Locator DVSEC */
> >  #define CXL_DVSEC_REG_LOCATOR					8
> >  #define   CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET			0xC
> 
