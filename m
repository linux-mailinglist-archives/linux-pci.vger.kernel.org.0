Return-Path: <linux-pci+bounces-31235-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B831DAF1209
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 12:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C71CB1896E46
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 10:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B80A25EFBF;
	Wed,  2 Jul 2025 10:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nzhSB8Cz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AD525DCEC;
	Wed,  2 Jul 2025 10:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751452582; cv=none; b=l/ClfyKwVnvENt3TabWNafms5VGzE47gpbSSF3ioDQJ4azT3gnP8plpimB+Cssu1tc259sVCxsJCVN9UmDLU3SsHbz6y6PHPRwUAw7Aj1ObIVjnMOzqAdq7IurnYurdZJYwTQOyBOuFjGCGby6VyNR0j/igvQ50OM2sVlvFLLWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751452582; c=relaxed/simple;
	bh=GaZCKY0SU+yrmjqmrkNLz9qIM363CmKL6Yd8iR4z5G4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JuvVtvRItcPOImemY8s4G/E2SpdjbwkEU6ZYQoz32gWVUhxSYA1ASt+vIXt0QXlWQztv2J5WpS4bM/d4hO1hV8DwkUqMc+BbnnJzSt5yuAFL13rHh4tLVOS09j4dLXDxa1nxu6aPse53f7yv9DiyJ4jIi10IwUDlq0g+MRswLIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nzhSB8Cz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5627b6qs019831;
	Wed, 2 Jul 2025 10:36:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=1Ypy47BdFf3JhOwF9brvNY71Wi2+yZUl3eF
	9Wbgne7s=; b=nzhSB8Czwd8/urmmIrwK3k5x4yJsc43U9/2Ai9sMRGnpxf/jizY
	P0fxggTd4Hy+c3OujLH6999RDNtDhZxwRcY4ikI0GB6RTqL9RIYqOvRaCGHKcKx4
	yantEZ9yO0W0cOjtcF6F9+quPRabLPLzUgCwrZrV4YdZfLcvDL8vlqsrBzAtH9mW
	EAaG8SuwZC/vE4jBdYTxuWXzdtskJbOrRLf8tYC5y736jJMrskPI+2g7wYkh5RM1
	eaQ5sTzcfv3hcFxUft4d+78EBop9UNhbv1JN38ixkcD3ASfQZYt/RI9Y7y0+D87P
	aw2E+//hrPanzbyeF6a23rrXh++182KVpNw==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47n0h8gm8y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Jul 2025 10:36:08 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 562Aa6gw003672;
	Wed, 2 Jul 2025 10:36:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 47j9fmbh2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Jul 2025 10:36:06 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 562Aa58R003658;
	Wed, 2 Jul 2025 10:36:05 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (cse-cd02-lnx.qualcomm.com [10.64.75.246])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 562Aa45i003654
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Jul 2025 10:36:05 +0000
Received: by cse-cd02-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id B31AF3923; Wed,  2 Jul 2025 18:36:03 +0800 (CST)
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
        Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Subject: [PATCH v7 0/3] pci: qcom: Add QCS615 PCIe support
Date: Wed,  2 Jul 2025 18:35:46 +0800
Message-Id: <20250702103549.712039-1-ziyue.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDA4NiBTYWx0ZWRfX9MUvxrgxP8Xb
 toQEAnLRSA3FlazYhExW9aH4QCCbFKKXzILbPZZkpqte0zHESM0UprV0h9nQljQ0V+aBgqN8EiE
 BuRV4v0ZWNReiRPTnMaiYFcuTUYsnmIDFgq0br7/af4a1r9otpaWicL01LB4kjwQrHIgo8gVqYi
 P8KzPn9IXXfg+sRxHCG45VJbvKrpc1iIRh56JnQKvBxHf8jDhwnxLuWbBXwm6ZokavkmOrIDxyF
 GFtJic7XqsFnuMi0rWjVD9ExcG1zoZInLroG7Z7N6ldRXo6zwITDof1OLA6aUHubCc71C2cjWPw
 9lRGp8M4a9LT9rnUOWNX70RpvYfqy1LKPbx9HXpyEOWeRbMf+t/C/ZgcLGGwEj8mOUzft0KRGaK
 MMtUh2H+0rTnkYHZ0XAjuedYEngHoj4f/+SwvkhoC/0bizTxSKfx9BRNC+u8luj5AuWrItqw
X-Proofpoint-ORIG-GUID: Rgdtu__xCs89fhYeg_6xEO55jxXCaNGc
X-Authority-Analysis: v=2.4 cv=L4odQ/T8 c=1 sm=1 tr=0 ts=68650b98 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=FMqLFO0IG5DNS-mwCd0A:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: Rgdtu__xCs89fhYeg_6xEO55jxXCaNGc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0 mlxlogscore=793 suspectscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1011 bulkscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507020086

This series adds document, phy, configs support for PCIe in QCS615.

This series depend on the dt-bindings change
https://lore.kernel.org/all/20250521-topic-8150_pcie_drop_clocks-v1-0-3d42e84f6453@oss.qualcomm.com/

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
---
Have following changes:
	- Add a new Document the QCS615 PCIe Controller
	- Add configurations in devicetree for PCIe, including registers, clocks, interrupts and phy setting sequence.
	- Add configurations in devicetree for PCIe, platform related gpios, PMIC regulators, etc.

Changes in v7:
- Add Fixes tag to phy bindings patch (Johan)
- QCS615 is Gen3 controller but Gen2 phy, so limited max link speed to Gen2.
- Remove eq-presets-8gts and oppopp-8000000 for only support Gen2.
- Link to v6: https://lore.kernel.org/all/t6bwkld55a2dcozxz7rxnvdgpjis6oveqzkh4s7nvxgikws4rl@fn2sd7zlabhe/

Changes in v6:
- Change PCIe equalization setting to one lane
- Add reviewed by tags
- Link to v5: https://lore.kernel.org/all/t6bwkld55a2dcozxz7rxnvdgpjis6oveqzkh4s7nvxgikws4rl@fn2sd7zlabhe/

Changes in v5:
- Drop qcs615-pcie.yaml and use sm8150, as qcs615 is the downgraded
  version of sm8150, which can share the same yaml.
- Drop compatible enrty in driver and use sm8150's enrty (Krzysztof)
- Fix the DT format problem (Konrad)
- Link to v4: https://lore.kernel.org/all/20250507031559.4085159-1-quic_ziyuzhan@quicinc.com/

Changes in v4:
- Fixed compile error found by kernel test robot(Krzysztof)
- Update DT format (Konrad & Krzysztof)
- Remove QCS8550 compatible use QCS615 compatible only (Konrad)
- Update phy dt bindings to fix the dtb check errors.
- Link to v3: https://lore.kernel.org/all/20250310065613.151598-1-quic_ziyuzhan@quicinc.com/

Changes in v3:
- Update qcs615 dt-bindings to fit the qcom-soc.yaml (Krzysztof & Dmitry)
- Removed the driver patch and using fallback method (Mani)
- Update DT format, keep it same with the x1e801000.dtsi (Konrad)
- Update DT commit message (Bojor)
- Link to v2: https://lore.kernel.org/all/20241122023314.1616353-1-quic_ziyuzhan@quicinc.com/

Changes in v2:
- Update commit message for qcs615 phy
- Update qcs615 phy, using lowercase hex
- Removed redundant function
- split the soc dtsi and the platform dts into two changes
- Link to v1: https://lore.kernel.org/all/20241118082619.177201-1-quic_ziyuzhan@quicinc.com/

Krishna chaitanya chundru (2):
  arm64: dts: qcom: qcs615: enable pcie
  arm64: dts: qcom: qcs615-ride: Enable PCIe interface

Ziyue Zhang (1):
  dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Update pcie phy bindings
    for QCS615

 .../phy/qcom,sc8280xp-qmp-pcie-phy.yaml       |   2 +-
 arch/arm64/boot/dts/qcom/qcs615-ride.dts      |  42 ++++++
 arch/arm64/boot/dts/qcom/qcs615.dtsi          | 138 ++++++++++++++++++
 3 files changed, 181 insertions(+), 1 deletion(-)


base-commit: 3f804361f3b9af33e00b90ec9cb5afcc96831e60
-- 
2.34.1


