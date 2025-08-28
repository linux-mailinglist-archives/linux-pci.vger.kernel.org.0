Return-Path: <linux-pci+bounces-35000-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BE5B39C98
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 14:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11F125625DE
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 12:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F91F314A90;
	Thu, 28 Aug 2025 12:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YFL6eLAn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0EB3148D4
	for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 12:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756383049; cv=none; b=N3T41h6/oJjDNwBv9gdcgtQHxrI5GBAIXkC0wIjUPhGbnqiUwczwaTH1XSJ5r6gcp7hqwKiThcWI4Q+rNYjB5xBMR3q9gfvRkc8oVI+O3acs3ClZHIQOKBPgBBGlkFruUqKMzoZerJ4oSbKbghuKullxNZ/KHlC2dN1oYmq6Z5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756383049; c=relaxed/simple;
	bh=JLQioafU2Ha99tn/qTONrjpmtaS25D1YyPb7oDSQVMk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Uy269ud6LsjJs/4oq8kLkdhRj6Cv5wlLZcMjUPgGlMF9aoDGLhiw1tpzpr5pWNSgNphett2ZdIxBqgMK8hzcao7KY7/0s2JQ+rZhsDzxnajZFtp5i5ThuiJMpBqVN9hTPMyyHAvs6xvDWX95Q2RKjA06SO2z5L78fePvlK43W7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YFL6eLAn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S5QodL016089
	for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 12:10:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JH0s9yKloivepHo0VkuQk79EV0GNYwLeAdz+CShJbJE=; b=YFL6eLAnQBNb+9ji
	gr8NtTF3af7ZhnHWqNHsuqr6nH0oARxi4/mF0MLythSKjNyUY0JY3FUlU0iiRZ5Y
	UHo8IbeddO+J0HbiQ2wxQXbWXFvX11dYQ4n2cSGXZ8b37k1M68mrGoL7KHKr7O0o
	LMMWhUHzh9wINrtNTnbw/7xDK7ENia3z+DWC9oxCKY4BJodnYKsvqdpDjDMX6Zqb
	E5u+0qtkfggWm+j+/NBQ9m3Rrci0MFVu6Vg4C4Rrp3/92SxWahU9xTF7XiGx18xm
	TUihd40F15zf7/aX7a9UOR9BW33l0k5qEdannLyTfTQy1qCrdYqFNLPLsUJp1eIz
	Hg0tiA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48rtpf2dt9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 12:10:45 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3235e45b815so1088597a91.0
        for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 05:10:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756383044; x=1756987844;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JH0s9yKloivepHo0VkuQk79EV0GNYwLeAdz+CShJbJE=;
        b=bTfa8Euc4Wua68y0rEGj+oYkhWgE+jKBTK2/gWV+Zw+Vtx+LkcnyPGr7Jrex6k0/6U
         Huye7ZMcAxjhOvhCRQRskhjTOqVoBUECs2n7xs8mPK6osXIZ1MAKLoIwxp5FUBZmA3O0
         4hNGiKXeIGNkcpyrwd9TIUzanQh13FM/VYec2jE9ZLEL+lKLifwNX3tGNCiWtrVSoN19
         U34Dvk3E8lg+JNdOHDuA9Tf5uE5EtfIVKrI8t5z8pn3tRY1+lQZgoGzPfk5QJNld8LFM
         TgqAYHDEjIkH8Fe2jpeLr8DRmdTbp7BlYEknu16CHdpZy1sF28ofdTu5IX3MQqXXfNIY
         rHiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYn3UeWr4eBT70igDK8ZrEDiqzrXrRS8inDZG6PTYG9qume78f1a1UoDC45xKfWOif16Nf6fWbt60=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR1rlKF4aKeMN36ThpQ9EKVGMP4DTQT+zyJNoE0mUJkHnoa7Cv
	c05DEisQizVehfnG0JH3/6SyCmDLZkeVQWlRMCvKIiFVh/E3mh18K+PvDzARV7bzrO5n4UZilcn
	SpMYQ7GmRX87yIXvpHApOJPNV2RNDu6fP1FYiD1nQAW4kT97SsNNJVRBg8BdLfqQ=
X-Gm-Gg: ASbGncsu8/Abcyh71nGtMp3TpQa6RyhC3mBTaRKfohv42TVV/L0VOgmVsCSu1i8qOke
	/ojtpeQoC0ifzwnxvFStMUEc2Bj39+aXzRjhO+EQwaUW8uQ3DYHKsBMGtpZK0melqqHLlX0LZ1p
	vUa1+RCAtLArQzQbLcl4k+oun6W9ifRHJjB4XLNAPSWS8SZLAMk8zKkn8Ohjk91T8on3N756x5z
	6ILYTUBEKcsHMVcdqLRzdcrMuM8VhoyWfE4TY/b7z3cJgGUbp/rMs3FIkcGO5k70TeqKUVBuexL
	v1QtBgtMfcoVweFDAPr/fs+YzvOBmaTmInASwzHZvpBXafZ6Fx0QZu+EbZmipFiuQIuXbEmNdz4
	=
X-Received: by 2002:a17:90b:3f87:b0:325:55cd:9fd2 with SMTP id 98e67ed59e1d1-32555cda0a5mr25083441a91.20.1756383044288;
        Thu, 28 Aug 2025 05:10:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHh+FZuvrtHdatmZz9NFDOZX4EQHu2edGUNAKaj+LzwOmKyiYcPAJDdxI13V2Rm1b4wPERPWw==
X-Received: by 2002:a17:90b:3f87:b0:325:55cd:9fd2 with SMTP id 98e67ed59e1d1-32555cda0a5mr25083377a91.20.1756383043588;
        Thu, 28 Aug 2025 05:10:43 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32741503367sm4019070a91.0.2025.08.28.05.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 05:10:43 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 28 Aug 2025 17:39:03 +0530
Subject: [PATCH v6 6/9] PCI: qcom: Add support for host_stop_link() &
 host_start_link()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-qps615_v4_1-v6-6-985f90a7dd03@oss.qualcomm.com>
References: <20250828-qps615_v4_1-v6-0-985f90a7dd03@oss.qualcomm.com>
In-Reply-To: <20250828-qps615_v4_1-v6-0-985f90a7dd03@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        chaitanya chundru <quic_krichai@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: quic_vbadigan@quicnic.com, amitk@kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, jorge.ramirez@oss.qualcomm.com,
        linux-arm-kernel@lists.infradead.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756382994; l=2834;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=JLQioafU2Ha99tn/qTONrjpmtaS25D1YyPb7oDSQVMk=;
 b=3DLBa9Wbs2xtxAeBnSSZORHDlNgEkMWEmLEKsGR45JfGAYrdxo+fhjGG2bBtb8588SB4Y5YZO
 4i8Je/MeHLkDoxHV9YbpJJiY9H4K1KT7rOrj+Eb0UGwJkdPegzEFR43
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: Cm9exteE2FKeLla-GZ238miGv6rk6RJL
X-Proofpoint-ORIG-GUID: Cm9exteE2FKeLla-GZ238miGv6rk6RJL
X-Authority-Analysis: v=2.4 cv=Hd8UTjE8 c=1 sm=1 tr=0 ts=68b04745 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=dstPO7x8LWyc_yWpthkA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI1MDE0MiBTYWx0ZWRfX03mlfhC56DhZ
 tQqXpqbwGCBlL0fPy2LN97HysFa0MCLrQMYp1bWAtBNxuPG0F9RbjREEjLIGGelgYcSs4TMY01X
 9esrlB0ZGI/nk5mseUbU/6RypQrU07ndEqBKY9Uhr/OdfL5PttDZBDyCoQ6d46VG5yjMIguDeu4
 SyqvJozjvRnuqUnpolBYUliXZtnvRKp+AdTBVhVQLEoh6qZ/KXFv0baGZ1Ec/mrc86SMmDsOx6J
 K8l8i+Xf4Gh07wm6f4ffBBmXR7gdfOZf4mBSaJP+IvuAXdzODSf2bttfr5H+htRoN04Yw8XQ7up
 AIggj8Hz9TkEpxmn58twlqaiMgi3SN8OhRL0ZsSQLOmirZv91qmJQx0v/zRQ/RMtI/z9amEX4o8
 dHehCh2P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508250142

Add support for host_stop_link() and host_start_link() for switches like
TC956x, which require configuration before the PCIe link is established.

Assert PERST# and disable LTSSM bit to prevent the PCIe controller from
participating in link training during host_stop_link(). De-assert PERST#
and enable LTSSM bit during host_start_link().

Introduce ltssm_disable function op to stop link training.
For the switches like TC956x, which needs to configure it before
the PCIe link is established.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 35 ++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 294babe1816e4d0c2b2343fe22d89af72afcd6cd..8ec76fbc0787ae305e9c63eb82fbc999d197a123 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -250,6 +250,7 @@ struct qcom_pcie_ops {
 	void (*host_post_init)(struct qcom_pcie *pcie);
 	void (*deinit)(struct qcom_pcie *pcie);
 	void (*ltssm_enable)(struct qcom_pcie *pcie);
+	void (*ltssm_disable)(struct qcom_pcie *pcie);
 	int (*config_sid)(struct qcom_pcie *pcie);
 };
 
@@ -642,6 +643,37 @@ static int qcom_pcie_post_init_1_0_0(struct qcom_pcie *pcie)
 	return 0;
 }
 
+static int qcom_pcie_host_start_link(struct dw_pcie *pci)
+{
+	struct qcom_pcie *pcie = to_qcom_pcie(pci);
+
+	qcom_ep_reset_deassert(pcie);
+
+	if (pcie->cfg->ops->ltssm_enable)
+		pcie->cfg->ops->ltssm_enable(pcie);
+
+	return 0;
+}
+
+static void qcom_pcie_host_stop_link(struct dw_pcie *pci)
+{
+	struct qcom_pcie *pcie = to_qcom_pcie(pci);
+
+	qcom_ep_reset_assert(pcie);
+
+	if (pcie->cfg->ops->ltssm_disable)
+		pcie->cfg->ops->ltssm_disable(pcie);
+}
+
+static void qcom_pcie_2_3_2_ltssm_disable(struct qcom_pcie *pcie)
+{
+	u32 val;
+
+	val = readl(pcie->parf + PARF_LTSSM);
+	val &= ~LTSSM_EN;
+	writel(val, pcie->parf + PARF_LTSSM);
+}
+
 static void qcom_pcie_2_3_2_ltssm_enable(struct qcom_pcie *pcie)
 {
 	u32 val;
@@ -1435,6 +1467,7 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
 	.host_post_init = qcom_pcie_host_post_init_2_7_0,
 	.deinit = qcom_pcie_deinit_2_7_0,
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
+	.ltssm_disable = qcom_pcie_2_3_2_ltssm_disable,
 	.config_sid = qcom_pcie_config_sid_1_9_0,
 };
 
@@ -1506,6 +1539,8 @@ static const struct qcom_pcie_cfg cfg_fw_managed = {
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.link_up = qcom_pcie_link_up,
 	.start_link = qcom_pcie_start_link,
+	.host_start_link = qcom_pcie_host_start_link,
+	.host_stop_link = qcom_pcie_host_stop_link,
 };
 
 static int qcom_pcie_icc_init(struct qcom_pcie *pcie)

-- 
2.34.1


