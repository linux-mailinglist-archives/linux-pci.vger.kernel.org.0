Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885C57878A7
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 21:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbjHXThh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Aug 2023 15:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243292AbjHXThZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Aug 2023 15:37:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FD11BE6;
        Thu, 24 Aug 2023 12:37:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2307D63E83;
        Thu, 24 Aug 2023 19:37:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4651DC433C7;
        Thu, 24 Aug 2023 19:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692905842;
        bh=B381UX5uUyWBuzt4gPftg6j/LYRWdv9CcySZJg/PAhE=;
        h=From:To:Cc:Subject:Date:From;
        b=X9cmEMTGlesTF4j1LarIq+a+xcORDhl79TtRp/MoahlxeB9Q3G0P2AL3NCKbJXLM5
         6Jci/J6uGpvdV4pNHjRnRKnRwWbsW6k4nduoFYu7esZYjHO5f8VJ+IijVj0ZOBpSvO
         v+EriMjYqEM4np1KVvcv3DbQ9VV4nGAWGW1ry0SHGhrJhW3kzoF0jgzNUx2rB4xiKt
         Hwh5QiZmoq8s/dJKxKeEGkEHf/NCkMHoMRhHhkyrzz6MYifsEetCVjO6dRjDCQwwJX
         XM4v0yokgtemJqVYkPXOBDm5AqF8MExq/U9z+8XCF8F8atE5kvtxGATkwOZOIXAOdc
         cEkw99V2cI21Q==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 00/12] PCI: Miscellaneous cleanups
Date:   Thu, 24 Aug 2023 14:37:00 -0500
Message-Id: <20230824193712.542167-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Simplify some trivial things and fix some typos and formatting
inconsistencies.

Most are based on v6.5-rc1 (actually on the current "misc" branch, so there
may be minor conflicts).

The last ("Simplify pcie_capability_clear_and_set_word()") is based on the
current "pcie-rmw" branch because it changes the same code as that branch
does.

No functional change intended for any of this, except the printk changes
("%#08x" vs "%#010x").

Bjorn Helgaas (12):
  PCI: mvebu: Remove unused struct mvebu_pcie.busn
  PCI: Unexport pcie_port_bus_type
  PCI: Remove unnecessary initializations
  PCI: Fix printk field formatting
  PCI: Use consistent put_user() pointer types
  PCI/AER: Simplify AER_RECOVER_RING_SIZE definition
  PCI: Simplify pci_pio_to_address()
  PCI: Simplify pci_dev_driver()
  PCI: Fix pci_bus_resetable(), pci_slot_resetable() name typos
  PCI: Fix typos in docs and comments
  PCI: Fix code formatting inconsistencies
  PCI: Simplify pcie_capability_clear_and_set_word() control flow

-- 
2.34.1

