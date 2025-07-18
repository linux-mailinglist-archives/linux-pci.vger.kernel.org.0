Return-Path: <linux-pci+bounces-32501-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65596B09C1A
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 09:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF8ED1897342
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 07:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559DF215043;
	Fri, 18 Jul 2025 07:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eXN34sMF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B986D218821;
	Fri, 18 Jul 2025 07:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752822748; cv=none; b=JhK8y8cU4hN7F9rj2f3XZL9NlIDp6eU9weQZyv16uHGq+wwwbznTHi/d6x2ogIzW7HFZb1GYOGbfGa3kye086D6uo4iOduGom1Yaf7aMXa6pqGrHjNmhqAQs/X0WhNptilj9ELhBK4zjo+yM+NGJe+f0puei88LYhCBohs3WVag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752822748; c=relaxed/simple;
	bh=J9TTthri3P5Pz7rfBBtf0OP6gtbV/9IVRyhGQaWg3Xs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YrqyFKlewUuLoF1T2jxUmuAtWBB9OVmd6Su5k3CBIMaY0Ap2CgU0mrBlbRz3OoFmSh+WQcZg5Jw8t/8XQ39OKcrjMcFY1yjVvnTExHwKdEPryfKqPR02Y92VmZ+P4OYz/BjgR//Ijk/ZmerDO/cPYvoDd2xjDl1zQtkfw35TCqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eXN34sMF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HLuJkE020761;
	Fri, 18 Jul 2025 07:12:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=uAaPth0hkPo6/ZzqXgJcYrwqJuiYcbVXjFG
	EZRTPClo=; b=eXN34sMFBGX/ilvQjTWWk6RuhVtZ7gSOr6ZID3tylIEO7QsMAkg
	p/SiY3Z9RYnMfB1nSAqX2x3ZW6vsCxXhnAQDjaCJcatcY44gM/9mWhWpbUBtJWVp
	SHxSKrdLFFshiyh/76/kbKUgW4RIaMwwXJPz2zRVKy9Hq2RmY19OzUnF6ENph5rG
	K1ELBMq7q204/xXbqmnPIgfZclVVTFOZhL18WzimDQOa7mkMZQT+2KLIYUcmQ+Me
	sxl1SoUYBC48LuqIk4rTY5ACjvUr72pIHoDkwcf6Qj04MzyLuK6zpHfee6RvAj2k
	qn5g2VF4gjC2+nhWwIsqDIywDqKWVyf9HfA==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dpnjyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 07:12:15 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 56I7CCZn006329;
	Fri, 18 Jul 2025 07:12:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 47ugsn143w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 07:12:12 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56I7CC9a006313;
	Fri, 18 Jul 2025 07:12:12 GMT
Received: from cse-cd01-lnx.ap.qualcomm.com (cse-cd01-lnx.qualcomm.com [10.64.75.209])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 56I7CB4r006305
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 07:12:12 +0000
Received: by cse-cd01-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id EEC9220EEE; Fri, 18 Jul 2025 15:12:09 +0800 (CST)
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
        Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Subject: [PATCH v4 0/4] pci: qcom: drop unrelated clock and add link_down reset for sa8775p
Date: Fri, 18 Jul 2025 15:12:03 +0800
Message-Id: <20250718071207.160988-1-ziyue.zhang@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDA1NSBTYWx0ZWRfX+shTJ+F296sO
 bMEqUUxzbseWnGE050Zq15kIrk4/LmziW+FmrneC8/U7Yri5E2zVk1JP2AabF4yZ1yEm9FX7QwF
 OIfTR2r/OCCMuxotCbjXA62aWEY09HtQ5NZEOYCLBHI5mgKPXcui1bXVuZCEV8VB9ArW/ObL86s
 XRq43kPdZRhoSy+Rb5jTVWSE9w4Y3sPUa2XxdkhVFFIIZXgSRqdmqMeLeyzUaWZWLUfOA1ckZUs
 L++Qrj1wIgdmcBQP0wOEr+FhbsGn6PaZKjkUgvp4pQHrwI1wybFgVn54Wvg8sgxpEW8LbnDJhXq
 Y3OWSuv28gTHD++hMz19wipkMyDlAWoCj4cwIhgK9nHdSYs/LQjqk5ytxhE13itcNrHCbsLkwpz
 jVwCESj4hk8m7r9BtEgBS66VnTryguSznP60tSMfQLDCi/6TJqcJGlGj8fxjeU8xENeDLDmQ
X-Proofpoint-GUID: U2UcHfxo6cv8KRxzo4n0HBW0JlWbMhU4
X-Proofpoint-ORIG-GUID: U2UcHfxo6cv8KRxzo4n0HBW0JlWbMhU4
X-Authority-Analysis: v=2.4 cv=Y+r4sgeN c=1 sm=1 tr=0 ts=6879f3cf cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=5rr6ixAOVb5IYiBHoQ4A:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180055

This series drop gcc_aux_clock in pcie phy, the pcie aux clock should 
be gcc_phy_aux_clock. And sa8775p platform support link_down reset in
hardware, so add it for both pcie0 and pcie1 to provide a better user
experience.

Have follwing changes:
  - Update pcie phy bindings for sa8775p.
  - Document link_down reset.
  - Remove aux clock from pcie phy.
  - Add link_down reset for pcie.

Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>

Changes in v4:
- Update phy bindings, and commit msg(Johan)
- Add ABI break commit msg
- Link to v3: https://lore.kernel.org/linux-arm-msm/20250625090048.624399-1-quic_ziyuzhan@quicinc.com/

Changes in v3:
- Update phy bindings, remove phy_aux clock (Johan)
- Update DT binding's description (Johan)
- Link to v2: https://lore.kernel.org/all/20250617021617.2793902-1-quic_ziyuzhan@quicinc.com/

Changes in v2:
- Change link_down reset from optional to mandatory(Konrad)
- Link to v1: https://lore.kernel.org/all/20250529035416.4159963-1-quic_ziyuzhan@quicinc.com/

Ziyue Zhang (4):
  dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Update pcie phy bindings
  dt-bindings: PCI: qcom,pcie-sa8775p: document link_down reset
  arm64: dts: qcom: sa8775p: remove aux clock from pcie phy
  arm64: dts: qcom: sa8775p: add link_down reset for pcie

 .../bindings/pci/qcom,pcie-sa8775p.yaml       | 11 +++--
 .../phy/qcom,sc8280xp-qmp-pcie-phy.yaml       |  5 +--
 arch/arm64/boot/dts/qcom/sa8775p.dtsi         | 42 ++++++++++++-------
 3 files changed, 36 insertions(+), 22 deletions(-)


base-commit: b551c4e2a98a177a06148cf16505643cd2108386
-- 
2.34.1


