Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B651B7695
	for <lists+linux-pci@lfdr.de>; Fri, 24 Apr 2020 15:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgDXNKp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Apr 2020 09:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgDXNKp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Apr 2020 09:10:45 -0400
Received: from vultr.net.flygoat.com (vultr.net.flygoat.com [IPv6:2001:19f0:6001:3633:5400:2ff:fe8c:553])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C991C09B045;
        Fri, 24 Apr 2020 06:10:33 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2001:da8:20f:4430:250:56ff:fe9a:7470])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id 78C0D2049D;
        Fri, 24 Apr 2020 13:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1587733833; bh=YGFuG1Ptf8nWkQDHMUVyr5Yfy/uvF1j7CQOHSB5ziQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hCeSe+HB/3AEG8XxXm0f3lz8tzXsHjxvHK5dJuOHSx9ZvSqr5xPR9SnLdDRVLa9XA
         NLVfGI8OCLw1qDLyZtE/vbQ5fOAhcV/NJDOzpXsCmBoP3ikS8xOVNu7abhmR+lSFDt
         R+dnjbok+l4BX9gPRx4olL7lR5PApsWpQvf+0zobrgSWhWLHZXWdLbAQiOR8hxUpN9
         sAlOLBzQZZqifr8cEWlcqVAiSCgaq4evhnzdy8wtchHM2abB8WoWc0gTQvil5su69R
         rw6ECt3cc6vwyOECcPhuQMNXk048c3jfcTt/GuvA4mAdmXnxiwx/nmHJ7m6xB2L6tY
         7wMJSjNE+iUYg==
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-pci@vger.kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Paul Burton <paulburton@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: [PATCH v5 5/6] MIPS: DTS: Loongson64: Add PCI Controller Node
Date:   Fri, 24 Apr 2020 21:08:36 +0800
Message-Id: <20200424130847.328584-6-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200424130847.328584-1-jiaxun.yang@flygoat.com>
References: <20200424130847.328584-1-jiaxun.yang@flygoat.com>
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
--
v2: Clean-up
---
 arch/mips/boot/dts/loongson/rs780e-pch.dtsi | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/loongson/rs780e-pch.dtsi b/arch/mips/boot/dts/loongson/rs780e-pch.dtsi
index 8687c4f7370a..5e68ceae20ca 100644
--- a/arch/mips/boot/dts/loongson/rs780e-pch.dtsi
+++ b/arch/mips/boot/dts/loongson/rs780e-pch.dtsi
@@ -5,10 +5,25 @@ bus@10000000 {
 		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
-		ranges = <0 0x10000000 0 0x10000000 0 0x10000000
+		ranges = <0 0x00000000 0 0x00000000 0 0x00010000 /* I/O Ports */
+				0 0x10000000 0 0x10000000 0 0x10000000
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
+			ranges = <0x01000000 0 0x00004000 0 0x00004000 0 0x00004000>,
+				 <0x02000000 0 0x40000000 0 0x40000000 0 0x40000000>;
+
+			bus-range = <0x00 0xff>;
+		};
+
 		isa {
 			compatible = "isa";
 			#address-cells = <2>;
-- 
2.26.0.rc2

