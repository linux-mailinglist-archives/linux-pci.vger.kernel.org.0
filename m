Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330875A7FFB
	for <lists+linux-pci@lfdr.de>; Wed, 31 Aug 2022 16:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbiHaOUj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Aug 2022 10:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbiHaOUj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Aug 2022 10:20:39 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7712201B5
        for <linux-pci@vger.kernel.org>; Wed, 31 Aug 2022 07:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661955637; x=1693491637;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AcN6REUdOs+zrD82g5T9uQ9gVr520BbbpE2xvgbbsBA=;
  b=GF9Prhp4i7DSd9D41R2FTK07MRZ0flUB8eaLFiohxDn979qFmWoRA3F+
   HkkOt71Qx55HqDatDBie1qNSpFnEFk7Xfk5SExjpsje1DwMhO4zpRx6Y+
   F4nGVfvoooCsY3KlCqleSQVEP+strRII2hTND02DaUHgD/LLZdjp0kUV3
   mBO7f5d7/7VbYmXHrkBI7Cs8golyDJR+dCLnIJVVYhCOHB0+Y7bT+G1ZI
   spej03oTeL00TIC7b0COYxn1CjAful/R2zxflTAoVSETbEooTLknnVqHw
   9sXdrKexxBdpPPsuulyxRWYc6NvWDmxOxMEZam0yYSRDhiSxYduPIbTvI
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="296737579"
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="296737579"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 07:20:18 -0700
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="612108419"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 07:20:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oTOZi-006Pm6-0m;
        Wed, 31 Aug 2022 17:20:14 +0300
Date:   Wed, 31 Aug 2022 17:20:14 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/6] PCI: Allow for future resource expansion on initial
 root bus scan
Message-ID: <Yw9uHmijqFUckyUr@smile.fi.intel.com>
References: <20220816100740.68667-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816100740.68667-1-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 16, 2022 at 01:07:34PM +0300, Mika Westerberg wrote:
> Hi,
> 
> The series works around an issue found on some Dell systems where
> booting with Thunderbolt/USB4 devices connected the BIOS leaves some of
> the PCIe devices unconfigured. If the connected devices that are not
> configured have PCIe hotplug ports as well the initial root bus scan
> only reserves the minimum amount of resources to them making any
> expansion happening later impossible.
> 
> We do already distribute the "spare" resources between hotplug ports on
> hot-add but we have not done that upon the initial scan. The first three
> patches make the initial root bus scan path to do the same.
> 
> The additional three patches are just a small cleanups that can be
> applied separately too.
> 
> The related bug: https://bugzilla.kernel.org/show_bug.cgi?id=216000.

With split and squash or not, LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Mika Westerberg (6):
>   PCI: Fix used_buses calculation in pci_scan_child_bus_extend()
>   PCI: Pass available buses also when the bridge is already configured
>   PCI: Distribute available resources for root buses too
>   PCI: Remove two unnecessary empty lines in pci_scan_child_bus_extend()
>   PCI: Fix typo in pci_scan_child_bus_extend()
>   PCI: Fix indentation in pci_bridge_distribute_available_resources()
> 
>  drivers/pci/probe.c     |  13 +-
>  drivers/pci/setup-bus.c | 290 ++++++++++++++++++++++++----------------
>  2 files changed, 181 insertions(+), 122 deletions(-)
> 
> -- 
> 2.35.1
> 

-- 
With Best Regards,
Andy Shevchenko


