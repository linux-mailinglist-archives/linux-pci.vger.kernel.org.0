Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89A674844C6
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jan 2022 16:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbiADPi0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jan 2022 10:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbiADPiZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jan 2022 10:38:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC05FC061761;
        Tue,  4 Jan 2022 07:38:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51918614CF;
        Tue,  4 Jan 2022 15:38:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D982C36AE9;
        Tue,  4 Jan 2022 15:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641310704;
        bh=IvXybqAvGHkHohoxDtW3luo+IV3CGpGdFMVR8VHUbA4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iC3Xpt1UU7slFI0TkzHOJaf7Xi3CQcepOGAkMJC6B4xa69O/5p6nC6iMgzR1fg1fO
         Y/U5xZpcXKHpa05dmEtao2eEK7rEg1U2e7yiX621RNBQQatIOj8lx+7h3E+INCVEyY
         Rfq6Rtxi0CMXbJ+fss5LHsHt57wFic99YK6IInJ7s+Kve8ebKQVQcKUIXEehoSOSGc
         ebFLx7dnxeTleM1P0CsOwRrdnAAZxaGFpDPK/CLJFFvD2x6bTeySYAjrgKwMHmPETd
         tM3BONJdeRxaU2LlggD1/+zh0cWyZvhUunXR/yVeUxD7zn1+oADBas1vFZRbrdQ0ma
         4jtGSDhNfp/iQ==
Received: by pali.im (Postfix)
        id 7555096B; Tue,  4 Jan 2022 16:38:21 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/11] PCI: Small improvements for pci-bridge-emul and mvebu
Date:   Tue,  4 Jan 2022 16:35:18 +0100
Message-Id: <20220104153529.31647-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211221141455.30011-1-pali@kernel.org>
References: <20211221141455.30011-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch series contains small improvements for pci-bridge-emul and
mvebu drivers. This patch series is based on top of the patches:
https://lore.kernel.org/linux-pci/20211125124605.25915-1-pali@kernel.org/
(which are now in pci/mvebu branch)

In V2 was added comment into code explaining PCI_BRIDGE_EMUL_NO_PREFMEM_FORWARD
and PCI_BRIDGE_EMUL_NO_IO_FORWARD flags.

Pali Rohár (11):
  MAINTAINERS: Add Pali Rohár as pci-mvebu.c maintainer
  PCI: pci-bridge-emul: Make struct pci_bridge_emul_ops as const
  PCI: pci-bridge-emul: Rename PCI_BRIDGE_EMUL_NO_PREFETCHABLE_BAR to
    PCI_BRIDGE_EMUL_NO_PREFMEM_FORWARD
  PCI: pci-bridge-emul: Add support for new flag
    PCI_BRIDGE_EMUL_NO_IO_FORWARD
  PCI: mvebu: Add help string for CONFIG_PCI_MVEBU option
  PCI: mvebu: Remove duplicate nports assignment
  PCI: mvebu: Set PCI_BRIDGE_EMUL_NO_IO_FORWARD when IO is unsupported
  PCI: mvebu: Properly initialize vendor, device and revision of
    emulated bridge
  PCI: mvebu: Update comment for PCI_EXP_LNKCAP register on emulated
    bridge
  PCI: mvebu: Update comment for PCI_EXP_LNKCTL register on emulated
    bridge
  PCI: mvebu: Fix reporting Data Link Layer Link Active on emulated
    bridge

 MAINTAINERS                           |  1 +
 drivers/pci/controller/Kconfig        |  4 ++
 drivers/pci/controller/pci-aardvark.c |  2 +-
 drivers/pci/controller/pci-mvebu.c    | 64 ++++++++++++---------------
 drivers/pci/pci-bridge-emul.c         | 11 ++++-
 drivers/pci/pci-bridge-emul.h         | 14 +++++-
 6 files changed, 57 insertions(+), 39 deletions(-)

-- 
2.20.1

