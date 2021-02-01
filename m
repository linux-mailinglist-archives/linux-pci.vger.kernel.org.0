Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5AE30B057
	for <lists+linux-pci@lfdr.de>; Mon,  1 Feb 2021 20:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbhBAT14 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Feb 2021 14:27:56 -0500
Received: from mga01.intel.com ([192.55.52.88]:57606 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229555AbhBAT14 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Feb 2021 14:27:56 -0500
IronPort-SDR: 91DOs/c9+6ccIrtarMfJpO2kpUbYKL87kd+lqibePMcI/By7ZPUU9cFWHbB5DrsGGizdzBGfxD
 HbJijmptH1Xw==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="199641575"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="199641575"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 11:27:10 -0800
IronPort-SDR: Ar5npZIlmRyHOQSbD4WFo7BWVfXRSQKlTGiCVd73BlEHcqRFpJZVT35dVyiUYoiQkJZUvgY63t
 /fFyaLde9z+Q==
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="355891726"
Received: from jambrizm-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.133.15])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 11:27:09 -0800
Date:   Mon, 1 Feb 2021 11:27:08 -0800
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
Subject: Re: [PATCH 09/14] cxl/mem: Add a "RAW" send command
Message-ID: <20210201192708.5cvyecbcdrwx77de@intel.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-10-ben.widawsky@intel.com>
 <20210201182400.GK197521@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201182400.GK197521@fedora>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-02-01 13:24:00, Konrad Rzeszutek Wilk wrote:
> On Fri, Jan 29, 2021 at 04:24:33PM -0800, Ben Widawsky wrote:
> > The CXL memory device send interface will have a number of supported
> > commands. The raw command is not such a command. Raw commands allow
> > userspace to send a specified opcode to the underlying hardware and
> > bypass all driver checks on the command. This is useful for a couple of
> > usecases, mainly:
> > 1. Undocumented vendor specific hardware commands
> > 2. Prototyping new hardware commands not yet supported by the driver
> 
> This sounds like a recipe for ..
> 
> In case you really really want this may I recommend you do two things:
> 
> - Wrap this whole thing with #ifdef
>   CONFIG_CXL_DEBUG_THIS_WILL_DESTROY_YOUR_LIFE
> 
>  (or something equivalant to make it clear this should never be
>   enabled in production kernels).
> 
>  - Add a nice big fat printk in dmesg telling the user that they
>    are creating a unstable parallel universe that will lead to their
>    blood pressure going sky-high, or perhaps something more professional
>    sounding.
> 
> - Rethink this. Do you really really want to encourage vendors
>   to use this raw API instead of them using the proper APIs?

Again, the ideal is proper APIs. Barring that they get a WARN, and a taint if
they use the raw commands.

> 
> > 
> > While this all sounds very powerful it comes with a couple of caveats:
> > 1. Bug reports using raw commands will not get the same level of
> >    attention as bug reports using supported commands (via taint).
> > 2. Supported commands will be rejected by the RAW command.
> > 
> > With this comes new debugfs knob to allow full access to your toes with
> > your weapon of choice.
> 
> Problem is that debugfs is no longer "debug" but is enabled in
> production kernel.

I don't see this as my problem. Again, they've been WARNed and tainted. If they
want to do this, that's their business. They will be asked to reproduce without
RAW if they file a bug report.

