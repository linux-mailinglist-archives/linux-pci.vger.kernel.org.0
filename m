Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC981CA9B4
	for <lists+linux-pci@lfdr.de>; Fri,  8 May 2020 13:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgEHLfM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 May 2020 07:35:12 -0400
Received: from vultr.net.flygoat.com ([149.28.68.211]:33114 "EHLO
        vultr.net.flygoat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbgEHLfM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 May 2020 07:35:12 -0400
Received: from localhost.localdomain (unknown [142.147.94.151])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id 8C25F20CE6;
        Fri,  8 May 2020 11:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1588937712; bh=iUXO+v5HiDqJPHq2gf+ejS8zrWOdgWrDJWhC3uNK88c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vc1AjuILSImBhPgrLowaPDdLOFhi7Box4JH+iYxpBWjQLDAY1Vc/gzeLtuiGK2a+j
         rdi71CpmFEBzy3Bphflmr3nDCfQmo8JcbWxzpimD/IZs184Zkyvm2apd0HoDx5gUBs
         Uwx2Xg+IjdQ2L+coWsrRs6oi8XSjcjNxHI6GSb0f3ow3vKl1qPAgCLPq1PovOgzh9I
         Lu9PWNck2U98QgSz/S3x5nhHS5stBlVPGYUcRayBytZwTk8IP1GXc/WsmyCoQKFqaX
         Ha35SSOIY6a8m3+NM2GrFfbvMR9phsHZSdj+DQqYn5SONzAti8Rt1XRygSyd2KRvW9
         /JL9KJqHqHCRg==
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     maz@kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Paul Burton <paulburton@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: [PATCH v8 4/5] MIPS: DTS: Loongson64: Add PCI Controller Node
Date:   Fri,  8 May 2020 19:34:04 +0800
Message-Id: <20200508113414.3091532-4-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200508113414.3091532-1-jiaxun.yang@flygoat.com>
References: <20200427060551.1372591-1-jiaxun.yang@flygoat.com>
 <20200508113414.3091532-1-jiaxun.yang@flygoat.com>
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

