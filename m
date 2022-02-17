Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8624BAB2C
	for <lists+linux-pci@lfdr.de>; Thu, 17 Feb 2022 21:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242577AbiBQUkR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Feb 2022 15:40:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiBQUkR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Feb 2022 15:40:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BC6148674;
        Thu, 17 Feb 2022 12:40:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5900461E1C;
        Thu, 17 Feb 2022 20:40:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D99EC340E8;
        Thu, 17 Feb 2022 20:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645130401;
        bh=gMwTMyNiKF2SJFRozKPAoW+wbNbKhGmor9hG8jl8CGc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jUl9xkZ4uiN5A1eww37AsO3qJEch+3jqmtFDPhIyhp3mXeZNhabJbFwM5bB2wYqX+
         5vFrGrFysgZYCNDE3LilbfzgF8DvDbx5IcmsRwEr2UuPWrS7rP0KkhoNDf5Vr78941
         9tzLH8KMntNkpiGUCeC0uWRpgPZ32o92aa497xciBKx2OGNfma4QhofkO6LXHB/HaF
         kZZ6/T5g8366MKV3WHHtcbgFA3ixcBSRnwPOd8u8fi/huKJH8jy6KqVLYIFj8Mimpx
         l+sJB4eAs/5vzXmi6FCPjXIDLEtNhDWaQeRWlecsopZN3Wb0jCkfXtIbeFE7ssqgaP
         BdZUKUOG2flOA==
Date:   Thu, 17 Feb 2022 14:40:00 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <nouveau@lists.freedesktop.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Alexander.Deucher@amd.com
Subject: Re: [PATCH v3 05/12] PCI: Detect root port of internal USB4 devices
 by `usb4-host-interface`
Message-ID: <20220217204000.GA302508@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ygo1eoVe8D0b80QF@lahna>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 14, 2022 at 12:56:58PM +0200, Mika Westerberg wrote:
> On Mon, Feb 14, 2022 at 09:52:02AM +0100, Lukas Wunner wrote:
> > On Mon, Feb 14, 2022 at 09:34:26AM +0200, Mika Westerberg wrote:
> > > On Fri, Feb 11, 2022 at 03:45:46PM -0600, Bjorn Helgaas wrote:
> > > > My expectation is that "USB" (like "PCI" and "PCIe") tells me
> > > > something about how a device is electrically connected and how
> > > > software can operate it.  It doesn't really tell me anything about
> > > > whether those electrical connections are permanent, made through an
> > > > internal slot, or made through an external connector and cable.
> > > 
> > > It is used to identify "tunneled" ports (whether PCIe, USB 3.x or
> > > DisplayPort). Tunnels are created by software (in Linux it is the
> > > Thunderbolt driver) and are dynamic in nature. The USB4 links go over
> > > USB Type-C cable which also is something user can plug/unplug freely.
> > > 
> > > I would say it is reasonable expectation that anything behind these
> > > ports can be assumed as "removable".
> > 
> > USB gadgets may be soldered to the mainboard.  Those cannot be
> > unplugged freely.  It is common practice to solder USB Ethernet
> > or USB FTDI serial ports and nothing's preventing a vendor to solder
> > USB4/Thunderbolt gadgets.
> 
> Right, that's why I say it is "reasonable expectation" that anything
> behind these ports can be assumed "removable" :) Of course they don't
> have to be but if we assume that in the driver where this actually
> matters we should be on the safe side, no?

Spec citations help maintain things over the long term.  Reasonable
expectations that are part of today's folklore but are not written
down and shared leads to things that work today but not tomorrow.

Bjorn
