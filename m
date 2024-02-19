Return-Path: <linux-pci+bounces-3728-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B7B85A48B
	for <lists+linux-pci@lfdr.de>; Mon, 19 Feb 2024 14:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0118C1C22188
	for <lists+linux-pci@lfdr.de>; Mon, 19 Feb 2024 13:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B392836125;
	Mon, 19 Feb 2024 13:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="B5QVJHKv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BFF2E834;
	Mon, 19 Feb 2024 13:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708348900; cv=none; b=Lzbd3c9OHoyROggHBBH/aBSm71o4Z6QB01snM+rjWsktQZ3tpfWYIz37Up2kTNIjrDeuREe7FSdhN43BiJjpFZHwoh9/Cmxl7A5ug5jSvDkWQAl55MtddjG8Tpv5z8JSItFcHFYycsPkqb6L7HZ7iC4SaIvYSr7t98IW1ZF29s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708348900; c=relaxed/simple;
	bh=lC+Va8VKJJRnjPL1NP5hZ/mWgsIad/xDcJU8KKEla+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=JFFpnWpwyhOYvMcBpiBFf+VQw/ZnZBxw+G15eQY1RTWWMwYJ+O07A0Tfn+u/iTuI/4CLu2kTLkWfEigIj0IwI+4dGITBjSFqOXhvYoAD1w1mJrQRuossB4n021itcTI2jbsRzLVJqqsK+ofqxAv9DL8HNPqgKU/4rVmaDuYQa60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=B5QVJHKv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41JCiNFU018209;
	Mon, 19 Feb 2024 13:21:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=F7i
	D/VqgEIiLKlYBQdbtCp2S7O7L8FqKjuOYcPetuLs=; b=B5QVJHKv8YU0U2gA/Dr
	Ek18Kx8ENx8SUHM8/c3QrlzhXlWF2baE5BpvaDCQwOGaKSUz31EFTaY5SUb9cb2V
	ALNkGi1BWXNNyy+cDdJYKjXCElDRNKJ0tQ4HJYm5frBBtyfa/5BXByIOtn5A+pVn
	pCYjQEhnrxPD0MswXlRQf+R9+wHtB/xloHz35IfNLQzLWgfZhhEatGUx3odu1316
	xWbgYh9enM/VXhPHF7ZPurgf7xEU5kw/3ps23fK0P3GUtdbtjoOSeXGjmL+jOPVh
	dzNxZTEsNh/XTH3T9Wrkxs7MPFS/n2bLaCx7LEiSmGZW7gbRNd0WXLZDx0MosMM/
	muQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wc78qr24j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 13:21:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41JDLRWW015729
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 13:21:27 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 19 Feb 2024 05:21:23 -0800
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Mon, 19 Feb 2024 18:51:10 +0530
Subject: [PATCH] PCI: dwc: Enable runtime pm of the host bridge
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240219-runtime_pm_enable-v1-1-d39660310504@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAMZV02UC/x3MQQqAIBBA0avIrBNUiqirRITmVANpohWBdPek5
 Vv8nyFhJEzQswwRb0p0+AJZMZg37VfkZItBCVULJTseL3+Swym4Cb02O3JjZ9l2sja2EVC6EHG
 h538O4/t+PxSkQWMAAAA=
To: Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel
	<gustavo.pimentel@synopsys.com>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_vbadigan@quicinc.com>, <quic_ramkri@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_parass@quicinc.com>,
        Krishna chaitanya chundru
	<quic_krichai@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708348882; l=1466;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=lC+Va8VKJJRnjPL1NP5hZ/mWgsIad/xDcJU8KKEla+E=;
 b=uItbQ0PRyWCOqJ4GM6tXMhioNvyuGlpf0qLZwqb0FVXGXoQYKMkFJHVBAc37WwDCbpYKHRX7x
 UJ461EQdg1YDr+nAnerFDyH+ncy8TJhTaA+qCHcnls78GuO+vvzG6FQ
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rIGyQEr32HOD5ThTKYpcNVhD5kBNqavq
X-Proofpoint-ORIG-GUID: rIGyQEr32HOD5ThTKYpcNVhD5kBNqavq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_09,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 adultscore=0 spamscore=0 mlxscore=0 priorityscore=1501
 mlxlogscore=785 phishscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402190099

Currently controller driver goes to runtime suspend irrespective
of the child(pci-pci bridge & endpoint driver) runtime state.
This is because the runtime pm is not being enabled for the host
bridge dev which maintains parent child relationship.

So enable pm runtime for the host bridge, so that controller driver
goes to suspend only when all child devices goes to runtime suspend.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index d5fc31f8345f..57756a73df30 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -16,6 +16,7 @@
 #include <linux/of_pci.h>
 #include <linux/pci_regs.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 
 #include "../../pci.h"
 #include "pcie-designware.h"
@@ -505,6 +506,9 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	if (pp->ops->post_init)
 		pp->ops->post_init(pp);
 
+	pm_runtime_set_active(&bridge->dev);
+	pm_runtime_enable(&bridge->dev);
+
 	return 0;
 
 err_stop_link:

---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240219-runtime_pm_enable-bdc17914bd50

Best regards,
-- 
Krishna chaitanya chundru <quic_krichai@quicinc.com>


