Return-Path: <linux-pci+bounces-39918-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA469C24BAE
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 12:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AA8F463AAF
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 11:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94693451A2;
	Fri, 31 Oct 2025 11:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ST58v/25";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SvBqTS1J"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CBF3446AB
	for <linux-pci@vger.kernel.org>; Fri, 31 Oct 2025 11:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761909153; cv=none; b=c2XB72PPdQNpDAGrvbw0QC2UQvfFNjb/0zbDcE//L2caYuqMXv9DnRpgRnnzSpN142frPCGXJ4Xp7qBxuMaTcigfFaEnlOoob2mISYKdbmutIkBghgxw3yEf10uuroWBZ6hbmEj2tmPVaWSLIx2TZhg1KJKc0/D/uBDBpvUlbNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761909153; c=relaxed/simple;
	bh=/rHGDiZUdOdrl9DYepaOQeGv1VtjtTYXi/+ZkT8cb+s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X0nZOYa/BGTzV/9qMADcSAxmNukYFYr0lmp2JyvDqIPwnKDBAO/M/jvpS5CfViXQh/5qs+wmPCAEnh8PJCdHWMCIN2rv6VHAxODpcST33Ozm5GCVc6F9rQDxboyiX9ppho4ZMunPfPGm08eCf1RRD0T1fZOXsiICUi7AL7UZH+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ST58v/25; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SvBqTS1J; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V9pl2k1416929
	for <linux-pci@vger.kernel.org>; Fri, 31 Oct 2025 11:12:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TUun8ttkoQTOkHeDhGd/NSYDbZVcwe4JABD7MBbYCrY=; b=ST58v/25oX5eH+Mn
	tUypL1GZUOsYAKlZu0fVev3CwND6mMnDYOJ9tCeH0Y/Y5DB36PPgobmAPQ7ZRC00
	LqLQK9EWsowwhPmFP+4mUuCxCq1l05rWavuhbK2WVPW5edLM07iqibISllyVbg+P
	HM6hnjqjdx9qX4uktkBvgwH261Sxeiv3q/mOJOf6bRiLNoWTN6lPrhW+8Z7fpdvD
	I6MSRYTLbfio6X0ZtddinQYpZDrxwjgYFIgMLKddnNYQGlcVrCLt/tv8v7aJml68
	14ciKwC6W+Abwx+B8MqmCgUEg8KAOskIdah4aGF83iU0NisBKI282tuSn7IIFDCO
	9G7k4g==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4k69hhbv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 31 Oct 2025 11:12:30 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-781171fe1c5so2097918b3a.0
        for <linux-pci@vger.kernel.org>; Fri, 31 Oct 2025 04:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761909150; x=1762513950; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TUun8ttkoQTOkHeDhGd/NSYDbZVcwe4JABD7MBbYCrY=;
        b=SvBqTS1JLYcuAkLr5/K9Jix9PDSHHmfKUKDwgxUs7OycpAzKZK63XdBcYY3XG74U6F
         UqEzpC+Xlz6wqMS6ksqD7vEAO/LvAnDeGIRAVfzK8U4TvWEmag/7yGIUGCKPqXlSDN3p
         Ju6Ay6wK+01f3Bi1oSqJqoGmtp4Y9WERz1PuQk+D8fYxLhg8rVSqu/HYwvo6GSuynadj
         q2u/0zpvyQUu5Nphbux5b2/ukHcc0i2ErddMszPBO0Ur227l4TZqjvEYMviWSANy4cNZ
         F+ax9o4HR5CJ6xGI/0jWga3DPNgxLFj6DQkkc/W3VzjOh6B+YofUIn00+MaDc4ZtaCbo
         rBJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761909150; x=1762513950;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TUun8ttkoQTOkHeDhGd/NSYDbZVcwe4JABD7MBbYCrY=;
        b=et4ApCeHQWaydbB7cqj5vTsoKA+fquGH+sW+K8Mh2KImaFg5mXRfVchyRz8UCaH1/4
         Q3uzWfF1IypMMzYtFMFOhk9tJsRjqYg+PinyucPV16JLVudWMwsqs72rqDJmN/q06Btj
         ZssiNonqGBXns07B/Y6acLDfInPL4r4zr8e06wzeCtgboBGiwBFT3zfRsTTkx6Fkpg5b
         gr2Mzj1ZjkCYptKo8ysGAwWctOPV7NTUydx3M6DYjM+CD/J9OZ4LbaI1pfCQxKag0ui1
         1jerbVo2w8gZdsvEcKZXe3a0Bzbo7jFRLwlSNGlVYXJT4UdhJzCR8Ci/k6Zia4iAL1lj
         lQ0w==
X-Gm-Message-State: AOJu0YwONk2EuqZ6nJ7r/LCWucWQqIw1MYMsjeWZX/D6jlY0xjk1EJpG
	DmJML/AdWVBZhr+S7w25tLmGCWvICOlc40l54kJ/CjNpr/xRtY1A+/WMwaTVtvl65hY1jDg2lXh
	gAb6EIEG9l1q5sjwjIx/y78cJVXXIGXNQN3b+yn0JvFAwgzFCHVe7lL/tfs4SZs4=
X-Gm-Gg: ASbGncsYTUZ4jz0lr4h7MT3b096xiDCGNe98/NhnqFGsjtlOXzX0XZxfJdctwxOao7p
	2EQZbFLg8y1glnYvotu440Pe/ab1ykTR78nWmy9Rh69EBpQrQm9S1SqQu6MsVi10FtWrjPdB1Gv
	tfRjHKCvvPC7M4vQcF19B3tAVlxuW3CpZhOSLwJHW5w0ChoLcExgGwWLxWvEVASpcXmVmwZZB06
	9E+08rKeMWlW//w4UkFsr8uHqiiqrLA4fzxKvTywbARF53gEvTmchgSgOPHqxTmqLz6aVYw2Ytz
	QbRcFUAgnTMXT0XbUroECXj23x08GgkBGmJEYtnpfdQlIh8X5MEn7/L3MyvI5dchxNUGM83IwKQ
	fSgyAk4SnmMyitBlSNT1XjhAONpjfnvJvhw==
X-Received: by 2002:a05:6a21:6da7:b0:344:97a7:8c62 with SMTP id adf61e73a8af0-348cb08f3c9mr4485377637.23.1761909150039;
        Fri, 31 Oct 2025 04:12:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTcz2eZ3B0V8wEazc5KEbLKkxIWKgiiOEp0tZ7ZxRptwHbThKDQlcx3aEinQTqWNiwdcZvrg==
X-Received: by 2002:a05:6a21:6da7:b0:344:97a7:8c62 with SMTP id adf61e73a8af0-348cb08f3c9mr4485327637.23.1761909149547;
        Fri, 31 Oct 2025 04:12:29 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7d8d7793fsm1887363b3a.25.2025.10.31.04.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 04:12:29 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 16:42:02 +0530
Subject: [PATCH v8 5/7] PCI: qcom: Add support for assert_perst()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-tc9563-v8-5-3eba55300061@oss.qualcomm.com>
References: <20251031-tc9563-v8-0-3eba55300061@oss.qualcomm.com>
In-Reply-To: <20251031-tc9563-v8-0-3eba55300061@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761909120; l=1479;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=/rHGDiZUdOdrl9DYepaOQeGv1VtjtTYXi/+ZkT8cb+s=;
 b=IVF5DRupFn6r14/z9fGTp84BhyIy1Hl9FJ3EWg7OBJZnfOL0e8jWTHPMb+mBCov5dy8UuYoz/
 l2lTVLFzBEjBM+jJWXeLRG5+esykCOJwy6N82STTktTPOEz8boJ2HC6
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEwMSBTYWx0ZWRfX76mJEdDODYuA
 3TyDOSAKHiTWmB2aMmc64AcjXdZASQqjgCAkDdwRMtSOcW84bUPhwsXx97PJcnOTOPTxYXP79bk
 3F82HrpnDESMEd1t01M+o4Zfo0yBTYjWZsLpY0Zu8c/2MLSfPCxUmhsftoC4+5UtX0660lAzLyl
 De57+pVjTm5WVdl2xflwGO6lG3bcDzaTg2rKSZ9zSKjlrj2qAo4RrosDxNFpbm0E9nEcodBvbMx
 949+oLa1aK9lkm+DbR5dl1Z98eCtvSHvuzMQDdBsTkMH2W+S5NQ5QjdOc6W5vFZo0QBColl8NbM
 jh4hIEKlfSLKO4KgLhMO2wyFkfzy8kWzA1M4zTWB3faGO17XrQSKJpyJ4+rgM8MGVcrmmXsuMhI
 YVy//z8ifPpHSEM50papAnPFqcFjcA==
X-Authority-Analysis: v=2.4 cv=Bv2QAIX5 c=1 sm=1 tr=0 ts=6904999f cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=j2XxTBISUlk66HYKGUMA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: QZL70kY042Knld9ZbemYA0J0SkpmIoBm
X-Proofpoint-ORIG-GUID: QZL70kY042Knld9ZbemYA0J0SkpmIoBm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310101

Add support for assert_perst() for switches like TC9563, which require
configuration before the PCIe link is established. Such devices use
this function op to assert the PERST# before configuring the device
and once the configuration is done they de-assert the PERST#.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 805edbbfe7eba496bc99ca82051dee43d240f359..cdc605b44e19e17319c39933f22d0b7710c5e9ef 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -696,6 +696,18 @@ static int qcom_pcie_post_init_1_0_0(struct qcom_pcie *pcie)
 	return 0;
 }
 
+static int qcom_pcie_assert_perst(struct dw_pcie *pci, bool assert)
+{
+	struct qcom_pcie *pcie = to_qcom_pcie(pci);
+
+	if (assert)
+		qcom_ep_reset_assert(pcie);
+	else
+		qcom_ep_reset_deassert(pcie);
+
+	return 0;
+}
+
 static void qcom_pcie_2_3_2_ltssm_enable(struct qcom_pcie *pcie)
 {
 	u32 val;
@@ -1516,6 +1528,7 @@ static const struct qcom_pcie_cfg cfg_fw_managed = {
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.link_up = qcom_pcie_link_up,
 	.start_link = qcom_pcie_start_link,
+	.assert_perst = qcom_pcie_assert_perst,
 };
 
 static int qcom_pcie_icc_init(struct qcom_pcie *pcie)

-- 
2.34.1


