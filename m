Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658C94FC479
	for <lists+linux-pci@lfdr.de>; Mon, 11 Apr 2022 21:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234178AbiDKTDh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Apr 2022 15:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244926AbiDKTDg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Apr 2022 15:03:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3782A32041;
        Mon, 11 Apr 2022 12:01:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD99A6140F;
        Mon, 11 Apr 2022 19:01:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13989C385A6;
        Mon, 11 Apr 2022 19:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649703680;
        bh=dtnf8XsUhj4Osmhrrm08Dt6iD1UNUzpBusiWKcRHhvA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OTS3qLMsLBOoQuuPqyrf6snrwRJnEgz8uyxhJR4Wr2GOnuwBxWtBBPS41FORx5re0
         ZvJdmXOicezA/vU3/yeDemD6P6DJ8YYV57AFIakKks/xFaTGaXORXClSF1G79iGNMs
         Y8/JfjPT9rCKd+4z2gmonEziI1ggQuIIFmZCc9Es8Z4UFT/6NEDOBQBQlx++oLl4GS
         3Md3dcg7RH8Duu8eiuS3WOFsZWEQNTB1yt59rNb3MkqaX/vBg4jjGcQk0ek36Munhg
         qphvDYxAGIZzY7dUtgK7ouT70UBg0v6P25aOrdqSwQVW/Yi94lAmHIsRQi7tWaNM73
         kVC2hLoWnR71w==
Received: by pali.im (Postfix)
        id 69F23A83; Mon, 11 Apr 2022 21:01:17 +0200 (CEST)
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
Subject: [PATCH v4 2/4] dt-bindings: Add 'slot-power-limit-milliwatt' PCIe port property
Date:   Mon, 11 Apr 2022 20:58:57 +0200
Message-Id: <20220411185859.32722-3-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220411185859.32722-1-pali@kernel.org>
References: <20220411185859.32722-1-pali@kernel.org>
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

