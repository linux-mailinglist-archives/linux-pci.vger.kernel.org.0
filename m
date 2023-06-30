Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A52743DBA
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jun 2023 16:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbjF3OnI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jun 2023 10:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbjF3Om7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Jun 2023 10:42:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636823C06;
        Fri, 30 Jun 2023 07:42:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDCAF6176C;
        Fri, 30 Jun 2023 14:42:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16954C433C8;
        Fri, 30 Jun 2023 14:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688136157;
        bh=FobgviI7+8dwx2oijrp2XqAsD6wlFH06OENkuR5Y50g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ZEO2dSFD4R0cumSQ4KDz5a/xHsp+PHKKOqrleiwbGQWliL7M6QRQL3SI2fjxSu1/c
         DPrZlpsMi9p+MbDq8YRTskpM8iHGZZ2Da21v2F6dsYGd5W0RWL1nJKjni7/JCt5wHf
         r1DyKC01cKJyK93I5AT+W9u+RMYg5NMxBAmSwqWM0c7L7OtQOBriffyjkbtxiOET1k
         0CDlBcMIe8WZtdT5Ahl/iF+kTtFjRnSXJfkcGdm0SLMLb0dn1K6sH0Q1ORH3EpiEpM
         aTKIrBolB1mZRob90MIuRPw4QcORcVjnPiAYAgKYBr8FYllUafmLgNkisCFneynHJz
         8YQVaA1qHSWPQ==
Date:   Fri, 30 Jun 2023 09:42:35 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Lizhi Hou <lizhi.hou@amd.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        max.zhen@amd.com, sonal.santan@amd.com,
        stefano.stabellini@xilinx.com
Subject: Re: [PATCH V10 2/5] PCI: Create device tree node for bridge
Message-ID: <20230630144235.GA483557@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629235551.GB92592-robh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 29, 2023 at 05:55:51PM -0600, Rob Herring wrote:
> On Thu, Jun 29, 2023 at 05:56:31PM -0500, Bjorn Helgaas wrote:
> > On Thu, Jun 29, 2023 at 10:19:47AM -0700, Lizhi Hou wrote:
> > > The PCI endpoint device such as Xilinx Alveo PCI card maps the register
> > > spaces from multiple hardware peripherals to its PCI BAR. Normally,
> > > the PCI core discovers devices and BARs using the PCI enumeration process.
> > > There is no infrastructure to discover the hardware peripherals that are
> > > present in a PCI device, and which can be accessed through the PCI BARs.

> > > --- a/drivers/pci/of.c
> > > +++ b/drivers/pci/of.c
> > > @@ -487,6 +487,15 @@ static int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *
> > >  		} else {
> > >  			/* We found a P2P bridge, check if it has a node */
> > >  			ppnode = pci_device_to_OF_node(ppdev);
> > > +#if IS_ENABLED(CONFIG_PCI_DYNAMIC_OF_NODES)
> > 
> > I would use plain #ifdef here instead of IS_ENABLED(), as you did in
> > pci.h below.  IS_ENABLED() is true if the Kconfig symbol is set to
> > either "y" or "m".
> 
> Actually, IS_ENABLED() with a C 'if' rather than a preprocessor #if 
> would work here and is preferred.

Makes sense; I see the justification at [1].  I do wish it didn't have
to be different between this usage and the "#ifdef
CONFIG_PCI_DYNAMIC_OF_NODES" in pci.h for the stubs.  But this is OK
by me.

Bjorn

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?id=v6.4#n1162
