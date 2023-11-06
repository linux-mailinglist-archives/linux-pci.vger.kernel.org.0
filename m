Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5CD7E2C7B
	for <lists+linux-pci@lfdr.de>; Mon,  6 Nov 2023 19:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbjKFS45 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Nov 2023 13:56:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbjKFS44 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Nov 2023 13:56:56 -0500
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2239D8;
        Mon,  6 Nov 2023 10:56:53 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 65FC1300002D5;
        Mon,  6 Nov 2023 19:56:52 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 56AB4119432; Mon,  6 Nov 2023 19:56:52 +0100 (CET)
Date:   Mon, 6 Nov 2023 19:56:52 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Danilo Krummrich <dakr@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Xinhui Pan <Xinhui.Pan@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <nouveau@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v2 8/9] PCI: Exclude PCIe ports used for tunneling in
 pcie_bandwidth_available()
Message-ID: <20231106185652.GA3360@wunner.de>
References: <20231103190758.82911-1-mario.limonciello@amd.com>
 <20231103190758.82911-9-mario.limonciello@amd.com>
 <20231106181022.GA18564@wunner.de>
 <712ebb25-3fc0-49b5-96a1-a13c3c4c4921@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <712ebb25-3fc0-49b5-96a1-a13c3c4c4921@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 06, 2023 at 12:44:25PM -0600, Mario Limonciello wrote:
> Tangentially related; the link speed is currently symmetric but there are
> two sysfs files.  Mika left a comment in drivers/thunderbolt/switch.c it may
> be asymmetric in the future. So we may need to keep that in mind on any
> design that builds on top of them.

Aren't asymmetric Thunderbolt speeds just a DisplayPort thing?


> As 'thunderbolt' can be a module or built in, we need to bring code into PCI
> core so that it works in early boot before it loads.

tb_switch_get_generation() is small enough that it could be moved to the
PCI core.  I doubt that we need to make thunderbolt built-in only
or move a large amount of code to the PCI core.

Thanks,

Lukas
