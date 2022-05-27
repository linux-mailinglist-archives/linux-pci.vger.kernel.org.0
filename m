Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8004A53692C
	for <lists+linux-pci@lfdr.de>; Sat, 28 May 2022 01:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355169AbiE0X2C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 May 2022 19:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235741AbiE0X2B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 May 2022 19:28:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F20762A5;
        Fri, 27 May 2022 16:28:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F90E61A5F;
        Fri, 27 May 2022 23:28:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C6AC385A9;
        Fri, 27 May 2022 23:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653694079;
        bh=tsZOyDdsn/R3PNVK/DQdKGBDnPHlMZFoXEP8WTRvpiQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=efWgDNo+o/YTK0ZMvEGzbW/HvGG4IleYaiYe1wKIgtfQDoxJGtVPz3Dg1RP50TToS
         TdMSOdrg8oPkKML2qm6L9wUpIC5fG1OLAOX43VxsyDnQRlHwanQSEkTqG4jw1+K6Ho
         vLkFmg7IhNMjqW/qy9WGZ1W9VQMmD7IIhcekRjfjDqqPNaHkZDwpy9ks2RVAUzK2bO
         51kR5Gjx3w0QxaotMrl+e5D7/D6TO6RKezcH/ATfoIwyxXTQT3KYHo8yZT8I4ba0Ny
         JPhPNWbOvR9AtV+OKD9R+C6nvfjXpro6G30G27JjE4mACI42tsMwSnp6o7MFHz35wz
         SbQ5EQlzieeEQ==
Date:   Fri, 27 May 2022 18:27:57 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        James Dutton <james.dutton@gmail.com>,
        Cyril Brulebois <kibi@debian.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1] PCI: brcmstb: Fix regression regarding missing PCIe
 linkup
Message-ID: <20220527232757.GA515159@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525215739.GA275957@bhelgaas>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 25, 2022 at 04:57:39PM -0500, Bjorn Helgaas wrote:
> On Tue, May 24, 2022 at 12:54:48PM -0400, Jim Quinlan wrote:
> > On Mon, May 23, 2022 at 6:10 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Sat, May 21, 2022 at 02:51:42PM -0400, Jim Quinlan wrote:
> > > > On Sat, May 21,
> > > > 2CONFIG_INITRAMFS_SOURCE="/work3/jq921458/cpio/54-arm64-rootfs.cpio022
> > > > at 12:43 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > On Wed, May 18, 2022 at 03:42:11PM -0400, Jim Quinlan wrote:
> > > > > > commit 93e41f3fca3d ("PCI: brcmstb: Add control of subdevice
> > > > > > voltage regulators")
> > > > > >
> > > > > > introduced a regression on the PCIe RPi4 Compute Module.  If the
> > > > > > PCIe endpoint node described in [2] was missing, no linkup would
> > > > > > be attempted, and subsequent accesses would cause a panic
> > > > > > because this particular PCIe HW causes a CPU abort on illegal
> > > > > > accesses (instead of returning 0xffffffff).
> > > > > >
> > > > > > We fix this by allowing the DT endpoint subnode to be missing.
> > > > > > This is important for platforms like the CM4 which have a
> > > > > > standard PCIe socket and the endpoint device is unknown.
> 
> > > But above you say it's the *endpoint* node that doesn't exist.  The
> > > existing code looks like it's checking for the *bridge* node
> > > (bus->dev->of_node).  We haven't even enumerated the devices on the
> > > child bus, so we don't know about them at this point.
> >
> > You are absolutely correct and I must change the commit message
> > to say the "root port DT node".   I'm sorry; this mistake likely did not
> > help you understand the fix. :-(
> 
> Great, that will help me out!  I think including the relevant DT
> snippet would also make it more concrete and might conceivably be
> helpful to somebody working around it on a kernel without the fix.

Where are we at with this?  Linus just merged my pull request, and I'd
really like to get this resolved before -rc1 (expected June 5 or so),
which means I'd like to ask him to pull the fix early next week.

The alternative is to ask him to pull these reverts, which have
actually been in -next since May 11:

  4246970a3bcb ("Revert "PCI: brcmstb: Split brcm_pcie_setup() into two funcs"")
  f35b19f02e01 ("Revert "PCI: brcmstb: Add mechanism to turn on subdev regulators"")
  ae65b283d7a4 ("Revert "PCI: brcmstb: Add control of subdevice voltage regulators"")
  d938b26e9b14 ("Revert "PCI: brcmstb: Do not turn off WOL regulators on suspend"")

Bjorn
