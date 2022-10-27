Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675326105F4
	for <lists+linux-pci@lfdr.de>; Fri, 28 Oct 2022 00:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbiJ0Wvx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Oct 2022 18:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiJ0Wvw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Oct 2022 18:51:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E0883223
        for <linux-pci@vger.kernel.org>; Thu, 27 Oct 2022 15:51:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C4A362585
        for <linux-pci@vger.kernel.org>; Thu, 27 Oct 2022 22:51:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F44EC433B5;
        Thu, 27 Oct 2022 22:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666911110;
        bh=YdEuZF3yyr0tMUwlLbxCnyWQyIjEDazZNgt9jZIjDN8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=lm2JRMRTxASuwDyozd2Tj7ZG+kpjcsZ7ZMzQCZ+nG81oVfJUegvIm4M8MPvTAlvoq
         LObkECg1+R49RnDXagk8h8H60d0YXrNJf9XL4u9faMdkpXD3Vpufd9OCdDJZ2iYprK
         muIHvbIuGrthRNowYpxnplrW4xDRhjErEqWdE3SimCkJDBn3ajbVymqz//xXzCMtOl
         nwF5TCfFhMdS0mo36BBi9cFNcTf6Qrh4M0zNzc7KuU02yTWinrh0wHsNYxssgBIGFm
         7HW1z31kRf2BfGjxFFYY9q6cY8xTNwHr5/zYlgK5d+6uV6Z+4PQ4f8ZSwPO7e2aFdH
         O9Dj8hmblJrjg==
Date:   Thu, 27 Oct 2022 17:51:49 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Tyler Hicks <code@tyhicks.com>
Cc:     Keith Busch <kbusch@kernel.org>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, Zhiqiang Hou <Zhiqiang.Hou@nxp.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH] PCI: Align MPS to upstream bridge for SAFE and
 PERFORMANCE mode
Message-ID: <20221027225149.GA846989@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025050551.br3ewbegcpz55f5e@sequoia>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 25, 2022 at 12:07:47AM -0500, Tyler Hicks wrote:
> On 2022-10-20 15:24:37, Bjorn Helgaas wrote:
> > On Wed, Oct 19, 2022 at 01:25:59PM -0500, Tyler Hicks wrote:
> > > On 2022-06-10 23:01:31, Zhiqiang Hou wrote:
> > > > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > > > 
> > > > The commit 27d868b5e6cf ("PCI: Set MPS to match upstream bridge")
> > > > made the device's MPS matches upstream bridge for PCIE_BUS_DEFAULT
> > > > mode, so that it's more likely that a hot-added device will work in
> > > > a system with an optimized MPS configuration.
> > > > 
> > > > Obviously, the Linux itself optimizes the MPS settings in the
> > > > PCIE_BUS_SAFE and PCIE_BUS_PERFORMANCE mode, so let's do this also
> > > > for these modes.
> > > > 
> > > > Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > > 
> > > I wanted to give a little more information about the issue we're seeing.
> > > We're having trouble retaining the optimized Max Payload Size (MPS)
> > > value of a PCIe endpoint after hotplug/rescan. In this case,
> > > `pcie_ports=native` and `pci=pcie_bus_safe` are set on the cmdline and
> > > we expect the Linux kernel to retain the MPS value. Commit 27d868b5e6cf
> > > preserved the MPS value when using the default PCIe bus mode
> > > (PCIE_BUS_DEFAULT) and we're hopeful that this can be extended to other
> > > modes, as well.
> > 
> > Thanks, Tyler.  I need help understanding what's going on here.  An
> > example of the topology and what happens and what *should* happen
> > might help.
> 
> Hey Bjorn and Keith! Thanks for both of your responses and your
> patience. They spurred good investigations on my side and I'm learning a
> lot as I go.
> 
> > Some MPS configuration is done per-device in pci_configure_mps(), and
> > some considers a hierarchy in pcie_bus_configure_settings().  In the
> > current tree, in the PCIE_BUS_SAFE case:
> > 
> >   - pci_configure_mps() does nothing (except for RCiEPs).
> > 
> >   - pcie_bus_configure_settings(bus) looks at the hierarchy rooted at
> >     the bridge leading to "bus".  If the hierarchy contains a hotplug
> >     Switch Downstream Port, it sets MPS and MRRS to 128 for
> >     everything.
> > 
> >     If it does not contain such a bridge, it finds the smallest
> >     MPS_Supported ("smpss") of any device in the hierarchy and sets
> >     MPS and MRRS to that for everything.
> > 
> > If you boot with a hotplug Root Port leading to an empty slot, I think
> > the RP MPS will end up being whatever BIOS put there.
> 
> I've been talking to the firmware folks on why SAFE mode was selected,
> based on Keith's question from Wednesday. From what I've been told,
> U-Boot doesn't seed the RP MPS with a value so the kernel sees a value
> of 128 for p_mps in pci_configure_mps() when using the DEFAULT mode.
> Apparently UEFI does seed the RP MPS but we don't get that with U-Boot.
> Therefore, SAFE mode was selected to get an initial, tuned RP MPS value
> set to 256.

Are there any devices below the RP at the time we set MPS=256?

> > A subsequent hot-add will do nothing in pci_configure_mps(), and
> > pcie_bus_configure_settings() looks like it would set the RP and EP
> > MPS to the minimum of the RP and EP MPS_Supported.
> > 
> > Is that what you see?  What would you like to see instead?
> 
> No, not quite. After hot-add, we see the EP MPS set to 128 with SAFE
> mode even though the RP MPS is 256.

Can you add the relevant topology here so we can work through the
concrete details?  Is the endpoint hot-added directly below a Root
Port?  Or is there a switch involved?  What are the MPS_Supported
values for all the devices?  If there's a switch in the picture, it
looks like we currently restrict to 128, I think because it's possible
an endpoint that can only do 128 may be added.

Bjorn
