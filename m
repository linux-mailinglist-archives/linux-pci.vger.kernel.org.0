Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41991CEE7D
	for <lists+linux-pci@lfdr.de>; Tue, 12 May 2020 09:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgELHrr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 May 2020 03:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbgELHrr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 May 2020 03:47:47 -0400
Received: from vultr.net.flygoat.com (vultr.net.flygoat.com [IPv6:2001:19f0:6001:3633:5400:2ff:fe8c:553])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCBFC061A0C;
        Tue, 12 May 2020 00:47:47 -0700 (PDT)
Received: from localhost.localdomain (unknown [142.147.94.151])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id 03F8220F1A;
        Tue, 12 May 2020 07:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1589269667; bh=2II2DHV4+Iks6xy2EWtnJbO+xA3KlRUpJ+Ydv9JIdBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I1zJHcfowIfrvYY0to4K2WNseXbmadXj3RD/weZEpu6awBZJxHlF6RaZ6gImFf76/
         K+J675jN5/X/3nKyIterZo54TDlZ5pWtg2dXpjw4TmrTVtVDmzY9+VN84M3c1vgsG0
         3eo2hbMJsF18ZAP1pQR6xNSH55wxPfRtubsa3//Sr27NqOXHk5QvKHSDe0R+h3DY2d
         L+qNvTstu+NEKvohfedINLaDiX7XBreNiO6S/kf9ug9VL7Nl5vo9tMpRqAbnavNjvw
         u9SD5Xbof7TJDEFQlAsj/JddqmeBv4MrIwAcBGR0i7ggi5FlGDHXph9zAgFJCRZmS6
         NP2RGVWX/5QgA==
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
Subject: [PATCH v9 4/5] MIPS: DTS: Loongson64: Add PCI Controller Node
Date:   Tue, 12 May 2020 15:43:58 +0800
Message-Id: <20200512074413.3557835-4-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200512074413.3557835-1-jiaxun.yang@flygoat.com>
References: <20200427060551.1372591-1-jiaxun.yang@flygoat.com>
 <20200512074413.3557835-1-jiaxun.yang@flygoat.com>
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
2.26.2

