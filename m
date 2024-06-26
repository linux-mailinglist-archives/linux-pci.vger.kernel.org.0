Return-Path: <linux-pci+bounces-9303-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C9F918112
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 14:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C6242859A6
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 12:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8011181D05;
	Wed, 26 Jun 2024 12:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dZdKabU9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A76181CF1;
	Wed, 26 Jun 2024 12:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719405509; cv=none; b=NZswe4Vy/vcB0VYz9ovG1b1lyEt4BZ/rR/aShfYfqLDe3ejKgDcH+nArcEhj9UE0XixgUJbw2bWvH63Ml9RlyTG+wDH3EGrzSF0z2eb7/YEk4dFpfW1pqGPfaCDZ8ZR9MgQnlrXI2epbNepOnjI8CxBWozLILh2eXtt4Fc+YTUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719405509; c=relaxed/simple;
	bh=k3m1vxMbl2ArWV+IwppPThDXiHUXp5H1ICsNoOwyDzs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=clnzcJLtVqp2cdPvaFE0EdoWz4SSKroVzp9c2elEa5hJnSFqdcHB2+we9rnHiU6JgyeycMPk3nGPMbpmVD47mmAqw57XrteOafQat0CMWoXKLnAdhsOSIliMLwl0GiEOFy94tSiuK9JO3NFGsbdGcQTmxlaibkpN8034qcoaEtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dZdKabU9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QAfLBB018773;
	Wed, 26 Jun 2024 12:38:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bzQCIXOvbMz5V60jXgWs5L+ETRaTIwpdo3pynIJnx3I=; b=dZdKabU9gTObYh9Z
	1ZzQstqJt51cpwQWw4bNXGk8WrtUk3HWRakvMJT7sXBNSfNwHujAUSGhTPlQEMSz
	cplz9S2gm/M+VK69sgM3sOsUsURlN+iUrs6eG66hRvEaKP+BL0NniBStpVs8+UPt
	xCZfE06mh2nULDcdS0tNY9sxx7xnDUmug7ji/AOEgJcg2BFFkZrd7/Iks0/WCNXF
	tycQuDM32vECTscA0Eo37HvH814K/sXDwuOPzqcrwUXntueBD+dkroXMpHEChDsn
	75GSitIUbhrXuQjnZkuR9/SUGNhsxlov+Kaoh004OQQI8WLjCbxCBIIvXQXDeNJJ
	ZH5O3A==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 400f90gqq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 12:38:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45QCcH35012411
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 12:38:17 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 26 Jun 2024 05:38:12 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Wed, 26 Jun 2024 18:07:52 +0530
Subject: [PATCH RFC 4/7] pci: Add new start_link() & stop_link function ops
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240626-qps615-v1-4-2ade7bd91e02@quicinc.com>
References: <20240626-qps615-v1-0-2ade7bd91e02@quicinc.com>
In-Reply-To: <20240626-qps615-v1-0-2ade7bd91e02@quicinc.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>
CC: <quic_vbadigan@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Krishna chaitanya chundru
	<quic_krichai@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719405471; l=1124;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=k3m1vxMbl2ArWV+IwppPThDXiHUXp5H1ICsNoOwyDzs=;
 b=W59MU/4BMD6km9wW4YtLoQv17jadLx/Q4URwYe1JajExQ6M/IAibfdrqyaE1mX3hYfczJlZZU
 CYk2FAl0Lr5AMW5muuzSAvdUdsJWikTZXz40fdPqYbALm6bDzQmOw2J
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cJje_2zXIrvTwK1-rGC_oR5TFDUozetQ
X-Proofpoint-GUID: cJje_2zXIrvTwK1-rGC_oR5TFDUozetQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_07,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 spamscore=0 malwarescore=0 mlxlogscore=572 mlxscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406260094

Certain devices like QPS615 which uses PCI pwrctl framework
needs to stop link training before configuring the PCIe device.

As controller driver already enables link training, we need to
stop the link training by using stop_link and enable them back after
device is configured by using start_link.

The stop_link() & start_link() be used to keep the link in D3cold &
D0 before turning off the power of the device.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 include/linux/pci.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index fb004fd4e889..3892ff7fd536 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -803,6 +803,8 @@ struct pci_ops {
 	void __iomem *(*map_bus)(struct pci_bus *bus, unsigned int devfn, int where);
 	int (*read)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val);
 	int (*write)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val);
+	int (*start_link)(struct pci_bus *bus);
+	int (*stop_link)(struct pci_bus *bus);
 };
 
 /*

-- 
2.42.0


