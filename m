Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD88F6C24F6
	for <lists+linux-pci@lfdr.de>; Mon, 20 Mar 2023 23:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjCTW4n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Mar 2023 18:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCTW4m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Mar 2023 18:56:42 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB15B2CFC0;
        Mon, 20 Mar 2023 15:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679353001; x=1710889001;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=L8dkAazkP6gp+tUnia7Go6L7A/IteNz5613YzTAF6qw=;
  b=UEoSwDu3QSQRhOrksgVNA3/fpU41OoPSJHXoe0aXAnmJg72jKYXvv72Z
   1XPM+pXw5M22pRYj61LtZhbENbsrAlvRThVBYFOAlFCjq3YGZHToKhh8g
   qM+/JzObvl5umAmROttJVk3cz8JXZLcSKKluVidA0uPbWql1MySHhc7b5
   poCY+5V0TpjIfO1yCCDdI9jFAjrdnvQdGX8jZbkTFqb5U8Mja0VWqJxTg
   lXEVKhKzhUuUi2yfGI7uIkLC8w5kiK7GV2f+efWEtShlrKePHWqSYmqlU
   1TzKCZ1tAdoc3p7K3qz7uYE6BSvcQlPvzZRekKFLwL7fzhEZDyJlGBPrB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="322639145"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="322639145"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 15:56:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="745590000"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="745590000"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.70])
  by fmsmga008.fm.intel.com with SMTP; 20 Mar 2023 15:56:36 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 21 Mar 2023 00:56:35 +0200
Date:   Tue, 21 Mar 2023 00:56:35 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lorenzo.pieralisi@arm.com, hch@infradead.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, michael.a.bottini@intel.com,
        rafael@kernel.org, me@adhityamohan.in, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH V10 4/4] PCI: vmd: Add quirk to configure PCIe ASPM and
 LTR
Message-ID: <ZBjko/ifunIwsK2v@intel.com>
References: <20230120031522.2304439-1-david.e.box@linux.intel.com>
 <20230120031522.2304439-5-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230120031522.2304439-5-david.e.box@linux.intel.com>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 19, 2023 at 07:15:22PM -0800, David E. Box wrote:
> +/*
> + * Enable ASPM and LTR settings on devices that aren't configured by BIOS.
> + */
> +static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
> +{
> +	unsigned long features = *(unsigned long *)userdata;
> +	u16 ltr = VMD_BIOS_PM_QUIRK_LTR;
> +	u32 ltr_reg;
> +	int pos;
> +
> +	if (!(features & VMD_FEAT_BIOS_PM_QUIRK))
> +		return 0;
> +
> +	pci_enable_link_state(pdev, PCIE_LINK_STATE_ALL);

Hi,

This is tripping lockdep on one our CI ADL machines.

https://intel-gfx-ci.01.org/tree/drm-tip/CI_DRM_12814/bat-adlp-6/boot0.txt

<4>[   13.815380] ============================================
<4>[   13.815382] WARNING: possible recursive locking detected
<4>[   13.815384] 6.3.0-rc1-CI_DRM_12814-g4753bbc2a817+ #1 Not tainted
<4>[   13.815386] --------------------------------------------
<4>[   13.815387] swapper/0/1 is trying to acquire lock:
<4>[   13.815389] ffffffff827ab0b0 (pci_bus_sem){++++}-{3:3}, at: pci_enable_link_state+0x69/0x1d0
<4>[   13.815396] 
                  but task is already holding lock:
<4>[   13.815398] ffffffff827ab0b0 (pci_bus_sem){++++}-{3:3}, at: pci_walk_bus+0x24/0x90
<4>[   13.815403] 
                  other info that might help us debug this:
<4>[   13.815404]  Possible unsafe locking scenario:

<4>[   13.815406]        CPU0
<4>[   13.815407]        ----
<4>[   13.815408]   lock(pci_bus_sem);
<4>[   13.815410]   lock(pci_bus_sem);
<4>[   13.815411] 
                   *** DEADLOCK ***

<4>[   13.815413]  May be due to missing lock nesting notation

<4>[   13.815414] 2 locks held by swapper/0/1:
<4>[   13.815416]  #0: ffff8881029511b8 (&dev->mutex){....}-{3:3}, at: __driver_attach+0xab/0x180
<4>[   13.815422]  #1: ffffffff827ab0b0 (pci_bus_sem){++++}-{3:3}, at: pci_walk_bus+0x24/0x90
<4>[   13.815426] 
                  stack backtrace:
<4>[   13.815428] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.3.0-rc1-CI_DRM_12814-g4753bbc2a817+ #1
<4>[   13.815431] Hardware name: Intel Corporation Alder Lake Client Platform/AlderLake-P DDR4 RVP, BIOS ADLPFWI1.R00.3135.A00.2203251419 03/25/2022
<4>[   13.815434] Call Trace:
<4>[   13.815436]  <TASK>
<4>[   13.815437]  dump_stack_lvl+0x64/0xb0
<4>[   13.815443]  __lock_acquire+0x9b5/0x2550
<4>[   13.815461]  lock_acquire+0xd7/0x330
<4>[   13.815463]  ? pci_enable_link_state+0x69/0x1d0
<4>[   13.815466]  down_read+0x3d/0x180
<4>[   13.815480]  ? pci_enable_link_state+0x69/0x1d0
<4>[   13.815482]  pci_enable_link_state+0x69/0x1d0
<4>[   13.815485]  ? __pfx_vmd_pm_enable_quirk+0x10/0x10
<4>[   13.815488]  vmd_pm_enable_quirk+0x49/0xb0
<4>[   13.815490]  pci_walk_bus+0x6d/0x90
<4>[   13.815492]  vmd_probe+0x75f/0x9d0
<4>[   13.815495]  pci_device_probe+0x95/0x120
<4>[   13.815498]  really_probe+0x164/0x3c0
<4>[   13.815500]  ? __pfx___driver_attach+0x10/0x10
<4>[   13.815503]  __driver_probe_device+0x73/0x170
<4>[   13.815506]  driver_probe_device+0x19/0xa0
<4>[   13.815508]  __driver_attach+0xb6/0x180
<4>[   13.815511]  ? __pfx___driver_attach+0x10/0x10
<4>[   13.815513]  bus_for_each_dev+0x77/0xd0
<4>[   13.815516]  bus_add_driver+0x114/0x210
<4>[   13.815518]  driver_register+0x5b/0x110
<4>[   13.815520]  ? __pfx_vmd_drv_init+0x10/0x10
<4>[   13.815523]  do_one_initcall+0x57/0x330
<4>[   13.815527]  kernel_init_freeable+0x181/0x3a0
<4>[   13.815529]  ? __pfx_kernel_init+0x10/0x10
<4>[   13.815532]  kernel_init+0x15/0x120
<4>[   13.815534]  ret_from_fork+0x29/0x50
<4>[   13.815537]  </TASK>

-- 
Ville Syrjälä
Intel
