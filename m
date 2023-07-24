Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8668875EBA5
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jul 2023 08:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjGXGgn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jul 2023 02:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGXGgf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jul 2023 02:36:35 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD03810F5;
        Sun, 23 Jul 2023 23:36:03 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36O6VevR013855;
        Mon, 24 Jul 2023 06:35:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=sKNIlGgDGJQyffX5cxfVtq4EsikPhy0mBhHTSMVlDmk=;
 b=fh3h/CaCMH7uTiSBJ0R/cd/jg8JlNN/3OGAHbr6J6pGmcnfSdQGIZ2i38ViIx6vtIruJ
 3eWXBXPXC93tek2snnVQMQXI2pWk8F78zkMNoS7DxQE45fqk78N8/6rRDIwHtajQUJp8
 JAQ7Hh+JJdB8hmtWwTUHCCsu7xJ/NKzf8b3SnwRH98bxrLU7MoxLlCSvJtyC8l77kInt
 N/lz6nHmNKzjZyWgl/9NkCFUE+EYJSGLraCsfcmzvsBhxHLI/AtFA1zEmLQHt8Ug2Kv3
 UoYAtTdUAWYCM8+TYpeCv2BMLQ/J8R3D8AdyQ8ZfA+53jscbf4mepDgZSdEp9LH0kdzk wQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s04tmaq7e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 06:35:02 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36O6Z1Xm015221
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 06:35:01 GMT
Received: from win-platform-upstream01.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sun, 23 Jul 2023 23:34:53 -0700
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh@kernel.org>, <mani@kernel.org>,
        <lpieralisi@kernel.org>, <bhelgaas@google.com>, <kw@linux.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <dmitry.baryshkov@linaro.org>
CC:     <quic_srichara@quicinc.com>, <stable@vger.kernel.org>,
        <Stable@vger.kernel.org>
Subject: [PATCH V5] PCI: qcom: Fixing broken pcie enumeration for 2_3_3 configs ops
Date:   Mon, 24 Jul 2023 12:04:29 +0530
Message-ID: <20230724063429.3980462-1-quic_srichara@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8yoK1RlbjHvgoxwsAZAtvwcMYbQjkxzU
X-Proofpoint-GUID: 8yoK1RlbjHvgoxwsAZAtvwcMYbQjkxzU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_04,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307240060
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PARF_SLV_ADDR_SPACE_SIZE_2_3_3 macro is used for IPQ8074 2_3_3 post_init.
PCIe slave addr register offset is 0x358, but was wrongly changed to
0x168 as a part of commit 39171b33f652 ("PCI: qcom: Remove PCIE20_ prefix
from register definitions"). Fixing it, by using the right macro and remove
the unused PARF_SLV_ADDR_SPACE_SIZE_2_3_3.

Without this access to the registers of slave addr space like iATU etc
are broken leading to pcie enumeration failure.

Fixes: 39171b33f652 ("PCI: qcom: Remove PCIE20_ prefix from register definitions")
Cc: <Stable@vger.kernel.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
---
 [v5] Fixed subject, commit log
 [v4] Fix commit sub and added '<mani@kernel.org>' reviewed-by tag
 [v3] Added reviewed-by tag, fixed subject, commit text
 [v2] Fixed the 'fixes tag' correctly, subject, right macro usage 

 drivers/pci/controller/dwc/pcie-qcom.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 4ab30892f6ef..8418894b3de7 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -43,7 +43,6 @@
 #define PARF_PHY_REFCLK				0x4c
 #define PARF_CONFIG_BITS			0x50
 #define PARF_DBI_BASE_ADDR			0x168
-#define PARF_SLV_ADDR_SPACE_SIZE_2_3_3		0x16c /* Register offset specific to IP ver 2.3.3 */
 #define PARF_MHI_CLOCK_RESET_CTRL		0x174
 #define PARF_AXI_MSTR_WR_ADDR_HALT		0x178
 #define PARF_AXI_MSTR_WR_ADDR_HALT_V2		0x1a8
@@ -810,8 +809,7 @@ static int qcom_pcie_post_init_2_3_3(struct qcom_pcie *pcie)
 	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	u32 val;
 
-	writel(SLV_ADDR_SPACE_SZ,
-		pcie->parf + PARF_SLV_ADDR_SPACE_SIZE_2_3_3);
+	writel(SLV_ADDR_SPACE_SZ, pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
 
 	val = readl(pcie->parf + PARF_PHY_CTRL);
 	val &= ~PHY_TEST_PWR_DOWN;
-- 
2.34.1

