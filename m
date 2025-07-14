Return-Path: <linux-pci+bounces-32077-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA58B04702
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 20:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93C5317EF88
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 18:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA49266B5D;
	Mon, 14 Jul 2025 18:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ljfRAkrH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A839E2E36FC
	for <linux-pci@vger.kernel.org>; Mon, 14 Jul 2025 18:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752516084; cv=none; b=hn9ogeK3A6NrUaaaLBstvID40hjYaP7EFO8oaUJ0DcOUL8SCQ489gdK0tUNQO3N47lZJfkIDmfeFaDJCleBVaOxctU4CaydTA9gjqcWQR1KU79gnddwQYn+74g3DIOXcftFm/9nJa9bFRnn1PFDP0MdQGfHKdSjyPBdXnnak0bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752516084; c=relaxed/simple;
	bh=rK1mHRwfLofxCrHg/hy4DKXz7ak5yRST/iNSGy5d/GE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pHz2QAmfk2EDgvkSMvIl5LnrhHNzYKzzl4vw/jwr6Q163XACn0Jz9I+gR3462QcOa6spYIEHKAS9KGUdMb3xjRuH9OzIJ7S8njgGW/oypzeg/o0GLsDr7Gq/Z02UqyA/bQdThKHsqRljZxWTcbhAU+GJOAeVTz0IT1Cwyym4lto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ljfRAkrH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EGIJZ2007836
	for <linux-pci@vger.kernel.org>; Mon, 14 Jul 2025 18:01:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ohJyu1geVqwV23Bgi/9wQX
	zmFnqB141Eg+tm/AJaoKM=; b=ljfRAkrHLsROSFC/Yo8QSj9RRtS86W0e1oaMaj
	tMgPIgF+B+N1urCMmNg7Wr64UbCoSJpRvMClL6T01nFA3ZDv8qvUiXbTIZ76489J
	YkEB28r1ppgyH4ohQ2o0ak1utKDGZgj/qf3qO0Fy58FRmXLVpTO7vIDfUOlCOBaT
	U/Zsi4JZ1j/CMWfGzGthfGiU6wTnpZEJJeNXw9NTk+ICMGrYlMWQKGFdRYOj56Kn
	JFi43RBtAFG4NGIA95hoNOLW0uLgOk0ehCwXJUo9/PbtODaZt5Kh1G6Eo/zBJAKA
	iJSmGj+xysYZbx6AtO814Uz7KP1/a37HXgwU44Q3VPAGQdEw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w58yga0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 14 Jul 2025 18:01:21 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ab6d31e2dbso33312451cf.3
        for <linux-pci@vger.kernel.org>; Mon, 14 Jul 2025 11:01:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752516080; x=1753120880;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ohJyu1geVqwV23Bgi/9wQXzmFnqB141Eg+tm/AJaoKM=;
        b=CEc+VhfB1J8xhKsvPdvdZKRtYGxD1z/d0K4V9vofbFMhxQul1OeYYb3oApeWotWS9m
         GBZP4ENDlhrdiZPl980RfozBLcnlbBsU8bMRG9w1vxNFni7em04Fupg8K+P4wUOlzqD4
         lAGKyjoDRYD1R2gCdUKxrUIKPQdS4zDIHC6tJNuCzo4SZm1xL8beVLbaBHHFt6CvI+yV
         uzOHEl5WpZIkD1QTfSGtrVDDLtIMZ9JTp5GawLTs6NizrEIP8nswNzGo+RV95H8T3Zwx
         EnuzeDrZstqLV4lDJNwHYritUkUiY3Y0xnFUGas3FPqG835W+DyQqlAnTF/X36CfCWPm
         LlQw==
X-Forwarded-Encrypted: i=1; AJvYcCVhWOwguiQG1VlT9LwM7OcuzE6ltxSofC0L/Vs09ALI1m2KXZ1khIZEoeq/Cd40Lwp5+5HfKiWTzio=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfW5JmhBW4Wa7b5Nw899oLg+YVoy285NxDlOUoGdLpXEE4vCEA
	ly8FuG7tTAWrWBQNMQYAlFOmRjVf/CEUYdtEpsQp/jPATSHUnXHsV4hwqcuWl+i2pv7WCj5dx8L
	jj48rkg9erRSDQJicTmrPr7VZ9vU/OXjDAmEwJGFoYmnvhX3ObsJnE+qICDQ3XhQ=
X-Gm-Gg: ASbGncuJXk1k/J0d9PTmIR03zyF+RGKoCA7gvsarL0rllRqD2HF0YlnRwHuDZf6KwCC
	9YiTMKcVCRClJjCu3v1LgK9xCdJKzLr/NOuIdJnzjHVAhptxcniB/n4QSBAcvr3ccCRHrau8bqp
	Aq5rBxNAkluP2F8HDCLaCVpCiZzeJ4JiehIWJrj+MfJ1qMQJj0ffWyTe66bQtMrSt+HGPjFQicH
	9DNxitVTb7Q57ZUtEjY4+o73UTm9U0re0DMrbSwDCPOWJm0bMDPs1c/yRVxVUkRREH4XnLHr11M
	q1++IfRzzBrjKw6WWCQIEvQV8D5+hSymnNFlf0nsIJGPRopp5BLqj/DHkpIX+V+WJKE=
X-Received: by 2002:a05:622a:2308:b0:4a9:c9c6:ae8d with SMTP id d75a77b69052e-4a9fb9612d9mr215365741cf.35.1752516080604;
        Mon, 14 Jul 2025 11:01:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/6Pul50lfnYF7kucBGxB7MrwD9ARcmggCN/hiK8dl/0nzcXDqTO0GXrPd5FCOVdGXTFlOow==
X-Received: by 2002:a05:622a:2308:b0:4a9:c9c6:ae8d with SMTP id d75a77b69052e-4a9fb9612d9mr215364991cf.35.1752516080005;
        Mon, 14 Jul 2025 11:01:20 -0700 (PDT)
Received: from [192.168.1.17] ([120.60.67.95])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ab659238a1sm16999381cf.17.2025.07.14.11.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 11:01:19 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH 0/2] PCI: qcom: Switch to bus notifier for enabling ASPM of
 PCI devices
Date: Mon, 14 Jul 2025 23:31:03 +0530
Message-Id: <20250714-aspm_fix-v1-0-7d04b8c140c8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOBFdWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDc0MT3cTigtz4tMwK3dTUFGNLIzNjw2SLNCWg8oKiVKAw2Kjo2NpaAAZ
 JW2ZaAAAA
X-Change-ID: 20250714-aspm_fix-eed392631c8f
To: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1192;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=rK1mHRwfLofxCrHg/hy4DKXz7ak5yRST/iNSGy5d/GE=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBodUXqUyWYINFENbIxjWYt3rEs1gx0E/tbUSEcz
 SpppJ9KEpGJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaHVF6gAKCRBVnxHm/pHO
 9Up/B/9t5OmC953NndUYPqjfz4q/od5S20svRDDr+kRniUGMD7d6tqsfC62t8OXVGb5yRdFwyTc
 it9owf5qfbPyvKAk2EldZ1pPQaypwqUGbN2Cz3wQIEOBOT2obnIeJNv3nOVtUzMxVZXsKEhjbRk
 gsV2l/OF5CJQtgxEdfx4Dp/0hM7BwA/DQV6D2NsVjxIEmUAggQOl5zK/ICCIYrQUzdAiDFeA17A
 40cPcZSwZhLbLMrmSckpCLRt/tq6mqKut2pjIcq7vs3eG6xMOnS7L56Tfp6yw8gUpscOHIIW4Xe
 oIuTKql+lue3GRVMHIdgvfJEycpEJoWWi+amwwj52tH/5DGK
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDExNCBTYWx0ZWRfX7IGh39IvWecS
 HpBHhDeif99pKOji/vfXfkJIStoRkZZUWmQ+cuk0MjRN5k/kf/6WyyVscmsnZB0rYVi8Nifaht0
 n7K25ZqpfDK9yO0vh2QlNCjFaCmH4jCD89KjUwXpnC2E550v5yILH77jxm5elF89pyMO1bLSe8I
 RlgtMcAYYMY+zy+no90o2Ryy8/Ux6tLFRZuK7dr8e/QtxiFlg0ah0w7FFiaGT+2miCbCHCh0ZUq
 ANxX1G9st09udK4F69K3+fhFnKlOVKP8v8q5PXtO2r7uvwcwGSLBmBxcTF++2jNRPnOFRfxnm4S
 AbY0DcmKU5WVxqiC1AZBBmPTn7qQjwtEZ9/aiNco2vghZxhPRANRNWBBwUmEiI7yDQ9js2QJ0bR
 c8LA2Pxrh5Euvh8jwFWR3fMrqEcbXH8MOS7R1hMJEKTcp6pntrI6F+Pv/Sj8axhAMO6mwuyE
X-Proofpoint-GUID: JcaialeScUI0J-CpE-jko2R8SsnxkIwE
X-Proofpoint-ORIG-GUID: JcaialeScUI0J-CpE-jko2R8SsnxkIwE
X-Authority-Analysis: v=2.4 cv=Or9Pyz/t c=1 sm=1 tr=0 ts=687545f1 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=fXYZ39HhpiwvwaHYBd8ing==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=djgaaEycexjLLnWtpDoA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_02,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=912 bulkscore=0
 impostorscore=0 malwarescore=0 clxscore=1011 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507140114

Hi,

This series switches the Qcom PCIe controller driver to bus notifier for
enabling ASPM (and updating OPP) for PCI devices. This series is intented
to fix the ASPM regression reported (offlist) on the Qcom compute platforms
running Linux. It turned out that the ASPM enablement logic in the Qcom
controller driver had a flaw that got triggered by the recent changes to the
pwrctrl framework (more details in patch 1/1).

Testing
-------

I've tested this series on Thinkpad T14s laptop and able to observe ASPM state
changes (through controller debugfs entry and lspci) for the WLAN device.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
Manivannan Sadhasivam (2):
      PCI: qcom: Switch to bus notifier for enabling ASPM of PCI devices
      PCI: qcom: Move qcom_pcie_icc_opp_update() to notifier callback

 drivers/pci/controller/dwc/pcie-qcom.c | 73 ++++++++++++++++++----------------
 1 file changed, 38 insertions(+), 35 deletions(-)
---
base-commit: 00f0defc332be94b7f1fdc56ce7dcb6528cdf002
change-id: 20250714-aspm_fix-eed392631c8f

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>


