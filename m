Return-Path: <linux-pci+bounces-10293-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2211E931A12
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 20:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D550D28347A
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 18:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A5371742;
	Mon, 15 Jul 2024 18:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="o+sBeQIC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C8761FFA;
	Mon, 15 Jul 2024 18:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721067287; cv=none; b=KFcPtWp5C8Vm3Gdtd4MY4y/hbWD4dyMEAZDYQCuiN6MhqS5hdGffI07t68d7pa3jeKS03JuyA/zsCBR24MwDJqbeb+JXI6vXFYYxh6xpKbTsAE7UKk6G9iQwsoh+hijsSICJ8jgBoZtrnL7vA/ncl34BxPmZFrVYYgDbV6/ZsXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721067287; c=relaxed/simple;
	bh=iijeqEy/27APwBwGb5GwgrmSs08E04QSvdbgAaZOwuM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IotN3+iepN2J7YId7+iyd0y31OH9H/n7afVIjUELBKm6o6XUdrzcwUyg2TuSm27JYpHBjWRgR6lvqox5vih39Eh5qWuqhaxP5y+5mEMB1ilR5KetADOMov4ppVoZIHvx350/k7L2i2lPQxz72htiXwOJAg2j2N/L65EA579fHH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=o+sBeQIC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46FH9bbJ001777;
	Mon, 15 Jul 2024 18:13:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=KtEqsKKyAId6WCwFuWmtXjap
	IMQ6lcIUriKWZ69bLDE=; b=o+sBeQIC9Q9MVh08iqfelLQ2IX9jZ08inM7sRNCl
	n5yj/cKsFuRPX16g6aSdPy082T1OMFdVSH92uxe41NGTqyr5SFFO1u0mMWtqP0rh
	6y9/ylXRHJnCHtGJDo1mNVFDZvG5X/Gnx52jjGpGFOiyjcrU4zxUb1tOD3XqUnvm
	2V2AqENaW5W7s+pLGPuyoGRb2XanJ6t+A9RdirZKRj9muWqUwlE/7VoD4Zw27c1D
	+Ae7c4lS0MeLGmE/lq7VuB5OCFUGcU1DcMxI5WRqlBCJ2ZnPaRKsxg2qeEa8VHUR
	5aJ4GsrB48wlLGB0CDtVbAPjYTnQa1xlYbeM4IHNMiVXeg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40bjbh4up8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jul 2024 18:13:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46FIDrKj011266
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jul 2024 18:13:53 GMT
Received: from hu-mrana-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 15 Jul 2024 11:13:53 -0700
From: Mayank Rana <quic_mrana@quicinc.com>
To: <will@kernel.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
        <manivannan.sadhasivam@linaro.org>, <cassel@kernel.org>,
        <yoshihiro.shimoda.uh@renesas.com>, <s-vadapalli@ti.com>,
        <u.kleine-koenig@pengutronix.de>, <dlemoal@kernel.org>,
        <amishin@t-argos.ru>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <Frank.Li@nxp.com>,
        <ilpo.jarvinen@linux.intel.com>, <vidyas@nvidia.com>,
        <marek.vasut+renesas@gmail.com>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>
CC: <quic_ramkri@quicinc.com>, <quic_nkela@quicinc.com>,
        <quic_shazhuss@quicinc.com>, <quic_msarkar@quicinc.com>,
        <quic_nitegupt@quicinc.com>, Mayank Rana <quic_mrana@quicinc.com>
Subject: [PATCH V2 5/7] PCI: host-generic: Add power domain based handling for PCIe controller
Date: Mon, 15 Jul 2024 11:13:33 -0700
Message-ID: <1721067215-5832-6-git-send-email-quic_mrana@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1721067215-5832-1-git-send-email-quic_mrana@quicinc.com>
References: <1721067215-5832-1-git-send-email-quic_mrana@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JMtVsoSUwacfvcTCm72XoCPtsZeg-yZk
X-Proofpoint-GUID: JMtVsoSUwacfvcTCm72XoCPtsZeg-yZk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_12,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407150142

Add usage of power domain to control PCIe controller enumeration. This is
needed to allow interaction with firmware to vote/unvote system resources,
PCIe PHY and configuration of PCIe controller into ECAM mode. This feature
support system suspend and resume to put PCIe into D3 cold and D0.

Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
---
 drivers/pci/controller/pci-host-generic.c | 42 +++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-host-generic.c b/drivers/pci/controller/pci-host-generic.c
index 41cb6a0..c2c027f 100644
--- a/drivers/pci/controller/pci-host-generic.c
+++ b/drivers/pci/controller/pci-host-generic.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/pci-ecam.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 
 static const struct pci_ecam_ops gen_pci_cfg_cam_bus_ops = {
 	.bus_shift	= 16,
@@ -76,13 +77,50 @@ static const struct of_device_id gen_pci_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, gen_pci_of_match);
 
+static int gen_pcie_ecam_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	int ret = 0;
+
+	if (!IS_ERR_OR_NULL(dev->pm_domain)) {
+		ret = devm_pm_runtime_enable(dev);
+		if (ret)
+			return ret;
+
+		ret = pm_runtime_resume_and_get(dev);
+		if (ret < 0) {
+			dev_err(dev, "fail to enable pcie controller:%d\n", ret);
+			return ret;
+		}
+	}
+
+	ret = pci_host_common_probe(pdev);
+	if (ret) {
+		dev_err(dev, "pci_host_common_probe() failed:%d\n", ret);
+		goto err;
+	}
+
+	return ret;
+err:
+	if (!IS_ERR_OR_NULL(dev->pm_domain))
+		pm_runtime_put_sync(dev);
+	return ret;
+}
+
+static void gen_pcie_ecam_remove(struct platform_device *pdev)
+{
+	pci_host_common_remove(pdev);
+	if (pdev->dev.pm_domain)
+		pm_runtime_put_sync(&pdev->dev);
+}
+
 static struct platform_driver gen_pci_driver = {
 	.driver = {
 		.name = "pci-host-generic",
 		.of_match_table = gen_pci_of_match,
 	},
-	.probe = pci_host_common_probe,
-	.remove_new = pci_host_common_remove,
+	.probe = gen_pcie_ecam_probe,
+	.remove_new = gen_pcie_ecam_remove,
 };
 module_platform_driver(gen_pci_driver);
 
-- 
2.7.4


