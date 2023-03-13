Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958196B77D4
	for <lists+linux-pci@lfdr.de>; Mon, 13 Mar 2023 13:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjCMMnB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Mar 2023 08:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjCMMmz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Mar 2023 08:42:55 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27C5664E8;
        Mon, 13 Mar 2023 05:42:20 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32D6OxcI020021;
        Mon, 13 Mar 2023 05:42:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=QJOWFJmvLNjPQ3cK/VFiHx9zeHs9QVtLszvjB+5MdRM=;
 b=dESX45KFJYcFjRIFl7+4CD8CZlvr8xvixUnVeUhmG57G0373NHF+9CUc/n/pczDnT1lx
 iHWpHp8+psFnw0HGmgehZiN67TDzUs+tbSvYCYSgZjMK4Wf7gAUUuj/wD6SLYqGljDAI
 uWxGjLix9YlRgTYcSJZsKoqvKx5S3SJZig/CDBNvF0yKqwqlMIEF2EzQnpd+iKmZQeE+
 S0F1ac6occap9xS1RzVsp/gVLDVLGiwYDJ/Rqql0fUeXGZa6vYBS2ozGfFM1jq2JZMLK
 Lr9kwa0ZDhiQ9t89ce32ebFIk9dJE/rWEVUc9sbPrxqFpFH0nxpagLxeQ4g2/gQygXIj 4Q== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3p8t1t5gex-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 05:42:06 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 13 Mar
 2023 05:40:55 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Mon, 13 Mar 2023 05:40:55 -0700
Received: from jupiter073.il.marvell.com (unknown [10.5.116.85])
        by maili.marvell.com (Postfix) with ESMTP id 903725B6921;
        Mon, 13 Mar 2023 05:40:51 -0700 (PDT)
From:   Elad Nachman <enachman@marvell.com>
To:     <thomas.petazzoni@bootlin.com>, <bhelgaas@google.com>,
        <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Vadym Kochan <vadym.kochan@plvision.eu>
Subject: [PATCH v4 1/8] dt-bindings: PCI: armada8k: Add compatible string for AC5 SoC
Date:   Mon, 13 Mar 2023 14:40:09 +0200
Message-ID: <20230313124016.17102-2-enachman@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230313124016.17102-1-enachman@marvell.com>
References: <20230313124016.17102-1-enachman@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: XI55rmSjiSveaP3dlq5zNOwxQhqp1rFa
X-Proofpoint-ORIG-GUID: XI55rmSjiSveaP3dlq5zNOwxQhqp1rFa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_05,2023-03-13_01,2023-02-09_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Vadym Kochan <vadym.kochan@plvision.eu>

AC5 SoC has armada8k PCIe IP so add compatible string for it.

Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/pci/pci-armada8k.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/pci-armada8k.txt b/Documentation/devicetree/bindings/pci/pci-armada8k.txt
index ff25a134befa..b272fa4f08b5 100644
--- a/Documentation/devicetree/bindings/pci/pci-armada8k.txt
+++ b/Documentation/devicetree/bindings/pci/pci-armada8k.txt
@@ -4,7 +4,9 @@ This PCIe host controller is based on the Synopsys DesignWare PCIe IP
 and thus inherits all the common properties defined in snps,dw-pcie.yaml.
 
 Required properties:
-- compatible: "marvell,armada8k-pcie"
+- compatible: Should be set to one of the following:
+   - "marvell,armada8k-pcie" : For A7K/8K family of SoCs
+   - "marvell,ac5-pcie"      : For AC5 family of SoCs
 - reg: must contain two register regions
    - the control register region
    - the config space region
-- 
2.17.1

