Return-Path: <linux-pci+bounces-32942-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4A3B11D68
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 13:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F0E35A3F7D
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 11:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0844D2E610E;
	Fri, 25 Jul 2025 11:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bmqA9+hG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C120F2114;
	Fri, 25 Jul 2025 11:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753442651; cv=none; b=XFTycr+Pl7CgySLXFL/+eqXSBoXm6QUMlx+scH/mfsqw9GwnIOcdMuRyww21LmDAKX43yVVvGKAzyVsM0dKQt27PgZkxYYw2X/Na/aZEoWpwGI8IE3hg6N6x9Z9QqlOCcCokvjVmPuUiCUyxDKE44wtXklIE57qFQynZBrO7OUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753442651; c=relaxed/simple;
	bh=++66ni+hWLvKnoZxAIdLffVnFQpHvjiJ/1hbvKkf9y4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HB4lb12fAzvcBd0f2pwJTG0xP+cYzNBXdwrfJsehmQtE3Vjkw7vuEEK8o8kZRWAgKMwJUrvvcbAPcPuR6hxIqlqQ2Ub6cGFPDICznEF5ZO4Kv86gvoXHcpUPfXKTXbyuc1gX6GY1hxSi2HkfB28Bgjz12X7is5LucJuv2kOG0lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bmqA9+hG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56P9EKd3001090;
	Fri, 25 Jul 2025 11:23:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Rih3g8CxOzFoTHxyHT4XlmN/DrVkdGL21oJ
	qnOuVf0Q=; b=bmqA9+hGZxHLFcEhguEV1100s55eIs0A8CBB9MGmBI2bb5klBeI
	mJopSAw/JNXbp06zfbCrK1pCs3QG8uGCjsjirk7/+7OOE9B1cDHi4siCoSZPyyfS
	sOcsySQ+I2hEZVfRV+47yoCPwz1hKuMmD7DC6ydEq0LVtiNcMiXWT6nsl4unKdRm
	ayq1R9PetesyswRmk00lIeVvzvYPJLl51HPeEUsZBfx5xfSYJ0gFFE8T8s81rv9H
	NR+tFYr9A2H1I3KYdZlUCHbZyRGQkavwSOhOuM3RF/oCCozK6D9m9M8g57WG3eVY
	Y6co5npA7vSNgdBU0UgUjiXCnd79YipHjzg==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483w2xhubf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 11:23:59 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 56PBNu84024518;
	Fri, 25 Jul 2025 11:23:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 4804emt82c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 11:23:56 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56PBNt4P024512;
	Fri, 25 Jul 2025 11:23:56 GMT
Received: from cse-cd01-lnx.ap.qualcomm.com (cse-cd01-lnx.qualcomm.com [10.64.75.209])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 56PBNt6p024509
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 11:23:55 +0000
Received: by cse-cd01-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id 2594620EDA; Fri, 25 Jul 2025 19:23:54 +0800 (CST)
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
Subject: [PATCH v9 0/2] pci: qcom: Add QCS615 PCIe support
Date: Fri, 25 Jul 2025 19:23:44 +0800
Message-Id: <20250725112346.614316-1-ziyue.zhang@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: ky72DWZBWDXL8MxZVsc3NChfb9cUSbk2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA5NiBTYWx0ZWRfX4AfAwiXwGi24
 VmsMJBivSSH43RkSbcf1N6RC+2JIC7rT5kJdr28eqmV93TAbPzPB9tQaIEuHnN2LVCbNcbhulIT
 gZpBKUWz+ZAdnfH1sJUFzw2wog1bI0Un1oT2fFsmVf9gmF7vdbx//jIK7eSSIaOZNzdn39p6BPj
 RX2Qn0K1EQ9RTeBs9ezSoazCTfhFThM9QCJhnyIYZNHXZ7zxE6UhtLyK1SlN/bU5Q2CWMrVSlhd
 nWwAGudXeCKoiX3z5lxsbvsEbUiAfsj/4jROlEAdLoKrBV9e514LN4FmXFDMvMhT+GNaBqStTcB
 X0Y5MXl//pEa9BPRyYEbBm+vCoMCWapsEUWGkvR+HHfSFOj5zfmO9Zsm41rVjXbhc7oBAFSX3EB
 Qfo5irtd/HMlJcFyyh6OUKZhN80IEcKYHzLUxrOgpxQkKZRKkUM4ZCmuzCCxfCvMyTqoCtM+
X-Proofpoint-GUID: ky72DWZBWDXL8MxZVsc3NChfb9cUSbk2
X-Authority-Analysis: v=2.4 cv=S8bZwJsP c=1 sm=1 tr=0 ts=6883694f cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=nFUSFbzN6SMpi5LfgmsA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_03,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=772 bulkscore=0 impostorscore=0
 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507250096

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

Changes in v9:
- Patch rebased
- Link to v8: https://lore.kernel.org/all/20250703095630.669044-1-ziyue.zhang@oss.qualcomm.com/

Changes in v8:
- Fix scripts/checkpatch.pl error (Krzystof)
- Link to v7: https://lore.kernel.org/all/20250702103549.712039-1-ziyue.zhang@oss.qualcomm.com/

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

 arch/arm64/boot/dts/qcom/qcs615-ride.dts |  42 +++++++
 arch/arm64/boot/dts/qcom/sm6150.dtsi     | 138 +++++++++++++++++++++++
 2 files changed, 180 insertions(+)


base-commit: d7af19298454ed155f5cf67201a70f5cf836c842
-- 
2.34.1


