Return-Path: <linux-pci+bounces-11226-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA841946727
	for <lists+linux-pci@lfdr.de>; Sat,  3 Aug 2024 05:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93AC71F21C08
	for <lists+linux-pci@lfdr.de>; Sat,  3 Aug 2024 03:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270EAFC01;
	Sat,  3 Aug 2024 03:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mGKGnlCy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773DBF9F5;
	Sat,  3 Aug 2024 03:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722655906; cv=none; b=kNK9Bd0JoeBVcwactePlW3N+45hQzD6InA3ZaRd5/+pBosjB9mohunhoWSJUOiOnOCrYK7VPHhe5EtYCj2w/cD9h9kZDpWJDKNSXsH8SyRsU8RbI3Nsnkn9Xj9SI4HjramixH/xKldbiliCtRn4eaaAJSOVLWr5P7x9HjPjJFEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722655906; c=relaxed/simple;
	bh=fugzrPQuTxWwC0Jlq48X/itx0ETjlv+UiheKkDz9pac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=rbM2tVdxguKInDqoJfHq7FOIJMsG4Rn7teklrdUB2CmoT9vHD7Ljf84Oeoxiq4p+3HNMUKhwX4T8C81QJ+pxOxDKPv+W74u5hFL9tQfaniCwYR82dQ1XA4cF2YAuhw7gVdIOyH7CCMFnt0AjVaOCbMBIyNKYCVIlnE2Q0rBYobQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mGKGnlCy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4732BlS6029774;
	Sat, 3 Aug 2024 03:23:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0bRob93PfL7mExfXgOVlkpqfMvJm3m0F1Q1oclI4iwE=; b=mGKGnlCyb5oY5Xqx
	e8aQ4MEKc2yxWej6Ahtdg4XY1VUmaqtt6uMxYY7XMe0zKDeo2WioC4AdQbDVAlZ6
	vtlYI++/jO3EYWUnwcyVnbTW4g+GcAQft5q+cnHvbITu+vzLhJYuPKUKQqlP4J+7
	0JuNbQAYlU2fbSlqMJvsVrnCz3YQjxJnpLlWBXcrHpFJXMEKSWIWNCHumksfe6pb
	pdaOjtUek/Lyn4EwwxodEr9W9LIWrstmOxtQ9E4CLX0Gf63xhw0A0fg40+B1vGU1
	Ev3vGU6mPpW8++JV/v0DXK3vLOO8hGShcHm9pUZjqgTUIk0IchD+Yy6jfSaGFpzq
	9P+k8w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40sbj6g28b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 03 Aug 2024 03:23:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4733NXQ9021756
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 3 Aug 2024 03:23:33 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 2 Aug 2024 20:23:28 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Sat, 3 Aug 2024 08:52:51 +0530
Subject: [PATCH v2 5/8] PCI: Add new start_link() & stop_link function ops
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240803-qps615-v2-5-9560b7c71369@quicinc.com>
References: <20240803-qps615-v2-0-9560b7c71369@quicinc.com>
In-Reply-To: <20240803-qps615-v2-0-9560b7c71369@quicinc.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        "Bartosz
 Golaszewski" <brgl@bgdev.pl>,
        Jingoo Han <jingoohan1@gmail.com>,
        "Manivannan
 Sadhasivam" <manivannan.sadhasivam@linaro.org>
CC: <andersson@kernel.org>, <quic_vbadigan@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Bartosz
 Golaszewski" <bartosz.golaszewski@linaro.org>,
        Krishna chaitanya chundru
	<quic_krichai@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722655379; l=1199;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=fugzrPQuTxWwC0Jlq48X/itx0ETjlv+UiheKkDz9pac=;
 b=4zqKnLyl7m8czZ754L5/9Iks5fHb1+YY1/BtVsZ1wNiRwDML+iDpG2Dj+aNrZmSXeHI3X/SMI
 xUfa/Bz7CkyC63FiULsR7FfnX0/F6iur6Uqh0H08vugDoxkdLOd9OF7
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JTShVwGQ6Aq1tg6l-I2Wznbk1DWjMW5S
X-Proofpoint-GUID: JTShVwGQ6Aq1tg6l-I2Wznbk1DWjMW5S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_20,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 mlxlogscore=610 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408030020

Certain devices like QPS615 which uses PCI pwrctl framework
needs to configure the device before PCI link is up.

If the controller driver already enables link training as part of
its probe, after the device is powered on, controller and device
participates in the link training and link can come up immediately
and maynot have time to configure the device.

So we need to stop the link training by using stop_link() and enable
them back after device is configured by using start_link().

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 include/linux/pci.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 4cf89a4b4cbc..0791d74951e9 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -802,6 +802,8 @@ struct pci_ops {
 	void __iomem *(*map_bus)(struct pci_bus *bus, unsigned int devfn, int where);
 	int (*read)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val);
 	int (*write)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val);
+	int (*start_link)(struct pci_bus *bus);
+	void (*stop_link)(struct pci_bus *bus);
 };
 
 /*

-- 
2.34.1


