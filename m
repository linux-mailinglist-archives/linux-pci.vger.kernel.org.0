Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB25E2A842
	for <lists+linux-pci@lfdr.de>; Sun, 26 May 2019 06:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbfEZEkH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 26 May 2019 00:40:07 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8154 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbfEZEkH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 26 May 2019 00:40:07 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cea18a60000>; Sat, 25 May 2019 21:40:06 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sat, 25 May 2019 21:40:06 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sat, 25 May 2019 21:40:06 -0700
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 26 May
 2019 04:40:05 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sun, 26 May 2019 04:40:05 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cea18a10000>; Sat, 25 May 2019 21:40:05 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <kishon@ti.com>, <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>
CC:     <mperttunen@nvidia.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V8 15/15] arm64: Add Tegra194 PCIe driver to defconfig
Date:   Sun, 26 May 2019 10:07:51 +0530
Message-ID: <20190526043751.12729-16-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190526043751.12729-1-vidyas@nvidia.com>
References: <20190526043751.12729-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558845606; bh=jKp2Rlg39I5yuNkDTP+nvGTq26lS/D1UJs7eSaA/A/M=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=I1+KtyS56dE/+1pQqY8wCWP5AQG+JrKilE89Y+4eqryUQWqwEPOYW4I/y/DGd+X+v
         Tn59WBnJfGyOQt7IfMXvS3jTbf2crU07Ps6m0dtewCKG6tHKbCdB6NPgiUIqWNOdL7
         U5XTwfZ2StAcRfg61iovp9TpWLSLnyEpa8zONb0Ce9Id3Ls3OzQAV7QgyhwdKzoF3Q
         2pbwAUVLz5BeTXxjpFZgOxttluQxdgJAXfdbpRg8hGVeD9tLwMvyzGNgHPPLsdjd/c
         +YxCoorpW88oHq6d+8fST4Ci77Hj6WAD1Svpxy+G0Ldhn4koH/QNiDTEn3d2qB77vZ
         raBBhSXDGLsvQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCIe host controller driver for DesignWare core based
PCIe controller IP present in Tegra194.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
Changes since [v7]:
* None

Changes since [v6]:
* None

Changes since [v5]:
* None

Changes since [v4]:
* None

Changes since [v3]:
* None

Changes since [v2]:
* None

Changes since [v1]:
* Changed CONFIG_PCIE_TEGRA194 from 'y' to 'm'

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 8871cf7aaba9..52105b2c2418 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -195,6 +195,7 @@ CONFIG_PCIE_QCOM=y
 CONFIG_PCIE_ARMADA_8K=y
 CONFIG_PCIE_KIRIN=y
 CONFIG_PCIE_HISI_STB=y
+CONFIG_PCIE_TEGRA194=m
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
-- 
2.17.1

