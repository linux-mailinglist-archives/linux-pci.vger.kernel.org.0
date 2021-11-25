Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5921145DA4C
	for <lists+linux-pci@lfdr.de>; Thu, 25 Nov 2021 13:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354505AbhKYMvq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Nov 2021 07:51:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:45096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237495AbhKYMto (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Nov 2021 07:49:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD70E61074;
        Thu, 25 Nov 2021 12:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637844393;
        bh=1XclSRaolokdnja6teAdCvRFwmwoQlvxxpkApF8Sjnw=;
        h=From:To:Cc:Subject:Date:From;
        b=U2C/BvEST8d9Tj26du0mnnsupLv+jpm2tRI3Luz8v7fn/I5mNozRkBN5177K63bcW
         dK3MGG+LgxB3GlSUjfcjeSKrlOyKwRYnmmZHfpAAximNVkgYZ7RLtSfyJzGHCRXgLQ
         0C0BJd1XpfBKi4/sbJWRL8wwKPg9XR3UKsRAGTroRtFYwOUOed9C6RRy6y8QY6cQVa
         gYtD2kqwzxj3bzCdi2q4IsOaTYCanbYTQ0gun5ZbYtDCPjf65vdgk4+Ccq0f7Euk+t
         DYq1o5bi37Xy2dSbCw241liWcqO+xAEsoTwxmCxqsPmxYMtzALIn+/zooHk3Bfsjar
         QqA+6OY9/m0Ng==
Received: by pali.im (Postfix)
        id DDC8C67E; Thu, 25 Nov 2021 13:46:29 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/15] pci: mvebu: Various fixes
Date:   Thu, 25 Nov 2021 13:45:50 +0100
Message-Id: <20211125124605.25915-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch series contains various fixes for pci-mvebu.c driver. Only
bugfixes, no new features.

For pci-mvebu.c I have prepared another 30+ patches with cleanups and
new features, they are currently available in my git branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pali/linux.git/log/?h=pci-mvebu

Pali Rohár (15):
  PCI: mvebu: Check for valid ports
  PCI: mvebu: Check for errors from pci_bridge_emul_init() call
  PCI: mvebu: Check that PCI bridge specified in DT has function number
    zero
  PCI: mvebu: Handle invalid size of read config request
  PCI: mvebu: Disallow mapping interrupts on emulated bridges
  PCI: mvebu: Fix support for bus mastering and PCI_COMMAND on emulated
    bridge
  PCI: mvebu: Do not modify PCI IO type bits in conf_write
  PCI: mvebu: Propagate errors when updating PCI_IO_BASE and
    PCI_MEM_BASE registers
  PCI: mvebu: Setup PCIe controller to Root Complex mode
  PCI: mvebu: Set PCI Bridge Class Code to PCI Bridge
  PCI: mvebu: Fix configuring secondary bus of PCIe Root Port via
    emulated bridge
  PCI: mvebu: Fix support for PCI_BRIDGE_CTL_BUS_RESET on emulated
    bridge
  PCI: mvebu: Fix support for PCI_EXP_DEVCTL on emulated bridge
  PCI: mvebu: Fix support for PCI_EXP_RTSTA on emulated bridge
  PCI: mvebu: Fix support for DEVCAP2, DEVCTL2 and LNKCTL2 registers on
    emulated bridge

 drivers/pci/controller/pci-mvebu.c | 380 ++++++++++++++++++++++++-----
 1 file changed, 313 insertions(+), 67 deletions(-)

-- 
2.20.1

