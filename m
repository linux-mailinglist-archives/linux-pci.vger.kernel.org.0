Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928A256C2BA
	for <lists+linux-pci@lfdr.de>; Sat,  9 Jul 2022 01:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238889AbiGHTH3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Jul 2022 15:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238639AbiGHTH3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Jul 2022 15:07:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5E12656F;
        Fri,  8 Jul 2022 12:07:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0E11B824F7;
        Fri,  8 Jul 2022 19:07:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DEB2C341C0;
        Fri,  8 Jul 2022 19:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657307245;
        bh=rjeSBuy7WINmWx1pFu173n7NXaBRljwS3TEUUol/8xA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Qr2pIIxsT2+b8vifONEdOuiCMeFMq+Fdai7jvFef2HwpemnemDmbIpP3eaGbsmuox
         KHOi3zFjMCjR4O7rRCM2PTdRRGSN+AQuIKuRv1LutHC81uf0AAtDdyokB3ZXlmzXQq
         xAeyocy5ylC80h/i6Da+PF5y694B0C79aUCgR7jUwl+9MQapwkEq6+dzOVLaWgxc7M
         q4D+CjrsYvDqPbHo+aZskqtk6ehJZ5dY6V20cu5ukQ58L+PMcrnXMogUzUt5UE0QGK
         DyFJVIkSeDLJBVraMvoBmZ2ozjZAmWgQhhT+RWfiShELqvlT/8zwhr7xiQ3oQJFLSo
         RCvFlPlESAAAw==
Date:   Fri, 8 Jul 2022 14:07:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/4] PCI: brcmstb: Add mechanism to turn on subdev
 regulators
Message-ID: <20220708190723.GA366169@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+-6iNyfi805jef2dSAAup5r=V=WEE0dm5=kYLMhLrcAfeQHUQ@mail.gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 08, 2022 at 10:14:11AM -0400, Jim Quinlan wrote:
> On Wed, Jul 6, 2022 at 7:12 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Jul 01, 2022 at 12:27:23PM -0400, Jim Quinlan wrote:
> > > Add a mechanism to identify standard PCIe regulators in the DT, allocate
> > > them, and turn them on before the rest of the bus is scanned during
> > > pci_host_probe().
> > > ...

> > > +static int pci_subdev_regulators_add_bus(struct pci_bus *bus);
> > > +static void pci_subdev_regulators_remove_bus(struct pci_bus *bus);
> >
> > I think these forward declarations are unnecessary.  I can remove them
> > if you agree.
> 
> It is up to you.  I have a commit-set ready that will make a number of
> improvements to our driver.
> One of them removes all forward declarations.  Other commits concern
> other suggestions you
> have made, e.g. rename brcm_pcie_linkup() to brcm_pcie_start_link().

If you're planning a v2, I'd drop the declarations there.  No point in
adding them, only to remove them in a future patch (unless we need
them in the interim, of course, but in this case I don't think we do).

Bjorn
