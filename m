Return-Path: <linux-pci+bounces-32705-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2814DB0D56E
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 11:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74C9F3B3BD7
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 09:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F1B2DAFCF;
	Tue, 22 Jul 2025 09:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TqN5T3eM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5DD2DCC02;
	Tue, 22 Jul 2025 09:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753175533; cv=none; b=q89F4hOlimBgHy6yu6RD6xt0Jbs7YKjO74lWdDpOtA3GSJ+5cx98bUsYMEk3N5ybFv9bbHyNfPbz3f8SEmifTK9zU0xKybKJkwM5OJSxZIjYsg32J+S4W9yEQ6XwJ6Oh5H+K41uv/4bDabBxat8mquXruF/Q6ySQyk5v6kiUa74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753175533; c=relaxed/simple;
	bh=KzHam7BkSFDBK/1DVhgpDKmF9W9tSm54FAWlTeSaygU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZrN5+mR18U16+iThrhSnl4SBAmFgbBSqiVEjg8s3UGUHg1ITd/vmG1PJUErn+DbWOerZ4HtpEh50qjUYteFaO7kxi06TGEMPWPyS6BnDD4WKWVpTJwyz9FGG860wWfnoqiR1jeeE/z8bNGOpdB9XFhFqcE93BZ6/meZ1fUHdaNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TqN5T3eM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M7KkUW015650;
	Tue, 22 Jul 2025 09:12:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=cIRLuoCfzOX
	BWo70Fo1AfoQKa3KZ8R9OxpxvgV/x0Q8=; b=TqN5T3eMgbG9gF6k2yTmvUVoV55
	iofdihGRZXOMYKmczJ0D33TbkBexvR5uMAMhMAVdEP3k6tsOs3miNC2ojrfsTNmK
	upH7qiotYok912HUrnKsiVt8ZwhkaWp9hY3d8AzNXKHPGJsUCIvxOoaCLYv1KAzC
	C9uC+0vdwFcZZDGJGy6/s72tu3HWqg4mgYhqc4iKKEa6e4AM/Njbu1mAKPdaKHtc
	KioIS30F9eHJB30ozipqW1yltr36F9zZ6O6kFtenwCL2AcKbqrgbnJYIA2YDLYsV
	sjvbGtI5WmCwxKe3rTq3D/5hba5TiirDWEXcWKa9/x1tt+yyu0yWvGfZa0g==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481t6w1yua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Jul 2025 09:12:02 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 56M9C0jr003114;
	Tue, 22 Jul 2025 09:12:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 4804em6q2e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Jul 2025 09:12:00 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56M9C0GW003105;
	Tue, 22 Jul 2025 09:12:00 GMT
Received: from cbsp-sh-gv.ap.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 56M9C075003104
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Jul 2025 09:12:00 +0000
Received: by cbsp-sh-gv.ap.qualcomm.com (Postfix, from userid 4635958)
	id 5933240D2E; Tue, 22 Jul 2025 17:11:59 +0800 (CST)
From: Wenbin Yao <quic_wenbyao@quicinc.com>
To: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
        robh@kernel.org, bhelgaas@google.com, sfr@canb.auug.org.au,
        qiang.yu@oss.qualcomm.com, quic_wenbyao@quicinc.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc: krishna.chundru@oss.qualcomm.com, quic_vbadigan@quicinc.com,
        quic_mrana@quicinc.com, quic_cang@quicinc.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH v5 2/3] arm64: dts: qcom: x1e80100: add bus topology for PCIe domain 3
Date: Tue, 22 Jul 2025 17:11:50 +0800
Message-Id: <20250722091151.1423332-3-quic_wenbyao@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722091151.1423332-1-quic_wenbyao@quicinc.com>
References: <20250722091151.1423332-1-quic_wenbyao@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=SPpCVPvH c=1 sm=1 tr=0 ts=687f55e2 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=ZDVFxM84AbWdf4itxYgA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA3NSBTYWx0ZWRfXyJctrKfMbmvQ
 cHIRYdgLwjv6N/VPHbn/UrOzOILYkxjC/fLchb38gN/C5cdt4po5+vFS+Tyl98Lb3Jhgo8haL+I
 7GjZC17rS1qvbIDJbwurC7v5o0dozLeNGP+IvCkY3olM3q0KPlAWOsToJeACTPNQQIYGIuAq96Y
 3vM+z5aXDwa8aKR98suKqn+2O2Z9QMpqdSFtooK/TAEz21rG3ygo8EwYPb0PGFd4ZbfxtT1oJFt
 uRIPUF0o976KXE3It6NUVCj1Z3cpL8+Aaimuy+dlrk5D+TgHhk+kHMg2A3FYO1yEtwl5tG8S9p9
 q/tCnGt0UgRAWXicXM9HXjPWsMjsLogOcXtJEQqkmLhr4+U+K4s1JJbvwxpgNY2hqEYygFdMOc6
 itcFs9TJhG1qtnXI/bpZUfnVsfv4fTHm6jnrJ1LKt7ngG2AVoENtuJsHhn8XNf9CsTonsdz7
X-Proofpoint-ORIG-GUID: CTUwAWWVG23YO-iatw8_JFKIuzIec9PA
X-Proofpoint-GUID: CTUwAWWVG23YO-iatw8_JFKIuzIec9PA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_01,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxlogscore=922 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507220075

From: Qiang Yu <qiang.yu@oss.qualcomm.com>

Add pcie3_port node to represent the PCIe bridge of PCIe3 so that PCI slot
voltage rails can be described under this node in the board's dts.

Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
Signed-off-by: Wenbin Yao <quic_wenbyao@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 5e9a8fa3c..c9fea0402 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -3306,6 +3306,17 @@ opp-128000000 {
 					opp-peak-kBps = <15753000 1>;
 				};
 			};
+
+			pcie3_port: pcie@0 {
+				device_type = "pci";
+				compatible = "pciclass,0604";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				bus-range = <0x01 0xff>;
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
 		};
 
 		pcie3_phy: phy@1be0000 {
-- 
2.34.1


