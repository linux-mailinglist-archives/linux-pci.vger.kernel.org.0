Return-Path: <linux-pci+bounces-14272-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0735499A1AD
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 12:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8C4C286757
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 10:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52020213EDE;
	Fri, 11 Oct 2024 10:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lKaxJGWH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17BD213ED8;
	Fri, 11 Oct 2024 10:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728643329; cv=none; b=EUCVAH9TFuuK+Il/KRW4FrNS0rLBbLHrk95z+iFq8CJpvxySFPFOXIEVR5NIE32f0FrPfN9ZHyiDSFwJrAz7sKegVXl7YSA8zE3vlvocoLKxQZ6KURkyvfiMZC3PHSPyUMRDJZ4Eru1iTQONdlFRKJvUlCCnPpfqeslZU+p56Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728643329; c=relaxed/simple;
	bh=H1ziV5tyupxzZh4Cd1MkMsrgUXkihHsPR7l8O8TlpOg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WLtQsYsMBOOsEXKNzvjN3lylWjLeKT2GhK06CHrQJIbLRkjQU5E8bes9rXNS5gEcGcMYwOoXvmEJtmhMYK7y9cwgMdQovRKpbVA/lTOvSBSi02E+HYbHe3tW1jAizXoTc5XNNZ1FxskWz7uG3PSXqNsivTourAfmAYbtBnwpNaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lKaxJGWH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49B3aUd8027261;
	Fri, 11 Oct 2024 10:41:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=fM+DrFtFwy1
	+oio8hpHJjcoOsNaQT5+Glmr5yzAR83g=; b=lKaxJGWH32hvgH5dZe2CPNjm/TJ
	azew8lrajBRWhcKR5JWAKWRiKjJ0COzmebUogISxwyCMGOd/Vyv4Bdy0nELzMahq
	KySVnC3KuB4YKuWxbdNjEEULnjkwriTbsp5H+xpJTcO/AxU8zZOyrhuswMFOSQ/H
	NVkJ8E4Fv9zNxdGlg1T24CZ7o/g7S1EVFDRFldbHHpIXEGB441IWsWS5i4W4IQvG
	iq/h5sItCOOvJ3HJUzGwVIjbfJSZaSBvumkDgLLda/2qLV/XKg3hz8E8NVAPluSv
	viC72vxtbiUNVELFUbM7LFpxRg4ZGUvsw403Zl+1jIT6tra3MURW12qrhRw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 426fj6u1a1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Oct 2024 10:41:48 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA02.qualcomm.com [127.0.0.1])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 49BAU4NY016719;
	Fri, 11 Oct 2024 10:41:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 426uxek3yb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Oct 2024 10:41:47 +0000
Received: from NALASPPMTA02.qualcomm.com (NALASPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49BAfl4a000500;
	Fri, 11 Oct 2024 10:41:47 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-qianyu-lv.qualcomm.com [10.81.25.114])
	by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 49BAfkjj000499
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Oct 2024 10:41:47 +0000
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 4098150)
	id DA296651; Fri, 11 Oct 2024 03:41:46 -0700 (PDT)
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
        stable@vger.kernel.org, Mike Tipton <quic_mdtipton@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v6 5/8] clk: qcom: gcc-x1e80100: Fix halt_check for pipediv2 clocks
Date: Fri, 11 Oct 2024 03:41:39 -0700
Message-Id: <20241011104142.1181773-6-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241011104142.1181773-1-quic_qianyu@quicinc.com>
References: <20241011104142.1181773-1-quic_qianyu@quicinc.com>
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
X-Proofpoint-GUID: CkvloQ8YEJCuLTC0qJycda0ol7u3FqzL
X-Proofpoint-ORIG-GUID: CkvloQ8YEJCuLTC0qJycda0ol7u3FqzL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=954
 lowpriorityscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 clxscore=1015 mlxscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410110073

The pipediv2_clk's source from the same mux as pipe clock. So they have
same limitation, which is that the PHY sequence requires to enable these
local CBCs before the PHY is actually outputting a clock to them. This
means the clock won't actually turn on when we vote them. Hence, let's
skip the halt bit check of the pipediv2_clk, otherwise pipediv2_clk may
stuck at off state during bootup.

Cc: stable@vger.kernel.org
Fixes: 161b7c401f4b ("clk: qcom: Add Global Clock controller (GCC) driver for X1E80100")
Suggested-by: Mike Tipton <quic_mdtipton@quicinc.com>
Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
Reviewed-by: Konrad Dybcio <konradybcio@kernel.org>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
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


