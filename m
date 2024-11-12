Return-Path: <linux-pci+bounces-16551-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F6F9C5D61
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 17:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D1DCB85A17
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 15:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B304720110F;
	Tue, 12 Nov 2024 15:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dF3iGhPE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2740A20111B;
	Tue, 12 Nov 2024 15:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731423751; cv=none; b=LTh6QKw2LXuvDhRGHB4YAItHLUvujl/+UsDxg84TL2rGvUCsIUgweviZwhZUOcmHYvn7JAizrC7kHtq/LTLQ2EpKcFeAazjR6+WJRy8qU74rFhz1eI7jFNg451RDsb9EF2/XKD6TX5k3Q8mxAwJjX6CeI5I1LPOHxRt0CNKdFwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731423751; c=relaxed/simple;
	bh=acyYyUafl9feiMn2VOhRTftG1tFqx2+TRdN0o9G37UU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=siH6Tiq0DIAEVyx366X9SqluKKpku5XT6IS9gTLYNDQzIoArDA0cztzVzTabZIKDa2F4xAPZwq/P38aELoMADSPymWOtA2kjURk3kykChB0aHLnuSCuSLnaTjjsPzCN7zNlNGE7MhgoZ19LSfrYpqIIgOqfXgoqc6iwRZrKGcMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dF3iGhPE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACD4D9C032436;
	Tue, 12 Nov 2024 15:02:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aPZ6oq1ZKpWlL8TmiCqZx+G6KqgOTM1pUnuv9xmGQoo=; b=dF3iGhPEpAePCPyp
	XJYGUpmCDQ4gDIZp0ijizLmyhc+PYRbw7TM7yAplz4nrSqpUE0Fhi40C7jGDXU3/
	txwPbn8pgxXSmbGWVuh0O5ZECscuhlOmLmPJ3lICq8Sc1sF3ii+gf1xJ5KTGF4r1
	mRTfayq5uZAShlkMJ4GRST5QJRKDReZIFNiZea+0P17xAsji3bw75vRf+otEHkPf
	rozGEVOclMm6K8bdaYSYnChq4fB2VRzgdS1As4D9uaxo6+NF2lImMa2BFsmcr7nr
	IuIqjbI8n8XxAu9lBpgy7y9k/ZdgyfoJAcw80bXOoiZ/Peomg1rSuiK1yjZB9R4J
	HZjuPw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42sxpqfq0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 15:02:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ACF2BAf001604
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 15:02:11 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 12 Nov 2024 07:02:06 -0800
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Tue, 12 Nov 2024 20:31:35 +0530
Subject: [PATCH v3 3/6] PCI: Add new start_link() & stop_link function ops
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241112-qps615_pwr-v3-3-29a1e98aa2b0@quicinc.com>
References: <20241112-qps615_pwr-v3-0-29a1e98aa2b0@quicinc.com>
In-Reply-To: <20241112-qps615_pwr-v3-0-29a1e98aa2b0@quicinc.com>
To: <andersson@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        "Lorenzo
 Pieralisi" <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "Rob Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        Jingoo Han <jingoohan1@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>
CC: <quic_vbadigan@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Krishna chaitanya chundru
	<quic_krichai@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731423711; l=1199;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=acyYyUafl9feiMn2VOhRTftG1tFqx2+TRdN0o9G37UU=;
 b=FSu9ivbVmI7F5iPmBqarsbGk4rUE4adRO8ukpADAsLE7/f+f6ZwEnN6zJ0sWWdIdr4UJrGbjp
 WU9VZJACyM9C5F/xaUCqmYXY6HF/UdufdVZn69QkBkAS5Es7SGCOQCO
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pBouPSESrfyt_WkccRJrFI82cH0LGRmy
X-Proofpoint-ORIG-GUID: pBouPSESrfyt_WkccRJrFI82cH0LGRmy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxlogscore=564 phishscore=0
 suspectscore=0 impostorscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411120121

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
index 573b4c4c2be6..fe6a9b4b22ee 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -806,6 +806,8 @@ struct pci_ops {
 	void __iomem *(*map_bus)(struct pci_bus *bus, unsigned int devfn, int where);
 	int (*read)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val);
 	int (*write)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val);
+	int (*start_link)(struct pci_bus *bus);
+	void (*stop_link)(struct pci_bus *bus);
 };
 
 /*

-- 
2.34.1


