Return-Path: <linux-pci+bounces-32126-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE17B053F4
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 10:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04CD756319C
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 08:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0912750EF;
	Tue, 15 Jul 2025 08:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bWmZGFIF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EF0274FEF
	for <linux-pci@vger.kernel.org>; Tue, 15 Jul 2025 08:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752566425; cv=none; b=gh2r0FjZQi4UW4QMl3e9PbcnQ6JDJjt5wnGPTiHGEZpijepaWoNmrCRAURrbcEFl/7IQCvPFeppSMx5D+q5D49yBS1tMBcoZ7GcHtdM7Z/z7DkZKOiwe9PeAf5xElMsVDARTEZb+1ma5IbsqAz6u9YnCU8jUWPuSft/bsb6SFuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752566425; c=relaxed/simple;
	bh=GbfOEePw+z5MtTz44J4WfJHcnv9d9dSlNQ7AQG96tVo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HyTo8QLPNa1PKCmyJal2jiFQopQh95tIAftlaFEOFRO0DIsi9z9o7xA/M1xYsIB2lpLQAC9H8PtJCC/0oyCBhSZTTX17a+YFQP6SrBomDCmRQNI9y96zXcPfgcFn1wK1SaUZqlQlItDkOJ8D37sU12WJ4enDL+c17ctrxQ7KUM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bWmZGFIF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F7pwaQ032437
	for <linux-pci@vger.kernel.org>; Tue, 15 Jul 2025 08:00:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	29osqCa8Dk0skNiIogmNa+iuqm6tKwJ5AW+ZWWEuekQ=; b=bWmZGFIFA6nB798K
	UoTaUZCPWOYAAIUoBB1pOdT8mI/IKXyCaq13eStFS/YSvJTfa6a4s9FuSMlxdlqc
	xSh/iFWmIzOLfk0kApSSy7BXPIjzOe2/Un3Si/McSi7l08zDwq6P1+6NvaSwKImo
	aFe1kFMwk4OiFN4EctFIxeXi9pSMMIxyXv/qt98xSeR+xZTuP9TNdhHmG9fQbazw
	tT8C96bPmUdB7HHnfXbFtS48AIwiKjmIPj03yMRwrWQHmXcpsi4iT0bhDBvyMvwK
	hp1xoYtQghsLpKqWsTtDYN8MNcotEuopEztMWKs8lflqBco1J0KQUvGiEeXqquc+
	DBSItw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufut78gj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 15 Jul 2025 08:00:23 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ab878dfc1aso3914671cf.0
        for <linux-pci@vger.kernel.org>; Tue, 15 Jul 2025 01:00:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752566418; x=1753171218;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=29osqCa8Dk0skNiIogmNa+iuqm6tKwJ5AW+ZWWEuekQ=;
        b=fqFYeYKq68fQzPUVAZOK/pPmYGtL8/nFvOQSrrgfOiSflFNlYSOR+kjGuRw4drqdJh
         Gbq/dEBjuid3tDw3yDZXaSJxI5//6gh1wrRQiDrrpBgulG4MQPyZ6uQi+PiwgmwNPF27
         JZF1JxLkqdlLvd4jRZXRmTNscvrR9yjJ9L9kipeMKdaUu8q8J1HU1vPKF9G6OlMWOweC
         XcWB7dTjRvD8wUG+qJ5LJsKE9YnjbC3YdbxXkEhcwHpv/9InGVFq/XvYkcDGveMdFs2d
         0PYSzUjPuDXq1FrPMAAkq1HWgS+RNhP2aEZOVjq/OxKChziyf+h+LI76tNGUYlAxDLLL
         WLHw==
X-Gm-Message-State: AOJu0YwSzAYBByKLSeV/cEzH86cJYPdwWmyzvWmPNC4jnvnX1IuUnt6r
	1Uta1LMvmjou85G4qEa+McCQSBxwGpDQxBXFRgCns2dM/tZpd9XIzKlUcDVOuRgyWUxMu/S1cod
	pFgD8r2a8bjevN3yeT3IXAtwXuQfqiHjKIXjS3oxuN0YCI8B0eldPQllXinTODWY=
X-Gm-Gg: ASbGncv/9m6k4eCBlCJb9dlLrOfae521iLa2xIXh0BXgpQZkm3Gu5sB/9h8LvIQ9XOx
	G2DmVW6uOniQAdKJucxC9WKJ8yipe60imKDB8pjbafOWFJCmOK1PWzOB4WjswKYAcGPTYiQ2YCo
	xEZ+k/B6zntBWWnOjn6jFCf2OyfXHWW9cGok6z9WwzmMuyxSYSNTAgKSL0kURjU7BwOB/I13dhx
	bWle9V6SgoDa5By0VxG64FBn4o7PiDonfEJHLsBA2w/1kbRhbiIF1pMVbMrqhApZmTCe4iVsuHS
	C0SfA5oQU9cWe8+tYY/5e6hLQ76vpMIxEVDkTwETJzB8opl/a6ah4gLOp2jDzlsT/Cq3YQ==
X-Received: by 2002:a05:622a:18a4:b0:4ab:5f47:da5b with SMTP id d75a77b69052e-4ab5f47de9cmr131465871cf.8.1752566417911;
        Tue, 15 Jul 2025 01:00:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzxAuZjlIsaIQYm8rUmtgg6lfPzyFqgOdBUY48IJRWVOd/+6pHo+ureD7f0u+Ea8Kb36AIOg==
X-Received: by 2002:a05:622a:18a4:b0:4ab:5f47:da5b with SMTP id d75a77b69052e-4ab5f47de9cmr131465031cf.8.1752566417355;
        Tue, 15 Jul 2025 01:00:17 -0700 (PDT)
Received: from [192.168.1.17] ([120.60.140.219])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ab3f1c9a2csm37792461cf.67.2025.07.15.01.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 01:00:16 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Date: Tue, 15 Jul 2025 13:29:18 +0530
Subject: [PATCH v5 1/4] PCI/ERR: Add support for resetting the Root Ports
 in a platform specific way
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250715-pci-port-reset-v5-1-26a5d278db40@oss.qualcomm.com>
References: <20250715-pci-port-reset-v5-0-26a5d278db40@oss.qualcomm.com>
In-Reply-To: <20250715-pci-port-reset-v5-0-26a5d278db40@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>, Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Niklas Cassel <cassel@kernel.org>,
        Wilfred Mallawa <wilfred.mallawa@wdc.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        mani@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2880;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=r0nAnKYpMV4ShS/A4tyT1tuVoZHwLxeeuNZjL60OQmQ=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBodgqBv1NxanE9ktG92zwVOS86zmTwrgRknu0BG
 EdgynZglOeJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaHYKgQAKCRBVnxHm/pHO
 9eGbB/9qWuKdG71Bkc05mHOvA3YhLiqRtMkImAXOhrGbspJBs2gazpPTUmbvvZugat5RiXiSKLl
 VnsanmUx9+DFNfHa/SpLum7wxWPkU3VMkcPHjLFBjRAMmGNrmfozcQBaQdfaI3zRwFG8YE1knma
 SoN8FMSVwaUXywfXWqQl8BC1zp1KjE1L/4Qcw1WdgOjylOYbCwYA863NFMBmoD72Spc8MCNVcQT
 H4c0QyA2IHkKCDLAB4Jgow/7A63z10vHSeCM4EwUwpGUU7gMHTJSjSZPLsBrP83G/8sA3qxt3m7
 wGzCBJF/tOljFQFAZpwnRRToBRyLWeULjVeiU54/GsfAvg+T
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Authority-Analysis: v=2.4 cv=e7gGSbp/ c=1 sm=1 tr=0 ts=68760a97 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=HOswsyiB/7FCIMMjk980kA==:17
 a=lJ8DZ0MjVbnDIa4D:21 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=OSb3l-ukYRaLxMRXSjIA:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: c08tbMmLprfdidjuD6EwxCXnNGLrFjZj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA3MiBTYWx0ZWRfX3/0/BEGp+yd6
 1+ZZ9nR0TCNleQUx/pLZaF8MwtYC2LemT92gR5TqfCSqYwx7c9ZspepZfwBs+d4+nm+NOpQSwlD
 ZAfBA2HAwOYz077X5gT+G0kCGyW/VdD8VoJUfqxb/tEcaUWsy1m2CIrcD4Iligz8OE83sj0FScf
 XhkLhjDLjeeslMCfBHDkKZuD4ltkmYTBykUuLCQMW1vf8U76sQs+ns6egrvePG2OVBH5VNBTEcG
 ZNEs06lRVvWgLmPhJsFlK/xpe5DjwjCKPu28vrb18eqzr7YXeU6v/wB5r/FoOfPhaCWlKFzVxMJ
 KVQO/X5juEPilytH+9vetZv0Mov0gWT1qEmBuN1hl2sfjLqVSolG08VCaO8ERmkyKDNeqk/p+vM
 zHI8RFz6zUR+TZ5fETPTPQQZeoeh0IX38RvxkvJ6lyYoe9eLxedVm/CBWuzvVOJ3zhRaHZjk
X-Proofpoint-ORIG-GUID: c08tbMmLprfdidjuD6EwxCXnNGLrFjZj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_03,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 malwarescore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507150072

From: Manivannan Sadhasivam <mani@kernel.org>

Some host bridge devices require resetting the Root Ports in a platform
specific way to recover them from error conditions such as Fatal AER
errors, Link Down etc... So introduce pci_host_bridge::reset_root_port
callback and call it from pcibios_reset_secondary_bus() if available.

The 'reset_root_port' callback is responsible for resetting the given Root
Port referenced by the 'pci_dev' pointer in a platform specific way and
bring it back to the working state if possible. If any error occurs during
the reset operation, relevant errno should be returned.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/pci.c      | 12 ++++++++++++
 drivers/pci/pcie/err.c |  5 -----
 include/linux/pci.h    |  1 +
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e9448d55113bdfd2263d8e2f6b3ec802f56b712e..82c56fbd58ca4aaafac4f1638e7e0225c07958cb 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4964,7 +4964,19 @@ void pci_reset_secondary_bus(struct pci_dev *dev)
 
 void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)
 {
+	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
+	int ret;
+
+	if (host->reset_root_port) {
+		ret = host->reset_root_port(host, dev);
+		if (ret)
+			pci_err(dev, "Failed to reset Root Port: %d\n", ret);
+
+		return;
+	}
+
 	pci_reset_secondary_bus(dev);
+
 }
 
 /**
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index de6381c690f5c21f00021cdc7bde8d93a5c7db52..b834fc0d705938540d3d7d3d8739770c09fe7cf1 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -234,11 +234,6 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	}
 
 	if (status == PCI_ERS_RESULT_NEED_RESET) {
-		/*
-		 * TODO: Should call platform-specific
-		 * functions to reset slot before calling
-		 * drivers' slot_reset callbacks?
-		 */
 		status = PCI_ERS_RESULT_RECOVERED;
 		pci_dbg(bridge, "broadcast slot_reset message\n");
 		pci_walk_bridge(bridge, report_slot_reset, &status);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 05e68f35f39238f8b9ce08df97b384d1c1e89bbe..e7c118a961910a307ec365f17b8fe4f2585267e8 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -599,6 +599,7 @@ struct pci_host_bridge {
 	void (*release_fn)(struct pci_host_bridge *);
 	int (*enable_device)(struct pci_host_bridge *bridge, struct pci_dev *dev);
 	void (*disable_device)(struct pci_host_bridge *bridge, struct pci_dev *dev);
+	int (*reset_root_port)(struct pci_host_bridge *bridge, struct pci_dev *dev);
 	void		*release_data;
 	unsigned int	ignore_reset_delay:1;	/* For entire hierarchy */
 	unsigned int	no_ext_tags:1;		/* No Extended Tags */

-- 
2.45.2


