Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449914B2341
	for <lists+linux-pci@lfdr.de>; Fri, 11 Feb 2022 11:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349045AbiBKKf0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Feb 2022 05:35:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349055AbiBKKfW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Feb 2022 05:35:22 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C111BF19;
        Fri, 11 Feb 2022 02:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644575715; x=1676111715;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xZqL227qrEuXaCf1lVm11orizsim7DciTShq3TaFFQU=;
  b=YQ5u4AFRMW7kt7DRblwsIXSlo1y9OkzkPqOe22LQ92eDdDB9bHaPB9JC
   mPITg46SXh2ef7LysltpVKYuLeeQMKKSlVDoOM8l2rivxjKxJr6KphHFV
   HaFtcAFpEy8Pn40bNhxZlbsqT2aCrE0vpZRgssxznb3pqn7BpLUNtGwS/
   cwWb9+U5Kiwap8lFMZBPAGZKbanzaMMx1D4S7ks8k5T5If0l0/DRjVvmw
   T5kzfENR5bHuz5duBxKdRzaC9s2n/OnGs0IRw09DgoriUfknI2/opHAIF
   tnu8KFfYN7rFSSmjNG0BEk5NWgVjltlThQzTxtAyTsl6wNx78XB5flKKD
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="247302176"
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="247302176"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 02:35:07 -0800
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="623185131"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 02:35:03 -0800
Received: by lahna (sSMTP sendmail emulation); Fri, 11 Feb 2022 12:35:00 +0200
Date:   Fri, 11 Feb 2022 12:35:00 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <nouveau@lists.freedesktop.org>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>, Alexander.Deucher@amd.com
Subject: Re: [PATCH v2 4/9] PCI: mark USB4 devices as removable
Message-ID: <YgY71Lw4ZFOtdBVj@lahna>
References: <20220210224329.2793-1-mario.limonciello@amd.com>
 <20220210224329.2793-5-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210224329.2793-5-mario.limonciello@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Mario,

On Thu, Feb 10, 2022 at 04:43:24PM -0600, Mario Limonciello wrote:
> USB4 class devices are also removable like Intel Thunderbolt devices.
> 
> Drivers of downstream devices use this information to declare functional
> differences in how the drivers perform by knowing that they are connected
> to an upstream TBT/USB4 port.

This may not be covering the integrated controllers. For discrete, yes
but if it is the PCIe root ports that start the PCIe topology (over the
PCIe tunnels) this does not work.

For integrated we have the "usb4-host-interface" ACPI property that
tells this for each port:

https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#mapping-native-protocols-pcie-displayport-tunneled-through-usb4-to-usb4-host-routers

and for discrete there is the PCIe DVSEC that can be used (see the USB4
spec archive it includes the "USB4 DVSEC Version 1.0.pdf" that has more
information). I would expect AMD controller (assuming it is discrete)
implements this too.

So I'm proposing that we mark the devices that are below  PCIe ports
(root, downstream) that fall in the above categories as "removable".
This is then not dependent on checking the USB4 controller and how it is
setup in a particular system.
