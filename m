Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B946A7410E7
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jun 2023 14:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjF1MbG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jun 2023 08:31:06 -0400
Received: from mga06b.intel.com ([134.134.136.31]:28840 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230449AbjF1MbG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Jun 2023 08:31:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687955465; x=1719491465;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=squAxCqo4O6bze9c8h2Fwv2QcDXRfEjzIKrKVxRZvKg=;
  b=De3yf5AzL/1w968RkcTuAC91e+az3Ps8i2KLwtlGZzkyzq8hk8vmMt9n
   YO+Oqd3cd+6QYDOfhOkxUb0SIM4T6NNAXmy19FtsRpt8dNJuG0pj6Ph75
   vgcxz17uArucWp83xUuBp+PeJf7+WKyzmTX/Q2/y4hoq2QqsclTtfmmSs
   577+Tm0BPTQ6KGY4hrOrxhu1gljMNIL0XgFzW98IU1a57jg0wrGiJ6J5c
   OhNS5iHdfqu27PQ+lyu1SjoUCR7kq8SlEFg6n0Qen25s8qAz8n7sgZ/oP
   LLAGr3RT1q8iNfeOTmySd4N2bwYnIM4rygr6FP7+iZ5wo+FeNF1P2L5zE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="425502427"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="425502427"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 05:30:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="806874446"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="806874446"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Jun 2023 05:30:45 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 9E276E1; Wed, 28 Jun 2023 15:30:46 +0300 (EEST)
Date:   Wed, 28 Jun 2023 15:30:46 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Thomas Witt <kernel@witt.link>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Michael Bottini <michael.a.bottini@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Tasev Nikola <tasev.stefanoska@skynet.be>,
        Mark Enriquez <enriquezmark36@gmail.com>,
        Koba Ko <koba.ko@canonical.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/ASPM: Add back L1 PM Substate save and restore
Message-ID: <20230628123046.GL14638@black.fi.intel.com>
References: <20230627100447.GC14638@black.fi.intel.com>
 <20230627204124.GA366188@bhelgaas>
 <20230628064637.GF14638@black.fi.intel.com>
 <650f68a1-8d54-a5ad-079b-e8aea64c5130@witt.link>
 <20230628105940.GK14638@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230628105940.GK14638@black.fi.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 28, 2023 at 01:59:40PM +0300, Mika Westerberg wrote:
> Hi Thomas,
> 
> On Wed, Jun 28, 2023 at 12:24:06PM +0200, Thomas Witt wrote:
> > On 28/06/2023 08:46, Mika Westerberg wrote:
> > > @Thomas, is there any particular reason you have this option in the
> > > command line? There is possibility that S3 is not even fully validated
> > > if the system advertises S0 low power sleep instead.
> > 
> > In fact, there is: Entering suspend-to-ram without setting
> > /sys/power/mem_sleep to "deep", my laptop consumes about the same power as
> > it would idling online. The manufacturer suggests setting that commandline
> > parameter:
> > 
> > <https://www.tuxedocomputers.com/en/Infos/Help-Support/Instructions/Fine-tuning-of-power-management-with-suspend-standby.tuxedo#>
> 
> Thanks for the clarification.
> 
> > I just retested your patch with setting mem_sleep to "s2idle", and it no
> > longer triggers the loss of PCI devices. I guess that could be the indicator
> > that Björn asked for.
> 
> I wonder if the patch actually helps here now because the reason we want
> to add it back is that it allows the CPU to enter lower power states and
> thus reducing the power consumption in S2idle too. Do you observe that
> when you have the patch applied?

One possibility is to check the package C-state residency like:

  # cat /sys/kernel/debug/pmc_core/package_cstate_show

after system sleep and see if there is a change with the patch applied,
as done here:

  https://bugzilla.kernel.org/show_bug.cgi?id=217321
