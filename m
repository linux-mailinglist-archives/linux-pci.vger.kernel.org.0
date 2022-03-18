Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B174DDA6C
	for <lists+linux-pci@lfdr.de>; Fri, 18 Mar 2022 14:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236653AbiCRN0b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Mar 2022 09:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236648AbiCRN03 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Mar 2022 09:26:29 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDEC1EE4C6;
        Fri, 18 Mar 2022 06:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647609910; x=1679145910;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=InZ4gM0n9VmGhsbv3r77oTtxNorS/SN0pEblK/FfVAI=;
  b=ALEkEIPVvrMuPq9Hkd/lNYdyhk8o3wIj0iHIwgmxSfAixOeo1/OKHzys
   x/HwZKKrJWRw3db0q1I6XeeQgbAF2ijthPqRFxrExPdbyVnxNH8uTdKNI
   ZvFYXulTHPpNgZ5o5arUpGBaVmAU1Xx4SW0UPNRQU9dLy7TfoT10+nS2t
   InAWXY7HxeywHG6Y8148WVy+gOeMFJKy8f18JgAtm2M1s/hj78jUGhakZ
   gcCJvPG1ZJ3Tn4I3vwdp86GKbSHBgB3UG+Nj6xBtndHWU/slqVbg3NK1v
   Bn++0lVWxIwfz8/u7LfQCeKl67RvEr6Lu4r4XiASvi/0TJ6WOrwMyJzZ0
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="237745360"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="237745360"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 06:25:10 -0700
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="558438415"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 06:25:07 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 18 Mar 2022 15:25:04 +0200
Date:   Fri, 18 Mar 2022 15:25:04 +0200
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
Message-ID: <YjSCWaq7Ej/2iJPp@lahna>
References: <2d01fa50c2650c730b0244929097737918e302e7.1647533152.git.robin.murphy@arm.com>
 <BL1PR12MB515783C0F998169D49D92A55E2129@BL1PR12MB5157.namprd12.prod.outlook.com>
 <BL1PR12MB51573F55B3C2B3922BAAA7F1E2129@BL1PR12MB5157.namprd12.prod.outlook.com>
 <YjRvMk1kcbMwJvx+@lahna>
 <65207fdf-c4ab-5165-dbda-8ab55b51adb7@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65207fdf-c4ab-5165-dbda-8ab55b51adb7@arm.com>
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

On Fri, Mar 18, 2022 at 12:01:42PM +0000, Robin Murphy wrote:
> > This adds quite a lot code and complexity, and honestly I would like to
> > keep it as simple as possible (and this is not enough because we need to
> > make sure the DMAR bit is there so that none of the possible connected
> > devices were able to overwrite our memory already).
> 
> Shall we forget the standalone sibling check and just make the
> pdev->untrusted check directly in tb_acpi_add_link() then?

I think we should leave tb_acpi_add_link() untouched if possible ;-)
This is because it is used to add the device links from firmware
description that we need for proper power management of the tunneled
devices. It has little to do with the identification of the external
facing DMA-capable PCIe ports.

Furthermore these links only exists in USB4 software connection manager
systems so we do not have those in the existing Thunderbolt 3/4 systems
that use firmware based connection manager (pretty much all out there).

> On reflection I guess the DMAR bit makes iommu_dma_protection
> functionally dependent on ACPI already, so we don't actually lose
> anything (and anyone can come back and revisit firmware-agnostic
> methods later if a need appears).

I agree.
