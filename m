Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5A84DDCBF
	for <lists+linux-pci@lfdr.de>; Fri, 18 Mar 2022 16:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237934AbiCRP0Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Mar 2022 11:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237831AbiCRP0X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Mar 2022 11:26:23 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776B3A5E91;
        Fri, 18 Mar 2022 08:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647617105; x=1679153105;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LlOEVehLpDxPQcChYnPKlnsRrBtAlMMFuCk3HXvGY80=;
  b=Oh9+WeOWgT8HjzHe4TLar2R07De2kG9HBq5u3YbVFLW1Aq9hbVrXufjB
   yTRpGFMknifNHKY706SaVvcpzt8OTEhdIKiz0SoFgcbpCZzE3JMonsd1W
   HpiS1LF8xQPg8k4DkJmJNfzdcwwYf1H6stiY+V7XotJb7o1h22Q6wOvHw
   LJtmpTvYbC6GOePCxW+nVbQX1sBQHGO79TiQh8AvJL2szHjb7Se/yXOiU
   DQMwSQwyJVG925oLHnaJM1NQ8C1GaXRvQl4junbxnHiG+kSD+MBwKZsO/
   khLw/7oSH6gqbij+DjBXDtuByiPx5+k3OXcFOPvM6wuudYxs6TOvNN8jp
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="343590069"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="343590069"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 08:25:02 -0700
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="715521623"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 08:24:57 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 18 Mar 2022 17:23:45 +0200
Date:   Fri, 18 Mar 2022 17:23:45 +0200
From:   "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "andreas.noever@gmail.com" <andreas.noever@gmail.com>,
        "michael.jamet@intel.com" <michael.jamet@intel.com>,
        "YehezkelShB@gmail.com" <YehezkelShB@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] thunderbolt: Make iommu_dma_protection more accurate
Message-ID: <YjSkAcxLDFmVdhEq@lahna>
References: <2d01fa50c2650c730b0244929097737918e302e7.1647533152.git.robin.murphy@arm.com>
 <BL1PR12MB515783C0F998169D49D92A55E2129@BL1PR12MB5157.namprd12.prod.outlook.com>
 <BL1PR12MB51573F55B3C2B3922BAAA7F1E2129@BL1PR12MB5157.namprd12.prod.outlook.com>
 <YjRvMk1kcbMwJvx+@lahna>
 <65207fdf-c4ab-5165-dbda-8ab55b51adb7@arm.com>
 <YjSCWaq7Ej/2iJPp@lahna>
 <78fc0426-c22a-ec62-f92b-0019bea5947e@arm.com>
 <YjSbfScU0Ssuca3y@lahna>
 <73e25ee3-c2f3-0a72-e5cc-04e51f650f2e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73e25ee3-c2f3-0a72-e5cc-04e51f650f2e@arm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Robin,

On Fri, Mar 18, 2022 at 03:15:19PM +0000, Robin Murphy wrote:
> > IMHO we should just trust the firmare provided information here
> > (otherwise we are screwed anyway as there is no way to tell if the
> > devices connected prior the OS can still do DMA), and use the external
> > facing port indicator to idenfity the ports that need DMA protection.
> 
> Indeed that's exactly what I want to do, but it begs the question of how we
> *find* the firmware-provided information in the first place!

Oh, right :) Its the combination of ACPI _DSD "ExternalFacingPort"
(which we already set, dev->external_facing, dev->untrusted for the
devices behind these ports IIRC) and the DMAR opt-in bit. All these are
already read by the kernel.

> I seem to have already started writing the dumb version that will walk the
> whole PCI segment and assume the presence of any external-facing port
> implies that we're good. Let me know if I should stop ;)

That sounds good to me, so don't stop just yet ;-)
