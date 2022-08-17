Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF125979E2
	for <lists+linux-pci@lfdr.de>; Thu, 18 Aug 2022 01:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242046AbiHQXDk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Aug 2022 19:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241908AbiHQXDj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Aug 2022 19:03:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11925A59A3;
        Wed, 17 Aug 2022 16:03:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2081B81FF0;
        Wed, 17 Aug 2022 23:03:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F48C433B5;
        Wed, 17 Aug 2022 23:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660777415;
        bh=fekDNg1F4N2wBEf7RoTG3BeHW051EFSYazNh7Asi3Z4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lPokxyBzKMnKW8r7xusjkJRmM7NtARTr/Aj2BZBFZ5IPR+UPbR4RpxqjANXAagSVl
         doOyrUZEfkMmHDvBL26XwMg44wiU0yloMMOg752WHG2UrmmrlUm59GkvJpiQdksuQV
         u683XBUzRAH9UWZr1DNq9nX2svxeswlWNFRVbLpjwH2f4BBCQ0IN7cKJFsL5mgVMXV
         oMF3qZAsq4kmpMXpKCanRIuNgvqYLleF2Zq5wKHeqwSgndTlsY+S6U6R2chHqYcTs2
         LsF0VvR1Lt1zsuuIc2SiubHULZiV9kJ366rv5tJWAUY7BCm/RTmOmYz1OMknZlRw6g
         FoOkRwTnONsUg==
Received: by pali.im (Postfix)
        id 671912799; Thu, 18 Aug 2022 01:03:32 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/4] dt-bindings: PCI: mvebu: Update information about error interrupt
Date:   Thu, 18 Aug 2022 01:00:33 +0200
Message-Id: <20220817230036.817-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220817230036.817-1-pali@kernel.org>
References: <20220817230036.817-1-pali@kernel.org>
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

mvebu error interrupt is triggered by any non-intx event, which is mainly
some pcie error.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 Documentation/devicetree/bindings/pci/mvebu-pci.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/mvebu-pci.txt b/Documentation/devicetree/bindings/pci/mvebu-pci.txt
index 6d022a9d36ee..8f0bca42113f 100644
--- a/Documentation/devicetree/bindings/pci/mvebu-pci.txt
+++ b/Documentation/devicetree/bindings/pci/mvebu-pci.txt
@@ -83,6 +83,7 @@ and the following optional properties:
   specified will default to 100ms, as required by the PCIe specification.
 - interrupt-names: list of interrupt names, supported are:
    - "intx" - interrupt line triggered by one of the legacy interrupt
+   - "error" - interrupt line triggered by any other event (non-intx)
 - interrupts or interrupts-extended: List of the interrupt sources which
   corresponding to the "interrupt-names". If non-empty then also additional
   'interrupt-controller' subnode must be defined.
-- 
2.20.1

