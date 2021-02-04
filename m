Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAEF830FC14
	for <lists+linux-pci@lfdr.de>; Thu,  4 Feb 2021 20:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239243AbhBDS5s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Feb 2021 13:57:48 -0500
Received: from mga09.intel.com ([134.134.136.24]:2119 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239410AbhBDS4d (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Feb 2021 13:56:33 -0500
IronPort-SDR: OOLtcW5BNSMu6RWIunb+wEeiCXaWGZREjqp0sfGc8J2FRYMgY2l0sqoqJwuW0xXhZbRj+429cN
 CX/3NtrKOu5g==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="181455269"
X-IronPort-AV: E=Sophos;i="5.81,153,1610438400"; 
   d="scan'208";a="181455269"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 10:55:43 -0800
IronPort-SDR: 9kuExkt4nlo9ze0QjfV35lBjvzzDxy7AIn6Rd/7Gtw34q0j+7KGDkY/Ai8mQRDq1jem7DKVmTh
 NU1MVdRLFXUQ==
X-IronPort-AV: E=Sophos;i="5.81,153,1610438400"; 
   d="scan'208";a="393322655"
Received: from jguillor-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.133.14])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 10:55:42 -0800
Date:   Thu, 4 Feb 2021 10:55:40 -0800
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
Message-ID: <20210204185540.oxwurggwd7a37a2o@intel.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-14-ben.widawsky@intel.com>
 <20210201182848.GL197521@fedora>
 <20210202235103.v36v3znh5tsi4g5x@intel.com>
 <CAPcyv4i3MMY=WExfvcPFYiJkHoM_UeZ63ORZqi0Vbm76JapS8A@mail.gmail.com>
 <20210203171610.2y2x4krijol5dvkk@intel.com>
 <YBroGrVd76p+BF0v@Konrads-MacBook-Pro.local>
 <CAPcyv4hMM9isho5d8wS=5vtP0NxE5KA0HrMp+Bx2PZhPDrrWsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hMM9isho5d8wS=5vtP0NxE5KA0HrMp+Bx2PZhPDrrWsg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-02-03 12:31:00, Dan Williams wrote:
> On Wed, Feb 3, 2021 at 10:16 AM Konrad Rzeszutek Wilk
> <konrad.wilk@oracle.com> wrote:
> >
> > On Wed, Feb 03, 2021 at 09:16:10AM -0800, Ben Widawsky wrote:
> > > On 21-02-02 15:57:03, Dan Williams wrote:
> > > > On Tue, Feb 2, 2021 at 3:51 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > > > >
> > > > > On 21-02-01 13:28:48, Konrad Rzeszutek Wilk wrote:
> > > > > > On Fri, Jan 29, 2021 at 04:24:37PM -0800, Ben Widawsky wrote:
> > > > > > > The Get Log command returns the actual log entries that are advertised
> > > > > > > via the Get Supported Logs command (0400h). CXL device logs are selected
> > > > > > > by UUID which is part of the CXL spec. Because the driver tries to
> > > > > > > sanitize what is sent to hardware, there becomes a need to restrict the
> > > > > > > types of logs which can be accessed by userspace. For example, the
> > > > > > > vendor specific log might only be consumable by proprietary, or offline
> > > > > > > applications, and therefore a good candidate for userspace.
> > > > > > >
> > > > > > > The current driver infrastructure does allow basic validation for all
> > > > > > > commands, but doesn't inspect any of the payload data. Along with Get
> > > > > > > Log support comes new infrastructure to add a hook for payload
> > > > > > > validation. This infrastructure is used to filter out the CEL UUID,
> > > > > > > which the userspace driver doesn't have business knowing, and taints on
> > > > > > > invalid UUIDs being sent to hardware.
> > > > > >
> > > > > > Perhaps a better option is to reject invalid UUIDs?
> > > > > >
> > > > > > And if you really really want to use invalid UUIDs then:
> > > > > >
> > > > > > 1) Make that code wrapped in CONFIG_CXL_DEBUG_THIS_IS_GOING_TO..?
> > > > > >
> > > > > > 2) Wrap it with lockdown code so that you can't do this at all
> > > > > >    when in LOCKDOWN_INTEGRITY or such?
> > > > > >
> > > > >
> > > > > The commit message needs update btw as CEL is allowed in the latest rev of the
> > > > > patches.
> > > > >
> > > > > We could potentially combine this with the now added (in a branch) CONFIG_RAW
> > > > > config option. Indeed I think that makes sense. Dan, thoughts?
> > > >
> > > > Yeah, unknown UUIDs blocking is the same risk as raw commands as a
> > > > vendor can trigger any behavior they want. A "CONFIG_RAW depends on
> > > > !CONFIG_INTEGRITY" policy sounds reasonable as well.
> > >
> > > What about LOCKDOWN_NONE though? I think we need something runtime for this.
> > >
> > > Can we summarize the CONFIG options here?
> > >
> > > CXL_MEM_INSECURE_DEBUG // no change
> > > CXL_MEM_RAW_COMMANDS // if !security_locked_down(LOCKDOWN_NONE)
> > >
> > > bool cxl_unsafe()
> >
> > Would it be better if this inverted? Aka cxl_safe()..
> > ?
> > > {
> > > #ifndef CXL_MEM_RAW_COMMANDS
> 
> nit use IS_ENABLED() if this function lives in a C file, or provide
> whole alternate static inline versions in a header gated by ifdefs.
> 

I had done this independently since... but agreed.

> > >       return false;
> > > #else
> > >       return !security_locked_down(LOCKDOWN_NONE);
> >
> > :thumbsup:
> >
> > (Naturally this would inverted if this was cxl_safe()).
> >
> >
> > > #endif
> > > }
> > >
> > > ---
> > >
> > > Did I get that right?
> >
> > :nods:
> 
> Looks good which means it's time to bikeshed the naming. I'd call it
> cxl_raw_allowed(). As "safety" isn't the only reason for blocking raw,
> it's also to corral the userspace api. I.e. things like enforcing
> security passphrase material through the Linux keys api.

It actually got pushed into cxl_mem_raw_command_allowed()

static bool cxl_mem_raw_command_allowed(u16 opcode)
{
        int i;

        if (!IS_ENABLED(CONFIG_CXL_MEM_RAW_COMMANDS))
                return false;

        if (security_locked_down(LOCKDOWN_NONE))
                return false;

        if (raw_allow_all)
                return true;

        if (is_security_command(opcode))
                return false;

        for (i = 0; i < ARRAY_SIZE(disabled_raw_commands); i++)
                if (disabled_raw_commands[i] == opcode)
                        return false;

        return true;
}

That work for you?
