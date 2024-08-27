Return-Path: <linux-pci+bounces-12254-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1FB9601F6
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 08:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FD6CB2362F
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 06:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7BA189522;
	Tue, 27 Aug 2024 06:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="T+IOEAWm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BF51714BC;
	Tue, 27 Aug 2024 06:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724740627; cv=none; b=geAfRgrKvJIPz08VVjWrEVsrlJPgiLu6YXhrI1vp4fIpPRVMBgboefFCaGDZVTie2QWp02aW7FQQonES2WTrfrGF/LaX1u6O2uHlc1PThZKOw+txxmzEi32iKRKnMuaIiJSd4KqXZuNRYURNQRHFqwtCuG4yqWJND6Pw6Clsklg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724740627; c=relaxed/simple;
	bh=/oEQPR9kvm+dlSMkd3p37c08GEErH6wjZAGlspApVHs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KuG0nhyfa59FmBbJPBAac2hN2KXWKrlglxVVuP+X6vpw7o777wolsJb17EgpPHP20+a9EagQRHkpND/j8NzpcjQ0dm9t+VYJ45vY3Ixu4N0cjT/hWb1gM73+fPeV390AA6P1Y+2pPJS5eVd6qpIy1ZNraYeCZK7bgaDqR8XsiZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=T+IOEAWm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47QJGpl4001758;
	Tue, 27 Aug 2024 06:36:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=UDstDoKBmWn
	Vhz71tmSgBhtUz1NR1NA1YuZu4o0de7w=; b=T+IOEAWmf1uaE+efeVT8sg7RPI+
	olZGbjXYZf486NMkbwmaHE0fwvEWXjfgopyxkjkm0EL7hWnTsOjvkGFP7BSqOchI
	5q814+1TQTy3aSMpXcYjYkKT/UH6CwtKXeq5V53iVtjW37tJfmnum3NoigGZfesl
	FjlbxGVmGQ3idEf6AFYmtlclO3OHFdomFiKpeECNUCTV5NwSlncS0hczCy63CCKR
	DWW6YScObaxPNcN6QfMcU92JH00l+maavyIPl1mguUSNEt9Zq3kujbqdhrK18tIB
	gc49Y+di9dY8IHZBcTdWKIYlh3/trUAqMKJtoDmE3eWe7FgjuzyMQWjxfHg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4179anwyvu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 06:36:52 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA01.qualcomm.com [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 47R6Cek0022859;
	Tue, 27 Aug 2024 06:36:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 418uqwxr5e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 06:36:51 +0000
Received: from NALASPPMTA01.qualcomm.com (NALASPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47R6ZIUX003937;
	Tue, 27 Aug 2024 06:36:51 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-qianyu-lv.qualcomm.com [10.81.25.114])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 47R6apTM006366
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 06:36:51 +0000
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 4098150)
	id 0169464E; Mon, 26 Aug 2024 23:36:51 -0700 (PDT)
From: Qiang Yu <quic_qianyu@quicinc.com>
To: manivannan.sadhasivam@linaro.org, vkoul@kernel.org, kishon@kernel.org,
        robh@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, abel.vesa@linaro.org, quic_msarkar@quicinc.com,
        quic_devipriy@quicinc.com
Cc: dmitry.baryshkov@linaro.org, kw@linux.com, lpieralisi@kernel.org,
        neil.armstrong@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, Qiang Yu <quic_qianyu@quicinc.com>,
        Mike Tipton <quic_mdtipton@quicinc.com>
Subject: [PATCH 6/8] clk: qcom: gcc-x1e80100: Fix halt_check for pipediv2 clocks
Date: Mon, 26 Aug 2024 23:36:29 -0700
Message-Id: <20240827063631.3932971-7-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827063631.3932971-1-quic_qianyu@quicinc.com>
References: <20240827063631.3932971-1-quic_qianyu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bCrKYcRK7Ee47ocWZySvHIkAdHeqvDvC
X-Proofpoint-ORIG-GUID: bCrKYcRK7Ee47ocWZySvHIkAdHeqvDvC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_04,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 phishscore=0 suspectscore=0 mlxlogscore=973 clxscore=1015 malwarescore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408270048

The pipediv2_clk's source from the same mux as pipe clock. So they have
same limitation, which is that the PHY sequence requires to enable these
local CBCs before the PHY is actually outputting a clock to them. This
means the clock won't actually turn on when we vote them. Hence, let's
skip the halt bit check of the pipediv2_clk, otherwise pipediv2_clk may
stuck at off state during bootup.

Suggested-by: Mike Tipton <quic_mdtipton@quicinc.com>
Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
---
 drivers/clk/qcom/gcc-x1e80100.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/qcom/gcc-x1e80100.c b/drivers/clk/qcom/gcc-x1e80100.c
index 80e90e31be33..ad35a8c37ca8 100644
--- a/drivers/clk/qcom/gcc-x1e80100.c
+++ b/drivers/clk/qcom/gcc-x1e80100.c
@@ -3123,7 +3123,7 @@ static struct clk_branch gcc_pcie_3_pipe_clk = {
 
 static struct clk_branch gcc_pcie_3_pipediv2_clk = {
 	.halt_reg = 0x58060,
-	.halt_check = BRANCH_HALT_VOTED,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x52020,
 		.enable_mask = BIT(5),
@@ -3248,7 +3248,7 @@ static struct clk_branch gcc_pcie_4_pipe_clk = {
 
 static struct clk_branch gcc_pcie_4_pipediv2_clk = {
 	.halt_reg = 0x6b054,
-	.halt_check = BRANCH_HALT_VOTED,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x52010,
 		.enable_mask = BIT(27),
@@ -3373,7 +3373,7 @@ static struct clk_branch gcc_pcie_5_pipe_clk = {
 
 static struct clk_branch gcc_pcie_5_pipediv2_clk = {
 	.halt_reg = 0x2f054,
-	.halt_check = BRANCH_HALT_VOTED,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x52018,
 		.enable_mask = BIT(19),
@@ -3511,7 +3511,7 @@ static struct clk_branch gcc_pcie_6a_pipe_clk = {
 
 static struct clk_branch gcc_pcie_6a_pipediv2_clk = {
 	.halt_reg = 0x31060,
-	.halt_check = BRANCH_HALT_VOTED,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x52018,
 		.enable_mask = BIT(28),
@@ -3649,7 +3649,7 @@ static struct clk_branch gcc_pcie_6b_pipe_clk = {
 
 static struct clk_branch gcc_pcie_6b_pipediv2_clk = {
 	.halt_reg = 0x8d060,
-	.halt_check = BRANCH_HALT_VOTED,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x52010,
 		.enable_mask = BIT(28),
-- 
2.34.1


