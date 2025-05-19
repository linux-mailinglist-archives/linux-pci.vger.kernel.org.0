Return-Path: <linux-pci+bounces-27937-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4590ABB9F8
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 11:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E28AE170884
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 09:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B1F26FD9A;
	Mon, 19 May 2025 09:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JsMyobqf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4805126FD85
	for <linux-pci@vger.kernel.org>; Mon, 19 May 2025 09:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747647759; cv=none; b=bjV3Alrd5L/JfkvIPBRXjQpg2y6iYx+zXrbT3CthZ/UkQHo1TuZ6ByalWRI/gQuCz3Y5EvuO5GPo2R09HkmAAoBM9YpIfvri0tHYaaSb6MbkEkyrIiVyolM3P2GzDbPfY0t1Nm7oaMd8vt1nLoCcGX2Ppt4axqzXiZqBg1raaAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747647759; c=relaxed/simple;
	bh=uFH7gvcXfq8PXUbSnW4zFmBHt5LxnpwhDzcE1X+yWFo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q6YFoOHVWUh+1r/JjXmKVrLHy54G/1EN+jMoL7Pqc43x0xQFqwp4p1zYtNUrdk3h0MUR6SOSh2BvXsDDFBSdpqUBgYvSAPPULsAcma28o0dn5SwL50ko1m/AHB5xKVF+Pbi+LnNqrZRkeSs3kG3E/11FSzsXfK3i/amOJJjTaug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JsMyobqf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54INoUab026191
	for <linux-pci@vger.kernel.org>; Mon, 19 May 2025 09:42:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uU7PofubsUvHU2URxMpgS+EVNoeW1gK8KIbpSjZ8wvs=; b=JsMyobqftJleRTbj
	B11FC/2JAVgMNtjie8qW+mRAiSMr00ZwBIKJaCtY3K7PJC1hvmlA+odTItz9mkCP
	GIU5Beb95mBvQF1MoNpLuAZAKckt3FHFHBhceDgDSiLuQSndTkJrh3vfHvxrVIyp
	5Y+5+bEuE1WQC5majbNemPAgNASOi3DER8bcp3B5C0fCH4hSP1TxY/fEQJYUKzPF
	uXoHW6oUhwk4bFr8uqL/aKBxxmsApl1JfFXI1U6EDfPjcYkiq/nG3RWA99sCIJtj
	ZtvMxwTMCxFSyfvqeexb0VY2onCr+1/JBfnbs5Tb36ISaKeTEGQGtL6FR/1P+pCX
	4KULVQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46pjjsuuc2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 19 May 2025 09:42:36 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-742c9c92bb1so858485b3a.3
        for <linux-pci@vger.kernel.org>; Mon, 19 May 2025 02:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747647756; x=1748252556;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uU7PofubsUvHU2URxMpgS+EVNoeW1gK8KIbpSjZ8wvs=;
        b=Jcc6YR5J2bWM8MhLfCKl6iPz6qYdeYAShcS+BxntZ7yZIoSpapivbP/uKDzGsrXIBe
         l32vG993Z6aMpOJrtqsR5J+HkNdg0WLl1fSC/ULnflo16EQ1DTxilFBiAEl82GyL/9br
         P+PGb1rEI+I2kAHaSzQu17UM5RmdUnwfX18/xi6I2/g9cMD3BZiKk5D3K5PsvVR5W65w
         rBjO8ceONvpA3FB8N4e2hSQJb8PrzFSUV2kwkEOcPuCv94XECnksoVvA2QDhxLP/3cdG
         eC+m1Q3ckDLkA2+jn5Q/du2wI3ZqV8PFglmPUT5gtlkJNFISqKnyHwb7kly9ZHE0vJMm
         Tz8g==
X-Gm-Message-State: AOJu0YxATfpm7cWgwJUq5Cs6RUpsfmT3IfDlsuap3Vfy+fwnvsXJsaH8
	4nynXR7rWGD1RrxTljOV+v1swcIiiNOGKQGZ4g5YV2H6fyYyYod8iISlRMBhGgnS3YTfIxZ8fSv
	AMh9I9p2f/UAmkla9B2E6uxHPCr0I5TJfUc2Xcn2vOTSWHAaWDbxtrS8TSrgM8YY=
X-Gm-Gg: ASbGnctdXn3V2ZW9GQSXpewcDtB19khF330cxZNMZHRDr9BnXHBLgsbnm6LlKrV8tsi
	qQ84/fW4XRH5XiXvPWK6UqtotNAkXXMnYKk7YyER6/+fYT/JK67NJHharbo8pu/i9P8M9VlZGCK
	rbKT9uPxbs5MIHwUt3T8E/Kl8EoK4BLzXHhmK4V83gRVG4eXXswP9H6LpHgPLWFcW3i8pQuAvci
	5khS+ro0XQUNpyUhA5NxOCoLSlAfPvsc6KuQ2YrIZxexbTzCASQuGH7WoajTSVlFbAyKnFK/cYz
	aDL6wZky09BcUN18GszmeqEQav/Fwc4dCjEVkziPQsSr59o=
X-Received: by 2002:a05:6a00:ae1c:b0:742:b3a6:db10 with SMTP id d2e1a72fcca58-742b3a6dc2bmr11994274b3a.18.1747647755743;
        Mon, 19 May 2025 02:42:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE99iUQ+YVc/maiKCsxdLZP8n8nikcwdzK+f/VpTPSVQgsMwchfjJqT1QzUS2xVouHmoYvWTQ==
X-Received: by 2002:a05:6a00:ae1c:b0:742:b3a6:db10 with SMTP id d2e1a72fcca58-742b3a6dc2bmr11994251b3a.18.1747647755364;
        Mon, 19 May 2025 02:42:35 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a97398f8sm5809092b3a.78.2025.05.19.02.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 02:42:35 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 19 May 2025 15:12:14 +0530
Subject: [PATCH v3 01/11] PCI: Update current bus speed as part of
 pci_pwrctrl_notify()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250519-mhi_bw_up-v3-1-3acd4a17bbb5@oss.qualcomm.com>
References: <20250519-mhi_bw_up-v3-0-3acd4a17bbb5@oss.qualcomm.com>
In-Reply-To: <20250519-mhi_bw_up-v3-0-3acd4a17bbb5@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com,
        quic_vpernami@quicinc.com, quic_mrana@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747647743; l=1353;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=uFH7gvcXfq8PXUbSnW4zFmBHt5LxnpwhDzcE1X+yWFo=;
 b=lXyiRKWe2dUM/NoKi98YA2ST4iD+GyJH/JWFyhdLHqiaIoNSFdOEcmMxv7oVHUvW2lVe0h7ZL
 UYVeLSPwgrlBOdS2f0m/xziM1YsPsEV3QKXX1cYho1bhDVgeJ3/rrYA
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: C0CxxIYd4-bn6p0DTaslv-0XlHJVrpxG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDA5MSBTYWx0ZWRfX+a8uKwk35xaK
 DBNMTn/u5RZPWisHqqz9yJeFZwkaAAaaSe1R/P1ErOUbtJqn+M9CY+71NlNLxOGVT4ApSJx39SB
 2X6wHFwOgKDhoywNsLsd8WOTnkgfer7odTeqwrtZXlB8U7xci3pX7y5bvgV7MuyrlHzc2uYCBkn
 oecaMGz+acy3HNsyLXw5RWSzE8PQA9rNQGNmLQMQzaU2pfX8jR1H98NrYypTEknaTkpGszbo3Iq
 J/APCNn406Q7GsZ2yv69b5/cqOzjFEQQYg0U28YJ8tdQC0JpRATQKLVYLP09VTYGg/mCM5jvj6t
 UYyW2M2uglF1zR2eaPNNPmnvYSCerDsIfC9XxY3cM38xKeFGEdoVFnk490K9bx4f52W7kJpxqn2
 u5j9IuRXviA1NWB68MfnfQkMa8f2qjoeMX2YkSPuNXWsUZXqvV3AzwdnRkcJQLM8h8Ze3vAy
X-Authority-Analysis: v=2.4 cv=K4giHzWI c=1 sm=1 tr=0 ts=682afd0c cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=3phiJa3m8EW-4BHYHVwA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: C0CxxIYd4-bn6p0DTaslv-0XlHJVrpxG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_04,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505190091

If the link is not up till the pwrctl drivers enable power to endpoints
then cur_bus_speed will not be updated with correct speed.

As part of rescan, pci_pwrctrl_notify() will be called when new devices
are added and as part of it update the link bus speed.

Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/pwrctrl/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
index 9cc7e2b7f2b5608ee67c838b6500b2ae4a07ad52..034f0a5d7868fe956e3fc6a9b7ed485bb69caa04 100644
--- a/drivers/pci/pwrctrl/core.c
+++ b/drivers/pci/pwrctrl/core.c
@@ -10,16 +10,21 @@
 #include <linux/pci-pwrctrl.h>
 #include <linux/property.h>
 #include <linux/slab.h>
+#include "../pci.h"
 
 static int pci_pwrctrl_notify(struct notifier_block *nb, unsigned long action,
 			      void *data)
 {
 	struct pci_pwrctrl *pwrctrl = container_of(nb, struct pci_pwrctrl, nb);
 	struct device *dev = data;
+	struct pci_bus *bus = to_pci_dev(dev)->bus;
 
 	if (dev_fwnode(dev) != dev_fwnode(pwrctrl->dev))
 		return NOTIFY_DONE;
 
+	if (bus->self)
+		pcie_update_link_speed((struct pci_bus *)bus);
+
 	switch (action) {
 	case BUS_NOTIFY_ADD_DEVICE:
 		/*

-- 
2.34.1


