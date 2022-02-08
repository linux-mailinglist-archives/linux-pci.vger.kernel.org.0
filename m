Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13FF44AD70A
	for <lists+linux-pci@lfdr.de>; Tue,  8 Feb 2022 12:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245360AbiBHLbi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Feb 2022 06:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356513AbiBHKuY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Feb 2022 05:50:24 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1AC6C03FEC0
        for <linux-pci@vger.kernel.org>; Tue,  8 Feb 2022 02:50:22 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5864C11D4;
        Tue,  8 Feb 2022 02:50:22 -0800 (PST)
Received: from e123427-lin.arm.com (unknown [10.57.37.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D7873F73B;
        Tue,  8 Feb 2022 02:50:21 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        pali@kernel.org
Subject: Re: (subset) [PATCH v2 00/23] PCI: aardvark controller fixes BATCH 4
Date:   Tue,  8 Feb 2022 10:50:13 +0000
Message-Id: <164431738306.20265.453911406614125295.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220110015018.26359-1-kabel@kernel.org>
References: <20220110015018.26359-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 10 Jan 2022 02:49:55 +0100, Marek Behún wrote:
> this is v2 of fourth batch of fixes for the Aardvark PCIe controller
> driver.
> 
> Stuff is converted to new interrupt APIs and recommendations from Marc.
> Marc, could you look at these and acknowledge or comment?
> 
> This series mainly fixes and adds support for stuff around interrupts:
> the most important thing is fixing MSI support.
> 
> [...]

Applied to pci/aardvark, thanks!

[01/23] PCI: aardvark: Replace custom PCIE_CORE_INT_* macros with PCI_INTERRUPT_*
        https://git.kernel.org/lpieralisi/pci/c/1d86abf1f8
[02/23] PCI: aardvark: Fix reading MSI interrupt number
        https://git.kernel.org/lpieralisi/pci/c/805dfc18dd
[03/23] PCI: aardvark: Fix support for MSI interrupts
        https://git.kernel.org/lpieralisi/pci/c/b0b0b8b897
[04/23] PCI: aardvark: Rewrite IRQ code to chained IRQ handler
        https://git.kernel.org/lpieralisi/pci/c/1571d67dc1
[05/23] PCI: aardvark: Check return value of generic_handle_domain_irq() when processing INTx IRQ
        https://git.kernel.org/lpieralisi/pci/c/51f96e287c
[06/23] PCI: aardvark: Make MSI irq_chip structures static driver structures
        https://git.kernel.org/lpieralisi/pci/c/c3cb8e5183
[07/23] PCI: aardvark: Make msi_domain_info structure a static driver structure
        https://git.kernel.org/lpieralisi/pci/c/26bcd54e4a
[08/23] PCI: aardvark: Use dev_fwnode() instead of of_node_to_fwnode(dev->of_node)
        https://git.kernel.org/lpieralisi/pci/c/222af78532
[09/23] PCI: aardvark: Refactor unmasking summary MSI interrupt
        https://git.kernel.org/lpieralisi/pci/c/4689c09163
[10/23] PCI: aardvark: Add support for masking MSI interrupts
        https://git.kernel.org/lpieralisi/pci/c/e77d9c9069
[11/23] PCI: aardvark: Fix setting MSI address
        https://git.kernel.org/lpieralisi/pci/c/46ad3dc417
[12/23] PCI: aardvark: Enable MSI-X support
        https://git.kernel.org/lpieralisi/pci/c/754e449889
[13/23] PCI: aardvark: Add support for ERR interrupt on emulated bridge
        https://git.kernel.org/lpieralisi/pci/c/3ebfefa396
[14/23] PCI: aardvark: Fix reading PCI_EXP_RTSTA_PME bit on emulated bridge
        https://git.kernel.org/lpieralisi/pci/c/735f5ae49e
[15/23] PCI: aardvark: Optimize writing PCI_EXP_RTCTL_PMEIE and PCI_EXP_RTSTA_PME on emulated bridge
        https://git.kernel.org/lpieralisi/pci/c/7122bcb332
[16/23] PCI: aardvark: Add support for PME interrupts
        https://git.kernel.org/lpieralisi/pci/c/0fc75d8745
[17/23] PCI: aardvark: Fix support for PME requester on emulated bridge
        https://git.kernel.org/lpieralisi/pci/c/273ddd86d6
[18/23] PCI: aardvark: Use separate INTA interrupt for emulated root bridge
        https://git.kernel.org/lpieralisi/pci/c/815bc31368
[19/23] PCI: aardvark: Remove irq_mask_ack callback for INTx interrupts
        https://git.kernel.org/lpieralisi/pci/c/b08e5b53d1
[20/23] PCI: aardvark: Don't mask irq when mapping
        https://git.kernel.org/lpieralisi/pci/c/befa710001
[21/23] PCI: aardvark: Drop __maybe_unused from advk_pcie_disable_phy()
        https://git.kernel.org/lpieralisi/pci/c/0c36ab437e
[22/23] PCI: aardvark: Update comment about link going down after link-up
        https://git.kernel.org/lpieralisi/pci/c/92f4ffecc4

Thanks,
Lorenzo
