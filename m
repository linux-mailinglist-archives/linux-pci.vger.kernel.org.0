Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4131E4BFD88
	for <lists+linux-pci@lfdr.de>; Tue, 22 Feb 2022 16:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbiBVPwN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Feb 2022 10:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233714AbiBVPwL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Feb 2022 10:52:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8718513F6C;
        Tue, 22 Feb 2022 07:51:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2BD95B81A2B;
        Tue, 22 Feb 2022 15:51:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE42C340F1;
        Tue, 22 Feb 2022 15:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645545103;
        bh=XWmi5NJivzp3vt7XTYxmuFvhD7l+7GEtiZkvDdUoUss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CuPCiIqJd3jY20wR0yBa3s0/CxquxONb/dYCTFRvG/yRRkAoiGz208dBXvlnlHb8i
         umFlRTwEXYOx80OCCMrGxQ2F6mq9lQr/TGixnNN/6N6c7337r7+/LA7kRQVxt+784j
         NP5f4zdWZIUOqFQUMBVrOj6MGaUrMN7D9M8xus1xObeYWUdCHGyt3zp5yYcQfaJUEV
         EpfxIM/5hmqI+e+BmVYiZK04dtPQu+oxPPstf6/joinkzX4r8/Y5vKtkmoStsaC3xd
         tLoDj/xQa9BIATkwbWnX98he5iuj+gvylZjilHFbfZdPDTNQCeOvvzsB89tK8i4nnT
         Kj8qLmZjdzlbQ==
Received: by pali.im (Postfix)
        id 64C03FDB; Tue, 22 Feb 2022 16:51:43 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 09/12] dt-bindings: PCI: mvebu: Update information about intx interrupts
Date:   Tue, 22 Feb 2022 16:50:27 +0100
Message-Id: <20220222155030.988-10-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220222155030.988-1-pali@kernel.org>
References: <20220222155030.988-1-pali@kernel.org>
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

Signed-off-by: Pali Rohár <pali@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pci/mvebu-pci.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/mvebu-pci.txt b/Documentation/devicetree/bindings/pci/mvebu-pci.txt
index 24225852bce0..6d022a9d36ee 100644
--- a/Documentation/devicetree/bindings/pci/mvebu-pci.txt
+++ b/Documentation/devicetree/bindings/pci/mvebu-pci.txt
@@ -81,6 +81,11 @@ and the following optional properties:
 - reset-gpios: optional GPIO to PERST#
 - reset-delay-us: delay in us to wait after reset de-assertion, if not
   specified will default to 100ms, as required by the PCIe specification.
+- interrupt-names: list of interrupt names, supported are:
+   - "intx" - interrupt line triggered by one of the legacy interrupt
+- interrupts or interrupts-extended: List of the interrupt sources which
+  corresponding to the "interrupt-names". If non-empty then also additional
+  'interrupt-controller' subnode must be defined.
 
 Example:
 
-- 
2.20.1

