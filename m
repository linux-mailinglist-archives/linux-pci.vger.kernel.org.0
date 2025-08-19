Return-Path: <linux-pci+bounces-34240-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B0DB2B8C0
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 07:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D3B3567CE4
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 05:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB4930FF3F;
	Tue, 19 Aug 2025 05:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gpoFfe4U"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056EC30FF2A
	for <linux-pci@vger.kernel.org>; Tue, 19 Aug 2025 05:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755581715; cv=none; b=tg331iCILLdoifmj9WfxVPizXPD00+mLTEYjyQTJlTTyYkGG9ZDiPrmdPZ82Sg0vqoEC0/mtCyzOgEEPI6MVEhDmyPM0+aBsJbTp1w9iuUyKxJViSXrjRFVn8Ixd8APwPmnoOcj/p0mPSJMHJRSng7iWhF1/MGpTQMXpfjBQ/os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755581715; c=relaxed/simple;
	bh=zNNsKODeITIq9p5C4zPwt5vGWZ3TBF1so1nIBED9rGw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ErqlMOr06XsZX6wedA5mHXHaZeFoThU5ZqIpQLvDwXs2eGGx813p8nWQIn0jhU8nKP1uzoG6YKAuZ16zSpAqebL3MNWsoAhFCpzVhgGlzdvltw5/7Py+c/C3MsAL1GkkcFNrddio62X9G13qvz42rpAnKp1oiT9bBy0C2ZmU/J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gpoFfe4U; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J0B6X6017909
	for <linux-pci@vger.kernel.org>; Tue, 19 Aug 2025 05:35:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	E2kyA8hwKaH90uvk2Xmr6w2kxbT4ZU7HruVvyuzREbE=; b=gpoFfe4UFOaDA9bU
	r9jDeKQzo0SMU99M0zQJ151VvKu4U7McC6qE51lNUIFuvbYxMnj2/prmj4NZq1+y
	cqQvxoDxsiPgGjrKGOU1T+eoCJt6PC00vnkvvtK3M7PD3WHy9ZxZLoK4OP6AGeZw
	emT9WmHmHG+8oQQfAmEsTDlkW7qIpsvZ6G1U+AQxYquH6hXxx/NzJ6KUeFjqG1xN
	SBmKDFBsHHwIEe8L4fh/M3gRtH6qkh+W18WoQzt6Cm9tkFeB90Fqixvr5bubneHk
	8Yr6QAV7UkJXK5bgNHEoH9jODoYV9h40iOGmknvuzESgi+rI7rsRmvTkcTQvTfAT
	xuZhCg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jgxtfgtj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 19 Aug 2025 05:35:13 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-244570600a1so58835075ad.1
        for <linux-pci@vger.kernel.org>; Mon, 18 Aug 2025 22:35:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755581712; x=1756186512;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E2kyA8hwKaH90uvk2Xmr6w2kxbT4ZU7HruVvyuzREbE=;
        b=JEJOanAxo5WjdgRwH+EK2Ovkai5mOt+N7kvOZJ8mYRwjDLxhVdMq4ERJYWCkatyNbL
         EXx0Nh97Ee/BBwfOwm5hVTNoGLZ/KqU+5MG8ettr4/USPBQ3hGVeyeubNpd7OZZTixUe
         +IFte2rH33T8u19hMvpUgM+dDOwwS9LAeM6M8h1JUJc5JZfM5B6fIj6iUZgX1zsX3ysO
         W5Bij8PAKs6JsmXrxYCawchaVYoZeF0vcRbzGwjpGClfSdD/Cm9paGbmmEmcyU8sssNY
         6zkAWHynH11nhIE6Q+GaM4M8BtWKPsrx5tVhL9p4Oj5A/cnqm+JYo+ISg3MM14048LPc
         usCA==
X-Forwarded-Encrypted: i=1; AJvYcCVG60azmi8E1Wp9rcHzOoKOGqlGszRm8bkyCo0/N/rA/GILsypLhn09UhB3VBkr/Zhw0q+JrPibfXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMKZqf2UGgVKxaAWIgd/9FklyOvoBowoeBQ6Rvz82LVcw6pVkn
	fa9UdiOwvCP60G1+QrutDhhPTy5AiBTpHmiunde3kInvnbFFhNUKsFpwvThG74XWkf7FCOxoCa/
	CdaT2pO7fSPwJcr5X72M3YCjAJUP15uhSsDKvqjQgb3Vym8mr0sUlwIRiRBtHLTY=
X-Gm-Gg: ASbGnct+ra1JS/L7efwEfj/aHcGRgoMQdIZ9+cajXj8KXW4/BUyeyuaGHMSoxxdpvQM
	8FL1iNJTBDcH730YXLZfrxGXgTFRprVNDxkn3lOPR9Bv3ifBPB7L1a++6K19J9mH20z7GA0Az7c
	FOTcU1yZXBIstO/AuGVTmxothmoRJmCw2XOfMwWP6HvejSxbgjQ8R+6a/qcGhmoEfKG990BWmhu
	UBFG0yDIw35NqzZ7BQP0LuQT08YASC2FCgsjq+znJDfEA47jcKfVhO7VInYyyi/Dl5XpmPruG73
	r2eBzOAbLKZpq552OmnUHEJQtPR91X9uuLT68+i9dWf4ZjPovslToPfaaTQGB+zsH33GdbQfKls
	=
X-Received: by 2002:a17:902:fb0b:b0:240:8381:45b9 with SMTP id d9443c01a7336-245e0e7e446mr10287365ad.8.1755581712172;
        Mon, 18 Aug 2025 22:35:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlQWzbteHJo76hpEH20uaQnkd1jnlahQtMpjZ67WAow1lhts+lyKQezKrKBUYJNQS0+C1iDw==
X-Received: by 2002:a17:902:fb0b:b0:240:8381:45b9 with SMTP id d9443c01a7336-245e0e7e446mr10286985ad.8.1755581711630;
        Mon, 18 Aug 2025 22:35:11 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d50f710sm97004785ad.86.2025.08.18.22.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 22:35:11 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Tue, 19 Aug 2025 11:04:44 +0530
Subject: [PATCH v3 3/3] PCI: qcom: Use frequency and level based OPP lookup
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-opp_pcie-v3-3-f8bd7e05ce41@oss.qualcomm.com>
References: <20250819-opp_pcie-v3-0-f8bd7e05ce41@oss.qualcomm.com>
In-Reply-To: <20250819-opp_pcie-v3-0-f8bd7e05ce41@oss.qualcomm.com>
To: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755581690; l=1508;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=zNNsKODeITIq9p5C4zPwt5vGWZ3TBF1so1nIBED9rGw=;
 b=eMVsS4IDFU8hFcD2F6t7VUAbSugqg0W2QV7+j5cYp/puvGByR2nitDuJVhUEL2MRqHpkfdIKl
 VnFRKOAoOXPD998biJlrKBmMT5FS56JhLQvtb+clOi+AEl3ORrhDtLc
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: 98RxksFQpjyMNklHk5oGPY4pK62a6ndh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyMCBTYWx0ZWRfXw+9nuzBOlBpN
 idzyr6XAxlRHtTsHKeEZCrzy86bk7541j3AUDgQwl5Ak4kg4I4/B6JA3ETUZiF/uBtQfiXlG0nh
 eOR8AKDyq/B+LuO+iQwzNn/lkScPX8CAZRdU16Qt28m/TzPCOMcYa79m1KvrDHaHRfoyYz7jgtL
 Cbr/9Lnj+hzvzw59frECLViSbS3FdL07zz1PDwKGad73JRyjJEcRkf91yVbv7520cmrWla63KPO
 1lO42oxoGGHZHG5fTRxhChJXFZfl9B36+uZ+NjIBiiTlSno3xaHdC1gCz/oFQOPhWlz6T1SwflC
 RV/rSHwn9WWByy77dKdIs8j/SoMB+e0Gyuehjly7n3kls0M1ntct3AEh1wSMvni2I2CgZToQh2C
 SgU8EAAX
X-Proofpoint-GUID: 98RxksFQpjyMNklHk5oGPY4pK62a6ndh
X-Authority-Analysis: v=2.4 cv=V7B90fni c=1 sm=1 tr=0 ts=68a40d11 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=Py5lcOcq67Lbq8UMOfUA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 bulkscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160020

PCIe supports multiple data rates that may operate at the same clock
frequency by varying the link width. In such cases, frequency alone
is insufficient to identify the correct OPP. Use the newly introduced
dev_pm_opp_find_key_exact() API to match both frequency and
level when selecting an OPP, here level indicates PCIe data rate.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 294babe1816e4d0c2b2343fe22d89af72afcd6cd..831c9138841ac089c6dd6b08a4a206751dfebc91 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1555,6 +1555,7 @@ static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
 {
 	u32 offset, status, width, speed;
 	struct dw_pcie *pci = pcie->pci;
+	struct dev_pm_opp_key key;
 	unsigned long freq_kbps;
 	struct dev_pm_opp *opp;
 	int ret, freq_mbps;
@@ -1582,8 +1583,9 @@ static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
 			return;
 
 		freq_kbps = freq_mbps * KILO;
-		opp = dev_pm_opp_find_freq_exact(pci->dev, freq_kbps * width,
-						 true);
+		key.freq = freq_kbps * width;
+		key.level = speed;
+		opp = dev_pm_opp_find_key_exact(pci->dev, key, true);
 		if (!IS_ERR(opp)) {
 			ret = dev_pm_opp_set_opp(pci->dev, opp);
 			if (ret)

-- 
2.34.1


