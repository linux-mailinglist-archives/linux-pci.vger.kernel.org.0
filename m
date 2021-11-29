Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02107462015
	for <lists+linux-pci@lfdr.de>; Mon, 29 Nov 2021 20:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379811AbhK2TS5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Nov 2021 14:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244092AbhK2TQ4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Nov 2021 14:16:56 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1625AC08EE2C;
        Mon, 29 Nov 2021 07:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ldLJAPaLyuaEbVb/P7FFe5WR0zhbiWV3eHox1SK3apU=; b=IiiG1cFg1Sx5wf8ERjrDajOkBf
        qm7LY73LR68rcpRD883MIBOfqTWYhCoboGxqGahn3669hQ4T2jkFEE57KgvHJ+RLLFAUO+fqhQaAg
        xFuLVIclYKwBTdIDFWwlsP+x1p/yUPcITyrKtKLonf46Y6YMC+vMP39oMG54ZXF43waY=;
Received: from p54ae943f.dip0.t-ipconnect.de ([84.174.148.63] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mriey-0000mo-Mo; Mon, 29 Nov 2021 16:33:40 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-arm-kernel@lists.infradead.org,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     john@phrozen.org, Rob Herring <robh@kernel.org>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 08/13] dt-bindings: PCI: Add support for Airoha EN7532
Date:   Mon, 29 Nov 2021 16:33:24 +0100
Message-Id: <20211129153330.37719-9-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20211129153330.37719-1-nbd@nbd.name>
References: <20211129153330.37719-1-nbd@nbd.name>
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
2.30.1

