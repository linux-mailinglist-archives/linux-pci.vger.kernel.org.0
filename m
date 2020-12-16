Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB27D2DC7DC
	for <lists+linux-pci@lfdr.de>; Wed, 16 Dec 2020 21:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbgLPUmt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Dec 2020 15:42:49 -0500
Received: from mga03.intel.com ([134.134.136.65]:26387 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726979AbgLPUmt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Dec 2020 15:42:49 -0500
IronPort-SDR: QPD30WIQKrfJgosEkOHLaew8PMjHkRNoZplib9QY9/+37fhU+cChhY+8YCfQETsAN3dgIwHgPN
 PeF5ZlcnQbCQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9837"; a="175237331"
X-IronPort-AV: E=Sophos;i="5.78,425,1599548400"; 
   d="scan'208";a="175237331"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2020 12:42:07 -0800
IronPort-SDR: a1N5veaUEZSYSkyI6dbDQnr7U8r0v/vdWeIKvhMygGCuxuuB0VtYyvISwgHNU1GfpkxDG1wwGo
 jLHB4ak/king==
X-IronPort-AV: E=Sophos;i="5.78,425,1599548400"; 
   d="scan'208";a="369339256"
Received: from ticela-or-085.amr.corp.intel.com (HELO intel.com) ([10.252.135.213])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2020 12:42:06 -0800
Date:   Wed, 16 Dec 2020 12:42:05 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jon Masters <jcm@jonmasters.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH 11/14] cxl/mem: Add a "RAW" send command
Message-ID: <20201216204205.acum2sf652aspah3@intel.com>
References: <20201209002418.1976362-1-ben.widawsky@intel.com>
 <20201209002418.1976362-12-ben.widawsky@intel.com>
 <CAPcyv4hRJRP+55QHxQYsAoE7V601+YMWgtEvzLimKRO8b4Jrjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hRJRP+55QHxQYsAoE7V601+YMWgtEvzLimKRO8b4Jrjg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 20-12-09 14:38:49, Dan Williams wrote:
> On Tue, Dec 8, 2020 at 4:24 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > The CXL memory device send interface will have a number of supported
> > commands. The raw command is not such a command. Raw commands allow
> > userspace to send a specified opcode to the underlying hardware and
> > bypass all driver checks on the command. This is useful for a couple of
> > usecases, mainly:
> > 1. Undocumented vendor specific hardware commands
> > 2. Prototyping new hardware commands not yet supported by the driver
> >
> > While this all sounds very powerful it comes with a couple of caveats:
> > 1. Bug reports using raw commands will not get the same level of
> >    attention as bug reports using supported commands (via taint).
> > 2. Supported commands will be rejected by the RAW command.
> >
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > ---
> >  drivers/cxl/mem.c            | 32 ++++++++++++++++++++++++++++++++
> >  include/uapi/linux/cxl_mem.h | 14 ++++++++++++--
> >  2 files changed, 44 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > index 0bf03afc0c80..a2cea7ac7cc6 100644
> > --- a/drivers/cxl/mem.c
> > +++ b/drivers/cxl/mem.c
> > @@ -115,6 +115,7 @@ struct cxl_mem_command {
> >
> >  static struct cxl_mem_command mem_commands[] = {
> >         CXL_CMD(INVALID, NONE, 0, 0, "Reserved", false, 0),
> > +       CXL_CMD(RAW, TAINT, ~0, ~0, "Raw", true, 0),
> 
> Why is the taint indication in the ABI? It seems like it only needs to
> be documented.
> 

It's removed per the previous patch discussion.

> >  };
> >
> >  static int cxl_mem_wait_for_doorbell(struct cxl_mem *cxlm)
> > @@ -326,6 +327,20 @@ static int cxl_mem_count_commands(void)
> >         return n;
> >  };
> >
> > +static struct cxl_mem_command *cxl_mem_find_command(u16 opcode)
> > +{
> > +       int i;
> > +
> > +       for (i = 0; i < ARRAY_SIZE(mem_commands); i++) {
> > +               struct cxl_mem_command *c = &mem_commands[i];
> > +
> > +               if (c->opcode == opcode)
> > +                       return c;
> > +       }
> > +
> > +       return NULL;
> > +};
> > +
> >  /**
> >   * handle_mailbox_cmd_from_user() - Dispatch a mailbox command.
> >   * @cxlmd: The CXL memory device to communicate with.
> > @@ -421,6 +436,23 @@ static int cxl_validate_cmd_from_user(struct cxl_send_command __user *user_cmd,
> >         c = &mem_commands[cmd.id];
> >         info = &c->info;
> >
> > +       /* Checks are bypassed for raw commands but along comes the taint! */
> > +       if (cmd.id == CXL_MEM_COMMAND_ID_RAW) {
> > +               struct cxl_mem_command temp =
> > +                       CXL_CMD(RAW, NONE, cmd.size_in, cmd.size_out, "Raw",
> > +                               true, cmd.raw.opcode);
> 
> Oh, I thought CXL_CMD() was only used to populate the mem_commands
> array. Feels out of place to use it here when all it is doing is
> updating the size_{in,out} and opcode fields. Mainly I'm interested in
> CXL_CMD() enforcing that the command-id is the mem_commands index.
> 

Agreed and removed.

> > +
> > +               if (cmd.raw.rsvd)
> > +                       return -EINVAL;
> > +
> > +               if (cxl_mem_find_command(cmd.raw.opcode))
> > +                       return -EPERM;
> > +
> > +               add_taint(TAINT_WARN, LOCKDEP_STILL_OK);
> 
> TAINT_WARN seems the wrong value, especially since no WARN has
> occurred. I feel that this is more in the spirit of
> TAINT_PROPRIETARY_MODULE, TAINT_OVERRIDDEN_ACPI_TABLE, and
> TAINT_OOT_MODULE. How about a new TAINT_RAW_PASSTHROUGH? I could use
> this for the acpi/nfit driver as well to disclaim responsibility for
> system errors that can result from not using the nominal
> kernel-provided commands.

I like it.
