Return-Path: <linux-pci+bounces-9299-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C9A918102
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 14:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A81E1C215FA
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 12:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D8117B4F7;
	Wed, 26 Jun 2024 12:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="n0y3RmNr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E60D53B;
	Wed, 26 Jun 2024 12:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719405493; cv=none; b=BWK8I+jedCRvX3R+jTbucXLSERoBhqBvmIGsh1RK5y7KuYlHTpQ/GFmEj5qerHXnB872/7fCbVCIubmao9JMDiXIeiF3pWlGyv7XX+vbsFi7g14hfPCi9vaF8TekPYnesHz95EljaVtSUcSfRLH5E6LbEuRsfe9kuHzhvTBc2nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719405493; c=relaxed/simple;
	bh=QI95BY7P5ffry8E75+8X2Nu1sYmep1coAT3CeCVp23s=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=NZkgpKGc8WqIqzJmbZfl3qOQD4Ir1E4Ph91zgcHKshLvczcXyDyXJduPkNumSXiUnEuFnOWumB8oVcRxlGkHdh705eWqFMmmMjrDvcQLGvbjyiJSkOhJqEn9jtpBaDFRb9QLoTqleApxrR11EhU584abPLP167L/0vIrGpp6t1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=n0y3RmNr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QAfbs6016153;
	Wed, 26 Jun 2024 12:37:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=kVkerdnbW8izeltyxqtyeM
	ddKmGBDmuMuo/iyHHdP+Q=; b=n0y3RmNry4611Bti6RkLag+gbMMiNs8OlgC220
	lICvRRvPs+Pu2JbNpDUMQHW0z6PJ2vSBlAA/EUB54lZ2zmL3CMS3R90pX0vlVLyf
	iWUblRxKUSpAfFMqMh/yhe+sHaXKyJWk0clhwm068Z1cvZv6LB1Q/+vJcrYVOb25
	BTIJI/SzGENHuvW/+UM1pjqzmuZf1o84oeVACA8i1/Fq01fNpDa3U160p9WYxiF2
	3GaJypGCrdG5raQJijsb/w2catqWgeJAOfSQ6B+r2XIoxFgi08RRISdSP7iysUut
	3TKgkeJD/NpH03UifI7r9SBi3qHUTsyzJFW1EVBMLENJ4F9w==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 400gcm8gf4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 12:37:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45QCbu6p011629
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 12:37:56 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 26 Jun 2024 05:37:51 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: [PATCH RFC 0/7] PCI: enable Power and configure the QPS615 PCIe
 switch
Date: Wed, 26 Jun 2024 18:07:48 +0530
Message-ID: <20240626-qps615-v1-0-2ade7bd91e02@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJwLfGYC/12MsQ7CIBRFf6V5sxhAisapiYkf4Go6kAe1bxBaU
 KJp+HcJo+O59+RskFwkl+DcbRBdpkTBVxC7DnA2/uEY2coguVRcS8XWJWnRs8kYjqi5xaOCKi/
 RTfRpoTvcrhcY6zhTeoX4bfEs2vXfyYJxpk4oDtr0zlgc1jchedxjeMJYSvkBNO8cEKMAAAA=
To: Bartosz Golaszewski <brgl@bgdev.pl>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>
CC: <quic_vbadigan@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Krishna chaitanya chundru
	<quic_krichai@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719405471; l=3225;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=QI95BY7P5ffry8E75+8X2Nu1sYmep1coAT3CeCVp23s=;
 b=n3duV+bozAKVlOFbHTuhupYhTAjmgO00d5BPvds8I34A67WeyETwN79dkEgyLaka6u9pMhKyB
 0wRDoTAKP/6D3jQo3Hl5lgVJ7hrXhFVo7nmwnvjdcD78Jq0vKb+NyK+
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MHRd72PLuQDDIqFmg5R2gu56KZJRHT5_
X-Proofpoint-ORIG-GUID: MHRd72PLuQDDIqFmg5R2gu56KZJRHT5_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_07,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 mlxlogscore=601 clxscore=1011 mlxscore=0 phishscore=0 impostorscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406260094

QPS615 is the PCIe switch which has one upstream and three downstream
ports. One of the downstream ports is used as endpoint device of Ethernet
MAC. Other two downstream ports are supposed to connect to external
device. One Host can connect to QPS615 by upstream port.

QPS615 switch power is controlled by the GPIO's. After powering on
the switch will immediately participate in the link training. if the
host is also ready by that time PCIe link will established. 

The QPS615 needs to configured certain parameters like de-emphasis,
disable unused port etc before link is established. These settings
vary from platform to platform.

As the controller starts link training before the probe of pwrctl driver,
the PCIe link may come up before configuring the switch itself.
To avoid this introduce two functions in pci_ops to start_link() &
stop_link() which will disable the link training if the PCIe link is
not up yet.

Now PCI pwrctl device is the child of the pci-pcie bridge, if we want
to enable the suspend resume for pwrctl device there may be issues
since pci bridge will try to access some registers in the config which
may cause timeouts or Un clocked access as the power can be removed in
the suspend of pwrctl driver.

To solve this make PCIe controller as parent to the pci pwr ctrl driver
and create devlink between host bridge and pci pwrctl driver so that
pci pwrctl driver will go suspend only after all the PCIe devices went
to suspend.

In pci pwrctl driver use stop_link() to keep the link in D3cold and
start_link() to bring back link to D0.

This series is developed on top the series:
https://lore.kernel.org/lkml/20240612082019.19161-1-brgl@bgdev.pl/

we are sending this series to get coments on the usage of stop_link
and start_link which is being add in this series.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
Krishna chaitanya chundru (7):
      dt: bindings: add qcom,qps615.yaml
      arm64: dts: qcom: qcs6490-rb3gen2: Add qps615 node
      pci: Change the parent of the platform devices for child OF nodes
      pci: Add new start_link() & stop_link function ops
      pci: dwc: Add support for new pci function op
      pci: qcom: Add support for start_link() & stop_link()
      pci: pwrctl: Add power control driver for qps615

 .../devicetree/bindings/pci/qcom,qps615.yaml       |  73 ++++++
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts       |  55 ++++
 drivers/pci/bus.c                                  |   5 +-
 drivers/pci/controller/dwc/pcie-designware-host.c  |  19 ++
 drivers/pci/controller/dwc/pcie-qcom.c             | 108 +++++++-
 drivers/pci/pwrctl/Kconfig                         |   7 +
 drivers/pci/pwrctl/Makefile                        |   1 +
 drivers/pci/pwrctl/core.c                          |   7 +-
 drivers/pci/pwrctl/pci-pwrctl-qps615.c             | 278 +++++++++++++++++++++
 include/linux/pci.h                                |   2 +
 10 files changed, 541 insertions(+), 14 deletions(-)
---
base-commit: d737627471e5b3962eedae870aa0475d6c9bba18
change-id: 20240624-qps615-faa0cc60dc74

Best regards,
-- 
Krishna chaitanya chundru <quic_krichai@quicinc.com>


