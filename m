Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F235AF7D2
	for <lists+linux-pci@lfdr.de>; Wed,  7 Sep 2022 00:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiIFWX6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Sep 2022 18:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiIFWX5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2022 18:23:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A88A9C27;
        Tue,  6 Sep 2022 15:23:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCE9761711;
        Tue,  6 Sep 2022 22:23:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E484FC433C1;
        Tue,  6 Sep 2022 22:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662503036;
        bh=eAJVKKjSyS9O0xywzIN+Y34OoPYnRpz2oqS3VOvQdAw=;
        h=From:To:Cc:Subject:Date:From;
        b=oTQ5RW0zFq/HCqu8W9kLOhMyrlTUXGaT8irHzikNEKbB2jTw3yIAwkqhSpcNE5h+j
         SlIveyaa2UXiVqfYpU2QiBT6lbtcAbIF4rgrj7UpB3hvO2ZUhKPr/sg8Zep13RGmQg
         cREqHfYNiWnxskmm5Tcv178xb+MVjKmvqcOG3xNkL/uzB3KQot4bug36LpUyvwgmCI
         CaqD7GL1tI1ojI1ZCxBGSvjINAMbDob4x2PioFzPJVY8Bi//mPtH5mR/Oc5G7QjAVX
         ofP+Ic08lOrI7LNDODkX6Eqij+L/D7AvHv3Zwdk2tn49sY6LSS0p4uyyXC3fhG6wym
         fCL4NNzP2pjLA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Rajvi Jingar <rajvi.jingar@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Koba Ko <koba.ko@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 00/10] PCI/PM: Always disable PTM for all devices during suspend
Date:   Tue,  6 Sep 2022 17:23:41 -0500
Message-Id: <20220906222351.64760-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

We currently disable PTM for Root Ports during suspend.  Leaving PTM
enabled for downstream devices causes UR errors if they send PTM Requests.
The intent of this series is to:

  - Unconditionally disable PTM during suspend (even if the driver saves
    its own state) by moving the disable from pci_prepare_to_sleep() to
    pci_pm_suspend().

  - Disable PTM for all devices by removing the Root Port condition and
    doing it early in the suspend paths.

  - Explicitly re-enable PTM during resume.

This got long and pretty complicated to read via the patches.  The end
result of ptm.c might help as a roadmap to where I hoped to go:

  https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/tree/drivers/pci/pcie/ptm.c?h=07c2204ab0f3

Basically I wanted to make pci_enable_ptm() and pci_disable_ptm() flip the
PCI_PTM_CTRL_ENABLE bit and nothing else, with all the setup based on the
PTM Capabilities register done in pci_ptm_init().

Bjorn Helgaas (10):
  PCI/PTM: Preserve PTM Root Select
  PCI/PTM: Cache PTM Capability offset
  PCI/PTM: Add pci_upstream_ptm() helper
  PCI/PTM: Separate configuration and enable
  PCI/PTM: Add pci_disable_ptm() wrapper
  PCI/PTM: Add pci_enable_ptm() wrapper
  PCI/PTM: Add suspend/resume
  PCI/PTM: Move pci_ptm_info() body into its only caller
  PCI/PTM: Reorder functions in logical order
  PCI/PM: Always disable PTM for all devices during suspend

 drivers/pci/pci-driver.c |  11 ++
 drivers/pci/pci.c        |  28 +---
 drivers/pci/pci.h        |   6 +-
 drivers/pci/pcie/ptm.c   | 317 ++++++++++++++++++++-------------------
 include/linux/pci.h      |   3 +
 5 files changed, 181 insertions(+), 184 deletions(-)

-- 
2.25.1

