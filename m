Return-Path: <linux-pci+bounces-37887-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 509C5BD2A6C
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 12:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 343E64E53B4
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 10:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C702FE059;
	Mon, 13 Oct 2025 10:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Lnq47aeg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F972302779
	for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 10:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760352841; cv=none; b=XnGynawznY6bF9jLWgke4VCdZUmcKN1Z+7ByExVsRQHjoIYBz0nfySWqYP1EKHHWV1l0gwlf/BASnfGIe2xhdGYHf/Wb461rTDwJlsw1NSUmtsusR2zamKsSYi+aHs+E5uuOw92tRr50GfLznSsn8cM1KrSfFDepqUjB0p1RZtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760352841; c=relaxed/simple;
	bh=DMfL92AdXlzenYd0/1DcFtxFL7fShJdaftub5B4NfLA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aGKJdA5+TxkDpg/o85duM+0a/E5vklIXKr7MKayI+El7m2lxqdfuijZRZoICOBLzPzK0HIj/JMl0YV2R7BzUw9hwifP4Z6Xv1vPAS2fMgJsMjxmL8wUqNB1qXoe50iI/xUVk+UNNXzYNlxDUaQO4s+RMUjNd7Qs9LcrMda/hwWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Lnq47aeg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DAg2jF029645
	for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 10:53:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	u08lX6E4lF1MxSnTgYczMeE3BdQjrxXWCXSB/fw3rAw=; b=Lnq47aegwaYYDEHt
	eySFkWY8N+U6pkF3ky0z3Kv4UaVoCuLIIIfnGKgFctHJk6CW45eRtAnGjrm3bLyS
	n3jW1AVE/W+gvnYAczZsExW+cWrlE9qjFHep/WO1seHJ1FzPK6XRqsyv4TocMF1f
	EtSGcuPimDgSHm4jgJbwUaRFupz+M8tg2zMggxac1uUOo0Eknt19GMh1ZFfc23Y+
	6rH/NOsb3/PqRpNmNyGqS0pSNtpqad/JUlpHRsM1jyMY/UkueSsbAEtgKy3HJ1z2
	OG7U5jAFokEAOxGVR1yzhgJ3qMnqfNTQbYlwlztF4purLMBikbCWAZAnbgQjAbWz
	BfxsZQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfm5c9uq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 10:53:57 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2699ed6d43dso81313245ad.1
        for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 03:53:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760352836; x=1760957636;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u08lX6E4lF1MxSnTgYczMeE3BdQjrxXWCXSB/fw3rAw=;
        b=T9YcXYh7jW+5F0JP2Ie59sKjtnZK16J/Z/z6ECc5oyL8vYO/U6/Rd6vbql0G3esBUV
         RhBs/ODmiNpku34Wvflg9MSoZYBF0DvRs1vLOBZFeS1ESEIZ4UGf76b9xl4p7yf3AjTq
         5/bgZV5Fb38W6MQNlv3EZRxMh6D/CBWQVYO2Sk//EnEY51VIt12JgUUD++y4PSK9cCOr
         3OqLFlaDbE3hoivL4oOfcT0eekFs6abhPakhxG73rWx/QkOgQWd20/ssoSjxuA+TE5B2
         3LJFz3cKXwFe2V0HWlv3Yyn3u18B+9h0be4kcuaBsVptP3bzW1TnPv5e2YpbPRL48a8Z
         Ql/Q==
X-Forwarded-Encrypted: i=1; AJvYcCW4wo85l4zegWKibAsY+AFT7zpGvZTEs9aqFI9d6WLfUXYScEGG+NSIzJHmtM+SNKR37HYCdXtbzYw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkij1+8EL1qk8Urzoy9vjCnl3t9ANCWwO4IRRkdOQKBhAUM22I
	MbzTNX5DQyu9T9GOczvGU9dzGBTrfTphZObmY5ofRLv/qkMDb729stfUeKP06AvQ1/3NczLbYuP
	o5GrUIIWFtvXAeGAshEbfdQvtFR/2VLJI3nLuzimovJYV6V4DSN8OeoaRDmBOcE8=
X-Gm-Gg: ASbGncvYdLhSDGHp0cyhOvem8nYQcQC8qR4Bq1q4UAXT00dr9ItjxBPG3YSUYR2NkY1
	5EcCCkqlqM8k8kKCbhY3EXqlYAb4mggf7m766hicpbN3Lk9FAi5X6OQMVBS0USWu44YeO2A1uIq
	+yX3srz6AOFZ6JGTqSCN15OXxNvMskey4lkIAmphKsw5R7Y6jReinTW8pXeVKmsXrm49/8+hu6X
	xuL7obzauzPNbqig6SQ43fklINHFzrlRLPKVXMhmLNHoCt/YZgiR21XhjDUKpv69poy/Bi3TRSv
	PADIaVRRPbrDfqViWRzm1zkjefOHFBsxRtCluTZcunHQATJg3DeBibEBtTkRz9PPZ8PjkfxQp64
	=
X-Received: by 2002:a17:903:2302:b0:263:ac60:fc41 with SMTP id d9443c01a7336-290274030a0mr268570535ad.48.1760352836320;
        Mon, 13 Oct 2025 03:53:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4gao4pvLHEPOQz//QIqS/9Zz9d9DOggsWC7wOSF/QEy30BK1Aeknp4p0FhJCVT0WVN54eJQ==
X-Received: by 2002:a17:903:2302:b0:263:ac60:fc41 with SMTP id d9443c01a7336-290274030a0mr268570175ad.48.1760352835823;
        Mon, 13 Oct 2025 03:53:55 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b626403desm11662295a91.7.2025.10.13.03.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 03:53:55 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 13 Oct 2025 16:23:28 +0530
Subject: [PATCH v5 1/5] arm64: dts: qcom: sm8450: Add opp-level to indicate
 PCIe data rates
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-opp_pcie-v5-1-eb64db2b4bd3@oss.qualcomm.com>
References: <20251013-opp_pcie-v5-0-eb64db2b4bd3@oss.qualcomm.com>
In-Reply-To: <20251013-opp_pcie-v5-0-eb64db2b4bd3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760352825; l=4058;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=DMfL92AdXlzenYd0/1DcFtxFL7fShJdaftub5B4NfLA=;
 b=31xcT0QdpgR7G2WSAuRQQywywT1N0r3T7iCT13jrZ565TkRMr/wHsbX0Yy5s26RjTQdCMMMbE
 deYLgUXgn3bBSAAHsg/USnh5L4PFJPRiixnZCAR2KC8LOeDhv732Fpw
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: RliAndXiJFio92wKyXZwd1j9WxE37NKf
X-Proofpoint-ORIG-GUID: RliAndXiJFio92wKyXZwd1j9WxE37NKf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMCBTYWx0ZWRfX8/nchHSkxOj8
 TIhEB/lgNG7YLiv+PC4zodExwNJrhd4t6orQbtUWsM29ec4wBAKPcLUcIShgtbXIfEU2dtcpJZH
 +PbOvV+o0Lt9Tml2wEkzruE9MgvKfla0RtpXwwscGVlfAGbbx7Y3+8axaGCuJ6XBIhFN6/F1BJ5
 LnlcQen+Ac8nGitfsdt+UfIAaRAzFbtVACGXSMiVrxxPAWqRGMgTdVUDckmzMNvjuLghCUSAq2c
 qSz5bQyTSaNKnBsq9MPMhknETr4p48K2ABRQGWq/cng8QsMy9Rzb6ULJ/PZxPU2ePCfIYKZJxQ2
 Uf4Tg3GsMzu8bsTA8qpK5Nkwr6KyTlqpmHbZ9jABzohZve6qvZxTqYnk9F2txykMR641mojBMIu
 wed0O9uIx4UweveUR3lOvLIHRQYCpw==
X-Authority-Analysis: v=2.4 cv=V71wEOni c=1 sm=1 tr=0 ts=68ecda45 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=qQkGquXN9PvF_GGjQ98A:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110020

The existing OPP table for PCIe is shared across different link
configurations such as data rates 8GT/s x2 and 16GT/s x1. These
configurations often operate at the same frequency, allowing them
to reuse the same OPP entries. However, 8GT/s and 16 GT/s may have
different RPMh votes which cannot be represented accurately when
sharing a single OPP.

To address this, introduce an `opp-level` to indicate the PCIe data
rate and uniquely differentiate OPP entries even when the frequency
is the same.

Although this platform does not currently suffer from this issue, the
change is introduced to support unification across platforms.

Append the opp level to name of the opp node to indicate both frequency
and level.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 55 ++++++++++++++++++++++++++----------
 1 file changed, 40 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 23420e6924728cb80fc9e44fb4d7e01fbffae21f..2ae56c39f2e6d8a11a2ef0f77bffcf05a6fd637e 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -2047,25 +2047,28 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 			pcie0_opp_table: opp-table {
 				compatible = "operating-points-v2";
 
-				/* GEN 1 x1 */
+				/* 2.5 GT/s x1 */
 				opp-2500000 {
 					opp-hz = /bits/ 64 <2500000>;
 					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <250000 1>;
+					opp-level = <1>;
 				};
 
-				/* GEN 2 x1 */
+				/* 5 GT/s x1 */
 				opp-5000000 {
 					opp-hz = /bits/ 64 <5000000>;
 					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <500000 1>;
+					opp-level = <2>;
 				};
 
-				/* GEN 3 x1 */
+				/* 8 GT/s x1 */
 				opp-8000000 {
 					opp-hz = /bits/ 64 <8000000>;
 					required-opps = <&rpmhpd_opp_nom>;
 					opp-peak-kBps = <984500 1>;
+					opp-level = <3>;
 				};
 			};
 
@@ -2209,46 +2212,68 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 			pcie1_opp_table: opp-table {
 				compatible = "operating-points-v2";
 
-				/* GEN 1 x1 */
-				opp-2500000 {
+				/* 2.5 GT/s x1 */
+				opp-2500000-1 {
 					opp-hz = /bits/ 64 <2500000>;
 					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <250000 1>;
+					opp-level = <1>;
 				};
 
-				/* GEN 1 x2 and GEN 2 x1 */
-				opp-5000000 {
+				/* 2.5 GT/s x2 */
+				opp-5000000-1 {
+					opp-hz = /bits/ 64 <5000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <500000 1>;
+					opp-level = <1>;
+				};
+
+				/* 5 GT/s x1 */
+				opp-5000000-2 {
 					opp-hz = /bits/ 64 <5000000>;
 					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <500000 1>;
+					opp-level = <2>;
 				};
 
-				/* GEN 2 x2 */
-				opp-10000000 {
+				/* 5 GT/s x2 */
+				opp-10000000-2 {
 					opp-hz = /bits/ 64 <10000000>;
 					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <1000000 1>;
+					opp-level = <2>;
 				};
 
-				/* GEN 3 x1 */
-				opp-8000000 {
+				/* 8 GT/s x1 */
+				opp-8000000-3 {
 					opp-hz = /bits/ 64 <8000000>;
 					required-opps = <&rpmhpd_opp_nom>;
 					opp-peak-kBps = <984500 1>;
+					opp-level = <3>;
+				};
+
+				/* 8 GT/s x2 */
+				opp-16000000-3 {
+					opp-hz = /bits/ 64 <16000000>;
+					required-opps = <&rpmhpd_opp_nom>;
+					opp-peak-kBps = <1969000 1>;
+					opp-level = <3>;
 				};
 
-				/* GEN 3 x2 and GEN 4 x1 */
-				opp-16000000 {
+				/* 16 GT/s x1 */
+				opp-16000000-4 {
 					opp-hz = /bits/ 64 <16000000>;
 					required-opps = <&rpmhpd_opp_nom>;
 					opp-peak-kBps = <1969000 1>;
+					opp-level = <4>;
 				};
 
-				/* GEN 4 x2 */
-				opp-32000000 {
+				/* 16 GT/s x2 */
+				opp-32000000-4 {
 					opp-hz = /bits/ 64 <32000000>;
 					required-opps = <&rpmhpd_opp_nom>;
 					opp-peak-kBps = <3938000 1>;
+					opp-level = <4>;
 				};
 			};
 

-- 
2.34.1


