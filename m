Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73E130CA00
	for <lists+linux-pci@lfdr.de>; Tue,  2 Feb 2021 19:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238602AbhBBSfc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Feb 2021 13:35:32 -0500
Received: from mga02.intel.com ([134.134.136.20]:24260 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238751AbhBBSeU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Feb 2021 13:34:20 -0500
IronPort-SDR: xfxglwWbdwRYWyhqEiLLzWwXk5oStF3ynSCFlQCfqWDNs2O1TBJW0RREBu6VH2PNu9fq5rk+i4
 ZKsrGiBbKksg==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="168012528"
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="168012528"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 10:33:28 -0800
IronPort-SDR: o0BhQQsQFexfvQyPOkPHDvxmcu9hxi3ywGSD4mrPrneLs4gP1togqGK+AONy7stmmIWpDROh81
 OpG9MSEPKy+Q==
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="582136028"
Received: from joship1x-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.131.202])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 10:33:26 -0800
Date:   Tue, 2 Feb 2021 10:33:25 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-cxl@vger.kernel.org, kernel test robot <lkp@intel.com>,
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
Subject: Re: [PATCH 06/14] cxl/mem: Add basic IOCTL interface
Message-ID: <20210202183325.ls7o54zza4obw6df@intel.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-7-ben.widawsky@intel.com>
 <20210202181505.GF3708021@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202181505.GF3708021@infradead.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-02-02 18:15:05, Christoph Hellwig wrote:
> > +#if defined(__cplusplus)
> > +extern "C" {
> > +#endif
> 
> This has no business in a kernel header.

This was copypasta from DRM headers (which as you're probably aware wasn't
always part of the kernel)... It's my mistake and I will get rid of it.
