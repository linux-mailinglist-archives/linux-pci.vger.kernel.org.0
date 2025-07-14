Return-Path: <linux-pci+bounces-32078-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4A6B04708
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 20:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B57551A67FE7
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 18:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1485126B094;
	Mon, 14 Jul 2025 18:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zsbnlh1a"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5FA266B5D
	for <linux-pci@vger.kernel.org>; Mon, 14 Jul 2025 18:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752516091; cv=none; b=PJW0avFhdYIv2NCsRCvQft8aJ2xqZfFtCitbF/q4FQo5+Y7W3eYjzy1VFADoZegMnmtIPhULy9JwO1aSR+JE6JoBCwnpK1cNCVd/R0oJJGDEOkyvEhavEgl8fBn5OF0R/6uoKR84N5yRYhG2cl5wpabhudI2MFO4WBg5/M4XG/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752516091; c=relaxed/simple;
	bh=BaEHz4SigSFy/JoDQ5gfDzTeiTADTlZoV5mYSrK/rF8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gawFL0oHdspdbRZMsTo8PCuYVmYu92sKp+Ck7CekLTBx5SiUGnH6k4vXzoaN0Z2r7eojjiV0XO9jxPNX5//J/aXCshEZ+l39RI9RHrtzWdZnCApOpLURDDeEfazcrpC70l4YbrVK6vqhyOY+oQNBAYtYbskiGXZEOoi7LxHgv0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Zsbnlh1a; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9bBPd024672
	for <linux-pci@vger.kernel.org>; Mon, 14 Jul 2025 18:01:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VnJknR/ZXoUt72vcKJEpjugod2iPT7zi6lFjv3b+a9A=; b=Zsbnlh1apv5zGFP6
	pIyJ/EHbRlFd1sEIlIbc3PQD8SlUm5sqJ5WjZ9+T7BPcBd7c3v7x1BRtlLWar0IG
	nVDn8DeBcaST6amYTGTJMg2BiPG7Ubxtp1vYvyOdK5edFyYcegombbRPOyA9KEFU
	8ihfbgg+/7UfSJ8OPCGUHYEAA+nFUO0K1/kvxOMW7e9X/lvMc6wG+kBEjBZl/AOf
	FumBFH6BBOhnRvikPPVuls1H+UyEMT7EUgxtqeKsPhS2tzmOey8GHg5J9P1usW5C
	cFkjWJqxCq573vNqRCVH8qSmCCC6W3TMCmO9XOD03JYoy5tLe7Pko57RnSKAyMiK
	L6SgnQ==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ug37wkxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 14 Jul 2025 18:01:27 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-53141ba9e13so1772297e0c.0
        for <linux-pci@vger.kernel.org>; Mon, 14 Jul 2025 11:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752516087; x=1753120887;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VnJknR/ZXoUt72vcKJEpjugod2iPT7zi6lFjv3b+a9A=;
        b=RFXl+O0cCmfjJYo0yd8tCb5txhZtJOuAiFhV99E15BxZOl/wmiY6w4FNPa5T11bvKQ
         iQA5QB3teEfyNKK0gwwy+YMGEbv7IdSX+E6lnEQacDdae1DWzE9uK1GQ7l7ityw61VVd
         CCyqsYCckMp5BV89Q+JbIp0dibUFRSelFi/rZ0uaEwyrsdJyHtEDYRVEWi5zezl/D2GG
         RurSyi46ay+8VfkAdRUvU4LOg1ws6vOTEO5h8MlHPd+rC+mxQaJmL+cka1tiOFgZ2APA
         RiYeh1XciXedeeQqzhbUufO/Xb8wpF/3gUtsFDPckfvoFkQy9PWbSbcbXqq+idCUzJ00
         JwkA==
X-Forwarded-Encrypted: i=1; AJvYcCXwk9fF8MPUxYDrGYJb0Ua7oce3edZb1U7i8e5/ipIJfEtnMQHbSXnPRtBs6NzjCwV0qjY5Ja0YWos=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQmZreAigSAYhjBU3QZzrP4xM/vwlmG2noVl7AtiY1Y8KkW+12
	vpAf7UhIPoTIlHNS0Rue7dGxjpzv/DLZwODxGukrl974B6mzhZ30jBD+39XbWEFjR4BaqBm3jbK
	9NXenPHwc6RVUmYn7/CYfu/aSNyEuXW7/m2S1snv2UsGRy8OoJi0TUIAJ+c/cy3U=
X-Gm-Gg: ASbGncvR2LS789PDFoGu0P/wsRsGdt/6aJiPSsaXAXRRZm3qyUQrPIwCn8bGFoRZxGb
	v9XTnzbaVC3x1oq+1hhfSGFABwMNPrOpdz/9kXx/v7KbW2xfBmdl/eX2pk0waIrZn3Aj6RiSqEd
	649F9wroBJ+1kf89ZKL4qQLdNDP6V5Ii14rNgM0TAEWSRlbwUv+ZMK/bGsbOqQJjQZWtif9IuPV
	3x6XWhVvaCUOfbDxnAY1S4HkN20xYyAQA3ZzwqktxwwwxdHLLUnaJxmimMO0kkQczgHy+E2jWTd
	Ljo9kD36RzDAn1Adck/Lv1seHDQNCBRNB1CzgiDJvLLZNftffU2vX3/2D4H9vFaWHUM=
X-Received: by 2002:a05:6102:6894:b0:4f4:b401:d04b with SMTP id ada2fe7eead31-4f641faa1famr8556305137.20.1752516085468;
        Mon, 14 Jul 2025 11:01:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGm3GxR4EIJ1G8vKkhpp/SX2/bRO0DPWUlOfQp25eVLkuBk5rTYHi1ujsDxx5I/1TnPOK3d1A==
X-Received: by 2002:a05:6102:6894:b0:4f4:b401:d04b with SMTP id ada2fe7eead31-4f641faa1famr8556143137.20.1752516084774;
        Mon, 14 Jul 2025 11:01:24 -0700 (PDT)
Received: from [192.168.1.17] ([120.60.67.95])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ab659238a1sm16999381cf.17.2025.07.14.11.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 11:01:24 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Date: Mon, 14 Jul 2025 23:31:04 +0530
Subject: [PATCH 1/2] PCI: qcom: Switch to bus notifier for enabling ASPM of
 PCI devices
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-aspm_fix-v1-1-7d04b8c140c8@oss.qualcomm.com>
References: <20250714-aspm_fix-v1-0-7d04b8c140c8@oss.qualcomm.com>
In-Reply-To: <20250714-aspm_fix-v1-0-7d04b8c140c8@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7344;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=BaEHz4SigSFy/JoDQ5gfDzTeiTADTlZoV5mYSrK/rF8=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBodUXqSRvQeHmSfAgzDk3GrZnFSZKJV7pw/ZX8H
 1b5ye4Hzd2JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaHVF6gAKCRBVnxHm/pHO
 9aBUCACKYRPy0ZNObukNDNYcr+IVy/luKZzZTTqjbX60514TOp9OCuxKobn2N30SDN6G/G6NC0f
 bygTUasMqpDfXr3hBy7m1KfskrW2WwESuKX6RrpjciTQeyK1IQ6JeeKYhPRMUmSMb44wKpFonKy
 MOnxk54SqsTYQiWE6h/cV1TURdaPEzKvadcW2C+OGXX14Sq1P1YJP9w7/bKqU1HrEIgtiWHsBRp
 uyNtlOyHcATcCLN7YPwzp8sl0zACiStvq27ZoPyqsQRmxlZQPqIQWXJuDgTGuyN1YG9QqVn7pQr
 hBZfKmae16lDxNgJnPwbGTpwG/ULZNINet1FGEvomOkBnCoA
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDExNCBTYWx0ZWRfX03Q3wWtboR70
 TbUi4b676k2mna3nMoEr1w5LkhofxhiJxkdBv+BsSqB1hcsP9W/AdH7uZGyoZ15zk2vW1ExZxwi
 Lb1ZLq8ZB+gByPs5PNAgvaZupHqS1cLYSCjCqOfHh6Sowo8yQkXd5cYxVhOheKURdLSVpgUC6ND
 /xmcU08YXNMuT2DgdZGj38StHd22+TsuzkW2ox9XHV9B2SJuHn2fEzfW1TAcBjpecxkyuLwH5o5
 qlBD8uFRJ49k40Dd81Yu31FGA6ZDtvpq356L20F1KT5VXmaHdM9s6VTJ99FB5AgIpwWygCep0WA
 bop4YqrVv+auO8ZoRCci+dXkcIoNP65DD8kL8XQrcESHMAuKlNOndedrzVnYXfj1gXjohyZQrzN
 V7nZf7+SUAgvvJgBAKNoCDaapDlUrmAdk9rjaEv8RQeHYkWZlwAa+5fUvvojaarfeNa9P4wy
X-Proofpoint-GUID: W9k54groDNlHF10m-SiE9dtinxkLrILO
X-Authority-Analysis: v=2.4 cv=SZT3duRu c=1 sm=1 tr=0 ts=687545f7 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=fXYZ39HhpiwvwaHYBd8ing==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=96MU14pyfgFxr5UOt3AA:9 a=QEXdDO2ut3YA:10 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-ORIG-GUID: W9k54groDNlHF10m-SiE9dtinxkLrILO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_02,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 mlxlogscore=999 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507140114

Commit 9f4f3dfad8cf ("PCI: qcom: Enable ASPM for platforms supporting 1.9.0
ops") allowed the Qcom controller driver to enable ASPM for all PCI devices
enumerated at the time of the controller driver probe. It proved to be
useful for devices already powered on by the bootloader as it allowed
devices to enter ASPM without user intervention.

However, it could not enable ASPM for the hotplug capable devices i.e.,
devices enumerated *after* the controller driver probe. This limitation
mostly went unnoticed as the Qcom PCI controllers are not hotplug capable
and also the bootloader has been enabling the PCI devices before Linux
Kernel boots (mostly on the Qcom compute platforms which users use on a
daily basis).

But with the advent of the commit b458ff7e8176 ("PCI/pwrctl: Ensure that
pwrctl drivers are probed before PCI client drivers"), the pwrctrl driver
started to block the PCI device enumeration until it had been probed.
Though, the intention of the commit was to avoid race between the pwrctrl
driver and PCI client driver, it also meant that the pwrctrl controlled PCI
devices may get probed after the controller driver and will no longer have
ASPM enabled. So users started noticing high runtime power consumption with
WLAN chipsets on Qcom compute platforms like Thinkpad X13s, and Thinkpad
T14s, etc...

Obviously, it is the pwrctrl change that caused regression, but it
ultimately uncovered a flaw in the ASPM enablement logic of the controller
driver. So to address the actual issue, switch to the bus notifier for
enabling ASPM of the PCI devices. The notifier will notify the controller
driver when a PCI device is attached to the bus, thereby allowing it to
enable ASPM more reliably. It should be noted that the
'pci_dev::link_state', which is required for enabling ASPM by the
pci_enable_link_state_locked() API, is only set by the time of
BUS_NOTIFY_BIND_DRIVER stage of the notification. So we cannot enable ASPM
during BUS_NOTIFY_ADD_DEVICE stage.

So with this, we can also get rid of the controller driver specific
'qcom_pcie_ops::host_post_init' callback.

Cc: stable@vger.kernel.org # v6.7
Fixes: 9f4f3dfad8cf ("PCI: qcom: Enable ASPM for platforms supporting 1.9.0 ops")
Reported-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 70 ++++++++++++++++++----------------
 1 file changed, 37 insertions(+), 33 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 620ac7cf09472b84c37e83ee3ce40e94a1d9d878..b4993642ed90915299e825e47d282b8175a78346 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -20,6 +20,7 @@
 #include <linux/kernel.h>
 #include <linux/limits.h>
 #include <linux/init.h>
+#include <linux/notifier.h>
 #include <linux/of.h>
 #include <linux/of_pci.h>
 #include <linux/pci.h>
@@ -247,7 +248,6 @@ struct qcom_pcie_ops {
 	int (*get_resources)(struct qcom_pcie *pcie);
 	int (*init)(struct qcom_pcie *pcie);
 	int (*post_init)(struct qcom_pcie *pcie);
-	void (*host_post_init)(struct qcom_pcie *pcie);
 	void (*deinit)(struct qcom_pcie *pcie);
 	void (*ltssm_enable)(struct qcom_pcie *pcie);
 	int (*config_sid)(struct qcom_pcie *pcie);
@@ -286,6 +286,7 @@ struct qcom_pcie {
 	const struct qcom_pcie_cfg *cfg;
 	struct dentry *debugfs;
 	struct list_head ports;
+	struct notifier_block nb;
 	bool suspended;
 	bool use_pm_opp;
 };
@@ -1040,25 +1041,6 @@ static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
 	return 0;
 }
 
-static int qcom_pcie_enable_aspm(struct pci_dev *pdev, void *userdata)
-{
-	/*
-	 * Downstream devices need to be in D0 state before enabling PCI PM
-	 * substates.
-	 */
-	pci_set_power_state_locked(pdev, PCI_D0);
-	pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
-
-	return 0;
-}
-
-static void qcom_pcie_host_post_init_2_7_0(struct qcom_pcie *pcie)
-{
-	struct dw_pcie_rp *pp = &pcie->pci->pp;
-
-	pci_walk_bus(pp->bridge->bus, qcom_pcie_enable_aspm, NULL);
-}
-
 static void qcom_pcie_deinit_2_7_0(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
@@ -1358,19 +1340,9 @@ static void qcom_pcie_host_deinit(struct dw_pcie_rp *pp)
 	pcie->cfg->ops->deinit(pcie);
 }
 
-static void qcom_pcie_host_post_init(struct dw_pcie_rp *pp)
-{
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct qcom_pcie *pcie = to_qcom_pcie(pci);
-
-	if (pcie->cfg->ops->host_post_init)
-		pcie->cfg->ops->host_post_init(pcie);
-}
-
 static const struct dw_pcie_host_ops qcom_pcie_dw_ops = {
 	.init		= qcom_pcie_host_init,
 	.deinit		= qcom_pcie_host_deinit,
-	.post_init	= qcom_pcie_host_post_init,
 };
 
 /* Qcom IP rev.: 2.1.0	Synopsys IP rev.: 4.01a */
@@ -1432,7 +1404,6 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
 	.get_resources = qcom_pcie_get_resources_2_7_0,
 	.init = qcom_pcie_init_2_7_0,
 	.post_init = qcom_pcie_post_init_2_7_0,
-	.host_post_init = qcom_pcie_host_post_init_2_7_0,
 	.deinit = qcom_pcie_deinit_2_7_0,
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
 	.config_sid = qcom_pcie_config_sid_1_9_0,
@@ -1443,7 +1414,6 @@ static const struct qcom_pcie_ops ops_1_21_0 = {
 	.get_resources = qcom_pcie_get_resources_2_7_0,
 	.init = qcom_pcie_init_2_7_0,
 	.post_init = qcom_pcie_post_init_2_7_0,
-	.host_post_init = qcom_pcie_host_post_init_2_7_0,
 	.deinit = qcom_pcie_deinit_2_7_0,
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
 };
@@ -1773,6 +1743,33 @@ static int qcom_pcie_parse_legacy_binding(struct qcom_pcie *pcie)
 	return 0;
 }
 
+static int qcom_pcie_enable_aspm(struct pci_dev *pdev)
+{
+	/*
+	 * Downstream devices need to be in D0 state before enabling PCI PM
+	 * substates.
+	 */
+	pci_set_power_state_locked(pdev, PCI_D0);
+	pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
+
+	return 0;
+}
+
+static int pcie_qcom_notify(struct notifier_block *nb, unsigned long action,
+			      void *data)
+{
+	struct qcom_pcie *pcie = container_of(nb, struct qcom_pcie, nb);
+	struct device *dev = data;
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	switch (action) {
+	case BUS_NOTIFY_BIND_DRIVER:
+		qcom_pcie_enable_aspm(pdev);
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
 static int qcom_pcie_probe(struct platform_device *pdev)
 {
 	const struct qcom_pcie_cfg *pcie_cfg;
@@ -1946,10 +1943,15 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	if (irq > 0)
 		pp->use_linkup_irq = true;
 
+	pcie->nb.notifier_call = pcie_qcom_notify;
+	ret = bus_register_notifier(&pci_bus_type, &pcie->nb);
+	if (ret)
+		goto err_phy_exit;
+
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
 		dev_err(dev, "cannot initialize host\n");
-		goto err_phy_exit;
+		goto err_unregister_notifier;
 	}
 
 	name = devm_kasprintf(dev, GFP_KERNEL, "qcom_pcie_global_irq%d",
@@ -1982,6 +1984,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 
 err_host_deinit:
 	dw_pcie_host_deinit(pp);
+err_unregister_notifier:
+	bus_unregister_notifier(&pci_bus_type, &pcie->nb);
 err_phy_exit:
 	qcom_pcie_phy_exit(pcie);
 	list_for_each_entry_safe(port, tmp, &pcie->ports, list)

-- 
2.45.2


