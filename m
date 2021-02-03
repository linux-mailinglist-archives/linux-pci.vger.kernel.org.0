Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E5D30E0BA
	for <lists+linux-pci@lfdr.de>; Wed,  3 Feb 2021 18:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbhBCRQz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Feb 2021 12:16:55 -0500
Received: from mga18.intel.com ([134.134.136.126]:19332 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231794AbhBCRQx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Feb 2021 12:16:53 -0500
IronPort-SDR: pnXZrjrBTEkyD7ChDcnOdpHCiy1/Zal0oGummYcTfYB4DgojkKHtl4ousjbhsgt2pgM8PA/Y3G
 W2HLRiEazzug==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="168761297"
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="168761297"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 09:16:12 -0800
IronPort-SDR: kRBAlNWa/d0or8aMCNCiw4lcmGHwaVitVviGAbiEXOCLh21PNebMsCUDBPD4l5Wt+xpTd8MMkB
 kSdrJB4e6+WQ==
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="433497230"
Received: from lrenaud-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.131.246])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 09:16:11 -0800
Date:   Wed, 3 Feb 2021 09:16:10 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-cxl@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Jon Masters <jcm@jonmasters.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        daniel.lll@alibaba-inc.com,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>
Subject: Re: [PATCH 13/14] cxl/mem: Add limited Get Log command (0401h)
Message-ID: <20210203171610.2y2x4krijol5dvkk@intel.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-14-ben.widawsky@intel.com>
 <20210201182848.GL197521@fedora>
 <20210202235103.v36v3znh5tsi4g5x@intel.com>
 <CAPcyv4i3MMY=WExfvcPFYiJkHoM_UeZ63ORZqi0Vbm76JapS8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4i3MMY=WExfvcPFYiJkHoM_UeZ63ORZqi0Vbm76JapS8A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-02-02 15:57:03, Dan Williams wrote:
> On Tue, Feb 2, 2021 at 3:51 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > On 21-02-01 13:28:48, Konrad Rzeszutek Wilk wrote:
> > > On Fri, Jan 29, 2021 at 04:24:37PM -0800, Ben Widawsky wrote:
> > > > The Get Log command returns the actual log entries that are advertised
> > > > via the Get Supported Logs command (0400h). CXL device logs are selected
> > > > by UUID which is part of the CXL spec. Because the driver tries to
> > > > sanitize what is sent to hardware, there becomes a need to restrict the
> > > > types of logs which can be accessed by userspace. For example, the
> > > > vendor specific log might only be consumable by proprietary, or offline
> > > > applications, and therefore a good candidate for userspace.
> > > >
> > > > The current driver infrastructure does allow basic validation for all
> > > > commands, but doesn't inspect any of the payload data. Along with Get
> > > > Log support comes new infrastructure to add a hook for payload
> > > > validation. This infrastructure is used to filter out the CEL UUID,
> > > > which the userspace driver doesn't have business knowing, and taints on
> > > > invalid UUIDs being sent to hardware.
> > >
> > > Perhaps a better option is to reject invalid UUIDs?
> > >
> > > And if you really really want to use invalid UUIDs then:
> > >
> > > 1) Make that code wrapped in CONFIG_CXL_DEBUG_THIS_IS_GOING_TO..?
> > >
> > > 2) Wrap it with lockdown code so that you can't do this at all
> > >    when in LOCKDOWN_INTEGRITY or such?
> > >
> >
> > The commit message needs update btw as CEL is allowed in the latest rev of the
> > patches.
> >
> > We could potentially combine this with the now added (in a branch) CONFIG_RAW
> > config option. Indeed I think that makes sense. Dan, thoughts?
> 
> Yeah, unknown UUIDs blocking is the same risk as raw commands as a
> vendor can trigger any behavior they want. A "CONFIG_RAW depends on
> !CONFIG_INTEGRITY" policy sounds reasonable as well.

What about LOCKDOWN_NONE though? I think we need something runtime for this.

Can we summarize the CONFIG options here?

CXL_MEM_INSECURE_DEBUG // no change
CXL_MEM_RAW_COMMANDS // if !security_locked_down(LOCKDOWN_NONE)

bool cxl_unsafe()
{
#ifndef CXL_MEM_RAW_COMMANDS
	return false;
#else
	return !security_locked_down(LOCKDOWN_NONE);
#endif
}

---

Did I get that right?
