Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2CB54AFA7
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jun 2022 13:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243327AbiFNLzv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jun 2022 07:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236054AbiFNLzu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jun 2022 07:55:50 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561C73A5FC;
        Tue, 14 Jun 2022 04:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655207749; x=1686743749;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tflpx2G6+JJ9EPJTD2ED7MQkO0NbCWyhGrJRBvFDO+A=;
  b=Tvx834izWqSIhjAYuQyyT6qZzbmu42QaumgQIb+0tv/JZV9Fg1KkQi+K
   tpMK8n7QaYEDgLXlsHjJHfsVE2CLkhHeLgg0DzP2E7Mbp8ZC00475iycC
   tNlvzAHFJgQ37ZM1A6GlEizae6aUSH8m3FMkLAPHn2CRQoPQBIqqCf2lf
   eluqMfzS1viMV94Zii1qq0X/XihNVimQCwoD1L79E+BaVu0/opkyRZm/o
   +XlM7n1EoaRfX67IdiPIxcMfMwZUkzW8ZN3DSV+7QkirrhaB3qzqd40hC
   5ThZ9BilGo4tV8F6LohMMpa9szmUUIwXnU7LEATo4/520+2rW8LkMozne
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="278634286"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="278634286"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 04:55:49 -0700
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="651998382"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 04:55:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o1594-000cIs-Ot;
        Tue, 14 Jun 2022 14:55:42 +0300
Date:   Tue, 14 Jun 2022 14:55:42 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Ferry Toth <ftoth@exalondelft.nl>
Subject: Re: [PATCH v1 1/1] x86/PCI: Disable e820 usage for the resource
 allocation
Message-ID: <Yqh3PtENhktETx4S@smile.fi.intel.com>
References: <20220613201641.67640-1-andriy.shevchenko@linux.intel.com>
 <20220613223520.GA721969@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613223520.GA721969@bhelgaas>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 13, 2022 at 05:35:20PM -0500, Bjorn Helgaas wrote:
> On Mon, Jun 13, 2022 at 11:16:41PM +0300, Andy Shevchenko wrote:
> > The resource management improve for PCI on x86 broke booting of Intel MID
> > platforms. It seems that the current code removes all available resources
> > from the list and none of the PCI device may be initialized. Restore the
> > old behaviour by force disabling the e820 usage for the resource allocation.
> > 
> > Fixes: 4c5e242d3e93 ("x86/PCI: Clip only host bridge windows for E820 regions")
> > Depends-on: fa6dae5d8208 ("x86/PCI: Add kernel cmdline options to use/ignore E820 reserved regions")
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Yeah, I blew it with 4c5e242d3e93.  Can you provide more details on
> how the MID platforms broke?

It's not so easy. The breakage seems affects the console driver and earlycon
doesn't work. erlyprintk doesn't support 32-bit MMIO addresses (again,
addresses, not data size). That said, there is nothing to show at all.

What I did, I have bisected to your patch, commented out the call and instead
added a printk() to see what it does, and it basically removed all resources
listed in _CRS.

> Since you set "pci_use_e820 = false" for
> MID below, I assume MID doesn't depend on the e820 clipping and thus
> should not break if we turn off clipping by default in 2023 as in
> 0ae084d5a674 ("x86/PCI: Disable E820 reserved region clipping starting
> in 2023").

> But it'd be nice to see the dmesg log and make sure.

Nothing to provide (see above why), sorry.

-- 
With Best Regards,
Andy Shevchenko


