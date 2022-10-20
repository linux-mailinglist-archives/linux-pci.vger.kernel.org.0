Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96DC606972
	for <lists+linux-pci@lfdr.de>; Thu, 20 Oct 2022 22:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiJTUYr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Oct 2022 16:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiJTUYq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Oct 2022 16:24:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9B42339D
        for <linux-pci@vger.kernel.org>; Thu, 20 Oct 2022 13:24:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C324961D02
        for <linux-pci@vger.kernel.org>; Thu, 20 Oct 2022 20:24:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB15C433D6;
        Thu, 20 Oct 2022 20:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666297479;
        bh=Ak9rL6bc631+472LSxcLILNo1X2ELStyVJk3o3FvtIA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gQ7nw7sSQfCkiTwoWVyLhuIjPIJt8b6AlXOHxDYfaIM4GPbeoP1LL2zjuvhi/L2GO
         QyLYVEehbXYpWftmqqjrydd1oqO4jNEMrkrWMRGwmsm1UklL+XhOFTqciwDhHgqAxR
         o23QquZIhcFd7/5B7gRaoJffUGyipjjjzrv/xTr0osbkPHH+PFRLTP1sllGpJjHfp2
         C8De2R72L8t16vId+ba3Ak3W+mbEKOi9ZBcqrcQYp6fcgi9BMipExzjgFA7NOPmA4k
         L+Sog009JnuH8d1RKkQxubp4NB5Nh3+V/lF+mRN3DHZB4Lb6neS2YgxOeqYpJ5KZNI
         xKxnZmZiyV1wQ==
Date:   Thu, 20 Oct 2022 15:24:37 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Tyler Hicks <code@tyhicks.com>
Cc:     bhelgaas@google.com, Keith Busch <kbusch@kernel.org>,
        linux-pci@vger.kernel.org, Zhiqiang Hou <Zhiqiang.Hou@nxp.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH] PCI: Align MPS to upstream bridge for SAFE and
 PERFORMANCE mode
Message-ID: <20221020202437.GA142348@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019182559.yjnd2z6lhbvptwr3@sequoia>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 19, 2022 at 01:25:59PM -0500, Tyler Hicks wrote:
> On 2022-06-10 23:01:31, Zhiqiang Hou wrote:
> > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > 
> > The commit 27d868b5e6cf ("PCI: Set MPS to match upstream bridge")
> > made the device's MPS matches upstream bridge for PCIE_BUS_DEFAULT
> > mode, so that it's more likely that a hot-added device will work in
> > a system with an optimized MPS configuration.
> > 
> > Obviously, the Linux itself optimizes the MPS settings in the
> > PCIE_BUS_SAFE and PCIE_BUS_PERFORMANCE mode, so let's do this also
> > for these modes.
> > 
> > Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> I wanted to give a little more information about the issue we're seeing.
> We're having trouble retaining the optimized Max Payload Size (MPS)
> value of a PCIe endpoint after hotplug/rescan. In this case,
> `pcie_ports=native` and `pci=pcie_bus_safe` are set on the cmdline and
> we expect the Linux kernel to retain the MPS value. Commit 27d868b5e6cf
> preserved the MPS value when using the default PCIe bus mode
> (PCIE_BUS_DEFAULT) and we're hopeful that this can be extended to other
> modes, as well.

Thanks, Tyler.  I need help understanding what's going on here.  An
example of the topology and what happens and what *should* happen
might help.

Some MPS configuration is done per-device in pci_configure_mps(), and
some considers a hierarchy in pcie_bus_configure_settings().  In the
current tree, in the PCIE_BUS_SAFE case:

  - pci_configure_mps() does nothing (except for RCiEPs).

  - pcie_bus_configure_settings(bus) looks at the hierarchy rooted at
    the bridge leading to "bus".  If the hierarchy contains a hotplug
    Switch Downstream Port, it sets MPS and MRRS to 128 for
    everything.

    If it does not contain such a bridge, it finds the smallest
    MPS_Supported ("smpss") of any device in the hierarchy and sets
    MPS and MRRS to that for everything.

If you boot with a hotplug Root Port leading to an empty slot, I think
the RP MPS will end up being whatever BIOS put there.

A subsequent hot-add will do nothing in pci_configure_mps(), and
pcie_bus_configure_settings() looks like it would set the RP and EP
MPS to the minimum of the RP and EP MPS_Supported.

Is that what you see?  What would you like to see instead?

Bjorn
