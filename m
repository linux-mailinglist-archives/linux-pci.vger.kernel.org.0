Return-Path: <linux-pci+bounces-29213-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D02AD1BF1
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 12:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 721673A512D
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 10:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC15255E34;
	Mon,  9 Jun 2025 10:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G+hFA0Ck"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9C225B68A
	for <linux-pci@vger.kernel.org>; Mon,  9 Jun 2025 10:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749466348; cv=none; b=pTzIGr8UjuIOQv8t/50KKu+jJ4BPdVfXkFOY8sdBYkbCyWssDC3q6//jbDl73Cw8pjtfyshXO/8drREoO1ilCsCJwZEehXByWxFknkupa46sF9TQIUhLJZzTxV8XJJodxydU1XMtoWriP80YO08ziGEJ8dJOqj9V87x8S1qcZxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749466348; c=relaxed/simple;
	bh=mQP/2kjW43Zd9RccVZlz6IzdDvgPGrMPigpQllInEwU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LdpAPcsl1/UvYgihbRFL86AIUUccsrjVR2OoOYrrB8JgPI/UM9I6LfxOgma2vFqhWhrXzM/bXWx/EfptOsfUTMCZHCOjg7kYl/qqvpxUQ3sklZmpWni5ryrRYirvGpxUg8TBBwEAuymGbvjhs5wVPfxqHXE5pX3ND7Z+W/JDPAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G+hFA0Ck; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5599Wec9002402
	for <linux-pci@vger.kernel.org>; Mon, 9 Jun 2025 10:52:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	o92yNqD2Tgr7h+9utlt9yCYodwnleBQ6N8D29Rin1hw=; b=G+hFA0CkvxUJr/zi
	wSnDhjrRSzOgEA3bsEZp+cI8PQ7UAGoyyTmMjoFSarFBvdoHrr52XFEtW4j5szvz
	lIB8e2g58yJhls5rgb2DBkx5TP16rqjHSJGV8P4mXMi+W0VM409Y3o6lqoMT94Au
	Qa424WPhuK0+xC1a7GFrvVD+uxbDKEte+e+XOr5BexHbCRMXoeiHGZA9vDbosdJE
	GhfMLAW18ZMkj65OnldQXYBoun4jsrck+jZ6yDcS0/dPSChwXgZGK6jzwzPJAglb
	ajAk8mHfDDzNGpQqP2k0rmqrSlitkXpdhateK/4t5J3/FbfH6g/LDszHPpovFJg0
	CT/XYA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474dn65nja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 09 Jun 2025 10:52:25 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b2c37558eccso2643379a12.1
        for <linux-pci@vger.kernel.org>; Mon, 09 Jun 2025 03:52:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749466344; x=1750071144;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o92yNqD2Tgr7h+9utlt9yCYodwnleBQ6N8D29Rin1hw=;
        b=Jk/wjjYDgb+FLILbbpMTUm70J9WHDcnFylMJhnOL8GVRy6unmt7htbnZXAKm+dkLVX
         MXIkl3AtpygjV57A6dFRWYEJkmVdmvXeXSGxe6E/Z/UB4o3bPM0myUIR9VuH0RTiVdyO
         dbPJd7zZoiT5KLXmVtgr3FvNAnbXSDS0tN2EZDz8eHFcZknpMhaxTiaEYArdJlCP/cLu
         u0bIHTYUTFz077ImLO/coAjLVTcB6degEkC2usfay/029WNkP8HU5PEDMMdq9M8PxIQa
         poWnbw9F8DgVgNwswWFNCYS643VSe+bWPumX6liBuQfZvIIbcLM2HTUqYHfDLsG5hUw9
         kLOQ==
X-Gm-Message-State: AOJu0Yx3FGzJfWOTTh74T89cPdv6GduU4GceO6Jcamt3LYqv5kMCli2R
	CWkBYzNU4hEFGO1ehene8VRSMStQUnlhtDG0pRcN6HJr7EUwYdY7fd9W0ZbdJiCtOdGffyj8Qpu
	0rOmjSNVzh214Gb0HeFjCrzM7SQZwiWJN9HvWKjNDpeAZiTQMWTpYmVWfwRCqDFs=
X-Gm-Gg: ASbGncv1/nYtN4Mocv0KlNGDPh7UpuAbWtjVjLEeE3HgMntkzLcpRZNqPZ9jz4uQzE3
	Xgi7yBDlh8BMnk84aZ8e0inhuRsirOVY1Ij86wpp9nPwoo/SF7iIPnjzYOdDaw6L9vjO3lTKl1n
	x20fMu1qh6ELHCq2/yXhOkw/s5xmFJhRy0GHkuzb1rJm9f1prTG+TIUhUziudq17WHXFJ2EvrMZ
	8QcG44zMtzkXbe3Pe4q8w8ZKOoMGrKZg6ckrkdq8Bi6H8kYkqefIE56jFC1moKq/nYT7hJYUy/I
	AkAE0er+fm7UA3zo9/cDSlQ69f+7DCzqv+t2hZa7dP83k4E=
X-Received: by 2002:a17:902:f54c:b0:234:9066:c857 with SMTP id d9443c01a7336-23601e50d77mr159860335ad.21.1749466344254;
        Mon, 09 Jun 2025 03:52:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFqOZ0LBqhpHW4dTHxE+6rU0ZPQzQW2xA5UNp/TIVNcBbhnWqqq67ylrTPdwc7ULZzKPDUew==
X-Received: by 2002:a17:902:f54c:b0:234:9066:c857 with SMTP id d9443c01a7336-23601e50d77mr159860025ad.21.1749466343879;
        Mon, 09 Jun 2025 03:52:23 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603092f44sm51836465ad.63.2025.06.09.03.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 03:52:23 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 09 Jun 2025 16:21:29 +0530
Subject: [PATCH v4 08/11] PCI: qcom: Add support for PCIe
 pre/post_link_speed_change()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250609-mhi_bw_up-v4-8-3faa8fe92b05@qti.qualcomm.com>
References: <20250609-mhi_bw_up-v4-0-3faa8fe92b05@qti.qualcomm.com>
In-Reply-To: <20250609-mhi_bw_up-v4-0-3faa8fe92b05@qti.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Manivannan Sadhasivam <mani@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com,
        quic_vpernami@quicinc.com, quic_mrana@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749466291; l=4037;
 i=krichai@qti.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=mQP/2kjW43Zd9RccVZlz6IzdDvgPGrMPigpQllInEwU=;
 b=NU7mc78Y5DDzuXdX5+Bk8k6qlUSb4HRMRU9Cz98SQ5kXfngX5ckDgsx9jlTQpzKPe1SyhbpP1
 1B/b+g8nppgATx055WOYhDiMM9kQWBER9f7ygNyW0F/wiOdkazNdjrH
X-Developer-Key: i=krichai@qti.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDA4MiBTYWx0ZWRfX8lerLv3Sqe7t
 wOs7GpPYImWuAZyf2HoL/o4LYhRp4ss997Oc9je+1Z8B333PNbKGMQ1c9Zx7mv1AW+McXVW4YsZ
 2oYCUvxp7t+r7Ho2Z4SoumgHWBYrM7nvEliHRCy6pqkN3eM7V+rTxBu6plUmG2PyapAbHGYBIbH
 dWBWhIrHvvglDb8VuEL+Bvcu/dEgcnHQIuTLkTDLHUiDEAhZ88CvNBAdo+UMI4DFMti5AHrLjIe
 iNHqP/robaibib5KrCbembZmU2OM2TPhsnKG9pqL8a9FLiiQBbOqON/4c/G5Exc6bEIR+SBznDS
 mmLPmA6KqyWzCE0t3r7EH/73mc/8OYqsz9hvtI5bBd8dFHPnFcJVWPnt3doTy66mjvKcxbfk7Vu
 6Gju13/l9csXF6Qphx3MSYAoEH1Qo3/4BWdmBM6yuPx6g5t9En1YVchdIQ0BcTsHn+8/YBfl
X-Proofpoint-GUID: 34q_oaM3Bq7pXU1qCmlWEpSMNVKTZnHt
X-Authority-Analysis: v=2.4 cv=FaQ3xI+6 c=1 sm=1 tr=0 ts=6846bce9 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=h4B-02p0z56_JbXvspoA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: 34q_oaM3Bq7pXU1qCmlWEpSMNVKTZnHt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_04,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506090082

QCOM PCIe controllers need to disable ASPM before initiating link
re-train. So as part of pre_link_speed_change() disable ASPM and as
part of post_link_speed_change() enable ASPM back.

As the driver needs to enable the ASPM states that are enabled
by the system, save PCI ASPM states before disabling them and
in post_link_speed_change() use the saved ASPM states to enable
back the ASPM.

Update ICC & OPP votes based on the requested speed so that RPMh votes
get updated based on the speed.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 63 ++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 02643579707f45fc7279023feb7dbc903e69822d..c4aa193bbdcc928603ae50e8d7029b152d62f977 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -276,10 +276,16 @@ struct qcom_pcie {
 	struct dentry *debugfs;
 	bool suspended;
 	bool use_pm_opp;
+	int aspm_state; /* Store ASPM state used in pre & post link speed change */
 };
 
 #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
 
+static void qcom_pcie_post_link_speed_change(struct pci_host_bridge *bridge,
+					     struct pci_dev *pdev, int current_speed);
+static int qcom_pcie_pre_link_speed_change(struct pci_host_bridge *bridge,
+					   struct pci_dev *pdev, int current_speed);
+
 static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
 {
 	gpiod_set_value_cansleep(pcie->reset, 1);
@@ -1263,6 +1269,8 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 			goto err_assert_reset;
 	}
 
+	pp->bridge->pre_link_speed_change = qcom_pcie_pre_link_speed_change;
+	pp->bridge->post_link_speed_change = qcom_pcie_post_link_speed_change;
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
+static void qcom_pcie_post_link_speed_change(struct pci_host_bridge *bridge,
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
+static int qcom_pcie_pre_link_speed_change(struct pci_host_bridge *bridge,
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
+	 * Disable ASPM as part of pre_link_speed_change() and enable them
+	 * back as part of post_link_speed_change().
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


