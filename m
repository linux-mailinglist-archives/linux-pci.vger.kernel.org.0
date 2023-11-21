Return-Path: <linux-pci+bounces-37-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D81487F3127
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 15:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BA0F283ABE
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 14:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28108537F3;
	Tue, 21 Nov 2023 14:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="chhj/PlS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7731D100;
	Tue, 21 Nov 2023 06:38:27 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALE3gaY004535;
	Tue, 21 Nov 2023 14:38:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=mLnCKVrXSlRYitkedk8Eh52xMNVsJdK+ymgSHUEUf0E=;
 b=chhj/PlS/FcfM7vs2UQDdgeq6agBFFPKvDZuD13npsGg3Ix2h1er9WPAnwcJk+anQWhF
 sKrJ/vGOMkdOUM0L8x3eWfn/RBUdU0eGXsmc7T36dLj82L/K1OFxnzrXXPYy64lxWW46
 2JKa5EgKfKW1q1bjWSLINszmzzL99TPMWTMEyoohnYolAjQbLdIb94X97vjgtyTfkmhb
 ZOestpGWSc2SWMqQT5nscoXqT18M00EhbgyZGFi8Pn+6rWlxdBMPDIaBMQI3Kb5SH1Qs
 2gRdANdNe4ti2rwmCUfJgsBXjBV9B6DdlrQrv81a1lKJYwjacdNTJE8tAkiKf6JPIP3z 4A== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ugcqs2u1e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Nov 2023 14:38:19 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3ALEcGYx006070;
	Tue, 21 Nov 2023 14:38:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3uepbke7pp-1;
	Tue, 21 Nov 2023 14:38:16 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ALEcGmF006065;
	Tue, 21 Nov 2023 14:38:16 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3ALEcFP4006064;
	Tue, 21 Nov 2023 14:38:16 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
	id 9DEEE4C8C; Tue, 21 Nov 2023 20:08:14 +0530 (+0530)
From: Mrinmay Sarkar <quic_msarkar@quicinc.com>
To: agross@kernel.org, andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, konrad.dybcio@linaro.org, mani@kernel.org,
        robh+dt@kernel.org
Cc: quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        dmitry.baryshkov@linaro.org, robh@kernel.org, quic_krichai@quicinc.com,
        quic_vbadigan@quicinc.com, quic_parass@quicinc.com,
        quic_schintav@quicinc.com, quic_shijjose@quicinc.com,
        Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v4 0/3] arm64: qcom: sa8775p: add cache coherency support for SA8775P
Date: Tue, 21 Nov 2023 20:08:10 +0530
Message-Id: <1700577493-18538-1-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: hucPD2BD1A0sKVbOd06dDvDBg8XxajXj
X-Proofpoint-GUID: hucPD2BD1A0sKVbOd06dDvDBg8XxajXj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_07,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1015 mlxlogscore=333
 mlxscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311210114

In a multiprocessor system cache snooping maintains the consistency
of caches. Snooping logic is disabled from HW on this platform.
Cache coherency doesn’t work without enabling this logic.

This series is to enable cache snooping logic in both RC and EP
driver and add the "dma-coherent" property in dtsi to support
cache coherency in 8775 platform.

To verify this series we required [1]

[1] https://lore.kernel.org/all/1699669982-7691-1-git-send-email-quic_msarkar@quicinc.com/

v3 -> v4:
- added new cfg(cfg_1_34_0) for SA8775P in both RC and EP driver.
- populated a flag in the data structures instead of doing
  of_device_is_compatible() in both RC and EP patch.
- update commit mesaage and added reveiwed-by tag in commit message
  in dtsi patch.

v2 -> v3:
- update commit message(8755 -> 8775).

v1 -> v2:
- update cover letter with explanation.
- define each of these bits and ORing at usage time rather than
  directly writing value in register.

Mrinmay Sarkar (3):
  PCI: qcom: Enable cache coherency for SA8775P RC platform
  PCI: qcom-ep: Enable cache coherency for SA8775P EP
  arm64: dts: qcom: sa8775p: Mark PCIe EP controller as cache coherent

 arch/arm64/boot/dts/qcom/sa8775p.dtsi     |  1 +
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 23 ++++++++++++++++++++++-
 drivers/pci/controller/dwc/pcie-qcom.c    | 20 +++++++++++++++++++-
 3 files changed, 42 insertions(+), 2 deletions(-)

-- 
2.7.4


