Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAE3130AF84
	for <lists+linux-pci@lfdr.de>; Mon,  1 Feb 2021 19:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbhBAShQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Feb 2021 13:37:16 -0500
Received: from mga12.intel.com ([192.55.52.136]:30823 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232747AbhBASfk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Feb 2021 13:35:40 -0500
IronPort-SDR: eb5ne3CQoN6MJZEmWUYCu0+ivqgwXhPk3P+3t5zjksACCsFYrbz7DQf/vSuJQoRyLCIpWLKcgX
 Wqic+wUlPvBg==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="159899885"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="159899885"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 10:34:58 -0800
IronPort-SDR: 2nH8t8/c+4stZ/sLd9CRvDKJQVvEtoDO5fWXWNPS17Xeu0Z+5yQgq5tPL/lE+iYxcH8yEzg95U
 mZhVmj6F73ng==
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="371650563"
Received: from jambrizm-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.133.15])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 10:34:57 -0800
Date:   Mon, 1 Feb 2021 10:34:55 -0800
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
Subject: Re: [PATCH 08/14] taint: add taint for direct hardware access
Message-ID: <20210201183455.3dndfwyswwvs2dlm@intel.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-9-ben.widawsky@intel.com>
 <20210201181845.GJ197521@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201181845.GJ197521@fedora>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-02-01 13:18:45, Konrad Rzeszutek Wilk wrote:
> On Fri, Jan 29, 2021 at 04:24:32PM -0800, Ben Widawsky wrote:
> > For drivers that moderate access to the underlying hardware it is
> > sometimes desirable to allow userspace to bypass restrictions. Once
> > userspace has done this, the driver can no longer guarantee the sanctity
> > of either the OS or the hardware. When in this state, it is helpful for
> > kernel developers to be made aware (via this taint flag) of this fact
> > for subsequent bug reports.
> > 
> > Example usage:
> > - Hardware xyzzy accepts 2 commands, waldo and fred.
> > - The xyzzy driver provides an interface for using waldo, but not fred.
> > - quux is convinced they really need the fred command.
> > - xyzzy driver allows quux to frob hardware to initiate fred.
> 
> Would it not be easier to _not_ frob the hardware for fred-operation?
> Aka not implement it or just disallow in the first place?

Yeah. So the idea is you either are in a transient phase of the command and some
future kernel will have real support for fred - or a vendor is being short
sighted and not adding support for fred.

> 
> 
> >   - kernel gets tainted.
> > - turns out fred command is borked, and scribbles over memory.
> > - developers laugh while closing quux's subsequent bug report.
> 
> Yeah good luck with that theory in-the-field. The customer won't
> care about this and will demand a solution for doing fred-operation.
> 
> Just easier to not do fred-operation in the first place,no?

The short answer is, in an ideal world you are correct. See nvdimm as an example
of the real world.

The longer answer. Unless we want to wait until we have all the hardware we're
ever going to see, it's impossible to have a fully baked, and validated
interface. The RAW interface is my admission that I make no guarantees about
being able to provide the perfect interface and giving the power back to the
hardware vendors and their driver writers.

As an example, suppose a vendor shipped a device with their special vendor
opcode. They can enable their customers to use that opcode on any driver
version. That seems pretty powerful and worthwhile to me.

Or a more realistic example, we ship a driver that adds a command which is
totally broken. Customers can utilize the RAW interface until it gets fixed in a
subsequent release which might be quite a ways out.

I'll say the RAW interface isn't an encouraged usage, but it's one that I expect
to be needed, and if it's not we can always try to kill it later. If nobody is
actually using it, nobody will complain, right :D
