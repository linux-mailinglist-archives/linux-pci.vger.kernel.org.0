Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81A457895F
	for <lists+linux-pci@lfdr.de>; Mon, 18 Jul 2022 20:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbiGRSOb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Jul 2022 14:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiGRSOb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Jul 2022 14:14:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F1B2CCB9;
        Mon, 18 Jul 2022 11:14:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2418B816CF;
        Mon, 18 Jul 2022 18:14:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3937BC341C0;
        Mon, 18 Jul 2022 18:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658168067;
        bh=7mJAJ79anHwJ/WB2hxfx2DwpigreSJuf5+TDz+HsVrM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=N5PAtTh5h0s19MfOscwKfm7aa21gxE3sa57C64jOyouZ7OUJsYE39vA18FpeMNv7k
         zE3yKETrh12Y4gF3Efxu1HH+gAp6eG0A/GYlaa/J54vlSs//o/9sz4GRRvXwBy1bSV
         QrYDPfQdSfBgrcJggs40rKoYy72Npcsmsdt5THMcfAsYSV3F5SHRhqKzCZb3XDGyXl
         gVakm5QwwQFohcWLM8Rpz47lnWCcvteDO8CO/ZFSXUGYIVpV+Yw5rxCV2w5418Cdpl
         Kxvq3HaCSs5767/Jab8bT7Ztu91UUHkEDnAxTkOMb1KB0Gz3d0dgCCgtgLzNnp1scZ
         sYGzjyNkz/gDg==
Date:   Mon, 18 Jul 2022 13:14:25 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
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
Message-ID: <20220718181425.GA1431580@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220716222454.29914-3-jim2101024@gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jul 16, 2022 at 06:24:49PM -0400, Jim Quinlan wrote:
> Currently, the function does the setup for establishing PCIe link-up
> with the downstream device, and it does the actual link-up as well.
> The calling sequence is (roughly) the following in the probe:
> 
> -> brcm_pcie_probe()
>     -> brcm_pcie_setup();                       /* Set-up and link-up */
>     -> pci_host_probe(bridge);
> 
> This commit splits the setup function in two: brcm_pcie_setup(), which only
> does the set-up, and brcm_pcie_start_link(), which only does the link-up.
> The reason why we are doing this is to lay a foundation for subsequent
> commits so that we can turn on any power regulators, as described in the
> root port's DT node, prior to doing link-up.

All drivers that care about power regulators turn them on before
link-up, but typically those regulators are described directly under
the host bridge itself.

IIUC the difference here is that you have regulators described under
Root Ports (not the host bridge/Root Complex itself), so you don't
know about them until you've enumerated the Root Ports.
brcm_pcie_probe() can't turn them on directly because it doesn't know
what Root Ports are present and doesn't know about regulators below
them.

So I think brcm_pcie_setup() does initialization that doesn't depend
on the link or any downstream devices, and brcm_pcie_start_link() does
things that depend on the link being up.  Right?

If so, "start_link" might be a slight misnomer since AFAICT
brcm_pcie_start_link() doesn't do anything to initiate link-up except
maybe deasserting fundamental reset.  Some drivers start the LTSSM or
explicitly enable link training, but brcm_pcie_start_link() doesn't
seem to do anything like that.

brcm_pcie_start_link() still does brcm_pcie_set_outbound_win().  Does
that really depend on the link being up?  If that only affects the
Root Port, maybe it could be done before link-up?

> We do this by defining an
> add_bus() callback which is invoked during enumeraion.  At the end of this
> patchset the probe function trace will look something like this:
> 
> -> brcm_pcie_probe()
>     -> brcm_pcie_setup();                       /* Set-up only */
>     -> pci_host_probe(bridge);
>         -> [enumeration]
>             -> pci_alloc_child_bus()
>                 -> bus->ops->add_bus(bus);      /* We've set this op */
>                 -> brcm_pcie_add_bus()          /* Our callback      */
>                      -> [turn on regulators]    /* Main objective!   */
>                      -> brcm_pcie_start_link()  /* Link-up           */
