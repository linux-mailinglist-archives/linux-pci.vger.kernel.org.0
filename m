Return-Path: <linux-pci+bounces-13370-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D42B697EBD7
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 14:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECDFE1C214F0
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 12:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E7A199FCE;
	Mon, 23 Sep 2024 12:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AZ66UC6S"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814C6199E92;
	Mon, 23 Sep 2024 12:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727096264; cv=none; b=O7lpANiJEWz0hSjMZJplHu7sJUlalmrrrjm8OEz6w7/qaaKfIgT43rFIhJTZKB3+NTqNtrws8bdT8F/E1Vkl480Jv8q01mHJoMSlCGH/pt8BcGzx+NHRyuFLHmiOt5wHeju5dkKphDqmcgip5Hi3G1IYm408fJCP1Q9OTY9af4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727096264; c=relaxed/simple;
	bh=4dBLTQODPVehMYUE36dx4guUttMRQ5Qm/JBMFI0j7uY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U9d5znAzkOE19MeChJK8tgyYNIhECdt6Zm34dWWlU4/oiedbvpqewBEYGwyW+c9OeRlVGoJZPOPPg7i1OhJWLKTheSP7wKIFoU+3PoB7ksJgMrqx3CSLUj1xrixUjCl2HWJBRCFG9oUee6kVBXYcZ9IZ+jEXY7utZ+iU1PUGgFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AZ66UC6S; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48NBM3eN014189;
	Mon, 23 Sep 2024 12:57:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=deGWBSCQ5fh
	TkgJCHfFl7/mV0HgSSfPyxgjK9ESwV20=; b=AZ66UC6Sz3ZTIO5sjfwnGC6uYZW
	g/z2KMQRV38BhDHgZR2U05Xln4nDfwvX7Drp+pfJ7X/y7AbVHJVgAaS2i9CXRtWh
	7UneGoNB4wsOE4LEYIzg1fBg8XINM2zxaQ2pXvEWBU+DsPHjZj/vebJkYuDnsDH9
	+AU2FvEuStm+K1yCo1w4AXTVcWFSOgZLa417e0GaUW2ZjTTvfZddCk2dNfc7i2Py
	l4r84dkX1W4pRSrVHLi5ZQg3rKWwe5nnjeJq0NPrEfEynpSX/4astb6haCw3ewQK
	+ubpzct6wEOlQieonmKt+wz0BrvXN9REhRaeuEIqK9N9X8wE3uJTHkYfxTQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41sn3s4t77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Sep 2024 12:57:19 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA02.qualcomm.com [127.0.0.1])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 48NCt8T1031984;
	Mon, 23 Sep 2024 12:57:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 41sq7m2nsu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Sep 2024 12:57:18 +0000
Received: from NALASPPMTA02.qualcomm.com (NALASPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48NCvIOI002000;
	Mon, 23 Sep 2024 12:57:18 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-qianyu-lv.qualcomm.com [10.81.25.114])
	by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 48NCvHGa001986
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Sep 2024 12:57:18 +0000
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 4098150)
	id A870665F; Mon, 23 Sep 2024 05:57:17 -0700 (PDT)
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
Subject: [PATCH v3 4/6] clk: qcom: gcc-x1e80100: Fix halt_check for pipediv2 clocks
Date: Mon, 23 Sep 2024 05:57:11 -0700
Message-Id: <20240923125713.3411487-5-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240923125713.3411487-1-quic_qianyu@quicinc.com>
References: <20240923125713.3411487-1-quic_qianyu@quicinc.com>
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
X-Proofpoint-GUID: Kfp2SbRRyaGD7hEQUzbdzbHfwBI5pQZg
X-Proofpoint-ORIG-GUID: Kfp2SbRRyaGD7hEQUzbdzbHfwBI5pQZg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 mlxscore=0 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=989 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409230095

The pipediv2_clk's source from the same mux as pipe clock. So they have
same limitation, which is that the PHY sequence requires to enable these
local CBCs before the PHY is actually outputting a clock to them. This
means the clock won't actually turn on when we vote them. Hence, let's
skip the halt bit check of the pipediv2_clk, otherwise pipediv2_clk may
stuck at off state during bootup.

Suggested-by: Mike Tipton <quic_mdtipton@quicinc.com>
Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
Reviewed-by: Konrad Dybcio <konradybcio@kernel.org>
---
 drivers/clk/qcom/gcc-x1e80100.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/qcom/gcc-x1e80100.c b/drivers/clk/qcom/gcc-x1e80100.c
index 0f578771071f..81ba5ceab342 100644
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


