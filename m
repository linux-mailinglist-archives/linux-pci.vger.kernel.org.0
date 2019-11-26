Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41E66109B12
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2019 10:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfKZJUq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Nov 2019 04:20:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:47978 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727612AbfKZJUo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Nov 2019 04:20:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CEAB8B04F;
        Tue, 26 Nov 2019 09:20:43 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     andrew.murray@arm.com, maz@kernel.org, linux-kernel@vger.kernel.org
Cc:     james.quinlan@broadcom.com, mbrugger@suse.com,
        f.fainelli@gmail.com, phil@raspberrypi.org, wahrenst@gmx.net,
        jeremy.linton@arm.com, linux-pci@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v3 6/7] MAINTAINERS: Add brcmstb PCIe controller
Date:   Tue, 26 Nov 2019 10:19:44 +0100
Message-Id: <20191126091946.7970-7-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191126091946.7970-1-nsaenzjulienne@suse.de>
References: <20191126091946.7970-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The controller serves both the Raspberry Pi 4 (bcm2711) and brcmstb
platforms.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 999e8cc7db96..c9c85d29792c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3237,6 +3237,8 @@ S:	Maintained
 N:	bcm2711
 N:	bcm2835
 F:	drivers/staging/vc04_services
+F:	Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
+F:	drivers/pci/controller/pcie-brcmstb.c
 
 BROADCOM BCM47XX MIPS ARCHITECTURE
 M:	Hauke Mehrtens <hauke@hauke-m.de>
@@ -3292,6 +3294,8 @@ F:	drivers/bus/brcmstb_gisb.c
 F:	arch/arm/mm/cache-b15-rac.c
 F:	arch/arm/include/asm/hardware/cache-b15-rac.h
 N:	brcmstb
+F:	Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
+F:	drivers/pci/controller/pcie-brcmstb.c
 
 BROADCOM BMIPS CPUFREQ DRIVER
 M:	Markus Mayer <mmayer@broadcom.com>
-- 
2.24.0

