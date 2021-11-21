Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7364581AA
	for <lists+linux-pci@lfdr.de>; Sun, 21 Nov 2021 04:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbhKUD6N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 20 Nov 2021 22:58:13 -0500
Received: from mga09.intel.com ([134.134.136.24]:31111 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229823AbhKUD6N (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 20 Nov 2021 22:58:13 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10174"; a="234462873"
X-IronPort-AV: E=Sophos;i="5.87,251,1631602800"; 
   d="scan'208";a="234462873"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2021 19:55:08 -0800
X-IronPort-AV: E=Sophos;i="5.87,251,1631602800"; 
   d="scan'208";a="606023328"
Received: from dass-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.139.144])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2021 19:55:08 -0800
Date:   Sat, 20 Nov 2021 19:55:06 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 22/23] cxl/mem: Introduce cxl_mem driver
Message-ID: <20211121035506.zvq6ebs4i6msbi22@intel.com>
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
 <20211120000250.1663391-23-ben.widawsky@intel.com>
 <8eece50a-ffc6-700a-1613-4d45de37bdd2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8eece50a-ffc6-700a-1613-4d45de37bdd2@infradead.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-11-19 16:40:09, Randy Dunlap wrote:
> On 11/19/21 4:02 PM, Ben Widawsky wrote:
> > diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> > index 3aeb33bba5a3..f5553443ba2a 100644
> > --- a/drivers/cxl/Kconfig
> > +++ b/drivers/cxl/Kconfig
> > @@ -30,6 +30,21 @@ config CXL_PCI
> >   	  If unsure say 'm'.
> > +config CXL_MEM
> > +	tristate "CXL.mem: Memory Devices"
> > +	default CXL_BUS
> > +        help
> > +          The CXL.mem protocol allows a device to act as a provider of
> > +	  "System RAM" and/or "Persistent Memory" that is fully coherent
> > +	  as if the memory was attached to the typical CPU memory controller.
> > +	  This is known as HDM "Host-managed Device Memory".
> > +
> > +	  Say 'y/m' to enable a driver that will attach to CXL.mem devices for
> > +	  memory expansion and control of HDM. See Chapter 9.13 in the CXL 2.0
> > +	  specification for a detailed description of HDM.
> > +
> > +	  If unsure say 'm'.
> 
> Hi Ben,
> 
> Both patch 20 and patch 22 add a "new" CXL_MEM config symbol.
> Is one of them a typo?
> 
> thanks.

Yep. Thank you. Fixed for v2 and I added a reported-by tag from you.

> -- 
> ~Randy
