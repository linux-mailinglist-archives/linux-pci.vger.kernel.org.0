Return-Path: <linux-pci+bounces-21584-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD604A37B8E
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 07:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01EF67A2180
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 06:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74D4195F0D;
	Mon, 17 Feb 2025 06:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jtIxSIql"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CA31953AD
	for <linux-pci@vger.kernel.org>; Mon, 17 Feb 2025 06:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739774101; cv=none; b=ElcfyrbgVeg2qI9lG8/273jZEJ2/GcYnpQAfMS+e3TQvGwBiooJXC4kcBE9un5cwkZmyu9y7zHxcCxbF72XTo75lEdS5Ggih7UK2sDe2dDFOK6Os2YqDTqI0eYj+fP4KUe9Dr+qwyl9dlb2ZWa27Luy/DbEH2vi4TVU3nuwr/r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739774101; c=relaxed/simple;
	bh=MDH1EAT3iFlnei9rPbQ3oLiWKzuPU08kTSTKS0pttwE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A3G5xtYY8VV/HaCRvNPgMxbq+LNbPx2fik2qTQEwzSmvsPV5TfEa4xrM8UpQ5psqrs1C3VZ/9525a0fhMGzQNuekbJM+YZd8xPcuk6Hagvjl9Fmvbh5Q+mliiYx4SnqJsgmQlMS28pHuHsqrs4umgbpoRphj1NkBhbnVVrsmRTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jtIxSIql; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51H03Abl025483
	for <linux-pci@vger.kernel.org>; Mon, 17 Feb 2025 06:34:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vnkNnMCfFUxeM0wOwRWOrbx64pi1NXcdn9eltQQvhxg=; b=jtIxSIql9rVQy5UV
	UqMLQus7m7W/13yb2LGlfhPBRgGxbyimevQB/YbsDdSYEJmETeK0ieL3Hola4gAk
	hpcMVSlFheMTd4sxcI1663zQ3BxqSfzVtEK8ILbo7PY476x101F2HanakgI3DBK4
	OIbFmSYHHj4YSrUtpeuTIQUVvmjAP8j+DEm3kzPIbqN+pBsen2FExy2BSAhl6eKZ
	AqCIDIruWSi8z+9rvTgp09tkM9kqJ95x1cA0KVdaEbDV901TtwWfmxBj7BMfuwZW
	mUAyr3RtBl/Qi6e47T4Ryc5ByfqdGD8rMsIbfUfFcatn/HUu66fj8KEV5zOB4uuT
	P5fLTA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44ut7vrpq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 17 Feb 2025 06:34:57 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2fc45101191so2804520a91.1
        for <linux-pci@vger.kernel.org>; Sun, 16 Feb 2025 22:34:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739774096; x=1740378896;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vnkNnMCfFUxeM0wOwRWOrbx64pi1NXcdn9eltQQvhxg=;
        b=Vi7TFsy1yuYnNCtAsvpD9BNjRjfhZewqLbpIoYb/vKhkoZkigT97h1oJLpiLZ7j1JC
         ToxGsyMPUUuN0K8P5DdYPpUxzU0/TDNfVzJF1/vsYVrawYSllAWCLkPvCmZPpyYtxi9M
         fMSk6MDm+hq3ODveTo3WZ8w0rzn2FSLbc1AzqGnz4wLd7TEuRSfVgwY/duMNvntfo5om
         9DBXGBNq3BvOqnNI5VHL5zPWdBnvro+jU+Jsy6cMfl5EMng0LAtDcaTNn56Fkiq5D6Jk
         SaijdOxjFQ1USit+kQkVdlpQoqSBwgoE85eoidJb0fCct6zoeP7YpU9PHYPDb1abbKOj
         e55Q==
X-Gm-Message-State: AOJu0Yw3kpR2/QQF8/bAV9sSHhqRQZtwJwEkZo7T+ZwbRPDNE2qsA3SM
	p85bqaWbomWvjh04GMm8B1W4KKB1uBorg5FCDe+pSx6MD5RAr8/DEP7BLIhxON+x/l5hjz8d5Qe
	kBPxPgNYoWjSARmqXkxt+GzjZailfH4m5JaiqGWeu4o4EkPY1FjAstIUciiI=
X-Gm-Gg: ASbGncuD2zu9lyZT5qqMEjBoVS9lwTTWHcjFSRdTGWEwBHihvNhzoBV8b5w8lCdCPEs
	ge8y1UgyZVuG8jAJ4Byv/PooQOf8G4kMlOPeNtYfQ6w5Ht4naGp1X+N6NKH4VgPH+hzwW8eLyJB
	g09qmnMrWvm6/RlDvIxDDWfiK40ETWzXqeZ35Rr17LRPG2xjL20KbkBxjZ4vj93g+9yseAwqYER
	FdCytNZVSs3A6fbe4ZZEeF0g+DYO40F1JKactiaMYB8CuMHrLme9Z50IVx9YBIvY1J4N2YTtGL4
	AReimNqKPCLpzPCcJ7Ltc36bMjuIn5LAAoNajHDR
X-Received: by 2002:aa7:8f99:0:b0:732:6231:f2a3 with SMTP id d2e1a72fcca58-7326231f591mr10834882b3a.3.1739774096141;
        Sun, 16 Feb 2025 22:34:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7lYcW5hPdY6ZjNE6LJPu12IuQ+vFgWgZldyLyVtQtpguJsqNYOC4jj1hFpi5FOLfE6r8WdA==
X-Received: by 2002:aa7:8f99:0:b0:732:6231:f2a3 with SMTP id d2e1a72fcca58-7326231f591mr10834848b3a.3.1739774095765;
        Sun, 16 Feb 2025 22:34:55 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73263b79287sm3771800b3a.29.2025.02.16.22.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 22:34:55 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 17 Feb 2025 12:04:14 +0530
Subject: [PATCH 7/8] PCI: Make pcie_link_speed variable public & export
 pci_set_target_speed()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-mhi_bw_up-v1-7-9bad1e42bdb1@oss.qualcomm.com>
References: <20250217-mhi_bw_up-v1-0-9bad1e42bdb1@oss.qualcomm.com>
In-Reply-To: <20250217-mhi_bw_up-v1-0-9bad1e42bdb1@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        quic_jjohnson@quicinc.com, quic_pyarlaga@quicinc.com,
        quic_vbadigan@quicinc.com, quic_vpernami@quicinc.com,
        quic_mrana@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739774050; l=1633;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=MDH1EAT3iFlnei9rPbQ3oLiWKzuPU08kTSTKS0pttwE=;
 b=snYvwe6fz5/0tGaNyLSFO6GDeBFP6NvfzVDDK2eS6qx1l1MqJLBNCE6ieF3cDDsCtYItw70rc
 DiK+FnwplEVCc+mmzxuokhAenPJKdpKx0tYfSSyXHuaTWeeuVDz/U1y
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: UHzT0OFOmOSpZoNOLpKZxqD20jGaq48v
X-Proofpoint-ORIG-GUID: UHzT0OFOmOSpZoNOLpKZxqD20jGaq48v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_03,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=932
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502170056

It can be used by the PCIe client drivers and reduce the code duplication.
And export pci_set_target_speed() so that other kernel drivers can use it.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/pci.h         | 1 -
 drivers/pci/pcie/bwctrl.c | 1 +
 include/linux/pci.h       | 1 +
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 01e51db8d285..ada9a0433a99 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -82,7 +82,6 @@ struct pcie_tlp_log;
 #define PCIE_MSG_CODE_DEASSERT_INTC	0x26
 #define PCIE_MSG_CODE_DEASSERT_INTD	0x27
 
-extern const unsigned char pcie_link_speed[];
 extern bool pci_early_dump;
 
 bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
index e3faa4d1f935..dc01c93bcc37 100644
--- a/drivers/pci/pcie/bwctrl.c
+++ b/drivers/pci/pcie/bwctrl.c
@@ -214,6 +214,7 @@ int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(pcie_set_target_speed);
 
 static void pcie_bwnotif_enable(struct pcie_device *srv)
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 58f1de626c37..8a3b3195122d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -305,6 +305,7 @@ enum pci_bus_speed {
 
 enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev);
 enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev);
+extern const unsigned char pcie_link_speed[];
 
 struct pci_vpd {
 	struct mutex	lock;

-- 
2.34.1


