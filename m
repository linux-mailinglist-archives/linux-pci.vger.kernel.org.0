Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E14CA42CF74
	for <lists+linux-pci@lfdr.de>; Thu, 14 Oct 2021 02:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbhJNAOm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Oct 2021 20:14:42 -0400
Received: from mga18.intel.com ([134.134.136.126]:44398 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229590AbhJNAOl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Oct 2021 20:14:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10136"; a="214509920"
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="214509920"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 17:12:37 -0700
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="491699393"
Received: from sjchris1-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.132.156])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 17:12:37 -0700
Date:   Wed, 13 Oct 2021 17:12:36 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 07/10] cxl/pci: Split cxl_pci_setup_regs()
Message-ID: <20211014001236.aohtmzrrvmcq6dpo@intel.com>
References: <163379783658.692348.16064992154261275220.stgit@dwillia2-desk3.amr.corp.intel.com>
 <163379787433.692348.2451270397309803556.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20211013224523.rxyt2mg75ebxismi@intel.com>
 <CAPcyv4jHxWJQSgGFg4e5tSg8dgDcYVKrzXEN8gtg7TjNRj3h0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jHxWJQSgGFg4e5tSg8dgDcYVKrzXEN8gtg7TjNRj3h0g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-10-13 15:49:30, Dan Williams wrote:
> On Wed, Oct 13, 2021 at 3:45 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > On 21-10-09 09:44:34, Dan Williams wrote:
> > > From: Ben Widawsky <ben.widawsky@intel.com>
> > >
> > > In preparation for moving parts of register mapping to cxl_core, split
> > > cxl_pci_setup_regs() into a helper that finds register blocks,
> > > (cxl_find_regblock()), and a generic wrapper that probes the precise
> > > register sets within a block (cxl_setup_regs()).
> > >
> > > Move the actual mapping (cxl_map_regs()) of the only register-set that
> > > cxl_pci cares about (memory device registers) up a level from the former
> > > cxl_pci_setup_regs() into cxl_pci_probe().
> > >
> > > With this change the unused component registers are no longer mapped,
> > > but the helpers are primed to move into the core.
> > >
> > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > [djbw: rebase on the cxl_register_map refactor]
> > > [djbw: drop cxl_map_regs() for component registers]
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> >
> > [snip]
> >
> > Did you mean to also drop the component register handling in cxl_probe_regs()
> > and cxl_map_regs()?
> 
> No, because that has a soon to be added user, right?

In the current codebase, the port driver gets the offset from cxl_core, not
through the pci driver. I know you wanted this to be passed from cxl_pci (and
indeed it was before). Currently however, the functionality is subsumed by
cxl_find_regblock and is used by cxl_pci (for device registers), cxl_acpi (to
get the CHBCR) and cxl_core (to get the component register block for switches).

I have no user in cxl_pci for the component registers, and as we discussed, we
have no good way to share them across modules.

We can ignore this for now though and discuss it on the list when I post. If
there is a better way to handle this, I'm open to it.
