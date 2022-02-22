Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E205D4BFE51
	for <lists+linux-pci@lfdr.de>; Tue, 22 Feb 2022 17:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbiBVQTY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Feb 2022 11:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbiBVQTY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Feb 2022 11:19:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD1C166A50;
        Tue, 22 Feb 2022 08:18:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2489C61665;
        Tue, 22 Feb 2022 16:18:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F537C340E8;
        Tue, 22 Feb 2022 16:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645546737;
        bh=IzYQgPVIrzdZrtx5q+tqnEui3obxWSTUv594dzI//Qk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WKV8OLQMZMHYyR3NO+/mjQki2fzbApuXnlQCu4xDAlF7LZQqC/T/OV/5CpSTohQ7R
         6fCggzwEt931z8/DaVJ0kX61MEl+fizf1beaiN4UhjJ9Dk6Fe5ItuFifMrT0dnZlij
         IIxHvYEWb2EIjNLQBz3A9dp0JGIayHgXUvvnu0n6p1MlUJPgBSlZzUmpzmkbxi0QFs
         1oqycRDr7vH+048HwrIURCyhWw5MG40icPvHcjPNkofomaXXbOelugkKOuhFlLO+qy
         w8LZclUEQOlTTVAtuCz34V5AmhkM3Xpx13PMA1Ks9lGnGsaw7cDkXzt9XDN3UMrUAt
         /WWSD1DmhiHBQ==
Received: by pali.im (Postfix)
        id CD1F4FDB; Tue, 22 Feb 2022 17:18:54 +0100 (CET)
Date:   Tue, 22 Feb 2022 17:18:54 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH v4 00/12] PCI: mvebu: subsystem ids, AER and INTx
Message-ID: <20220222161854.7oot5v6xlw2wzmsc@pali>
References: <20220222155030.988-1-pali@kernel.org>
 <164554589988.5595.5091384618177225445.b4-ty@arm.com>
 <20220222161143.6ryghgtfmhnmhpmz@pali>
 <20220222161539.GA20114@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220222161539.GA20114@lpieralisi>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+ Gregory

On Tuesday 22 February 2022 16:15:39 Lorenzo Pieralisi wrote:
> On Tue, Feb 22, 2022 at 05:11:43PM +0100, Pali Rohár wrote:
> > On Tuesday 22 February 2022 16:06:20 Lorenzo Pieralisi wrote:
> > > On Tue, 22 Feb 2022 16:50:18 +0100, Pali Rohár wrote:
> > > > This patch series extends pci-bridge-emul.c driver to emulate PCI Subsystem
> > > > Vendor ID capability and PCIe extended capabilities. And then implement
> > > > in pci-mvebu.c driver support for PCI Subsystem Vendor IDs, PCIe AER
> > > > registers, support for legacy INTx interrupts, configuration for X1/X4
> > > > mode and usage of new PCI child_ops API.
> > > > 
> > > > Changes in v4:
> > > > * rebased on c3bd7dc553eea5a3595ca3aa0adee9bf83622a1f
> > > > 
> > > > [...]
> > > 
> > > I can't apply dts changes, patch 12 should go via the arm-soc tree.
> > 
> > Gregory already wrote about this dts change:
> > https://lore.kernel.org/linux-pci/87tud1jwpr.fsf@BL-laptop/
> > "So the easier is to let merge it through the PCI subsystem with the
> > other patches from this series."
> > 
> > Are there any issues with applying this dts change via pci tree?
> 
> I don't usually take dts changes through the PCI tree since they
> can conflict with arm-soc, that's the issue - dts changes should
> be managed by platform maintainers.

Gregory, could you please take patch 12/12?
https://lore.kernel.org/linux-pci/20220222155030.988-13-pali@kernel.org/
You have already Acked-by (see above previous link)

> Thanks,
> Lorenzo
> 
> > > Applied the others to pci/mvebu, thanks.
> > > 
> > > [01/12] PCI: pci-bridge-emul: Re-arrange register tests
> > >         https://git.kernel.org/lpieralisi/pci/c/c453bf6f9b
> > > [02/12] PCI: pci-bridge-emul: Add support for PCIe extended capabilities
> > >         https://git.kernel.org/lpieralisi/pci/c/c0bd419732
> > > [03/12] PCI: pci-bridge-emul: Add support for PCI Bridge Subsystem Vendor ID capability
> > >         https://git.kernel.org/lpieralisi/pci/c/3767a90242
> > > [04/12] dt-bindings: PCI: mvebu: Add num-lanes property
> > >         https://git.kernel.org/lpieralisi/pci/c/26b982ca83
> > > [05/12] PCI: mvebu: Correctly configure x1/x4 mode
> > >         https://git.kernel.org/lpieralisi/pci/c/2a81dd9fd9
> > > [06/12] PCI: mvebu: Add support for PCI Bridge Subsystem Vendor ID on emulated bridge
> > >         https://git.kernel.org/lpieralisi/pci/c/e3e13c9135
> > > [07/12] PCI: mvebu: Add support for Advanced Error Reporting registers on emulated bridge
> > >         https://git.kernel.org/lpieralisi/pci/c/2b6ee04c0a
> > > [08/12] PCI: mvebu: Use child_ops API
> > >         https://git.kernel.org/lpieralisi/pci/c/c099c2a761
> > > [09/12] dt-bindings: PCI: mvebu: Update information about intx interrupts
> > >         https://git.kernel.org/lpieralisi/pci/c/0124989220
> > > [10/12] PCI: mvebu: Fix macro names and comments about legacy interrupts
> > >         https://git.kernel.org/lpieralisi/pci/c/d00ea94e62
> > > [11/12] PCI: mvebu: Implement support for legacy INTx interrupts
> > >         https://git.kernel.org/lpieralisi/pci/c/ec07526264
> > > 
> > > Thanks,
> > > Lorenzo
