Return-Path: <linux-pci+bounces-27942-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2867FABBA1A
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 11:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8312B7A2512
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 09:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B1A274645;
	Mon, 19 May 2025 09:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cgX/o7F0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B742741CA
	for <linux-pci@vger.kernel.org>; Mon, 19 May 2025 09:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747647791; cv=none; b=iVBjsO6qlCNCej2Bgo5pYT1eLnyCkQaCz6zcjLwgQvFv+QXapYhYIT7JJ9r0ZmzPg0mgrR2fXPcFMlASo0BipXQvlSoR+3q25DBtkN6goD49pEe10ds6KphDoGaCqx3nIHiYITyXVq8LY0Snry7ySQFUo1pR0ab7PnyB1l3ajDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747647791; c=relaxed/simple;
	bh=uRy4dvcpRg7kmvMAbVOO9GqUHN/mlG3BTN+ZElHTVsw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A8JS6+lbDNa6OYoTjnAAjPxVf3VYj42Q7SSD1XoK/2gURhZu7cLW5XfMPSdT1YMLJO42ike9uH++Uq1CRO+n9kqNxpiQ6k/KSY17pzGQ7SdVhOcAsZFmoZjF/9Oa1bbqGwT6fJNeuVUO6C9P3FUWf6xR/ZgufhFvj1bOs+DwhQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cgX/o7F0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54INsIiY032032
	for <linux-pci@vger.kernel.org>; Mon, 19 May 2025 09:43:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	roesPrhIrlAEA1YO21ErXpasCF74J3nkSL/IK34yrk4=; b=cgX/o7F08d+t9S9G
	3tX/r5Mw0I2iJiP4Vn5nXkXD0E3O0JoodT8s1sxqtCps3ty+pLP35xiy3UpdOsk3
	UkKWIwmkUriV9MfumNUiSCQORL8OCOumMzWSgLoqYV7snr4gBCWG7NRUdsk8uLwU
	ByPfmopguNzLun4BWofMZysYT8+jUpODarBaC8XGIhz4RtHgu+YWrYwpteY79R6+
	BizLA11/vuY08MmZyp9kIIQOWKR5IgilwfGGMXH/vphsx7DEaltzxrfwtWO06cNJ
	AHP+tFpUJ52IkRxXCNhXiwwJM7ytxjrjPPQ6WBEjhD60VwlHOwsNkmDcZiv8mpz2
	YOAFxQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46pjjsuudq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 19 May 2025 09:43:08 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b0f807421c9so2484170a12.0
        for <linux-pci@vger.kernel.org>; Mon, 19 May 2025 02:43:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747647787; x=1748252587;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=roesPrhIrlAEA1YO21ErXpasCF74J3nkSL/IK34yrk4=;
        b=XKODJhGBVs4N1ZXlyDjkoo68AES5oVf+Pjs018Um6mS8I49CN4n5v6Vzjd6yEjq5TM
         OkYIsgek89FueUGKVaGtmhz2x+veULb5PJiE+jOea/26lmlX3Zuk2cFSR9e2nzmyan//
         FnYFIYZxRCmhgucejhZUlkN2YXt2vvU0rFreW5LOlyI+5ueE2BVtp38ET/ocDUYoCRoI
         evQ67Q31igkXMw4UmG8c0KuBMHdb5h+uwL8Eopa/fPpKCH1tg29mf/pLtIdZ6mTtc+II
         dMoGPJ7XVeEp4wcfPQRrC45FT04vLEybuCvSLQuc3MUam+EM/INrs95ZAzdGoEfbxyzV
         MrPw==
X-Gm-Message-State: AOJu0Yw5GMVR5tO55HH21hPNEJ1mRh/v5sIOXIZGDmWit0yxr7feZhKC
	rP7MIlXITt7a4435HK0ymqQN13x3LBR8q/nsNaXqEG1GonwK/lNr2GPjY78dSfAAXaQz76q1Ll6
	a1ejX3mvOtGuvC4YF9ZNVU4Kk4E7mqBxSNuZL4BjgGHcK3PAp3QL9I14uOmrje2Q=
X-Gm-Gg: ASbGncv+Dm7T3eyQFyRLj1RPv4648FusdlPV33sFfZ9fxBZpus31H9X2eBDPZuiwzOn
	wAX0H7fGCN7MRlh/Ks9GhtRaJsvR5uwfAQrqabSLU5817T/wuzOcunGe7rKWz18xer8i4RbqlA1
	kdptRUbNqVE8gd/4jEvVLixjYc7hgV8/NAK/EAdlDKaanoEbuz6BiZ2oDvakFefOK1qoKXuQ8MI
	N6YzU8BEkfY0HzcYFO7eV7vBuROllSQEJwlGONAqH9iBCETDEEqIOIdDR9RA3P6TDIOcToXaeK/
	LOtsejiFaWwVxp2JFBwebC1NQQlUsQcBDDwjWq0NMWV/sYI=
X-Received: by 2002:a05:6a20:a108:b0:1f5:882e:60f with SMTP id adf61e73a8af0-216218c6475mr16209495637.17.1747647787509;
        Mon, 19 May 2025 02:43:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZH8Dj3PuS6Ytm+ZrZel0YOH28lKM6PLPGcCy1a6ugOdm4Fbbt13k3NmX+lfNghb6SE7j+aA==
X-Received: by 2002:a05:6a20:a108:b0:1f5:882e:60f with SMTP id adf61e73a8af0-216218c6475mr16209456637.17.1747647787108;
        Mon, 19 May 2025 02:43:07 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a97398f8sm5809092b3a.78.2025.05.19.02.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 02:43:06 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 19 May 2025 15:12:19 +0530
Subject: [PATCH v3 06/11] PCI: qcom: Add support for PCIe bus bw scaling
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250519-mhi_bw_up-v3-6-3acd4a17bbb5@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747647743; l=3981;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=uRy4dvcpRg7kmvMAbVOO9GqUHN/mlG3BTN+ZElHTVsw=;
 b=mQtO0/n8c0BhB/f25pUQ1GkXVkBqCEu41cAG9IMiYjXuYqkYiaL9uOeXRiXpx2Zd39908iLjI
 3cLG+tItBK+DrmDBUuWU+gDQnMWH1DgjbAt4j3Ygm6yiMWh+y4Y98D9
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: EGLB6ZyqIlXR3L_hZA1Ovd3--gguk0rZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDA5MSBTYWx0ZWRfX8Dj9+YAXek7q
 peiXkIns4qGRofvQ0RPyF9V6iCZ+ShBrdPhSGL2p/qwpDessOzzit42H7v2WCiUaRR/kYKhfZS7
 zNPIcVDx7hITWZdetQ0zhELpo64ntLkFP0rXVI8HNj+uIQSQqGwOR6z0088DWHDyfetHkSt101c
 lVK+i3VLb9ybkeOVlRq8MNmvGGyAXOs6KK4PJi3/O9EugbiSfTjgy71RpUlCOj8L8+33rgQXam6
 E7pYRHE0J47a/aCXjxCkRqysTdcr7/YPZDhxaQi+KXTKJSZO8EMLnCr897KiaBwlwlZVrUGRBlA
 Ek4ArnuIKVyMKH82dDHu5lyvg8PrcET1Uv0FfEnkTwl4eSqShwSM3azTXbnH/T2jdlZUlbN2LT/
 v21qXtEQ8LR8zvQHbJaVbeM4/p4JOVllH9pQGHTNL6UCykyIkMWBZW5UHKN0F+vonYPR6YHd
X-Authority-Analysis: v=2.4 cv=K4giHzWI c=1 sm=1 tr=0 ts=682afd2c cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=h4B-02p0z56_JbXvspoA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: EGLB6ZyqIlXR3L_hZA1Ovd3--gguk0rZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_04,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505190091

QCOM PCIe controllers need to disable ASPM before initiating link
re-train. So as part of pre_bw_scale() disable ASPM and as part of
post_scale_bus_bw() enable ASPM back.

As the driver needs to enable the ASPM states that are enabled
by the system, save PCI ASPM states before disabling them and
in post_scale_bus_bw() use the saved ASPM states to enable
back the ASPM.

Update ICC & OPP votes based on the requested speed so that RPMh votes
get updated based on the speed.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 63 ++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index bd984cde8d3bd688b2ac32566b0e9cdbc70905c0..491324d44785535b84460d468727b8c356ca1040 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -276,10 +276,16 @@ struct qcom_pcie {
 	struct dentry *debugfs;
 	bool suspended;
 	bool use_pm_opp;
+	int aspm_state; /* Store ASPM state used in pre & post scale bus bw */
 };
 
 #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
 
+static void qcom_pcie_host_post_scale_bus_bw(struct pci_host_bridge *bridge,
+					     struct pci_dev *pdev, int current_speed);
+static int qcom_pcie_host_pre_scale_bus_bw(struct pci_host_bridge *bridge,
+					   struct pci_dev *pdev, int current_speed);
+
 static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
 {
 	gpiod_set_value_cansleep(pcie->reset, 1);
@@ -1263,6 +1269,8 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 			goto err_assert_reset;
 	}
 
+	pp->bridge->pre_scale_bus_bw = qcom_pcie_host_pre_scale_bus_bw;
+	pp->bridge->post_scale_bus_bw = qcom_pcie_host_post_scale_bus_bw;
 	return 0;
 
 err_assert_reset:
@@ -1328,6 +1336,61 @@ static int qcom_pcie_set_icc_opp(struct qcom_pcie *pcie, int speed, int width)
 	return ret;
 }
 
+static int qcom_pcie_scale_bw(struct dw_pcie_rp *pp, int speed)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct qcom_pcie *pcie = to_qcom_pcie(pci);
+	u32 offset, status, width;
+
+	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
+
+	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, status);
+
+	return qcom_pcie_set_icc_opp(pcie, speed, width);
+}
+
+static void qcom_pcie_host_post_scale_bus_bw(struct pci_host_bridge *bridge,
+					     struct pci_dev *pdev, int current_speed)
+{
+	struct dw_pcie_rp *pp = bridge->bus->sysdata;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct qcom_pcie *pcie = to_qcom_pcie(pci);
+	struct pci_dev *child;
+
+	/* Get function 0 of downstream device */
+	list_for_each_entry(child, &pdev->subordinate->devices, bus_list)
+		if (PCI_FUNC(child->devfn) == 0)
+			break;
+
+	pci_enable_link_state_locked(child, pcie->aspm_state);
+
+	qcom_pcie_scale_bw(pp, current_speed);
+}
+
+static int qcom_pcie_host_pre_scale_bus_bw(struct pci_host_bridge *bridge,
+					   struct pci_dev *pdev, int target_speed)
+{
+	struct dw_pcie_rp *pp = bridge->bus->sysdata;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct qcom_pcie *pcie = to_qcom_pcie(pci);
+	struct pci_dev *child;
+
+	/* Get function 0 of downstream device */
+	list_for_each_entry(child, &pdev->subordinate->devices, bus_list)
+		if (PCI_FUNC(child->devfn) == 0)
+			break;
+	/*
+	 * QCOM controllers doesn't support link re-train with ASPM enabled.
+	 * Disable ASPM as part of pre_bus_bw() and enable them back as
+	 * part of post_bus_bw().
+	 */
+	pcie->aspm_state = pcie_aspm_enabled(child);
+	pci_disable_link_state_locked(child, PCIE_LINK_STATE_ALL);
+
+	return qcom_pcie_scale_bw(pp, target_speed);
+}
+
 static const struct dw_pcie_host_ops qcom_pcie_dw_ops = {
 	.init		= qcom_pcie_host_init,
 	.deinit		= qcom_pcie_host_deinit,

-- 
2.34.1


