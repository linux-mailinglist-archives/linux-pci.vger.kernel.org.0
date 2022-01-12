Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95C4B48C701
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jan 2022 16:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354531AbiALPSv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 10:18:51 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51926 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354516AbiALPSn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jan 2022 10:18:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33DB56191F;
        Wed, 12 Jan 2022 15:18:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77DE0C36AEB;
        Wed, 12 Jan 2022 15:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642000722;
        bh=XWmi5NJivzp3vt7XTYxmuFvhD7l+7GEtiZkvDdUoUss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mBimUX5T45ZP07hHWdU0pfp3AIm44+/c2XjdK1Rk2h97QachqquBAOEa5tHRjwMWK
         6petmOTFucuud05+DzA4/DkcLgBLXuCvhY3Uar5AwdzimOWmBovJYwdmkZd5fjt8zl
         6/YKkaDcDDiZ8YY/EjsT6WvK3yDzCMVr1XoNANv4s5tusTsU6eL6uef3qTWW1m6IZU
         wC8zqXso8B6oma6fJQoX7vEPHboQ8EERPyv5zorI/+goedy+Cp+aCRZEGEamAK6e/u
         jtZRfX38hhN02TVzhjdW4zr4gJ90yMct04AeO6Kg9yPSWv5r4PRCPDz8wHmZyRj0ji
         EmFCFrPeRvfkA==
Received: by pali.im (Postfix)
        id 2F589768; Wed, 12 Jan 2022 16:18:42 +0100 (CET)
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
Subject: [PATCH v2 09/11] dt-bindings: PCI: mvebu: Update information about intx interrupts
Date:   Wed, 12 Jan 2022 16:18:12 +0100
Message-Id: <20220112151814.24361-10-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220112151814.24361-1-pali@kernel.org>
References: <20220105150239.9628-1-pali@kernel.org>
 <20220112151814.24361-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

