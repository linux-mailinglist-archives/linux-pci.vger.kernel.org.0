Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF564FDD2D
	for <lists+linux-pci@lfdr.de>; Tue, 12 Apr 2022 13:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240567AbiDLK6j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Apr 2022 06:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377356AbiDLK4h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2022 06:56:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9767A652E3;
        Tue, 12 Apr 2022 02:50:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16E21B81BB6;
        Tue, 12 Apr 2022 09:50:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89F2C385AC;
        Tue, 12 Apr 2022 09:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649757030;
        bh=dtnf8XsUhj4Osmhrrm08Dt6iD1UNUzpBusiWKcRHhvA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sgjz/h69Zzm0IbBc4hN20acNhDIQ01/cZcuXUONWZL+DHD66VXgkoGOSRTymU+XcH
         2LefS2l+jCeD1nkXXaRa0DokpNc4BbTeXW3IaBGNha8QG2wXmEqmxSPViXeRdZsHGp
         +0DnZ28COqc9mV7B3x2/A3utLWokfnxZoMTxQK7Lgffo72ukL4tZrxg8llezKL6snR
         B9uf9RVd93AptBUT2LGOeJwDPAOB3IGtOFUP1CKNSg0FxqAGgJ+rf6aOTbF/MfPI0e
         ME3AWRJPJp5V0Fr311sN24BT7hBUrPDtzZWpn2dMosyauzKGjWj/mTeFkL7TIvbsn8
         rj15zmdxoHo5w==
Received: by pali.im (Postfix)
        id 4A1632AB3; Tue, 12 Apr 2022 11:50:28 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/4] dt-bindings: Add 'slot-power-limit-milliwatt' PCIe port property
Date:   Tue, 12 Apr 2022 11:49:44 +0200
Message-Id: <20220412094946.27069-3-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220412094946.27069-1-pali@kernel.org>
References: <20220412094946.27069-1-pali@kernel.org>
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

This property specifies slot power limit in mW unit. It is a form-factor
and board specific value and must be initialized by hardware.

Some PCIe controllers delegate this work to software to allow hardware
flexibility and therefore this property basically specifies what should
host bridge program into PCIe Slot Capabilities registers.

The property needs to be specified in mW unit instead of the special format
defined by Slot Capabilities (which encodes scaling factor or different
unit). Host drivers should convert the value from mW to needed format.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>

---
This change was already accepted into dt-schema repo by Rob Herring:
https://github.com/devicetree-org/dt-schema/pull/66
---
 Documentation/devicetree/bindings/pci/pci.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
index 6a8f2874a24d..b0cc133ed00d 100644
--- a/Documentation/devicetree/bindings/pci/pci.txt
+++ b/Documentation/devicetree/bindings/pci/pci.txt
@@ -32,6 +32,12 @@ driver implementation may support the following properties:
    root port to downstream device and host bridge drivers can do programming
    which depends on CLKREQ signal existence. For example, programming root port
    not to advertise ASPM L1 Sub-States support if there is no CLKREQ signal.
+- slot-power-limit-milliwatt:
+   If present, this property specifies slot power limit in milliwatts. Host
+   drivers can parse this property and use it for programming Root Port or host
+   bridge, or for composing and sending PCIe Set_Slot_Power_Limit messages
+   through the Root Port or host bridge when transitioning PCIe link from a
+   non-DL_Up Status to a DL_Up Status.
 
 PCI-PCI Bridge properties
 -------------------------
-- 
2.20.1

