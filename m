Return-Path: <linux-pci+bounces-32704-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 124E9B0D56B
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 11:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 608831AA1D4A
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 09:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11CE2DD5E2;
	Tue, 22 Jul 2025 09:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JLKMihQs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F37B2DCF65;
	Tue, 22 Jul 2025 09:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753175531; cv=none; b=MzRQ/DerBxveqkjkB0NQynlIL4Qqg8LX/A68cvLpQF5vDi3zLHG3YQ7k57SfxA+VIARltfgQMQbs+z6oVWK9/VaYsrz0b22hVr1yfe4dE3Sy3yp1u2GBpOCpFWNF7cvpeeuDn2+l/9LyTDmHcnJv0M2vu2aCm791Ao4MLWvdOK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753175531; c=relaxed/simple;
	bh=4iC7b0YY9O8LIk+7LsFRLPW5Z6bVMSCFidBq29TYZ44=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q/wywmxk3e/NOipH9FIgyuLUSS3g9As5NCwk+ylH77W4RdE/iqZq4DUa5rf9+SHmeXpTFKApQrlQbfOb/ZpIz7ujnyFiIf1jPwgeRvonQrqWXLuGJQT9DYtO6fLLtFsfaEQPHMum1By7HAc0zz/BSpz8L18H2dOvHOWDazX4TUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JLKMihQs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M7VSBg004441;
	Tue, 22 Jul 2025 09:11:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=bHOK96ZopBLVO3VRhgzqUJvDL4SbmcoEt+g
	yWVRw7Hs=; b=JLKMihQsvCVNLguyNBoiUipPX1d5lapZDgswTAr1Lf2tqtKl9TX
	0UmZiAVu39tLKfrYEsAD1j908JyBUWvNbkJ3+LDj2WqfjMn4Q7E8kHe3Kko+3wg8
	j67Ij2oh6jHnHuSVgyQRwDqpjBeZTufPq1Vm9rarhdIQpGjNFduvgP8HXPHGclQ3
	hGr1VXvceV58K7FOGw4YuXlCMTro1O3QRG+9YLU49F068IXDqAzs2N2w5cCLTk2z
	lYdKcny43tBQcW40B8yn31DUGTAvNFa05fzV8NVbm0v7IukFpH+edvJJMW3tqDm7
	6eQKjUUOZyj9Y9T6cCU6L8fMkTBx6EVQ1ag==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48045vy6ue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Jul 2025 09:11:58 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 56M9Buec003075;
	Tue, 22 Jul 2025 09:11:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 4804em6q1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Jul 2025 09:11:56 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56M9Bu8W003068;
	Tue, 22 Jul 2025 09:11:56 GMT
Received: from cbsp-sh-gv.ap.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 56M9Bt7M003064
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Jul 2025 09:11:56 +0000
Received: by cbsp-sh-gv.ap.qualcomm.com (Postfix, from userid 4635958)
	id E9A0B40D28; Tue, 22 Jul 2025 17:11:54 +0800 (CST)
From: Wenbin Yao <quic_wenbyao@quicinc.com>
To: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
        robh@kernel.org, bhelgaas@google.com, sfr@canb.auug.org.au,
        qiang.yu@oss.qualcomm.com, quic_wenbyao@quicinc.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc: krishna.chundru@oss.qualcomm.com, quic_vbadigan@quicinc.com,
        quic_mrana@quicinc.com, quic_cang@quicinc.com
Subject: [PATCH v5 0/3] arm64: qcom: x1e80100-qcp: Add power supply and sideband signals for PCIe RC
Date: Tue, 22 Jul 2025 17:11:48 +0800
Message-Id: <20250722091151.1423332-1-quic_wenbyao@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=LL1mQIW9 c=1 sm=1 tr=0 ts=687f55de cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=6pwcJLpaZwdPYVvGVLQA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: mkyISQZ99y2rQlH_WKjE0oyLw6DgWwbK
X-Proofpoint-ORIG-GUID: mkyISQZ99y2rQlH_WKjE0oyLw6DgWwbK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA3NSBTYWx0ZWRfX3QX8GIXpbyss
 KQ6RHRrT+7NSL67NhzNRzGCnICEISidZktOU+wI/fx2T9CNWZT31Efr5IDjxnY85SXseEOW8hiZ
 14sda/Kj5vmvTypb88gyo0Kq3QMEviwKya4kU6nJ7ApJ0a+dhuCTUxhxkZYHKIfgSjc9EyboJZ9
 yyXh6Tc/diUSCwr51Phh7jSaiNxky15tCpFrEmJZ212IHaLKcy3RHlbLkt0IsYWq6mEyh7/8XPl
 v4s+NgbtWmBQN9rWzIrGTU5P/26Tu95hfD+JhMMkCqC4hcb/RiRFPgUY/fZgxFZ+wg2nMKBhw7E
 q/8xIWMr93uFnCO5X5MyFZmByBxdo0Fuunehx/aLbiGx3fj154JaDkMxqdCIAo5Mcne+IcjED+A
 IhBVRl13SgUzbl8A//6DpE/4zTqxZoaPkg0OCpIJxFbqUlNBG1PAi9sf8pPj6cW88K8UUgSI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_01,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxlogscore=999 clxscore=1011 mlxscore=0 adultscore=0
 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507220075

The first patch enables the PCI Power Control driver to control the power
state of PCI slots. The second patch adds the bus topology of PCIe domain 3
on x1e80100 platform. The third patch adds perst, wake and clkreq sideband
signals, and describe the regulators powering the rails of the PCI slots in
the devicetree for PCIe3 controller and PHY device.

The patchset has been modified based on comments and suggestions.

Changes in v5:
- Use CONFIG_PCIE_QCOM selecting CONFIG_PCI_PWRCTRL_SLOT.
- Drop vdda-qref-supply for PCIe PHY.
- Link to v4: https://lore.kernel.org/all/20250604080237.494014-1-quic_wenbyao@quicinc.com/

Changes in v4:
- Replace pcie3port with pcie3_port in Patch 2/5.
- Add restoring the vdda-qref request for the 3th PCIe instance by
  reverting commit eb7a22f830f6("phy: qcom: qmp-pcie: drop bogus x1e80100
  qref supply") in Patch 5/5.
- Link to v3: https://lore.kernel.org/all/20250508081514.3227956-1-quic_wenbyao@quicinc.com/

Changes in v3:
- Replace PCI_PWRCTL_SLOT with PCI_PWRCTRL_SLOT in Patch 1/5.
- Keep the order of pinctrl-0 before pinctrl-names in Patch 3/5.
- Add Patch 5/5 to request qref supply for PCIe PHYs.
- Link to v2: https://lore.kernel.org/all/20250425092955.4099677-1-quic_wenbyao@quicinc.com/

Changes in v2:
- Select PCI_PWRCTL_SLOT by ARCH_QCOM in arch/arm64/Kconfig.platforms in
  Patch 1/4.
- Add an empty line before pcie3port node in Patch 2/4.
- Rename regulator-pcie_12v regulator-pcie_3v3_aux and regulator-pcie_3v3
  in Patch 3/4.
- Add Patch 4/4 to describe qref supply of PCIe PHYs.
- Link to v1: https://lore.kernel.org/all/20250320055502.274849-1-quic_wenbyao@quicinc.com/

Qiang Yu (3):
  PCI: dwc: enable PCI Power Control Slot driver for QCOM
  arm64: dts: qcom: x1e80100: add bus topology for PCIe domain 3
  arm64: dts: qcom: x1e80100-qcp: enable pcie3 x8 slot for X1E80100-QCP

 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts | 118 ++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/x1e80100.dtsi    |  11 ++
 drivers/pci/controller/dwc/Kconfig        |   1 +
 3 files changed, 130 insertions(+)


base-commit: 05adbee3ad528100ab0285c15c91100e19e10138
-- 
2.34.1


