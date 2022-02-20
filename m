Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796224BD103
	for <lists+linux-pci@lfdr.de>; Sun, 20 Feb 2022 20:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244644AbiBTTek (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 20 Feb 2022 14:34:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244643AbiBTTej (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 20 Feb 2022 14:34:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4442F4506A
        for <linux-pci@vger.kernel.org>; Sun, 20 Feb 2022 11:34:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3FFF60EF0
        for <linux-pci@vger.kernel.org>; Sun, 20 Feb 2022 19:34:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FFC5C340F0;
        Sun, 20 Feb 2022 19:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645385657;
        bh=fOmdr0gznP2RE2090WbQ4xhGjNjGSDHYFPlsmLhbqGk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G5PaORd+Rf5arj43Q2beeTsSLtAETE8cu650EeZedsrBLf2ga7QDy4SmyueW/fX2Z
         Mo/UTWnGxo4lqsg7BzlZykU/ftI21ZjbcT+SvElBMyvNoH5jZzbLH/0HgVmVviPaPC
         BVp6lZhLZI2YejkZIO5HjQIMcKqIwdfIV6KWm18sllXRtXozvYc0q4PbMcQRQHS11Z
         LQv67ozK2Bba4/gFaj3FD3u7ZN3cPT0+h8bcO54dJJr57QQ2o4pLnav+iZXhuF86Uq
         bbT8FZM089H/NDnO1fzVtUMGVxsXLIq+eic7oyDjp6j+/8Kpce4OAa9pPXSi7FaIQE
         ia9Ol0wV4BHYQ==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Marc Zyngier <maz@kernel.org>, pali@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 11/18] dt-bindings: PCI: aardvark: Describe slot-power-limit-milliwatt
Date:   Sun, 20 Feb 2022 20:33:39 +0100
Message-Id: <20220220193346.23789-12-kabel@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220220193346.23789-1-kabel@kernel.org>
References: <20220220193346.23789-1-kabel@kernel.org>
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

From: Pali Rohár <pali@kernel.org>

Add description of the "slot-power-limit-milliwatt" property to the
Aardvark controller binding.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 Documentation/devicetree/bindings/pci/aardvark-pci.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/aardvark-pci.txt b/Documentation/devicetree/bindings/pci/aardvark-pci.txt
index 2b8ca920a7fa..0405870d2fa0 100644
--- a/Documentation/devicetree/bindings/pci/aardvark-pci.txt
+++ b/Documentation/devicetree/bindings/pci/aardvark-pci.txt
@@ -20,6 +20,7 @@ contain the following properties:
    define the mapping of the PCIe interface to interrupt numbers.
  - bus-range: PCI bus numbers covered
  - phys: the PCIe PHY handle
+ - slot-power-limit-milliwatt: see pci-bus.yaml in dtschema
  - max-link-speed: see pci.txt
  - reset-gpios: see pci.txt
 
@@ -52,6 +53,7 @@ Example:
 				<0 0 0 3 &pcie_intc 2>,
 				<0 0 0 4 &pcie_intc 3>;
 		phys = <&comphy1 0>;
+		slot-power-limit-milliwatt = <10000>;
 		pcie_intc: interrupt-controller {
 			interrupt-controller;
 			#interrupt-cells = <1>;
-- 
2.34.1

