Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B057C4A36F8
	for <lists+linux-pci@lfdr.de>; Sun, 30 Jan 2022 15:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355234AbiA3Ovn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 30 Jan 2022 09:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355227AbiA3Ovj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 30 Jan 2022 09:51:39 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E06C061741;
        Sun, 30 Jan 2022 06:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=rO6a7Hov1DT8YCZ0BC66z6nKE3NFtfTVucv70OUu+M0=; b=q96nErUZ3T934E6wic2bry1QA3
        yAMgnAaov/Z42N8o3z4D+qFaBW8mLaAKaYaIpHN4K7CtSaFt/55OQQvtnsZRgey8C1dpt1IqDpc8d
        38s+hYqT2yUp5od91BVxT232hlS+MfEnL+l5Y6QzulkpRdartylSULvjSWpxi0nuVE3I=;
Received: from p200300daa716f900d40f7dfd86c385e0.dip0.t-ipconnect.de ([2003:da:a716:f900:d40f:7dfd:86c3:85e0] helo=Maecks.lan)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1nEBYA-0002if-FS; Sun, 30 Jan 2022 15:51:30 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     soc@kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, john@phrozen.org,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 08/13] dt-bindings: PCI: Add support for Airoha EN7532
Date:   Sun, 30 Jan 2022 15:51:11 +0100
Message-Id: <20220130145116.88406-9-nbd@nbd.name>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220130145116.88406-1-nbd@nbd.name>
References: <20220130145116.88406-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: John Crispin <john@phrozen.org>

EN7532 is an ARM based platform SoC integrating the same PCIe IP as
MT7622, add a binding for it.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 Documentation/devicetree/bindings/pci/mediatek-pcie.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie.txt b/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
index 57ae73462272..684227522267 100644
--- a/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
@@ -7,6 +7,7 @@ Required properties:
 	"mediatek,mt7622-pcie"
 	"mediatek,mt7623-pcie"
 	"mediatek,mt7629-pcie"
+	"airoha,en7523-pcie"
 - device_type: Must be "pci"
 - reg: Base addresses and lengths of the root ports.
 - reg-names: Names of the above areas to use during resource lookup.
-- 
2.32.0 (Apple Git-132)

