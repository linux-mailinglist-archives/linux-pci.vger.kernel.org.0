Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCA8C1A62A8
	for <lists+linux-pci@lfdr.de>; Mon, 13 Apr 2020 07:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgDMFmb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Apr 2020 01:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729066AbgDMFma (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Apr 2020 01:42:30 -0400
X-Greylist: delayed 500 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 12 Apr 2020 22:42:30 PDT
Received: from vultr.net.flygoat.com (vultr.net.flygoat.com [IPv6:2001:19f0:6001:3633:5400:2ff:fe8c:553])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693CAC008678;
        Sun, 12 Apr 2020 22:42:30 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2001:da8:20f:4430:250:56ff:fe9a:7470])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id 79DD520D22;
        Mon, 13 Apr 2020 05:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1586756083; bh=vIG/lJ9a0pXyMSs7BllHvRyHLPSA9zXR3qX3NJnlerw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TQVL0Ga5ifwYQm5Nb0G7/7KJa5pTZdk43CfVN14fhLIj8ywKSLMWVq6vrd12e4a5Z
         o7SZB3zJDBQyYVLAyizl/QJWhoP+ppsfEXe1ZrDupw8wEX96ktG1lssUuvnHmM1nb8
         +hT/2TKNnrim/1l8RGSw7/AEB7tPdTN+Vc0D93Bys1jsACfKJ6E12806hhZLkhx01S
         EwIpFQUUpjS16AAGmXi4Zt12eslRtYSlTsujVxYf7P8XQoV5raKYicGZE10kK9S/VX
         IQzCGqmv6TB9rMy0w8IIJ4QdueG8IU+jl0/4uaDGrfTnd3eMTEBDxJyFFardBUM9BK
         yVIlWfu8gfKbw==
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Paul Burton <paulburton@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] MIPS: DTS: Loongson64: Add PCI Controller Node
Date:   Mon, 13 Apr 2020 13:32:12 +0800
Message-Id: <20200413053222.3976680-4-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200413053222.3976680-1-jiaxun.yang@flygoat.com>
References: <20200330114239.1112759-1-jiaxun.yang@flygoat.com>
 <20200413053222.3976680-1-jiaxun.yang@flygoat.com>
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
index 45c54d555fa4..8766f97306c6 100644
--- a/arch/mips/boot/dts/loongson/rs780e-pch.dtsi
+++ b/arch/mips/boot/dts/loongson/rs780e-pch.dtsi
@@ -5,10 +5,25 @@ bus@10000000 {
 		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
-		ranges = <0 0x10000000 0 0x10000000 0 0x10000000
+		ranges = <0 0x00000000 0 0x00000000 0 0x00010000 /* ioports */
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

