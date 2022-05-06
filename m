Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D96851D962
	for <lists+linux-pci@lfdr.de>; Fri,  6 May 2022 15:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441806AbiEFNo3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 May 2022 09:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441801AbiEFNo1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 May 2022 09:44:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92171081;
        Fri,  6 May 2022 06:40:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7503D620BC;
        Fri,  6 May 2022 13:40:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B58C385BE;
        Fri,  6 May 2022 13:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651844443;
        bh=XOfCRiSnJEHlnQ3QGJRGEiJHjdZf3trk4k7UXZvzBMg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BAH9uYIuww1yQEF8UaaquDhv+kfSez0+qJsrBcA0Kb2jx4XB3IJZ6M3a56snYvrrZ
         2Rhxrok2V1CovPlayEpgtyFJ9yqru3GhZHUnRjhYbvZzF5+yo8Y8pdf1HODM+/ww6s
         uK+9yr2nBKcr5VLvMdqOZyzJ1NyvLEWsUtib/HyZs2iXmyD0fQ8VbEkSGxhgIqGUNa
         EUEytkQiAqKC5GExWz3wbaXMValtGAxrSniS7XDzwEp33+TDzNV3ZAonY++AQ6GHXg
         HK/c4E9pBaLS8HrVUIo+40etNo1e9sw4MeAqQ411MG/d28pCCwiQzgxEG//bub55It
         c2/EZ7WryQqbA==
Received: by pali.im (Postfix)
        id 222B313AB; Fri,  6 May 2022 15:40:41 +0200 (CEST)
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
Subject: [PATCH 4/6] dt-bindings: PCI: mvebu: Update information about summary interrupt
Date:   Fri,  6 May 2022 15:40:27 +0200
Message-Id: <20220506134029.21470-5-pali@kernel.org>
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

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 Documentation/devicetree/bindings/pci/mvebu-pci.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/mvebu-pci.txt b/Documentation/devicetree/bindings/pci/mvebu-pci.txt
index 6d022a9d36ee..ef33558210d0 100644
--- a/Documentation/devicetree/bindings/pci/mvebu-pci.txt
+++ b/Documentation/devicetree/bindings/pci/mvebu-pci.txt
@@ -83,6 +83,7 @@ and the following optional properties:
   specified will default to 100ms, as required by the PCIe specification.
 - interrupt-names: list of interrupt names, supported are:
    - "intx" - interrupt line triggered by one of the legacy interrupt
+   - "summary" - interrupt line triggered by any event, including "intx"
 - interrupts or interrupts-extended: List of the interrupt sources which
   corresponding to the "interrupt-names". If non-empty then also additional
   'interrupt-controller' subnode must be defined.
-- 
2.20.1

