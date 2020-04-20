Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8B1F1B02CE
	for <lists+linux-pci@lfdr.de>; Mon, 20 Apr 2020 09:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgDTHXE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Apr 2020 03:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726136AbgDTHXE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Apr 2020 03:23:04 -0400
Received: from vultr.net.flygoat.com (vultr.net.flygoat.com [IPv6:2001:19f0:6001:3633:5400:2ff:fe8c:553])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECD8C061A0F;
        Mon, 20 Apr 2020 00:23:04 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2001:da8:20f:4430:250:56ff:fe9a:7470])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id 5024220CDA;
        Mon, 20 Apr 2020 07:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1587366786; bh=vIG/lJ9a0pXyMSs7BllHvRyHLPSA9zXR3qX3NJnlerw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o5IPepUWx8fR9PiOsxo8s5pJPROgpqg/1mgpJ270vIdgqVMfwWUhE6pTbxsugGt32
         rmzgv9FiSSLJZf6K2f+xybWgIO0ZOg/u+nbZZmTMOnvBfqC6Sz90pwF0mAMKuA3slx
         yKvuqaWz2847umrqu9Qp5TIDxlo7pTm1AI6E84/58rLSDr1g0l2PoDtyEtpCXdsQNP
         bMqtGWUyFK5LOFsn4mCnR+1viyzh8CjzqchuU1AQJMUkTb1fx23PyJoPhW2zm/BLNx
         afaW9sav+FM+n5MgcRvOv8dahTg0JExWXKsFYzZW1sr40lhwnhff7m1mTfrokB+YE8
         romAp/aNB58Fw==
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
Subject: [PATCH v4 4/5] MIPS: DTS: Loongson64: Add PCI Controller Node
Date:   Mon, 20 Apr 2020 15:12:10 +0800
Message-Id: <20200420071220.155357-4-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200420071220.155357-1-jiaxun.yang@flygoat.com>
References: <20200330114239.1112759-1-jiaxun.yang@flygoat.com>
 <20200420071220.155357-1-jiaxun.yang@flygoat.com>
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

