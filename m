Return-Path: <linux-pci+bounces-39770-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F31A1C1F1AF
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 09:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA47D19C3D27
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 08:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C2C339B47;
	Thu, 30 Oct 2025 08:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fk6rw1fc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A036E338F5D;
	Thu, 30 Oct 2025 08:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761814106; cv=none; b=LDvVfb3nLDTRqEF+PlKcsM0bZlZiSk0R//102YD/fuSilzHajM/7sUhfhJTLYyy5mBjSNHY8xrcx9wQOdnS1Fc0avAaVrUgakB3sJXxrYVPp90WHZUEnFRkpWgwRmYqzF+wXag+kSNGowVOcOEHeYzitwBq2hbb1x+NuD7EqAuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761814106; c=relaxed/simple;
	bh=/oHoQgv9nY43AEM/1rPAhmtqo79ajX5r0J6g+ctpSHw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mLzeplyy261uyo7Klb0C+rR6ST1O344zJRdGAOmbrS+dYIGla2ltbuuWcmc6YWc/Df9ol82zPZ8CzLWP00tV2n9rEJf5jGSKHUUBdpAov1Hm9vyZwnJARVoBQ6OXTAv0YGyK75DldmeQm5cSjnQVJjrzeNeGGE2atw8OcjyXVU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fk6rw1fc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U7IQQ21598401;
	Thu, 30 Oct 2025 08:48:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=YR4mdKEJCnW
	vTz52iytgDFjBRFAuxKUx+ZfdFVKRrbc=; b=fk6rw1fc4EPsAuGEp5a5qhBxihq
	3qjQM1IeHwrB9WRzEsY7+8TDZ5aH6G+h4hVWoq4KmJRP50PrKU048Waweo9xxEFZ
	9FoM0X1AL7EIziF1UyiOcX3GXTl5qLJ+ygtSac2ElaWY7NO+JHJbnh97nyaHUfQQ
	Ux8o9qgbufSCENp8ZrwB9rPDuAeeu7J288Wk20oHV+cDLfmUKecuFV0YPMB5tcxF
	6mGZWTtMjQerWIPEao/Jxtcsb4cLQ3nT5p44D7G+hC8YApaGm0P33rSkIV9ZnLSq
	jOOITvMGCa1QaZkB8RJWl9n0vCMapnkLCR/aY+myD3//SQIa37M+5KupNKQ==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3ta7srn5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Oct 2025 08:48:11 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 59U8m8eD003591;
	Thu, 30 Oct 2025 08:48:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 4a0qmmf1y6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Oct 2025 08:48:08 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59U8m8tT003581;
	Thu, 30 Oct 2025 08:48:08 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (cse-cd02-lnx.qualcomm.com [10.64.75.246])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 59U8m7Ke003573
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Oct 2025 08:48:08 +0000
Received: by cse-cd02-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id 251D2792; Thu, 30 Oct 2025 16:48:06 +0800 (CST)
From: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com,
        mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
        bhelgaas@google.com, johan+linaro@kernel.org, vkoul@kernel.org,
        kishon@kernel.org, neil.armstrong@linaro.org, abel.vesa@linaro.org,
        kw@linux.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v2 2/4] arm64: dts: qcom: Add PCIe 5 wwan regulator for HAMOA-IOT-EVK board
Date: Thu, 30 Oct 2025 16:48:02 +0800
Message-Id: <20251030084804.1682744-3-ziyue.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251030084804.1682744-1-ziyue.zhang@oss.qualcomm.com>
References: <20251030084804.1682744-1-ziyue.zhang@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=aaVsXBot c=1 sm=1 tr=0 ts=6903264b cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=bu6UjZ7a5GH_BZZocUYA:9 a=nl4s5V0KI7Kw-pW0DWrs:22 a=pHzHmUro8NiASowvMSCR:22
 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-ORIG-GUID: 8IZKpD7xa9YyMpNJXWQRDmoGoP5EaXKm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA3MSBTYWx0ZWRfX3wTGOnkQKKjY
 IkeSZl+D6Zl8kA3zhoMS4U+kKh0oc2ltzJ0CPr/Q1tuHHgB9EeXZG4O9jt1jqrCrlDCj2fnBAja
 Nx6K50SeVK5b1Pvbkky0HgQM7YzY7/hwUn+C7ScieZslcqo54U6hQZEobmrLQP5Nv8hNH7Swr7m
 OaGShqiC50xWEq+m9LHQBeNlvero3RE7ffscMYaOz9vkRTK1aLOLebot7NsNIsN0wWokY74e/Ne
 z3NGRwC09VqLSj3ejnv2qV9O1m/mQXiqx/XHP4OlUIxyP6FOtM0yc2GhlvZUns+P4srlhUX4PIw
 2JScWdp6vtngGgEoWZ/iQ7LwP8ptjHMgDi5gqauzklbMHy4qUu87ryCRG2JrAuZFXicXk2BJQFV
 6msYFCQ5+p4GU3qogNxxt8jeWCsvtA==
X-Proofpoint-GUID: 8IZKpD7xa9YyMpNJXWQRDmoGoP5EaXKm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 impostorscore=0
 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300071

Specify the vddpe-3v3-supply regulator for PCIe5 using &vreg_wwan to
ensure proper power configuration.

Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Reviewed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
index 36dd6599402b..24c2dcef0ba8 100644
--- a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
+++ b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
@@ -844,6 +844,10 @@ &mdss_dp3_phy {
 	status = "okay";
 };
 
+&pcie5 {
+	vddpe-3v3-supply = <&vreg_wwan>;
+};
+
 &pcie6a {
 	vddpe-3v3-supply = <&vreg_nvme>;
 };
-- 
2.34.1


