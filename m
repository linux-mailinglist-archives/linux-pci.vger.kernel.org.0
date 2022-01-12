Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E66748C67D
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jan 2022 15:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354304AbiALOvE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 09:51:04 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50192 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354287AbiALOu5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jan 2022 09:50:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63133B81F44;
        Wed, 12 Jan 2022 14:50:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2145C36AE5;
        Wed, 12 Jan 2022 14:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641999055;
        bh=ZYIhQu0CJmEYqQPsxX+F20R/7TLgNCmuzU7RtO1+uBU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=TXQxe4XlT38nugbWRKDdxBY1KByqJNOv/XOXpZvLebOZ9mcEi/Uvcpz3dY0ztwTJa
         31sW3/JElg+npzFZ1JCgqG1CywPvdfrxwbIIeebzyAcX96Dm5aY2ox8kce6thXtQty
         lXJweipz0XlaCSlNN3NyKg2BCTVRBxDi+1uUqVJOcvg3to99k4HHQtL1CtXTYmb2FT
         1c/ELnOzN0FXUxAo5Btp4avLKJa/gvHEQU55udjSCtYrDChsyhtz82vpA5qr1+pyvf
         nDWPzMqKsE+vdyJwT+NYjm9enW3FGmAGiw/43NgBhbbMq8mB1E8JMzTf8Nqk/qx7sP
         iUoY9ndVvBQWQ==
Date:   Wed, 12 Jan 2022 08:50:53 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH v2] PCI: Fix Intel i210 by avoiding overlapping of BARs
Message-ID: <20220112145053.GA254177@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9526698be0ced0f7a7ed00bd76538d16@walle.cc>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 23, 2021 at 07:12:02PM +0100, Michael Walle wrote:
> Am 2021-12-23 17:37, schrieb Bjorn Helgaas:
> 
> > I intended to change the quirk from FINAL to EARLY, but obviously
> > forgot.  Here's the updated version:
> > 
> > commit bb5639b73a2d ("PCI: Work around Intel I210 ROM BAR overlap
> > defect")
> > Author: Bjorn Helgaas <bhelgaas@google.com>
> > Date:   Tue Dec 21 10:45:07 2021 -0600
> > 
> >     PCI: Work around Intel I210 ROM BAR overlap defect
> > 
> >     Per PCIe r5, sec 7.5.1.2.4, a device must not claim accesses to its
> >     Expansion ROM unless both the Memory Space Enable and the Expansion
> > ROM
> >     Enable bit are set.  But apparently some Intel I210 NICs don't work
> >     correctly if the ROM BAR overlaps another BAR, even if the Expansion
> > ROM is
> >     disabled.
> > 
> >     Michael reported that on a Kontron SMARC-sAL28 ARM64 system with
> > U-Boot
> >     v2021.01-rc3, the ROM BAR overlaps BAR 3, and networking doesn't
> > work at
> >     all:
> > 
> >       BAR 0: 0x40000000 (32-bit, non-prefetchable) [size=1M]
> >       BAR 3: 0x40200000 (32-bit, non-prefetchable) [size=16K]
> >       ROM:   0x40200000 (disabled) [size=1M]
> > 
> >       NETDEV WATCHDOG: enP2p1s0 (igb): transmit queue 0 timed out
> >       Hardware name: Kontron SMARC-sAL28 (Single PHY) on SMARC Eval
> > 2.0 carrier (DT)
> >       igb 0002:01:00.0 enP2p1s0: Reset adapter
> > 
> >     Previously, pci_std_update_resource() wrote the assigned ROM address
> > to the
> >     BAR only when the ROM was enabled.  This meant that the I210 ROM BAR
> > could
> >     be left with an address assigned by firmware, which might overlap
> > with
> >     other BARs.
> > 
> >     Quirk these I210 devices so pci_std_update_resource() always writes
> > the
> >     assigned address to the ROM BAR, whether or not the ROM is enabled.
> > 
> >     Link:
> > https://lore.kernel.org/r/20201230185317.30915-1-michael@walle.cc
> >     Link: https://bugzilla.kernel.org/show_bug.cgi?id=211105
> >     Reported-by: Michael Walle <michael@walle.cc>
> >     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Tested-by: Michael Walle <michael@walle.cc>

Applied to pci/resource for v5.17, thanks!
