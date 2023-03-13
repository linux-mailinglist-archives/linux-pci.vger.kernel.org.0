Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22336B77E1
	for <lists+linux-pci@lfdr.de>; Mon, 13 Mar 2023 13:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjCMMnS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Mar 2023 08:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjCMMm7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Mar 2023 08:42:59 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB446A1EC;
        Mon, 13 Mar 2023 05:42:27 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32D6OxcQ020021;
        Mon, 13 Mar 2023 05:42:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=+Twwfo+d1JCCV20Ow3YeKxKYdEAuXIvfbVrrAMuP3yA=;
 b=guNHMHlyOa/7znmSrleiZRsrgbsvOWq0cOkeJh0umWESO1IqHPan62SO5JZ2XmM97+OR
 0x6v22rD/fNfDOMMmNu8eY4MEoVkv5QMJ48R5mtas/wLyJEK00ICbSKkk4SfNkGwwObE
 t+Jr4NCBKO74/1TmbvT6YJ549huXcJwVSoirSQEMW/uD6Koav30EsrjJNKaPRryRrtcV
 IjMIqETRoTzOKFrMmMwrKxf92OkN46wWc9Y07z2lqcisxdYJfp6YeOA53ZqFRUvKvw12
 S6EWaBxG1yt1/XXhrFcEiVP7LGAxUE0yjtu4J8nfCWGazwDpLsoyglXKuZlMOiHK6ojl pA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3p8t1t5gjs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 05:42:19 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 13 Mar
 2023 05:41:30 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Mon, 13 Mar 2023 05:41:30 -0700
Received: from jupiter073.il.marvell.com (unknown [10.5.116.85])
        by maili.marvell.com (Postfix) with ESMTP id 07CCF5B6921;
        Mon, 13 Mar 2023 05:41:26 -0700 (PDT)
From:   Elad Nachman <enachman@marvell.com>
To:     <thomas.petazzoni@bootlin.com>, <bhelgaas@google.com>,
        <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Elad Nachman <enachman@marvell.com>
Subject: [PATCH v4 8/8] PCI: dwc: Introduce region limit from DT
Date:   Mon, 13 Mar 2023 14:40:16 +0200
Message-ID: <20230313124016.17102-9-enachman@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230313124016.17102-1-enachman@marvell.com>
References: <20230313124016.17102-1-enachman@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: 9Xb2KkvInWYrasdOqz5A3CBQUIxGT5aI
X-Proofpoint-ORIG-GUID: 9Xb2KkvInWYrasdOqz5A3CBQUIxGT5aI
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

From: Elad Nachman <enachman@marvell.com>

Allow dts override of region limit for SOCs with older Synopsis
Designware PCIe IP but with greater than 32-bit address range support,
such as the Armada 7020/7040/8040 family of SOCs by Marvell,
when the DT file places the PCIe window above the 4GB region.
The Synopsis Designware PCIe IP in these SOCs is too old to specify the
highest memory location supported by the PCIe, but practically supports
such locations. Allow these locations to be specified in the DT file.
DT property is called num-regionmask , and can range between 33 and 64.

Signed-off-by: Elad Nachman <enachman@marvell.com>
---
v4:
   1) Fix blank lines removal / addition

   2) Remove usage of variable with same name as dt binding property

 drivers/pci/controller/dwc/pcie-designware.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 53a16b8b6ac2..9773c110c733 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -735,8 +735,10 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 link_gen)
 void dw_pcie_iatu_detect(struct dw_pcie *pci)
 {
 	int max_region, ob, ib;
-	u32 val, min, dir;
+	u32 val, min, dir, ret;
 	u64 max;
+	struct device *dev = pci->dev;
+	struct device_node *np = dev->of_node;
 
 	val = dw_pcie_readl_dbi(pci, PCIE_ATU_VIEWPORT);
 	if (val == 0xFFFFFFFF) {
@@ -781,7 +783,13 @@ void dw_pcie_iatu_detect(struct dw_pcie *pci)
 		dw_pcie_writel_atu(pci, dir, 0, PCIE_ATU_UPPER_LIMIT, 0xFFFFFFFF);
 		max = dw_pcie_readl_atu(pci, dir, 0, PCIE_ATU_UPPER_LIMIT);
 	} else {
-		max = 0;
+		/* Allow dts override of region limit for older IP with above 32-bit support: */
+		ret = of_property_read_u32(np, "num-regionmask", &val);
+		if (!ret && val > 32) {
+			max = GENMASK(val - 33, 0);
+			dev_info(pci->dev, "Overriding region limit to %u bits\n", val);
+		} else
+			max = 0;
 	}
 
 	pci->num_ob_windows = ob;
-- 
2.17.1

