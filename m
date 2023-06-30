Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5833744017
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jun 2023 18:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjF3Qs0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jun 2023 12:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjF3QsZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Jun 2023 12:48:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F07D10FB;
        Fri, 30 Jun 2023 09:48:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F74E6179E;
        Fri, 30 Jun 2023 16:48:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5583BC433C0;
        Fri, 30 Jun 2023 16:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688143703;
        bh=Nd8IcQkatSNE5s/b57nxVYn+hCy0DE0OvfYaIi0hv1U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=cpsaJu+ftljiTRRn524d0jBzQwdqQ/0GNIPJAXXUogfJg0YSjIjVVgSS3xlexPjQO
         oNBk3gCDchHEgPFBaD6gAjel/vjpMUFBjBI5cQtiVtdC+pIkZ9x1zSu971cs8mQ3xj
         8ehTFkwHyULNCE70KWSMDZj01v6ZrrwT9QSECZ/V4YGeiSl9LQ4w/2Nwa7q1/7ng+O
         Req4CMLRXV6doLCwWVkD0z3lITUGvAeaLgihdhvsNgFmO6EtDfBqWVsOD/6pq6GzuD
         pdQ6MHFFGWZl6k22eGRhi2VlkhdLh5u5SfBkAWN95bfi3J5gASF7AbHGzDSRAGrTRX
         vjujTX/dSF0wg==
Date:   Fri, 30 Jun 2023 11:48:21 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Lizhi Hou <lizhi.hou@amd.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        max.zhen@amd.com, sonal.santan@amd.com,
        stefano.stabellini@xilinx.com
Subject: Re: [PATCH V10 2/5] PCI: Create device tree node for bridge
Message-ID: <20230630164821.GA483874@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629235226.GA92592-robh@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 29, 2023 at 05:52:26PM -0600, Rob Herring wrote:
> On Thu, Jun 29, 2023 at 05:56:31PM -0500, Bjorn Helgaas wrote:
> > On Thu, Jun 29, 2023 at 10:19:47AM -0700, Lizhi Hou wrote:
> > > The PCI endpoint device such as Xilinx Alveo PCI card maps the register
> > > spaces from multiple hardware peripherals to its PCI BAR. Normally,
> > > the PCI core discovers devices and BARs using the PCI enumeration process.
> > > There is no infrastructure to discover the hardware peripherals that are
> > > present in a PCI device, and which can be accessed through the PCI BARs.
> > 
> > IIUC this is basically a multi-function device except that instead of
> > each device being a separate PCI Function, they all appear in a single
> > Function.  That would mean all the devices share the same config space
> > so a single PCI Command register controls all of them, they all share
> > the same IRQs (either INTx or MSI/MSI-X), any MMIO registers are likely
> > in a shared BAR, etc., right?
> 
> Could be multiple BARs, but yes.

Where does the PCI glue live?  E.g., who ioremaps the BARs?  Who sets
up PCI interrupts?  Who enables bus mastering?  The platform driver
that claims the DT node wouldn't know that this is part of a PCI
device, so I guess the PCI driver must do all that stuff?  I don't see
it in the xmgmt-drv.c from
https://lore.kernel.org/all/20220305052304.726050-4-lizhi.hou@xilinx.com/

> > Obviously PCI enumeration only sees the single Function and binds a
> > single driver to it.  But IIUC, you want to use existing drivers for
> > each of these sub-devices, so this series adds a DT node for the
> > single Function (using the quirks that call of_pci_make_dev_node()).
> > And I assume that when the PCI driver claims the single Function, it
> > will use that DT node to add platform devices, and those existing
> > drivers can claim those?
> 
> Yes. It will call some variant of of_platform_populate().
> 
> > I don't see the PCI driver for the single Function in this series.  Is
> > that coming?  Is this series useful without it?
> 
> https://lore.kernel.org/all/20220305052304.726050-4-lizhi.hou@xilinx.com/
> 
> I asked for things to be split up as the original series did a lot 
> of new things at once. This series only works with the QEMU PCI test 
> device which the DT unittest will use.
> 
> > > Apparently, the device tree framework requires a device tree node for the
> > > PCI device. Thus, it can generate the device tree nodes for hardware
> > > peripherals underneath. Because PCI is self discoverable bus, there might
> > > not be a device tree node created for PCI devices. Furthermore, if the PCI
> > > device is hot pluggable, when it is plugged in, the device tree nodes for
> > > its parent bridges are required. Add support to generate device tree node
> > > for PCI bridges.
> > 
> > Can you remind me why hot-adding a PCI device requires DT nodes for
> > parent bridges?
> 
> Because the PCI device needs a DT node and we can't just put PCI devices 
> in the DT root. We have to create the bus hierarchy.
> 
> > I don't think we have those today, so maybe the DT
> > node for the PCI device requires a DT parent?  How far up does that
> > go?
> 
> All the way.
> 
> >  From this patch, I guess a Root Port would be the top DT node on
> > a PCIe system, since that's the top PCI-to-PCI bridge?
> 
> Yes. Plus above the host bridge could have a hierarchy of nodes.

I'm missing something if it goes "all the way up," i.e., to a single
system root, but a Root Port is the top DT node.  If a Root Port is
the top, there would be several roots.

> > This patch adds a DT node for *every* PCI bridge in the system.  We
> > only actually need that node for these unusual devices.  Is there some
> > way the driver for the single PCI Function could add that node when it
> > is needed?  Sorry if you've answered this in the past; maybe the
> > answer could be in the commit log or a code comment in case somebody
> > else wonders.
> 
> This was discussed early on. I don't think it would work to create the 
> nodes at the time we discover we have a device that wants a DT node. The 
> issue is decisions are made in the code based on whether there's a DT 
> node for a PCI device or not. It might work, but I think it's fragile to 
> have nodes attached to devices at different points in time.

Ah.  So I guess the problem is we enumerate a PCI bridge, we might do
something based on the fact that it doesn't have a DT node, then add a
DT node for it later.

Bjorn
