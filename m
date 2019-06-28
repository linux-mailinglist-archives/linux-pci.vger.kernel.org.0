Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D78A45950C
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2019 09:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfF1Hf1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jun 2019 03:35:27 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:15740 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726408AbfF1Hf1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Jun 2019 03:35:27 -0400
X-UUID: 4348a167286d48f1959a32d5ed2dd538-20190628
X-UUID: 4348a167286d48f1959a32d5ed2dd538-20190628
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 96256411; Fri, 28 Jun 2019 15:35:14 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 28 Jun 2019 15:35:12 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 28 Jun 2019 15:35:12 +0800
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Ryder Lee <ryder.lee@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <youlin.pei@mediatek.com>,
        <jianjun.wang@mediatek.com>
Subject: [v2,1/2] dt-bindings: PCI: Add support for MT7629
Date:   Fri, 28 Jun 2019 15:34:24 +0800
Message-ID: <20190628073425.25165-2-jianjun.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190628073425.25165-1-jianjun.wang@mediatek.com>
References: <20190628073425.25165-1-jianjun.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 8ED5F4D19021FD9E5BE78EE408F42C39A0566BC23BE030BE3F8D63A4E3D719C72000:8
X-MTK:  N
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

MT7629 is an ARM platform Soc which has the same PCIe IP with MT7622.

Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
---
 Documentation/devicetree/bindings/pci/mediatek-pcie.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie.txt b/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
index 92437a366e5f..7468d666763a 100644
--- a/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
@@ -6,6 +6,7 @@ Required properties:
 	"mediatek,mt2712-pcie"
 	"mediatek,mt7622-pcie"
 	"mediatek,mt7623-pcie"
+	"mediatek,mt7629-pcie"
 - device_type: Must be "pci"
 - reg: Base addresses and lengths of the PCIe subsys and root ports.
 - reg-names: Names of the above areas to use during resource lookup.
-- 
2.18.0

