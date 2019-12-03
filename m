Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69F9C10FCCD
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2019 12:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfLCLsW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Dec 2019 06:48:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:49644 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726418AbfLCLr4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Dec 2019 06:47:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ED92EB1E0;
        Tue,  3 Dec 2019 11:47:54 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     andrew.murray@arm.com, maz@kernel.org, linux-kernel@vger.kernel.org
Cc:     james.quinlan@broadcom.com, mbrugger@suse.com,
        f.fainelli@gmail.com, phil@raspberrypi.org, wahrenst@gmx.net,
        jeremy.linton@arm.com, linux-pci@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v4 5/8] MAINTAINERS: Add brcmstb PCIe controller
Date:   Tue,  3 Dec 2019 12:47:38 +0100
Message-Id: <20191203114743.1294-6-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203114743.1294-1-nsaenzjulienne@suse.de>
References: <20191203114743.1294-1-nsaenzjulienne@suse.de>
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
index b8fa7652a736..69955fc47a54 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3238,6 +3238,8 @@ S:	Maintained
 N:	bcm2711
 N:	bcm2835
 F:	drivers/staging/vc04_services
+F:	Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
+F:	drivers/pci/controller/pcie-brcmstb.c
 
 BROADCOM BCM47XX MIPS ARCHITECTURE
 M:	Hauke Mehrtens <hauke@hauke-m.de>
@@ -3293,6 +3295,8 @@ F:	drivers/bus/brcmstb_gisb.c
 F:	arch/arm/mm/cache-b15-rac.c
 F:	arch/arm/include/asm/hardware/cache-b15-rac.h
 N:	brcmstb
+F:	Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
+F:	drivers/pci/controller/pcie-brcmstb.c
 
 BROADCOM BMIPS CPUFREQ DRIVER
 M:	Markus Mayer <mmayer@broadcom.com>
-- 
2.24.0

