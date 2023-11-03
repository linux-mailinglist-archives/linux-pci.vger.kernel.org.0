Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1104B7E0968
	for <lists+linux-pci@lfdr.de>; Fri,  3 Nov 2023 20:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345150AbjKCTVK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Nov 2023 15:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbjKCTVJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Nov 2023 15:21:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990A4D73;
        Fri,  3 Nov 2023 12:21:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E611AC433C8;
        Fri,  3 Nov 2023 19:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699039260;
        bh=7MN/U949LXBUJuxhHGoevzr7GxH9ANzavjzuKeHmEFI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ATOS90CQjIPKFdQUNME1YOl/ZNO2l4vdA/tAPEX5FuZ7YB0AZw3Rg48H9VhtnnOA7
         VtX7UDME19I2utp0+HF+lTQWr1D2hH09nX463+1I6RWUaNBEbWhgPk6cHDBxOANA2/
         GbhdCLcNRwLIWfdX1Sj8XI23fCuZmPAunNQ+ynphpjxhJc317uikh3sxlMhff1fqtK
         FCtukqW5Kj1gGpk6aAglpD5Efco/VWlsxThbznSAwnIfQu5rtd4/zabCMIAZ5h2wrN
         d43JcoHYz09h5jLLSCD3wjOJ1MfFJa73nnUnofNlVsP2Q8bxmAm1uiL68bvht0+bEj
         icfdgBagHldvQ==
Date:   Fri, 3 Nov 2023 14:20:58 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <dri-devel@lists.freedesktop.org>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        Danilo Krummrich <dakr@redhat.com>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <nouveau@lists.freedesktop.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Michael Jamet <michael.jamet@intel.com>,
        Mark Gross <markgross@kernel.org>,
        Xinhui Pan <Xinhui.Pan@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>
Subject: Re: [PATCH v2 0/9] Improvements to pcie_bandwidth_available() for
 eGPUs
Message-ID: <20231103192058.GA164718@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103190758.82911-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 03, 2023 at 02:07:49PM -0500, Mario Limonciello wrote:
> Downstream drivers are getting the wrong values from
> pcie_bandwidth_available() which is causing problems for performance
> of eGPUs.
> 
> This series overhauls Thunderbolt related device detection and uses
> the changes to change the behavior of pcie_bandwidth_available().
> 
> NOTE: This series is currently based on top of v6.6 + this change that
>       will be merged for 6.7:
> Link: https://patchwork.freedesktop.org/patch/564738/

Thanks, Mario, I'll look at this soon after v6.7-rc1 (probably Nov
12), so the amdgpu patch should be in mainline by then.

> v1->v2:
>  * Rename is_thunderbolt
>  * Look for _DSD instead of link
>  * Drop pci_is_thunderbolt_attached() from all drivers
>  * Adjust links
>  * Adjust commit messages
>  * Add quirk for Tiger Lake
> 
> Mario Limonciello (9):
>   drm/nouveau: Switch from pci_is_thunderbolt_attached() to
>     dev_is_removable()
>   drm/radeon: Switch from pci_is_thunderbolt_attached() to
>     dev_is_removable()
>   PCI: Drop pci_is_thunderbolt_attached()
>   PCI: Move the `PCI_CLASS_SERIAL_USB_USB4` definition to common header
>   PCI: pciehp: Move check for is_thunderbolt into a quirk
>   PCI: Rename is_thunderbolt to is_tunneled
>   PCI: ACPI: Detect PCIe root ports that are used for tunneling
>   PCI: Exclude PCIe ports used for tunneling in
>     pcie_bandwidth_available()
>   PCI: Add a quirk to mark 0x8086 : 0x9a23 as supporting PCIe tunneling
> 
>  drivers/gpu/drm/nouveau/nouveau_vga.c  |  6 +-
>  drivers/gpu/drm/radeon/radeon_device.c |  4 +-
>  drivers/gpu/drm/radeon/radeon_kms.c    |  2 +-
>  drivers/pci/hotplug/pciehp_hpc.c       |  6 +-
>  drivers/pci/pci-acpi.c                 | 16 ++++++
>  drivers/pci/pci.c                      | 76 +++++++++++++++++---------
>  drivers/pci/probe.c                    |  2 +-
>  drivers/pci/quirks.c                   | 31 +++++++++++
>  drivers/platform/x86/apple-gmux.c      |  2 +-
>  drivers/thunderbolt/nhi.h              |  2 -
>  include/linux/pci.h                    | 25 +--------
>  include/linux/pci_ids.h                |  1 +
>  12 files changed, 109 insertions(+), 64 deletions(-)
> 
> -- 
> 2.34.1
> 
