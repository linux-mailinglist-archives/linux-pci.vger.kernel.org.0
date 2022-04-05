Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6F14F4707
	for <lists+linux-pci@lfdr.de>; Wed,  6 Apr 2022 01:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbiDEU4e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Apr 2022 16:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457655AbiDEQ0q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Apr 2022 12:26:46 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF667C166
        for <linux-pci@vger.kernel.org>; Tue,  5 Apr 2022 09:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649175887; x=1680711887;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1lT1ORduTl6wuyJso2/+MycwhVPSszvccKAqxCLmaKA=;
  b=EKhPDvKSZT7Sx5Ysmf0SLufYBQux87LpMX4WzBTleoSNdr9H07sDyM7h
   0IQF4S2x7SY3V9BIIqflv0HArsWjFqcsRUexg41vwJd9GIlpmwEbg4/bQ
   TTpKidzQFInrkdsuuIepA1qlM9jy5xOnDJ6VVEpeQevGhDCge7QZPkOTb
   /KaSRt7WRfVDT14gLNx5fTAEVeI0QfY1eDXhcwlEBm3RL4qszEg005//1
   DUEhE9LDyMn6Yp7M/XKzavessWGc7D5eHneq2Bgeqd+WSiGE5qzKxhjVI
   AA4/yqKimtgrx7qXuKq5179WP4gUUgITCi89ADSa6sHG52bbFSRuQArg5
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="258378361"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="258378361"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 09:24:46 -0700
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="569964880"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 09:24:44 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 05 Apr 2022 19:24:41 +0300
Date:   Tue, 5 Apr 2022 19:24:41 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Quirk Intel DG2 ASPM L1 acceptable latency to be
 unlimited
Message-ID: <YkxtSRQxfWzxuCU5@lahna>
References: <20220405093810.76613-1-mika.westerberg@linux.intel.com>
 <20220405160151.GA68831@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405160151.GA68831@bhelgaas>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Tue, Apr 05, 2022 at 11:01:51AM -0500, Bjorn Helgaas wrote:
> On Tue, Apr 05, 2022 at 12:38:10PM +0300, Mika Westerberg wrote:
> > Intel DG2 discrete graphics PCIe endpoints hard-code their acceptable L1
> > ASPM latency to be < 1us even though the hardware actually supports
> > higher latencies (> 64 us) just fine. In order to allow the links to go
> > into L1 and save power, quirk the acceptable L1 ASPM latency for these
> > endpoints to be unlimited.
> 
> Is there a plan to fix this in future DG2 hardware/firmware?
> Obviously the point of Dev Cap is to make the device self-describing
> so we can avoid updates like this every time new hardware comes out.

Yes, I think that's the plan.

> > Note this does not have any effect unless the user requested the kernel
> > to enable ASPM in the first place (by default we don't enable it). 
> 
> I think this depends on the platform and kernel config, doesn't it?
> If CONFIG_PCIEASPM_POWERSAVE=y or CONFIG_PCIEASPM_POWER_SUPERSAVE=y
> I suspect we would enable ASPM L1 even without the parameters below.
> 
> > This is done with "pcie_aspm=force pcie_aspm.policy=powersupsersave"
> > command line parameters.
> 
> s/powersupsersave/powersupersave/
> 
> This should affect "powersave" as well as "powersupersave", right?
> Both enable L1.  "powersupersave" enables the L1 substates.
> 
> We *should* be able to enable/disable ASPM L1 using the sysfs "l1_aspm
> file, too.

Indeed you are right. I think we can drop that paragraph completely from
the commit log. Do you want me to send v2 with that corrected or you
will do that while applying?

Thanks!
