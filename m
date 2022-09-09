Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373C45B4075
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 22:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiIIUZN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 16:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiIIUZM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 16:25:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61EA96777;
        Fri,  9 Sep 2022 13:25:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D400620BA;
        Fri,  9 Sep 2022 20:25:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D7C2C433D6;
        Fri,  9 Sep 2022 20:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662755109;
        bh=zXin2k6immi9tRPLVqcDbBOQa3ynjPMF/61sq6IxOfs=;
        h=From:To:Cc:Subject:Date:From;
        b=THWl6dZUIK4gf+Qcoy1C86uQh+oNBTxuoyebdvnf1ttaIdKiqlM3SJsz3qdoYfsjy
         380DhO6arhGh5i0oIweM8c2dJuFoLlAydHYaa1louu9iUNC/50Q7Wp1kI3Su16YWT8
         RSiZNFz6xV4/vqjqBLZhXbhBESqEn8mz21rW9YCLcSSiiyHU2sGh8p8P/OsOt13l7W
         IzX9enk3iqI13+Q4O+yRGjHH3bMhAIkjpcncf4Tm4MCb7ItXmqUyx5VBTDp7VVSPus
         Zd6R4JuVrwqR/aJC5VmFKSwPS/At/NyQgfF6tjDLEAbw3wleY3n9Ja7J7abOAkpfUL
         D+wfrbAKReo/A==
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
Subject: [PATCH v4 0/9] PCI/PM: Always disable PTM for all devices during suspend
Date:   Fri,  9 Sep 2022 15:24:56 -0500
Message-Id: <20220909202505.314195-1-helgaas@kernel.org>
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
enabled for downstream devices causes UR errors if they send PTM Requests
to upstream devices that have PTM disabled.

The intent of this series is to:

  - Unconditionally disable PTM during suspend (even if the driver saves
    its own state) by moving the disable from pci_prepare_to_sleep() to
    pci_pm_suspend().

  - Disable PTM for all devices by removing the Root Port condition and
    doing it early in the suspend paths.

  - Explicitly re-enable PTM during resume.

Changes between v3 and v4:
  - Use u16 for ptm_cap
  - Add kernel-doc for pci_enable_ptm() and pci_disable_ptm() (exported
    functions)
  - Drop "Preserve PTM Root Select" (unnecessary since enabling PTM sets
    Root Select when needed)
  - Squash these three patches into one because they make more sense that
    way:
	PCI/PTM: Add suspend/resume
	PCI/PTM: Add pci_enable_ptm() wrapper
	PCI/PTM: Add pci_disable_ptm() wrapper
  - Add "PCI/PTM: Preserve RsvdP bits in PTM Control register"
  - Add "PCI/PTM: Consolidate PTM interface declarations"

Bjorn Helgaas (9):
  PCI/PTM: Cache PTM Capability offset
  PCI/PTM: Add pci_upstream_ptm() helper
  PCI/PTM: Separate configuration and enable
  PCI/PTM: Add pci_suspend_ptm() and pci_resume_ptm()
  PCI/PTM: Move pci_ptm_info() body into its only caller
  PCI/PTM: Preserve RsvdP bits in PTM Control register
  PCI/PTM: Reorder functions in logical order
  PCI/PTM: Consolidate PTM interface declarations
  PCI/PM: Always disable PTM for all devices during suspend

 drivers/pci/pci-driver.c |  11 ++
 drivers/pci/pci.c        |  28 +--
 drivers/pci/pci.h        |  14 +-
 drivers/pci/pcie/ptm.c   | 384 +++++++++++++++++++++------------------
 include/linux/pci.h      |   3 +
 5 files changed, 234 insertions(+), 206 deletions(-)

-- 
2.25.1

