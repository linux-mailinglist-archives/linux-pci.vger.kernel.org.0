Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC7A7109B13
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2019 10:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbfKZJUx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Nov 2019 04:20:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:47934 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727627AbfKZJUq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Nov 2019 04:20:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DF906BA0C;
        Tue, 26 Nov 2019 09:20:44 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     andrew.murray@arm.com, maz@kernel.org, linux-kernel@vger.kernel.org
Cc:     james.quinlan@broadcom.com, mbrugger@suse.com,
        f.fainelli@gmail.com, phil@raspberrypi.org, wahrenst@gmx.net,
        jeremy.linton@arm.com, linux-pci@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 7/7] arm64: defconfig: Enable Broadcom's STB PCIe controller
Date:   Tue, 26 Nov 2019 10:19:45 +0100
Message-Id: <20191126091946.7970-8-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191126091946.7970-1-nsaenzjulienne@suse.de>
References: <20191126091946.7970-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

For now only used in the Raspberry Pi 4.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7fa92defb964..dfd578129780 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -198,6 +198,7 @@ CONFIG_PCIE_ALTERA_MSI=y
 CONFIG_PCI_HOST_THUNDER_PEM=y
 CONFIG_PCI_HOST_THUNDER_ECAM=y
 CONFIG_PCIE_ROCKCHIP_HOST=m
+CONFIG_PCIE_BRCMSTB=m
 CONFIG_PCI_LAYERSCAPE=y
 CONFIG_PCI_HISI=y
 CONFIG_PCIE_QCOM=y
-- 
2.24.0

