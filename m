Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 802CA47C1F4
	for <lists+linux-pci@lfdr.de>; Tue, 21 Dec 2021 15:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235023AbhLUO4t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Dec 2021 09:56:49 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43878 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238680AbhLUO4t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Dec 2021 09:56:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA14B61633;
        Tue, 21 Dec 2021 14:56:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF9C1C36AE8;
        Tue, 21 Dec 2021 14:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640098608;
        bh=936LdB+AWw/0Sbf+/HopvGtMqTMu5gUY3UB8Pad1fPE=;
        h=From:To:Cc:Subject:Date:From;
        b=Zw6zbfmF594hw9C6R73I/DNFo2cUmYhrDIK0uLtY6y8Ax2mT0cdkL0OjPPSDMN/qV
         p3ig1npFgp8dZRJpnGtx45tMPk7PAbMwCxcmSIAZMKxaNKHXnJ+1FDZKKWUFUubrEC
         XhjvLhl62PJdxyHXWf1wbG3BjdNA+HJsKpHFG04krscLrYfecjToS1r+oKZxWw/tTK
         B2ewVWdqBgr+aFa0kuhek0KufTtqf3R10AysMSX2MTQw7OEo1+4brZAwzbliQicF4p
         YLzWonGURJC1QlCI6XHxe4hgKGmN5955CIxPr2lvfFNOfoWvbWyAtgnfGPJV7Wuf09
         fmv6BmmBg50lQ==
Received: by pali.im (Postfix)
        id A8D2D778; Tue, 21 Dec 2021 15:18:11 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        "Rob Herring" <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/11] PCI: Small improvements for pci-bridge-emul and mvebu
Date:   Tue, 21 Dec 2021 15:14:44 +0100
Message-Id: <20211221141455.30011-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch series contains small improvements for pci-bridge-emul and
mvebu drivers. This patch series is based on top of the patches:
https://lore.kernel.org/linux-pci/20211125124605.25915-1-pali@kernel.org/

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
 drivers/pci/pci-bridge-emul.h         |  5 ++-
 6 files changed, 48 insertions(+), 39 deletions(-)

-- 
2.20.1

