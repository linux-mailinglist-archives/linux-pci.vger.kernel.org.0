Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D17F7DC706
	for <lists+linux-pci@lfdr.de>; Tue, 31 Oct 2023 08:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343585AbjJaHPB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Oct 2023 03:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343556AbjJaHPA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Oct 2023 03:15:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146DAC2
        for <linux-pci@vger.kernel.org>; Tue, 31 Oct 2023 00:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698736498; x=1730272498;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=lzC1r5/MhuR3N9ZPloNAnD3/lZwpYF4xcO5Hf2mHMl0=;
  b=gBMD3JJ+APCzR3y2QhbFRSi8NAwko+BFYtwcTn8TE5S3VvYizLCLeKH5
   gniJBZnYOF2+870uoXgdTAV6okc2yMboSA0VFtBXDYldKCel5PSeVYKvV
   50ksWQEV2vIpEChesxAAYh8sPRSNvVDzNe626cpeYSPRyAXn6Dd5YvoHe
   WU+M3kKaFPsGLHVRtVd0NQUy2fJVjJIdypMBNM0E8dK/6iCVWvzV0CChO
   +tsXztJnPXRmWliAH8QdN2Ouup3LAWQX7e0Ra01+UhaV6SXsqrLSXm/VV
   F/SnKMnY8r3GIV1FVsdtcPhDrG9IaA/hmjgWJY/BK6t4lNFhoL9wVntEG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="452503228"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="452503228"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 00:14:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="789697385"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="789697385"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 31 Oct 2023 00:14:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 1045B16E; Tue, 31 Oct 2023 09:14:20 +0200 (EET)
Date:   Tue, 31 Oct 2023 09:14:20 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: Re: pcie_bandwidth_available and USB4/TBT3
Message-ID: <20231031071420.GN3208943@black.fi.intel.com>
References: <7ad4b2ce-4ee4-429d-b5db-3dfc360f4c3e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ad4b2ce-4ee4-429d-b5db-3dfc360f4c3e@amd.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Mario,

On Mon, Oct 30, 2023 at 11:46:20AM -0500, Mario Limonciello wrote:
> Hi,
> 
> Recently we’ve been looking at some issues with AMD dGPUs being put into a
> TBT3 eGPU enclosure and various issues that come up.  Several of them are
> root caused to bugs in the amdgpu driver that we’ll fix there.
> 
> However one thing stands out is a performance problem where the cards are
> artificially limited to a lower speed than necessary.
> 
> The amdgpu driver uses pcie_bandwidth_available() to decide what values to
> use for the platform speed cap and bandwidth cap.
> The value returned for the platform speed cap is always hardcoded to 2.5
> GT/s.
> 
> This happens because the USB4 spec explicitly states[1]
> 
> ---
> 11.2.1 PCIe Physical Layer Logical Sub-block
> The Logical sub-block shall update the PCIe configuration registers with the
> following
> characteristics:
> • PCIe Gen 1 protocol behavior.
> • Max Link Speed field in the Link Capabilities Register set to 0001b (data
> rate of 2.5 GT/s
> only).
> Note: These settings do not represent actual throughput. Throughput is
> implementation specific
> and based on the USB4 Fabric performance.
> ---
> 
> So I wanted to ask – is it better to:
> 1. Catch this case in pcie_bandwidth_available() to skip PCIe root ports
> associated with a USB4 controller.
> 
> 2. Special case the usage of pcie_bandwidth_available() to ignore any
> limiting devices when dev_is_removable() for the dGPU.
> 
> I'm personally tending to think it's better to fix in
> pcie_bandwidth_available() because papering over it in amdgpu means that the
> discovering the upper bound isn't possible if you must ignore the return
> value for pcie_bandwidth_available().

I agree, handling this in pcie_bandwidth_available() makes sense but I
suggest also to document this the kernel-doc so that the GPU driver
writers (probably the only ones using this function) can find the
information easily. Maybe the simplest is to skip any "tunneled" links
and stick to the real PCIe links when calculating the bandwidth.
