Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C5C3F30E0
	for <lists+linux-pci@lfdr.de>; Fri, 20 Aug 2021 18:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbhHTQE5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Aug 2021 12:04:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:43980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234797AbhHTQCa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Aug 2021 12:02:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 359376125F;
        Fri, 20 Aug 2021 16:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629475312;
        bh=E0spK2WvLv0kR6hFChEuyMy0Zl7nye/F5istWij8HSY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UCrloWHJSOMX1LJD7jHHyA9GepGsK+T3wFE+RRSHNJaZyFRQ8B0Oy/PjSJLJXgbdV
         w6MotSpZt5Bm6PNrMtbAY/q7a4HTT6U/7fe6N778Y0ZO7vH1pfIZMOvSAjhq46DNjP
         i16X4uHrU/z8EP3BIwvjt0Crg0UeRPPckFxI6RjeWjQ6s9VK7Z86BkMMLhOXKgvp4L
         iwaH8/EZkIyecDDceDPowGhxW1A2mjGrcwA5rSISfOSN8NOnS+Ul3isWwuYijJBuOm
         sQmLrAVs8uGYWk1PpRdx1eJBl+wsWoYd7iV7xjM6RAhCNy4jGYYaENzWXxjxL8S08R
         O9cm8dS55A+jA==
Received: by pali.im (Postfix)
        id EC4F17C5; Fri, 20 Aug 2021 18:01:51 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/3] arm64: dts: armada-3720-turris-mox: Define slot-power-limit for PCIe
Date:   Fri, 20 Aug 2021 18:00:23 +0200
Message-Id: <20210820160023.3243-4-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210820160023.3243-1-pali@kernel.org>
References: <20210820160023.3243-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIe Slot Power Limit on Turris Mox is 10W.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
index 86b3025f174b..1db928dff9ec 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
@@ -134,6 +134,7 @@
 	pinctrl-0 = <&pcie_reset_pins &pcie_clkreq_pins>;
 	status = "okay";
 	reset-gpios = <&gpiosb 3 GPIO_ACTIVE_LOW>;
+	slot-power-limit = <10000>;
 	/*
 	 * U-Boot port for Turris Mox has a bug which always expects that "ranges" DT property
 	 * contains exactly 2 ranges with 3 (child) address cells, 2 (parent) address cells and
-- 
2.20.1

