Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1146E2E9B
	for <lists+linux-pci@lfdr.de>; Sat, 15 Apr 2023 04:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjDOCfs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Apr 2023 22:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjDOCfr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2023 22:35:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B31F1
        for <linux-pci@vger.kernel.org>; Fri, 14 Apr 2023 19:35:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEEF161730
        for <linux-pci@vger.kernel.org>; Sat, 15 Apr 2023 02:35:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B84A9C433EF;
        Sat, 15 Apr 2023 02:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681526145;
        bh=nYFw4Q4QY3cpambVwYqT7BHMgZO+yFc1iIZ3PEe+Yx4=;
        h=From:To:Cc:Subject:Date:From;
        b=nBPPNEPaPCYDZKBN4YZDLZOkDC+TehHya00YOglWpUy8TaZbX1sCSK50Bi/5gaiJ2
         fCl44RfGBo1MResuYR31MeWn8f7KxVXZl4YDUqrRJkSuOnNzYmD2EuK/P7zJSX15oE
         AoDJFeGFM/qfdmxQITQGmuJkYfH2pZmZoPFexc1SUm9aUxpybMujD1yh7C6YmVUsPn
         NjxFfC8oBdll2pwacKWvmJAMLLWuFvH+E9fAeMWKBYOYTf71/ejV7i7hNm78Am9Yuo
         yWdcjEpLpoWUWUw6PjIEK6hUNBQ+yFrG3KHNSI2RwN+fBjt97ynRZtzBHa1MNB/dqk
         yZUdIx47Om1OA==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v5 00/17] PCI endpoint fixes and improvements
Date:   Sat, 15 Apr 2023 11:35:25 +0900
Message-Id: <20230415023542.77601-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.39.2
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

This series fixes several issues with the PCI endpoint code and endpoint
test drivers (RC side and EP side).

The first 2 patches address an issue with the use of configfs to create
an endpoint driver type attributes group, preventing a potential crash
if the user creates a directory multiple times for the driver type
attributes.

The following patches are fixes and improvements for the endpoint test
drivers, EP side and RC side.

This is all tested using a Pine Rockpro64 board, with the rockchip ep
driver fixed using Rick Wertenbroek <rick.wertenbroek@gmail.com>
patches [1].

[1] https://lore.kernel.org/linux-pci/20230404082426.3880812-1-rick.wertenbroek@gmail.com/

Changes from v4:
 - Addressed Bjorn comments on the commit messages (typos, text clarity)
 - Changed patch 1 to use dev_err() instead of pr_err().
 - Add print of invalid command value in patch 10
 - Chnaged all patches author and Signed-off-by tag to use my kernel.org
   email address
 - Added Mani's review tags

Changes from v3:
 - Corrected patch 7 and 12 title
 - Added patch 11

Changes from v2:
 - Add updates of the ntb and vntb function driver documentation in
   patch 1 to reflect the patch changes.
 - Removed unnecessary WARN_ON() call in patch 4
 - Added missing cc: stable tags
 - Added review tags

Changes from v1:
 - Improved patch 1 commit message
 - Modified patch 2 to not have to add an internal header file
 - Split former patch 3 into patch 3, 4 and 5
 - Removed former patch 4 introducing volatile casts and replaced it
   with patch 9
 - Added patch 6, 7, 8 and 10
 - Added Reviewed-by tags in patches not modified

Damien Le Moal (17):
  PCI: endpoint: Automatically create a function specific attributes
    group
  PCI: endpoint: Move pci_epf_type_add_cfs() code
  PCI: epf-test: Fix DMA transfer completion initialization
  PCI: epf-test: Fix DMA transfer completion detection
  PCI: epf-test: Use dmaengine_submit() to initiate DMA transfer
  PCI: epf-test: Simplify read/write/copy test functions
  PCI: epf-test: Simplify pci_epf_test_raise_irq()
  PCI: epf-test: Simplify IRQ test commands execution
  PCI: epf-test: Improve handling of command and status registers
  PCI: epf-test: Cleanup pci_epf_test_cmd_handler()
  PCI: epf-test: Cleanup request result handling
  PCI: epf-test: Simplify DMA support checks
  PCI: epf-test: Simplify transfers result print
  misc: pci_endpoint_test: Free IRQs before removing the device
  misc: pci_endpoint_test: Re-init completion for every test
  misc: pci_endpoint_test: Do not write status in IRQ handler
  misc: pci_endpoint_test: Simplify pci_endpoint_test_msi_irq()

 Documentation/PCI/endpoint/pci-ntb-howto.rst  |  11 +-
 Documentation/PCI/endpoint/pci-vntb-howto.rst |  13 +-
 drivers/misc/pci_endpoint_test.c              |  25 +-
 drivers/pci/endpoint/functions/pci-epf-test.c | 266 ++++++++----------
 drivers/pci/endpoint/pci-ep-cfs.c             |  54 ++--
 drivers/pci/endpoint/pci-epf-core.c           |  32 ---
 include/linux/pci-epf.h                       |   2 -
 7 files changed, 175 insertions(+), 228 deletions(-)

-- 
2.39.2

