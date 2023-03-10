Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7555A6B380A
	for <lists+linux-pci@lfdr.de>; Fri, 10 Mar 2023 09:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjCJIFw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Mar 2023 03:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjCJIFr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Mar 2023 03:05:47 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F4AB04BC;
        Fri, 10 Mar 2023 00:05:46 -0800 (PST)
Received: from cryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net [82.11.51.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: tanureal)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 56DAF66030BE;
        Fri, 10 Mar 2023 08:05:44 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678435544;
        bh=iZfz5TvdpibqFz6qT4kNJtS6iMl9+BPz7aSCwohid2U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g2ao3nkFY4N1PCsl0X3CjrEoTMMZ8bcZmmRThO5eZRp1ayRCTRgJw48hhFw5uqvVi
         lgln1/6maYEc7xGSGnP3aiCn6k2dWuK+v1lHIC7sBgezy/12aTYMdckKiYsMmjjs/h
         jLGWhpnxK93wiCGyAgZ6WCNYEJvDhINy4jFtCOLB1neIMjZSo3te/Xwl2K7POLy/mJ
         pZB7W+iN1EoGKe87QkQvSBAuz9Q7jPIhn2nCEYQOowXvsS4Jf00Gj9qCzGP6CUqzkA
         iMKDuEgvE85OsVvCgTU8Ghb0da4JPij1iZOVw4lZKank0NZd5rOEvobswjnvDwDMBs
         7GSp1xvZKlLRw==
From:   Lucas Tanure <lucas.tanure@collabora.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Qu Wenruo <wqu@suse.com>,
        Piotr Oniszczuk <piotr.oniszczuk@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Lucas Tanure <lucas.tanure@collabora.com>, kernel@collabora.com
Subject: [PATCH 5/7] arm64: dts: rockchip: Add ITS GIC600 configuration for rk3588s
Date:   Fri, 10 Mar 2023 08:05:16 +0000
Message-Id: <20230310080518.78054-6-lucas.tanure@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230310080518.78054-1-lucas.tanure@collabora.com>
References: <20230310080518.78054-1-lucas.tanure@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for Interrupts to be translated by the GIC-600
Interrupt Translation Service (ITS).
ITS provides a software mechanism for translating message-based
interrupts into Locality-specific Peripheral Interrupts (LPIs).

This is based on prior work from XiaoDong Huang and
Peter Geis fixing this issue specifically for Rockchip 356x.
Plus comments of Robin Murphy about Non-Coherent properties.

Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index 24919cb5c153..695aed05eba2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -1594,6 +1594,25 @@ gic: interrupt-controller@fe600000 {
 		mbi-ranges = <424 56>;
 		msi-controller;
 		#interrupt-cells = <4>;
+		ranges;
+
+		its0: msi-controller@fe640000 {
+			compatible = "arm,gic-v3-its";
+			msi-controller;
+			dma-noncoherent;
+			#msi-cells = <1>;
+			reg = <0x0 0xfe640000 0x0 0x20000>;
+			power-domains = <&power RK3588_PD_PCIE>;
+		};
+
+		its1: msi-controller@fe660000 {
+			compatible = "arm,gic-v3-its";
+			msi-controller;
+			dma-noncoherent;
+			#msi-cells = <1>;
+			reg = <0x0 0xfe660000 0x0 0x20000>;
+			power-domains = <&power RK3588_PD_PCIE>;
+		};
 
 		ppi-partitions {
 			ppi_partition0: interrupt-partition-0 {
-- 
2.39.2

