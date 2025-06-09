Return-Path: <linux-pci+bounces-29211-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 837F5AD1BE9
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 12:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7212A3A3B49
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 10:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE6825A32E;
	Mon,  9 Jun 2025 10:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kaTz+2TT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B1625A330
	for <linux-pci@vger.kernel.org>; Mon,  9 Jun 2025 10:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749466336; cv=none; b=Efc+/DDY51f4ScAkLOwAyUNX9doZ0Qdv6JAnFcFAmOdYwZyIHHDPxJwjhagY8y/vQol6l8OpLHU7NRnhhiOI0XncR4SAzJwaA4owaD4OLlt84oAnjsjgn8FXAwSw2Eq5aXzVkH/jEUzMPLZQjJBFXrt4uzhlyUn2KBHxkg6Jh2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749466336; c=relaxed/simple;
	bh=ZDtM21/VpYgUVrvDvFCvhbVFgnDB7/qixYXvJx5tN8c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=epKacCbs207+o0zW0aAXxnAyQG/PhWPuNGtBPq+fsHfsU2arV5vQuVouCQse2SErwJN7W/EEQOekuImtxeAH1ZioNg9+yfz08F4yF0Zs0OQ22g+lHMV594Ykn1EY/Y3/qFdv58tNjTr+OF1dDjWtt1zc55zR/ceh8DfyTo1L4VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kaTz+2TT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55996Wk6009671
	for <linux-pci@vger.kernel.org>; Mon, 9 Jun 2025 10:52:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zPgT8D4IPTgaAa3s6UuMsQfkwr2chND+bSAhzKGs8QU=; b=kaTz+2TTUluP90gA
	qb9bfQgIP0wW0hGU3JlT/vLppkNQR67FLVqXxBuPRuqfnyQhOZP4NcMsF/PbBTqt
	YZDhuAMryCkvy4o/Sku6P11w4w5E0pTL262yT19N6n7kuiTu5Wrncy42gwyF3bz7
	Lu+hvPUbMASH0L91vY6gHhE8L2KrkS5hEsx3SToZF00AG7jLRdKgrd8rPofuenl4
	26dwj2pJ/o2Oou4sMJY6KdMwG3BGlAotuUSfQaqRa7miYAWEI+w5yKsRq4WNXVOG
	K0B0TvIZG14yB/0P4B8nITsBYRhRXpTugwAP8LlBc6NSDGmr98nT9adP51dFQ4pQ
	QBLbjw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 475g75t1dg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 09 Jun 2025 10:52:13 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-235f77f86f6so27339765ad.2
        for <linux-pci@vger.kernel.org>; Mon, 09 Jun 2025 03:52:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749466332; x=1750071132;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zPgT8D4IPTgaAa3s6UuMsQfkwr2chND+bSAhzKGs8QU=;
        b=uKUC0uh2SWeRp8V1cex+Wf68jLX2sQ+vS4+GUNxljlG4ePIEBV+0j7oV71ZdnQg4+q
         PWc+DkU7JAdwd2/mSi6V3hLO4t+U0G60/Rd7OA7242YfDGIzQM3z1hw5Q2UMWPrpTtJt
         majhnTRp3FRvmymv9TKaNoe25R5GN3sym+pKUZUyVZRKV19/ZWy0N0pWNA4rVVxGoKGz
         9nfFV6eEzkvI81O8nKwp2Qt48VZ2b26yEfacMzfKUywEkI0wkGdpBd/EGpRf4u4dr/XO
         xM276AdKqjA1WeoKy7vOSzAMEpOd+ivlv41L/gJLqyC3112BmpkkzC1MhZK7Uhli/8Ac
         dQEA==
X-Gm-Message-State: AOJu0Ywbvb2pHNb+giKHcNkYHJZV59brFi/hIf/pm2sjHmYDN/eWq18H
	Mc20qNHITQCnipb6DEr68md9tYvhVrBVVd0NHP54qpX58as8+Vz9v4lpulPyb6L1MF0ZErqoCz4
	3GAu/iiQds/Zp4Mzmd632NupQc1B5OfPZQkY/U904IOxYmMFX1Lz3o4Fn1dunQqc=
X-Gm-Gg: ASbGncsSn5Mf8wRPT5wZ/LB9bCgMC9aTcyRLmOnzMT6TVZbGU4wogu2YdB5GyXEkg6k
	A9VkilD+2pfCoPasZtvM/T+PzlQrF5NfVex01AHG/02F1OhnMfNKBYAFos+4l3D1Gw1aku/ZI3Z
	v0TNiBi5Ic5uoeGdzFDp+PgaSoGyQms/C5XwPGS8Vlx6kfWvGRWniQikFz/f91wDEeBgFb25BQS
	EMQSYDzYe3R37anQoQr7zzdGX0AeaD8gthDy5BpgVh6mEohyEiKcU7xInOGND+3eNq+m5hD9A1e
	KUX2XVAea7r9X539UGSjT6yGCBISwpGvzE6bMe9CFd0oeYI=
X-Received: by 2002:a17:902:db0f:b0:234:f182:a734 with SMTP id d9443c01a7336-23601d24a79mr172681285ad.31.1749466332575;
        Mon, 09 Jun 2025 03:52:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGo/wXnrK3iji5yZk8aH4OcOGyMUm+fPqYmD5eHGzL0faoq492bZ37GElru7QLbpXFgJf0IYw==
X-Received: by 2002:a17:902:db0f:b0:234:f182:a734 with SMTP id d9443c01a7336-23601d24a79mr172681045ad.31.1749466332182;
        Mon, 09 Jun 2025 03:52:12 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603092f44sm51836465ad.63.2025.06.09.03.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 03:52:11 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 09 Jun 2025 16:21:27 +0530
Subject: [PATCH v4 06/11] PCI/ASPM: Clear aspm_disable as part of
 __pci_enable_link_state()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250609-mhi_bw_up-v4-6-3faa8fe92b05@qti.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749466291; l=1156;
 i=krichai@qti.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=ZDtM21/VpYgUVrvDvFCvhbVFgnDB7/qixYXvJx5tN8c=;
 b=LirUNXKSmX3ebHFBXXCn4igrV12r9SfiTvWKTR2nB6rgsDGG8kxtC4uNmZtMHaceWbMcscgcs
 fEN00pM7t4NAA6x0mbb4IpyHc7lmWammFasxXqtmtx8STYc7YUguKj6
X-Developer-Key: i=krichai@qti.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: 2pbx0E5Q2FoCQ0mknEsQkBAANVp-vl8y
X-Proofpoint-ORIG-GUID: 2pbx0E5Q2FoCQ0mknEsQkBAANVp-vl8y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDA4MiBTYWx0ZWRfXzUF0yNNcct6i
 0KfMQe6PN3KB5Rgby+YQBXnwPmY8a+yLRhQwi1mirvunh3KvJyP3nBtmOFacNmT7AqIrrnLQ+kH
 mkGZNf6BsyMCeJtM9GllAFtZojtUzeZ1689rgcfXhsbyGEU7BYs42jcHxRPlciiyWw8r2UjNk8S
 x7o75EuwFHukbbQ8EKjwPlACUrs3qdJAeirtY/vC1S+c2ZRRRZIq8UKNwrBr6UuKeTB3HHoMm36
 sQlgre63dC/VAr/3jtzHgG7TVfLpGyG4Q5YE/zdiyI1iTJpIqDS/eRM1IDNNMJxsS/Y5UP3r0o7
 mslFP82DC+rvwL5nsbYOsuLAHlTo/SYjLrvBA7V8Y+LQMsIc3sZnshYL9qR91P0K1TsRvpfPdjA
 T18+zAA0Z5x2y7KhvBbfTHq4XEsxFHu3cu3CzO+YtMG00GzJ6glHdNKej8aQF83qSoyMJ0/U
X-Authority-Analysis: v=2.4 cv=TeqWtQQh c=1 sm=1 tr=0 ts=6846bcdd cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=rcts_Xg4tTJKaDXoMsUA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_04,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 clxscore=1015
 phishscore=0 mlxlogscore=923 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506090082

ASPM states are not being enabled back with pci_enable_link_state() when
they are disabled by pci_disable_link_state(). This is because of the
aspm_disable flag is not getting cleared in pci_enable_link_state(), this
flag is being properly cleared when ASPM is controlled by sysfs.

Clear the aspm_disable flag with the requested ASPM states requested by
pci_enable_link_state().

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/pcie/aspm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 94324fc0d3e650cd3ca2c0bb8c1895ca7e647b9d..0f858ef86111b43328bc7db01e6493ce67178458 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1453,6 +1453,7 @@ static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked)
 		down_read(&pci_bus_sem);
 	mutex_lock(&aspm_lock);
 	link->aspm_default = pci_calc_aspm_enable_mask(state);
+	link->aspm_disable &= ~state;
 	pcie_config_aspm_link(link, policy_to_aspm_state(link));
 
 	link->clkpm_default = (state & PCIE_LINK_STATE_CLKPM) ? 1 : 0;

-- 
2.34.1


