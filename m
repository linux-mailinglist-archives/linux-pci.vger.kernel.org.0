Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E798E6DE416
	for <lists+linux-pci@lfdr.de>; Tue, 11 Apr 2023 20:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjDKSmb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Apr 2023 14:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjDKSma (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Apr 2023 14:42:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442E8ED;
        Tue, 11 Apr 2023 11:42:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D206762AE1;
        Tue, 11 Apr 2023 18:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1214C433EF;
        Tue, 11 Apr 2023 18:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681238549;
        bh=JO2yqbVvUl+G5u1FQlq1qzpv9f0fp/hLz6Ixw1ixQeQ=;
        h=Date:From:To:Cc:Subject:From;
        b=b/DRcx6mLKP8q7GXpd+v9EOZX7sW44uOpdNrpFAPqN6AQ0tkhgRpm6DKSx8JU0gIC
         CX05xqqtsgTiXLM04cF8Fa1vRLFeW29uJdxgXStcyCfvXMzyA8+P5Oj7lI6DRh9bxp
         iY4aD9FwrL0lIwDJ8ySblVXZPIoRsnGRi28bmc5/Pelb2xXUfdQ/2tG6761nA/Y3HR
         VzHt3K7QwRwM0xN1GZrHaJ8t2nDPXEqzbxsgYdTOkBvjfaOCOA5ZVGg7BZ8IoYiEqn
         tba7Ub6WhXAPUBTGZwm+w+4C/tBk7vKPZ4Xi+b2csbmtu6cVMznCVwqK3/JmyE6k9a
         r/cmqdLxISf6w==
Date:   Tue, 11 Apr 2023 13:42:27 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Thomas Glanzmann <thomas@glanzmann.de>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Arnd Bergmann <arnd@kernel.org>
Subject: [GIT PULL] PCI fixes for v6.3
Message-ID: <20230411184227.GA4167614@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pci-v6.3-fixes-2

for you to fetch changes up to 30ba2d09edb5ea857a1473ae3d820911347ada62:

  PCI: Fix use-after-free in pci_bus_release_domain_nr() (2023-04-06 18:20:59 -0500)

----------------------------------------------------------------
- Provide pci_msix_can_alloc_dyn() stub when CONFIG_PCI_MSI unset to avoid
  build errors (Reinette Chatre)

- Quirk AMD XHCI controller that loses MSI-X state in D3hot to avoid broken
  USB after hotplug or suspend/resume (Basavaraj Natikar)

- Fix use-after-free in pci_bus_release_domain_nr() (Rob Herring)

----------------------------------------------------------------
Basavaraj Natikar (1):
      x86/PCI: Add quirk for AMD XHCI controller that loses MSI-X state in D3hot

Reinette Chatre (1):
      PCI/MSI: Provide missing stub for pci_msix_can_alloc_dyn()

Rob Herring (1):
      PCI: Fix use-after-free in pci_bus_release_domain_nr()

 arch/x86/pci/fixup.c | 21 +++++++++++++++++++++
 drivers/pci/remove.c |  5 +++--
 include/linux/pci.h  |  2 ++
 3 files changed, 26 insertions(+), 2 deletions(-)
