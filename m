Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E12B1B96FF
	for <lists+linux-pci@lfdr.de>; Mon, 27 Apr 2020 08:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgD0GGs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Apr 2020 02:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726221AbgD0GGs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Apr 2020 02:06:48 -0400
Received: from vultr.net.flygoat.com (vultr.net.flygoat.com [IPv6:2001:19f0:6001:3633:5400:2ff:fe8c:553])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B37C061A0F;
        Sun, 26 Apr 2020 23:06:48 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2001:da8:20f:4430:250:56ff:fe9a:7470])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id 5C34B20CF4;
        Mon, 27 Apr 2020 06:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1587967608; bh=iUXO+v5HiDqJPHq2gf+ejS8zrWOdgWrDJWhC3uNK88c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k5vvdjKagmkn/5PUC9aQhXpcR8gJin92lltBhFLn5WEKPCmZI/g+MW5zupOqRNVJ5
         huJS2ujug92gGvisVZBHmanyu1VQMgOiUrGDVShx89YA8AUj75psSxmTiOpGPDTgr4
         7oQnt567WMUYMydlTbZGh2QGo28HQSsGQc/MihCNx0li0rhizHydmApeIgOrNguI+7
         LjAYLl5/5RE7Kd7lCrGDWUBf/jACPN2k8g8999MNkllmk0l6awbZzemDNfhV/On6jJ
         6dB8iFST3TtbUMYz4VGleuXtCTQuaNe0XFpV50upWudgnDT+PVD5aq7ssCnnhkSF5j
         Aa72r8hRLAYQA==
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Paul Burton <paulburton@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 4/5] MIPS: DTS: Loongson64: Add PCI Controller Node
Date:   Mon, 27 Apr 2020 14:05:41 +0800
Message-Id: <20200427060551.1372591-5-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200427060551.1372591-1-jiaxun.yang@flygoat.com>
References: <20200427060551.1372591-1-jiaxun.yang@flygoat.com>
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
2.26.0.rc2

