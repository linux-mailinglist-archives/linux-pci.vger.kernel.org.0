Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEFB6765318
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jul 2023 14:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbjG0MCM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jul 2023 08:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbjG0MCL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Jul 2023 08:02:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE958272C;
        Thu, 27 Jul 2023 05:02:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CB9061E4E;
        Thu, 27 Jul 2023 12:02:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C1C1C433C7;
        Thu, 27 Jul 2023 12:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690459329;
        bh=RRiuWw1RRzp5VPyZrgQCbrk18E8FE12rDzgmRmwDd30=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=h1AXazZy43+rn8mCiejHmBFcGhYww8GloBdqqxzrnymBbeJYa291e0x+5z5c7yd6T
         rW6/C/g+l/Fo5infe0clk3A2O75sZYIKdCax4Ao874pZYvJ8PsXNk6PqiOMqyXS+FJ
         iYYFvnXfpwiiyCoDsmhzLFj08or32t90/SysSG4ZHm9Jrt5ZW31qhV+9/qMFj0L2c5
         GaYRmzreC1gLBpTuiu1pCh1Ddg7TUv6+rGTVvM++ftwpOqhpGZ66McVFfsE8wv/djK
         L/Wnc1yl9iWwzCgwSj3LXN3VyH6iAXEOHrZ47eO3g95K/ZJxzAU5B5vL809hYfzsRC
         0zm3xbUJNaBnA==
Date:   Thu, 27 Jul 2023 07:02:07 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Minda Chen <minda.chen@starfivetech.com>
Cc:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
Subject: Re: [PATCH v2 2/4] PCI: plda: Get common codes from Microchip
 PolarFire host
Message-ID: <20230727120207.GA769710@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727103949.26149-3-minda.chen@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 27, 2023 at 06:39:47PM +0800, Minda Chen wrote:
> Add PLDA PCIe controller driver codes, Move them from Microchip
> PolarFire PCIe host driver codes. And move pcie-microchip-host.c
> to plda directory.
> 
> The change includes:
> - copy the IP register marcos.
> - Add related data structures of PCIe host instance.
>   mc_pcie --> plda_pcie (Get most of data members)
>   mc_msi  --> plda_msi
>   add plda_pcie_ops and plda_evt data structures.
> - function rename list:
>   mc_pcie_enable_msi       --> plda_pcie_enable_msi
>   mc_pcie_setup_window     --> plda_pcie_setup_window
>   mc_pcie_setup_windows    --> plda_pcie_setup_iomems
>   mc_pcie_init_irq_domains --> plda_pcie_init_irq_domains
>   mc_allocate_msi_domains  --> plda_allocate_msi_domains
>   mc_init_interrupts       --> plda_pcie_init_irq
>   msi interrupts related functions and irq domain
>   (primary function is mc_handle_msi):
>   mc_handle_msi            --> plda_handle_msi
>   intx interrupts related functions and irq domain
>   (primary function is mc_handle_intx):
>   mc_handle_intx           --> plda_handle_intx
>   event interrupts:
>   mc_handle_event	   --> plda_handle_event
> - For PolarFire implements non-plda local interrupt events, most of
>   event interrupt process codes can not be re-used. PLDA implements
>   new codes and irq domain ops like PolarFire.
>   New event functions:
>     plda_event_handler
>     plda_pcie_event_map
>     plda_ack_event_irq
>     plda_mask_event_irq
>     plda_unmask_event_irq
>     plda_hwirq_to_mask
> - plda_handle_event adds a new irqnum to event num mapping codes for
>   PLDA local event except DMA engine interrupt events. The DMA engine
>   interrupt events are implemented by vendors. So do not add these
>   events. PolarFire PCIe uses get_events function pointer to get
>   their events num.

There's a lot going on here, which makes this hard to review.  If
possible, I suggest splitting this into multiple patches:

  - Move code to plda/ directory with no other changes
  - Rename structs/functions from mc_* to plda_* with no other changes
  - Add PolarFire-specific code

Other general things:

  - Capitalize PLDA, IRQ, INTx, MSI, PCIe in commit logs, comments,
    dmesg text
  - Sort MAINTAINERS entries alphabetically; see
    https://git.kernel.org/linus/c192ac735768

Bjorn
