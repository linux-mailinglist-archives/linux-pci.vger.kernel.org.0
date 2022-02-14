Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4B64B44E4
	for <lists+linux-pci@lfdr.de>; Mon, 14 Feb 2022 09:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236444AbiBNIwP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Feb 2022 03:52:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbiBNIwP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Feb 2022 03:52:15 -0500
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68BC5F8F3;
        Mon, 14 Feb 2022 00:52:06 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 0240A100D942B;
        Mon, 14 Feb 2022 09:52:03 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id D49112D92C; Mon, 14 Feb 2022 09:52:02 +0100 (CET)
Date:   Mon, 14 Feb 2022 09:52:02 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <nouveau@lists.freedesktop.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Alexander.Deucher@amd.com,
        Andreas Noever <andreas.noever@gmail.com>
Subject: Re: [PATCH v3 05/12] PCI: Detect root port of internal USB4 devices
 by `usb4-host-interface`
Message-ID: <20220214085202.GA21533@wunner.de>
References: <20220211193250.1904843-6-mario.limonciello@amd.com>
 <20220211214546.GA737137@bhelgaas>
 <YgoGAkjZgCob8Mdl@lahna>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgoGAkjZgCob8Mdl@lahna>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 14, 2022 at 09:34:26AM +0200, Mika Westerberg wrote:
> On Fri, Feb 11, 2022 at 03:45:46PM -0600, Bjorn Helgaas wrote:
> > My expectation is that "USB" (like "PCI" and "PCIe") tells me
> > something about how a device is electrically connected and how
> > software can operate it.  It doesn't really tell me anything about
> > whether those electrical connections are permanent, made through an
> > internal slot, or made through an external connector and cable.
> 
> It is used to identify "tunneled" ports (whether PCIe, USB 3.x or
> DisplayPort). Tunnels are created by software (in Linux it is the
> Thunderbolt driver) and are dynamic in nature. The USB4 links go over
> USB Type-C cable which also is something user can plug/unplug freely.
> 
> I would say it is reasonable expectation that anything behind these
> ports can be assumed as "removable".

USB gadgets may be soldered to the mainboard.  Those cannot be
unplugged freely.  It is common practice to solder USB Ethernet
or USB FTDI serial ports and nothing's preventing a vendor to solder
USB4/Thunderbolt gadgets.
