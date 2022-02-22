Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E9D4BFEA4
	for <lists+linux-pci@lfdr.de>; Tue, 22 Feb 2022 17:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbiBVQdB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Feb 2022 11:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234062AbiBVQcr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Feb 2022 11:32:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94FC6E8E7;
        Tue, 22 Feb 2022 08:32:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4EF260AFD;
        Tue, 22 Feb 2022 16:32:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13904C340E8;
        Tue, 22 Feb 2022 16:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645547541;
        bh=X1NkggDZMaHHEK/ibc1MqFK+Ef81w3jOaBfki258e5Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JhhNpdV7ASN4Ad65L5LNmqytTZGEPdaHaHxNKInh1dr7E308XT5lfFLnNa1vmD2vf
         p6MClteatvt73MlM72iHdchLE/yUvn4OuDWLaWe/RYWQ6v8JGIRoUyhPW81dBUiJ/M
         xDdFpTFbL2XsFFx3PhmiMtQ+3DIsrPmVkSks0EQwHNwEgxXwFYe+epUmHntGiw0SSj
         YYs4hhFskTk94R2alrrs0g5dMKkQY2ZYiMhmwxqjnqD3E/gDo2NfR9kJSMT/WzkRnd
         tIe+xw+sawsuf9sZBvnpEIHSYTTEDX72ZxF/dqGAH45qSnuCeRbT9pDyfc8tZR7YoA
         FChsc8vh+WsWQ==
Received: by pali.im (Postfix)
        id BEEC5FDB; Tue, 22 Feb 2022 17:32:20 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Gregory Clement <gregory.clement@bootlin.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] ARM: dts: turris-omnia: Set PCIe slot-power-limit-milliwatt properties
Date:   Tue, 22 Feb 2022 17:31:58 +0100
Message-Id: <20220222163158.1666-7-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220222163158.1666-1-pali@kernel.org>
References: <20220222163158.1666-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

All 3 miniPCIe slots in Turris Omnia are designed for 10 W.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/arm/boot/dts/armada-385-turris-omnia.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/armada-385-turris-omnia.dts b/arch/arm/boot/dts/armada-385-turris-omnia.dts
index 5bd6a66d2c2b..f240018148f6 100644
--- a/arch/arm/boot/dts/armada-385-turris-omnia.dts
+++ b/arch/arm/boot/dts/armada-385-turris-omnia.dts
@@ -71,16 +71,19 @@
 			pcie@1,0 {
 				/* Port 0, Lane 0 */
 				status = "okay";
+				slot-power-limit-milliwatt = <10000>;
 			};
 
 			pcie@2,0 {
 				/* Port 1, Lane 0 */
 				status = "okay";
+				slot-power-limit-milliwatt = <10000>;
 			};
 
 			pcie@3,0 {
 				/* Port 2, Lane 0 */
 				status = "okay";
+				slot-power-limit-milliwatt = <10000>;
 			};
 		};
 	};
-- 
2.20.1

