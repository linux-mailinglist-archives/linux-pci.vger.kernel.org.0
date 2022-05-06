Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C0C51D96B
	for <lists+linux-pci@lfdr.de>; Fri,  6 May 2022 15:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441841AbiEFNoe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 May 2022 09:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441815AbiEFNo3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 May 2022 09:44:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9A0B1FE;
        Fri,  6 May 2022 06:40:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0EADB835D7;
        Fri,  6 May 2022 13:40:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E908C385B5;
        Fri,  6 May 2022 13:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651844443;
        bh=fzxRZCWmCCFgbf4knt9LuPHs1XRhGlf3VGA4Sizr/FQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=umht/pKW6oPjHn98M4IMsYj7QWvvDYNGwzFjMVXOR+kAfMEKj7APfZ6YnGQWd1xQG
         jgRUJtUsUnZhgaqZRhnIgMqNzGYRDmflBsJZE/dDFSLRZ3sZZM6zQuOA68oyWgcsJk
         7tFDOOJDHBsH+yJl7Y9zro1R9AbI8+fj9anDeMyqfNUJQE9U8o5aqA4SV5CcylHCxG
         nLGj4+plDx4t98QN9+iTsG/V+BNYiShdzEaEL3kFUSE9iV5X+eP/MGjaNIEvoaE+r1
         NYcwcwpV2ltkVIKYBk430bQK4o5/fI8SfxefE7CYfJM45VrgUGDjQIidqUIxH4r/62
         wH669SOy46Arw==
Received: by pali.im (Postfix)
        id B9C701265; Fri,  6 May 2022 15:40:40 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/6] ARM: dts: armada-38x.dtsi: Add node for MPIC SoC Error IRQ controller
Date:   Fri,  6 May 2022 15:40:26 +0200
Message-Id: <20220506134029.21470-4-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220506134029.21470-1-pali@kernel.org>
References: <20220506134029.21470-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

It is child of the MPIC IRQ controller.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/arm/boot/dts/armada-38x.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index 9b1a24cc5e91..54051f0b1ad1 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -398,6 +398,11 @@
 				interrupt-controller;
 				msi-controller;
 				interrupts = <GIC_PPI 15 IRQ_TYPE_LEVEL_HIGH>;
+
+				soc_err: interrupt-controller@20 {
+					interrupt-controller;
+					#interrupt-cells = <1>;
+				};
 			};
 
 			timer: timer@20300 {
-- 
2.20.1

