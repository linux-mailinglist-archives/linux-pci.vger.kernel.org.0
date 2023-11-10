Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D40B7E812C
	for <lists+linux-pci@lfdr.de>; Fri, 10 Nov 2023 19:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345433AbjKJSYz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Nov 2023 13:24:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345765AbjKJSXx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Nov 2023 13:23:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98923975C;
        Fri, 10 Nov 2023 06:39:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0380EC433C7;
        Fri, 10 Nov 2023 14:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699627143;
        bh=s66gHHjMySKSZbn63cKJJA1Bvs2R0xW/wRdb8aMe4VM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=VFN97HdpzS3TdmFDybUTeRVCW09lhWWC4tRqyIS+CJOfjgUOb1/QZsUqBsh3Faud+
         8/VXIg+r7JgsdtSQWbNI2dCwUuSNis7hCZ33JkThOLGRHDkoGeIPItVjODWGpXGlAN
         e6htKbqPWQndkLiBSKa9sBfFQ/WvtOKbM81ZhJZTXZGfQzp3IIbfkgytF88bTCD2E1
         WEahUa7JQGdec/XKOTdqLY2Nt9mBw1QeII28O3HYEF3X4JUDc76LlLvvXbfIe9ZxJ4
         z++kez5RnEOipVViYdFHeoIgvWNLwwBN8Ux9Yha2VY9K+lV8BXD9edSHk8hgkbXiMO
         cHYbRBuQqKKow==
Date:   Fri, 10 Nov 2023 08:39:01 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Jim Quinlan <jim2101024@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 2/3] PCI: brcmstb: Configure HW CLKREQ# mode
 appropriate for downstream device
Message-ID: <20231110143901.GA540912@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+-6iNwhifsRsGwz5Wk3VuECxa1jRg5vxQCuGe-MUr=kn301=w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 10, 2023 at 08:01:23AM -0500, Jim Quinlan wrote:
> On Thu, Nov 9, 2023 at 5:31 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Thu, Nov 09, 2023 at 05:06:15PM -0500, Jim Quinlan wrote:
> > > ...
> >
> > > BTW, besides the RPi4, I haven't been able to find a Linux platform
> > > where I can do
> > >
> > >         echo $POLICY > /sys/module/pcie_aspm/parameters/policy
> >
> > This sounds like something we should fix.  What exactly happens?  I
> > think this should be handled at pcie_aspm_set_policy(), so:
> 
> Well, I've tried changing the ASPM policy on my x86 Ubuntu system
> and IIRC a Fedora system.  In both cases it says "illegal write
> operation" but I am root and the "policy" file does have rw perms
> for root, so I have no idea how it comes back with that error.  Some
> machines allow one to change the setting in the BIOS, FWIW.

BIOS settings like that are potentially misleading unless the BIOS
*also* retains ownership of ASPM or changes the ASPM features
advertised by devices.  If BIOS grants ASPM ownership to the OS, BIOS
should not assume anything about how the OS will configure ASPM.

> Right now on my CM4, "echo $POLICY  > policy" actually works.
> Perhaps when I was testing this I did not yet apply my commits, or
> perhaps it was with a specific endpoint device.  Regardless, I'll
> let you know with a backtrace if I see this again.

Great, thanks!

Bjorn
