Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E927DE802
	for <lists+linux-pci@lfdr.de>; Wed,  1 Nov 2023 23:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234974AbjKAWUa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Nov 2023 18:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbjKAWUa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Nov 2023 18:20:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD15C126
        for <linux-pci@vger.kernel.org>; Wed,  1 Nov 2023 15:20:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE77C433C7;
        Wed,  1 Nov 2023 22:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698877227;
        bh=AZmA7dROASpovfPrfzw/u4RFujdY0pYB86EMcQ8XBDA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=EkmAv8spIRwRwE7FtCqYD+s6oLnzFMg0Bh5CDwhvp+LXspH7UZ6ijTLG/0EkzKpLV
         nlHIvP9IUPotDXy/CSJyaX1gdTxgaR4NFOmrymcnPQ4Dz5sTUlb5zOdAgmAKZylvrT
         j1hK0bCW1ck9JcxcHA0bmJ2uekeBNwg/+/96cjuCxzTxm8uOZ28tj6IAPt5NCE8oyW
         xy9VkApCCGAVO2WKEk4KrREG9BubZ/ERIgkteVNFfbZp/FiNmuNNnGrP74hhkZRVGC
         w8NJthX6UkPn4X2vjjUhvDXmvIeYLKhL0vLQhBKT3LJZ4mQber2X2NMHLlNGdlo1hU
         c/hMyKswNZ1DA==
Date:   Wed, 1 Nov 2023 17:20:25 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nirmal Patel <nirmal.patel@linux.intel.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: vmd: Enable Hotplug based on BIOS setting on VMD
 rootports
Message-ID: <20231101222025.GA101237@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0b9e19c7a976f7a81b55f432a4ed29324b319fc.camel@linux.intel.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 31, 2023 at 12:59:34PM -0700, Nirmal Patel wrote:
> On Tue, 2023-10-31 at 10:31 -0500, Bjorn Helgaas wrote:
> > On Mon, Oct 30, 2023 at 04:16:54PM -0400, Nirmal Patel wrote:
> > > VMD Hotplug should be enabled or disabled based on VMD rootports'
> > > Hotplug configuration in BIOS. is_hotplug_bridge is set on each
> > > VMD rootport based on Hotplug capable bit in SltCap in probe.c.
> > > Check is_hotplug_bridge and enable or disable native_pcie_hotplug
> > > based on that value.
> > > 
> > > Currently VMD driver copies ACPI settings or platform
> > > configurations
> > > for Hotplug, AER, DPC, PM, etc and enables or disables these
> > > features
> > > on VMD bridge which is not correct in case of Hotplug.
> > 
> > This needs some background about why it's correct to copy the ACPI
> > settings in the case of AER, DPC, PM, etc, but incorrect for hotplug.
> > 
> > > Also during the Guest boot up, ACPI settings along with VMD UEFI
> > > driver are not present in Guest BIOS which results in assigning
> > > default values to Hotplug, AER, DPC, etc. As a result Hotplug is
> > > disabled on VMD in the Guest OS.
> > > 
> > > This patch will make sure that Hotplug is enabled properly in Host
> > > as well as in VM.
> > 
> > Did we come to some consensus about how or whether _OSC for the host
> > bridge above the VMD device should apply to devices in the separate
> > domain below the VMD?
>
> We are not able to come to any consensus. Someone suggested to copy
> either all _OSC flags or none. But logic behind that assumption is
> that the VMD is a bridge device which is not completely true. VMD is an
> endpoint device and it owns its domain.

Do you want to facilitate a discussion in the PCI firmware SIG about
this?  It seems like we may want a little text in the spec about how
to handle this situation so platforms and OSes have the same
expectations.

Bjorn
