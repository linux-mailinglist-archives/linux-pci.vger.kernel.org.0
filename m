Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FE74B6457
	for <lists+linux-pci@lfdr.de>; Tue, 15 Feb 2022 08:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbiBOH3Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Feb 2022 02:29:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbiBOH3Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Feb 2022 02:29:24 -0500
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A91FA20D;
        Mon, 14 Feb 2022 23:29:13 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id E5202100D9410;
        Tue, 15 Feb 2022 08:29:11 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id C35C5254B5C; Tue, 15 Feb 2022 08:29:11 +0100 (CET)
Date:   Tue, 15 Feb 2022 08:29:11 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <nouveau@lists.freedesktop.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Alexander.Deucher@amd.com, Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v4 00/10] Overhaul `is_thunderbolt`
Message-ID: <20220215072911.GA13892@wunner.de>
References: <20220215000200.242799-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215000200.242799-1-mario.limonciello@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 14, 2022 at 06:01:50PM -0600, Mario Limonciello wrote:
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c  |  2 +-
>  drivers/gpu/drm/nouveau/nouveau_vga.c   |  4 +-
>  drivers/gpu/drm/radeon/radeon_device.c  |  4 +-
>  drivers/gpu/drm/radeon/radeon_kms.c     |  2 +-
>  drivers/pci/hotplug/pciehp_hpc.c        |  6 +-
>  drivers/pci/pci-acpi.c                  | 15 ++++-
>  drivers/pci/pci.c                       | 17 +++--
>  drivers/pci/probe.c                     | 52 ++++++++++++++-
>  drivers/pci/quirks.c                    | 84 +++++++++++++++++++++++++
>  drivers/platform/x86/apple-gmux.c       |  2 +-
>  drivers/thunderbolt/nhi.h               |  2 -
>  include/linux/pci.h                     | 25 +-------
>  include/linux/pci_ids.h                 |  3 +
>  14 files changed, 173 insertions(+), 47 deletions(-)

That's an awful lot of additional LoC for what is primarily
a refactoring job with the intent to simplify things.

Honestly this looks like an attempt to fix something that
isn't broken.  Specifically, the is_thunderbolt bit apparently
can't be removed without adding new bits to struct pci_dev.
Not sure if that can be called progress.

Thanks,

Lukas
