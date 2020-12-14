Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B79072D9DB4
	for <lists+linux-pci@lfdr.de>; Mon, 14 Dec 2020 18:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440375AbgLNRa3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Dec 2020 12:30:29 -0500
Received: from mga02.intel.com ([134.134.136.20]:10234 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440371AbgLNRaW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Dec 2020 12:30:22 -0500
IronPort-SDR: PVLZGPFdq4PJf412lWWdnix0NxdteFphUlCx9TvlIcyqUgRSBP22vyHVzvvYyiu+2A7TrnJV7n
 /41niS17b8RA==
X-IronPort-AV: E=McAfee;i="6000,8403,9834"; a="161795988"
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; 
   d="scan'208";a="161795988"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2020 09:29:37 -0800
IronPort-SDR: D7pm080c5efPDR/a8PvPUF0giaJs4ugzNWCeyNqrCQ2Enl67OQUgyIgQ0AgmjwiZLYvrfprUlS
 r8BgWXEtOd/w==
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; 
   d="scan'208";a="411343436"
Received: from davidjor-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.136.237])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2020 09:29:36 -0800
Date:   Mon, 14 Dec 2020 09:29:35 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jon Masters <jcm@jonmasters.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH 09/14] cxl/mem: Add basic IOCTL interface
Message-ID: <20201214172935.efknefvqthp7ohcz@intel.com>
References: <20201209002418.1976362-1-ben.widawsky@intel.com>
 <20201209002418.1976362-10-ben.widawsky@intel.com>
 <8a252085-9dd9-6cf0-afad-a3ff63cf00d8@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a252085-9dd9-6cf0-afad-a3ff63cf00d8@infradead.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 20-12-09 19:32:19, Randy Dunlap wrote:
> On 12/8/20 4:24 PM, Ben Widawsky wrote:
> > +
> > +#define CXL_MEM_QUERY_COMMANDS _IOR('C', 1, struct cxl_mem_query_commands)
> 
> Hi,
> I could have missed it, but IOCTL major "numbers" (like 'C') should be
> listed in Documentation/userspace-api/ioctl/ioctl-number.rst.
> 
> 
> thanks.

I was unaware of this. Fixing for v3 without conflict.

Thanks.
Ben
