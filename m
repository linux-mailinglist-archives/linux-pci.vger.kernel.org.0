Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405704DDC81
	for <lists+linux-pci@lfdr.de>; Fri, 18 Mar 2022 16:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237821AbiCRPNN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Mar 2022 11:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237829AbiCRPNL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Mar 2022 11:13:11 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A76D0A9A;
        Fri, 18 Mar 2022 08:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647616313; x=1679152313;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RyqKF6D9twudookxV1g3lDHqbNq6rtr8FS7sB7gUWvo=;
  b=U+R2i0mknK5br37bOZG1Wn3jmm1yvnq9iL6byF/+9O4ADVeBMNjojP0N
   /VVt9PzC79/8joC2B7HPAQKd544NZqkT2W9yqhoXJZxFajdkXG+CpHn0s
   UTSgw6Bk0dPUu5zKUebr9Xpoc8XmY+p6IM8MvMZmlr+f5PR1Gd0SDV5TO
   fDsiBEBlLFnKn5hoKeum6MJYZh6ETs+hO+xJXIgTq7pVBqJfNjkdbIcSr
   gycwUtqTy2yJdzgKob1Rk/+PGlpGvPeWlXhuIfKE1YlOHDDqc+9pGZfKt
   B/y3Jq4AaPjCI+clVypIP9cRSvWX7Z1RoFxU6uBHi/y7w+R62o7sAf4Bb
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="320363414"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="320363414"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 08:11:53 -0700
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="541886651"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 08:11:49 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 18 Mar 2022 17:11:47 +0200
Date:   Fri, 18 Mar 2022 17:11:47 +0200
From:   "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "andreas.noever@gmail.com" <andreas.noever@gmail.com>,
        "michael.jamet@intel.com" <michael.jamet@intel.com>,
        "YehezkelShB@gmail.com" <YehezkelShB@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] thunderbolt: Make iommu_dma_protection more accurate
Message-ID: <YjShM1g8wGDUymK4@lahna>
References: <2d01fa50c2650c730b0244929097737918e302e7.1647533152.git.robin.murphy@arm.com>
 <BL1PR12MB515783C0F998169D49D92A55E2129@BL1PR12MB5157.namprd12.prod.outlook.com>
 <BL1PR12MB51573F55B3C2B3922BAAA7F1E2129@BL1PR12MB5157.namprd12.prod.outlook.com>
 <YjRvMk1kcbMwJvx+@lahna>
 <65207fdf-c4ab-5165-dbda-8ab55b51adb7@arm.com>
 <YjSCWaq7Ej/2iJPp@lahna>
 <78fc0426-c22a-ec62-f92b-0019bea5947e@arm.com>
 <20220318145121.GA11127@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318145121.GA11127@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lukas,

On Fri, Mar 18, 2022 at 03:51:21PM +0100, Lukas Wunner wrote:
> On Fri, Mar 18, 2022 at 02:08:16PM +0000, Robin Murphy wrote:
> > OK, so do we have any realistic options for identifying the correct PCI
> > devices, if USB4 PCIe adapters might be anywhere relative to their
> > associated NHI? Short of maintaining a list of known IDs, the only thought I
> > have left is that if we walk the whole PCI segment looking specifically for
> > hotplug-capable Gen1 ports, any system modern enough to have Thunderbolt is
> > *probably* not going to have any real PCIe Gen1 hotplug slots, so maybe
> > false negatives might be tolerable, but it still feels like a bit of a
> > sketchy heuristic.
> 
> The Thunderbolt Device ROM contains the PCI slot number, so you can
> correlate the Thunderbolt switch ports with PCIe downstream ports
> and know exactly where PCIe tunnels are terminated.
> 
> Code is here:
> * thunderbolt: Obtain PCI slot number from DROM
>   https://github.com/l1k/linux/commit/756f7148bc10
> * thunderbolt: Move upstream_port to struct tb
>   https://github.com/l1k/linux/commit/58f16e7dd431
> * thunderbolt: Correlate PCI devices with Thunderbolt ports
>   https://github.com/l1k/linux/commit/f53ea40a7487
> 
> I implemented that in 2018, so it won't apply cleanly to current
> mainline.  But I kept forward-porting it on my private branch and
> could push that to GitHub if anyone is interested.
> 
> I don't know if this will work out-of-the-box for SoC-integrated
> Thunderbolt controllers.  It was developed with the discrete
> controllers in mind, which was the only thing available back then.

That DROM entry is completely optional and so is the whole DROM for the
host routers (this is the root of the USB4/TBT topology) so
unfortunately we cannot use it here.
