Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4148344C5FA
	for <lists+linux-pci@lfdr.de>; Wed, 10 Nov 2021 18:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbhKJRdb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Nov 2021 12:33:31 -0500
Received: from mga02.intel.com ([134.134.136.20]:35409 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230230AbhKJRda (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Nov 2021 12:33:30 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="219924230"
X-IronPort-AV: E=Sophos;i="5.87,224,1631602800"; 
   d="scan'208";a="219924230"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 09:30:42 -0800
X-IronPort-AV: E=Sophos;i="5.87,224,1631602800"; 
   d="scan'208";a="732571431"
Received: from rwmcguir-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.137.122])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 09:30:41 -0800
Date:   Wed, 10 Nov 2021 09:30:40 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 07/10] cxl/pci: Split cxl_pci_setup_regs()
Message-ID: <20211110173040.vttuxu2ggkqxfnza@intel.com>
References: <163379787433.692348.2451270397309803556.stgit@dwillia2-desk3.amr.corp.intel.com>
 <163434053788.914258.18412599112859205220.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20211110171437.00007160@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110171437.00007160@Huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-11-10 17:14:37, Jonathan Cameron wrote:
> On Fri, 15 Oct 2021 16:30:42 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > From: Ben Widawsky <ben.widawsky@intel.com>
> > 
> > In preparation for moving parts of register mapping to cxl_core, split
> > cxl_pci_setup_regs() into a helper that finds register blocks,
> > (cxl_find_regblock()), and a generic wrapper that probes the precise
> > register sets within a block (cxl_setup_regs()).
> > 
> > Move the actual mapping (cxl_map_regs()) of the only register-set that
> > cxl_pci cares about (memory device registers) up a level from the former
> > cxl_pci_setup_regs() into cxl_pci_probe().
> > 
> > With this change the unused component registers are no longer mapped,
> > but the helpers are primed to move into the core.
> > 
> > [djbw: drop cxl_map_regs() for component registers]
> > 
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > [djbw: rebase on the cxl_register_map refactor]
> > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> Hi Ben / all,
> 
> This is probably the best patch to comment on for this
> (note it is not a comment about this patch, but more the state we end up
> in after it).
> 
> cxl_map_regs() is a generic function, but with the new split approach
> as a result of this patch, we now always know at the caller which of
> the types of map we are doing.
> 
> I think it would be clearer to embrace that situation and drop cxl_map_regs()
> in favor of directly calling the relevant specific versions such as
> cxl_map_device_regs().  I can't immediately see how the generic cxl_map_regs()
> will be useful to us going forwards.
> 
> Jonathan

I completely agree. Long term, something like cxl_map_regs() might be desirable
for a Type2 device, but we have no such user today. Patches welcome?
