Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390A731D029
	for <lists+linux-pci@lfdr.de>; Tue, 16 Feb 2021 19:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhBPSXP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Feb 2021 13:23:15 -0500
Received: from mga03.intel.com ([134.134.136.65]:7660 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229572AbhBPSXP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Feb 2021 13:23:15 -0500
IronPort-SDR: uy9mURPYEK2K8s76qyou7FNgC8upyus+CPoLEa0NdD3sziZBnd/wKNGM5B2HCh7bzy59pkiR2t
 9+TWNVfTZ9+Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9897"; a="183046842"
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="183046842"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 10:22:34 -0800
IronPort-SDR: 4edsNo68YZJHh5PbP7eS+pmfhYoJhfnup3fnRT5m214M7FcmcRemf2FXr8iSGFMYVKd2nnJfKt
 v5TeoRfQeaWA==
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="399610160"
Received: from dlbingha-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.134.31])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 10:22:33 -0800
Date:   Tue, 16 Feb 2021 10:22:32 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jon Masters <jcm@jonmasters.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v4 4/9] cxl/mem: Add basic IOCTL interface
Message-ID: <20210216182232.mmo5pwchongpmrau@intel.com>
References: <20210216014538.268106-1-ben.widawsky@intel.com>
 <20210216014538.268106-5-ben.widawsky@intel.com>
 <YCwK9SblYCh/1lZS@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCwK9SblYCh/1lZS@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-02-16 18:12:05, Al Viro wrote:
> On Mon, Feb 15, 2021 at 05:45:33PM -0800, Ben Widawsky wrote:
> > +	if (cmd->info.size_in) {
> > +		mbox_cmd.payload_in = kvzalloc(cmd->info.size_in, GFP_KERNEL);
> > +		if (!mbox_cmd.payload_in) {
> > +			rc = -ENOMEM;
> > +			goto out;
> > +		}
> > +
> > +		if (copy_from_user(mbox_cmd.payload_in,
> > +				   u64_to_user_ptr(in_payload),
> > +				   cmd->info.size_in)) {
> > +			rc = -EFAULT;
> > +			goto out;
> > +		}
> 
> Umm...  Do you need to open-code vmemdup_user()?  The only difference is
> GFP_KERNEL allocation instead of GFP_USER one, and the latter is arguably
> saner here...  Zeroing is definitely pointless - you either overwrite
> the entire buffer with copy_from_user(), or you fail and free the damn
> thing.

mea culpa. In fact it was previously memdup_user and Dan suggested I switch to
vmemdup_user.
https://lore.kernel.org/linux-cxl/CAPcyv4j+ixVgEo5q2OhV4kdkBZbnohZj3KDovReQJjPBsREugw@mail.gmail.com/


Will fix for the next version.

Thanks.
