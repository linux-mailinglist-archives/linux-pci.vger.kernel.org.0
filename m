Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191D6578D9E
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jul 2022 00:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbiGRWkH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Jul 2022 18:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234908AbiGRWkG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Jul 2022 18:40:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85EA2BB04;
        Mon, 18 Jul 2022 15:40:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 364EBB817B1;
        Mon, 18 Jul 2022 22:40:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD605C341C0;
        Mon, 18 Jul 2022 22:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658184003;
        bh=1aFmPSkN+eagXMzM2UhrmyC197VaFyr+ob4HH3VJnOM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=i6dod+Gg9t7S2m5jhwrZaYhc/CEWouVzPBYUpPvjCUfu415cW7RT36QV5KSiBUILw
         OJl5UhyysiCDFoXrVxQGsIangXj1B6qVawJg799QutQFlcLp9YrZCqDlJusiCOani9
         bpvbsaGSehixnEzJpx/zrvG7tYndlGxUyz8MR/X2x9LpQKWng+eaPNm+5WdNBKZQm1
         hS94aGjcPofP/LoU22U5Iqo+M2paLim9dJ9bfkLC30F4WD9EYcX8bSggJN6DIkd1ys
         qTcihfM+tBTVTZb9medpOau4UG/UVEnoYkvg3JMPc/2gsP6vr0eoLwK/fzaaXoyaF7
         NrZxxEIFP09bg==
Date:   Mon, 18 Jul 2022 17:40:00 -0500
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
Subject: Re: [PATCH v2 2/6] PCI: brcmstb: Split brcm_pcie_setup() into two
 funcs
Message-ID: <20220718224000.GA1456196@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+-6iNwjPr2gu_oyn4NheLPJZHh-3eib-3onz63sfNOJpdJ6Tw@mail.gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 18, 2022 at 02:56:03PM -0400, Jim Quinlan wrote:
> On Mon, Jul 18, 2022 at 2:14 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Sat, Jul 16, 2022 at 06:24:49PM -0400, Jim Quinlan wrote:
> > > Currently, the function does the setup for establishing PCIe link-up
> > > with the downstream device, and it does the actual link-up as well.
> > > The calling sequence is (roughly) the following in the probe:
> > >
> > > -> brcm_pcie_probe()
> > >     -> brcm_pcie_setup();                       /* Set-up and link-up */
> > >     -> pci_host_probe(bridge);
> > >
> > > This commit splits the setup function in two: brcm_pcie_setup(), which only
> > > does the set-up, and brcm_pcie_start_link(), which only does the link-up.
> > > The reason why we are doing this is to lay a foundation for subsequent
> > > commits so that we can turn on any power regulators, as described in the
> > > root port's DT node, prior to doing link-up.
> >
> > All drivers that care about power regulators turn them on before
> > link-up, but typically those regulators are described directly under
> > the host bridge itself.
> 
> Actually, what you describe is what I proposed with my v1 back in Nov 2020.
> The binding commit message said,
> 
>     "Quite similar to the regulator bindings found in
>     "rockchip-pcie-host.txt", this allows optional regulators to be
>     attached and controlled by the PCIe RC driver."
> 
> > IIUC the difference here is that you have regulators described under
> > Root Ports (not the host bridge/Root Complex itself), so you don't
> > know about them until you've enumerated the Root Ports.
> > brcm_pcie_probe() can't turn them on directly because it doesn't know
> > what Root Ports are present and doesn't know about regulators below
> > them.
> 
> The reviewer's requested me to move the regulator node(s)
> elsewhere, and at some point later it was requested to be placed
> under the Root Port driver.  I would love to return them under the
> host bridge, just say the word!

Actually, I think my understanding is wrong.  Even though the PCI core
hasn't enumerated the Root Port as a pci_dev, brcm_pcie_setup() knows
about it and should be able to look up the regulators and turn them
on.

Can you dig up the previous discussion about why the regulators need
to be under the Root Port and why they can't be turned on before
calling pci_host_probe()?

Bjorn
