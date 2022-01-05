Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5143048554E
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jan 2022 16:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241249AbiAEPDI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jan 2022 10:03:08 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:46570 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241222AbiAEPDC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jan 2022 10:03:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA65B61796;
        Wed,  5 Jan 2022 15:03:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 188A8C36AE9;
        Wed,  5 Jan 2022 15:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641394981;
        bh=QxYm/9uNB0n2EL2h/fhS5fUjl2mt/ousNJgIsc+uGx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GWuK0ANiwwqZYs+c1TFlnRm8Rgh//CPtSziKe9oDz0DAtjSc+s6NfnNwCcCACBWLT
         xvKUTILrH3/bDN8pLnWBk4pVNrw7fdiRgcgJ13iTbvdH70FjxujZciL5HyvxnBmbuF
         LBWhrSuHGCGhRVcKiqRkp/eTf2Aq+WmnujbTaVvThYndTaa4tw7z3b0bwOWMbwA9rX
         0KJM4nMzQelBiRXuowWinbMwW+xDes5npLiPVN46bNyETBNWb8VmdSe11qcTEKsGiv
         A6dqidh7l0rcXdJUKUkT945yv+vCI4MTiNid+LTsig6zW7Uq3DKKKfSEW+va23G+Or
         dTE2vlyltsmMw==
Received: by pali.im (Postfix)
        id C44EB82A; Wed,  5 Jan 2022 16:03:00 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH 09/11] dt-bindings: PCI: mvebu: Update information about intx interrupts
Date:   Wed,  5 Jan 2022 16:02:37 +0100
Message-Id: <20220105150239.9628-10-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220105150239.9628-1-pali@kernel.org>
References: <20220105150239.9628-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Signed-off-by: Pali Rohár <pali@kernel.org>
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

