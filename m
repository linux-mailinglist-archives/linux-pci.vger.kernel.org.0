Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6A91E1E62
	for <lists+linux-pci@lfdr.de>; Tue, 26 May 2020 11:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388586AbgEZJWt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 May 2020 05:22:49 -0400
Received: from vultr.net.flygoat.com ([149.28.68.211]:34282 "EHLO
        vultr.net.flygoat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388425AbgEZJWt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 May 2020 05:22:49 -0400
Received: from localhost.localdomain (unknown [142.147.94.151])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id 99C1820CF1;
        Tue, 26 May 2020 09:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1590484968; bh=1A7r30/ddO3YA2iwUg/iQ9hDTh5suKpgGWHi+jEZjWE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dDVgagmLdmWB27rdrU+DYce+G6UbOoqtem4yEuPVs8vU4ceVlKwyyGBaVLXGYDyC1
         T9b/7rFsjCK1gZQhRcgRepMcCB5cwiUh0nDXz82gY97MszRvpGCAq4uZ+yq4avhcZq
         YH0xzxtARQE6FsVV9Bo4ldiIgzQAU6DfaRGH0nY7MSWPuhA0ZIYcK2S+hot8x2sRx/
         dBzmTHttwwKwv+L6Y/IvAtLZwxdcjndcPd4UWKt60T2DbpfzgaYO2Ew+9Et7v8wbmj
         aQTf8eLrVMwQosJguKomKZXCfcogVbktToSasgvndzNxr5PK2jdFAA0vx0LpBn+9+y
         Gyjl1FHPL/jOA==
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-pci@vger.kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Paul Burton <paulburton@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: [PATCH v11 4/5] MIPS: DTS: Loongson64: Add PCI Controller Node
Date:   Tue, 26 May 2020 17:21:15 +0800
Message-Id: <20200526092130.145550-5-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.27.0.rc0
In-Reply-To: <20200526092130.145550-1-jiaxun.yang@flygoat.com>
References: <20200427060551.1372591-1-jiaxun.yang@flygoat.com>
 <20200526092130.145550-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCI Host controller node for Loongson64 with RS780E PCH dts.
Note that PCI interrupts are probed via legacy way, as different
machine have different interrupt arrangement, we can't cover all
of them in dt.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/boot/dts/loongson/rs780e-pch.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/mips/boot/dts/loongson/rs780e-pch.dtsi b/arch/mips/boot/dts/loongson/rs780e-pch.dtsi
index 8687c4f7370a..d0d5d60a8697 100644
--- a/arch/mips/boot/dts/loongson/rs780e-pch.dtsi
+++ b/arch/mips/boot/dts/loongson/rs780e-pch.dtsi
@@ -9,6 +9,18 @@ bus@10000000 {
 				0 0x40000000 0 0x40000000 0 0x40000000
 				0xfd 0xfe000000 0xfd 0xfe000000  0 0x2000000 /* PCI Config Space */>;
 
+		pci@1a000000 {
+			compatible = "loongson,rs780e-pci";
+			device_type = "pci";
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			reg = <0 0x1a000000 0 0x02000000>;
+
+			ranges = <0x01000000 0 0x00004000 0 0x18004000 0 0x00004000>,
+				 <0x02000000 0 0x40000000 0 0x40000000 0 0x40000000>;
+		};
+
 		isa {
 			compatible = "isa";
 			#address-cells = <2>;
-- 
2.27.0.rc0

