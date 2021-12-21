Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4D3547C1F8
	for <lists+linux-pci@lfdr.de>; Tue, 21 Dec 2021 15:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238680AbhLUO4v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Dec 2021 09:56:51 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43888 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238685AbhLUO4t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Dec 2021 09:56:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 469F46163B;
        Tue, 21 Dec 2021 14:56:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E567C36AF9;
        Tue, 21 Dec 2021 14:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640098608;
        bh=uG8b6cgDUIxA5J6r1/yrflQam4I3mKXv7eeo14u0x7E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XGuXWjzNpMsCbwhwKBwyE485895PsET52JbD9yqC3D5PnhIJSk/dFZ+OT8FNR9/+k
         9vDIAHnIn8dMOucAw+JyLKvVis6LmmZEASLg9lf0gJdgAb1DMZ3dekkeDwnxGDzs0V
         NjsJenxBxiY7fns0WUATrQs5UO8RVEcKTNBt/659LsIZjEv+J8OEs8xs9icKXZ6Ojh
         w9DEE6SpE1MOHdSHBx3BZo4JOJ7NhxTgK/zULyUxYFppmWXZtWWcMXgQo84FT+nZUv
         lM5WtdmBCtc5EiDRSEFJrqgh8jSdiyVFoQEGqleDy8iliixQH9UyhoVxoHoP7O3gJy
         b8i41UhlatYWQ==
Received: by pali.im (Postfix)
        id 381AF2AB3; Tue, 21 Dec 2021 15:18:16 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        "Rob Herring" <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] PCI: mvebu: Update comment for PCI_EXP_LNKCAP register on emulated bridge
Date:   Tue, 21 Dec 2021 15:14:53 +0100
Message-Id: <20211221141455.30011-10-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211221141455.30011-1-pali@kernel.org>
References: <20211221141455.30011-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Reason for clearing this bit is because mvebu hw returns incorrectly this bit set to 1.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/controller/pci-mvebu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 94ef00b6d697..1aac65977b97 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -546,8 +546,8 @@ mvebu_pci_bridge_emul_pcie_conf_read(struct pci_bridge_emul *bridge,
 
 	case PCI_EXP_LNKCAP:
 		/*
-		 * PCIe requires the clock power management capability to be
-		 * hard-wired to zero for downstream ports
+		 * PCIe requires that the Clock Power Management capability bit
+		 * is hard-wired to zero for downstream ports but HW returns 1.
 		 */
 		*value = mvebu_readl(port, PCIE_CAP_PCIEXP + PCI_EXP_LNKCAP) &
 			 ~PCI_EXP_LNKCAP_CLKPM;
-- 
2.20.1

