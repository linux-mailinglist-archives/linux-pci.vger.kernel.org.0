Return-Path: <linux-pci+bounces-11225-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 170A3946721
	for <lists+linux-pci@lfdr.de>; Sat,  3 Aug 2024 05:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B7A81C20C4F
	for <lists+linux-pci@lfdr.de>; Sat,  3 Aug 2024 03:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13923C8DF;
	Sat,  3 Aug 2024 03:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mgLaT2zj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786111755C;
	Sat,  3 Aug 2024 03:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722655884; cv=none; b=Kygn2giogQwP6hikkxAnjX3x1k+EMwZtimw9bhhZuhENSM5PcJLzofR7hRaE45GNqVcVtr+kzVPGVxjHpkxgQdpxvZ7DEfDYPC6+NW3fWHibFly8zDxRQND9Iwpp7JJcI7IOroAMUnpl7WqdkrkU6C64r5U1nwHddoB5wYE4iaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722655884; c=relaxed/simple;
	bh=6cavA9XLKIM3BgR3NHEgRZLrQUpWWMHMmofpuijT6oo=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=FM2PoJ+gsXNUF5j9/eT61f6+eR4dQ8jRPzdOnaKFqZvMOaH4YAzCrJ37P22L/Iet7wRczoaAjWDjjDi7Suoq8kKofOJvZfZ4USDNId2G7rlY6dx23JMQ3KBSetd5HtYA5yjYaXOOqDsQyo0Qn8gnlb5VRB6Elf9oQcVe2mRs7jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mgLaT2zj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4733A2ZV000415;
	Sat, 3 Aug 2024 03:23:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=a61VFykzxYtyzwTkkcjkY4
	+QWZ7S28D3PmagGAlSBRk=; b=mgLaT2zjv5kDZVRlVtfV8QKrNGVoLgKMQxbGuv
	rZRIhA8mfWRRIrGIg0epddFd3AfOcrKGLv7ijdZ5mNOx8AU8NwZMao8+xqsqKhwP
	DGf1r+lBnKgfmDGH6sxgyqGGVI8KF1tGyqoUZG+jnSP9gLTu/xgdRptiYj8n3WjY
	kTkjurUGGFW1foezrHTdZroXytg5SIri5klNIHMn5ppi39SQJKFCN9TuKas31LOq
	ZhpqBUoRROJ7VfSBHipoEB30s1KSw0f2jKiBomCIoS7vdYN+g5/CD1xJMP6FOVlb
	moLiau5mf38oHg2qry6271/xSRaG2nuAj0k5OXTN5bGdqHew==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40sbgrr21n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 03 Aug 2024 03:23:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4733N5DN018288
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 3 Aug 2024 03:23:05 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 2 Aug 2024 20:23:00 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: [PATCH v2 0/8] PCI: Enable Power and configure the QPS615 PCIe
 switch
Date: Sat, 3 Aug 2024 08:52:46 +0530
Message-ID: <20240803-qps615-v2-0-9560b7c71369@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIairWYC/2XMQQ6CMBCF4auQWVtTBizFlfcwLLCdyiws0GqjI
 b27la3L/+Xl2yBSYIpwrjYIlDjy7EvgoQIzjf5Ogm1pQImt7LAT6xJVfRKEum/HRttGOSjnJZD
 j9w5dh9ITx+ccPrub8Lf+EQmFFNrc6t4q54p2WV9s2JujmR8w5Jy/AlE/iZ4AAAA=
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        "Bartosz
 Golaszewski" <brgl@bgdev.pl>,
        Jingoo Han <jingoohan1@gmail.com>,
        "Manivannan
 Sadhasivam" <manivannan.sadhasivam@linaro.org>
CC: <andersson@kernel.org>, <quic_vbadigan@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Bartosz
 Golaszewski" <bartosz.golaszewski@linaro.org>,
        Krishna chaitanya chundru
	<quic_krichai@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722655379; l=3676;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=6cavA9XLKIM3BgR3NHEgRZLrQUpWWMHMmofpuijT6oo=;
 b=/YzAIHJt439+4CTndqI64GLKUe1QJ+fWY+Q+exNah01wKp0y01ATu4qVq+WeA0K4HW1fifxxT
 BJwqwNcrHdGDGVWP5P8e6RtD+ucGDK8zx+1MibGYfErDaUNZuOgFfW5
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Y_v6DKcPIHw1qvNbDN5vkrATq5p704Ui
X-Proofpoint-GUID: Y_v6DKcPIHw1qvNbDN5vkrATq5p704Ui
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_20,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 suspectscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408030020

QPS615 is the PCIe switch which has one upstream and three downstream
ports. One of the downstream ports is used as endpoint device of Ethernet
MAC. Other two downstream ports are supposed to connect to external
device. One Host can connect to QPS615 by upstream port.

QPS615 switch power is controlled by the GPIO's. After powering on
the switch will immediately participate in the link training. if the
host is also ready by that time PCIe link will established. 

The QPS615 needs to configured certain parameters like de-emphasis,
disable unused port etc before link is established.

The device tree properties are parsed per node under pci-pci bridge in the
devicetree. Each node has unique bdf value in the reg property, driver
uses this bdf to differentiate ports, as there are certain i2c writes to
select particulat port.
 
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

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
Changes in V1:
- Fix the code as per the comments given.
- Removed D3cold D0 sequence in suspend resume for now as it needs
  seperate discussion.
- change to dt approach for configuring the switch instead of request_firmware() approach
- Link to v1: https://lore.kernel.org/linux-pci/20240626-qps615-v1-4-2ade7bd91e02@quicinc.com/T/
---

---
Krishna chaitanya chundru (8):
      dt-bindings: PCI: Add binding for qps615
      dt-bindings: trivial-devices: Add qcom,qps615
      arm64: dts: qcom: qcs6490-rb3gen2: Add node for qps615
      PCI: Change the parent to correctly represent pcie hierarchy
      PCI: Add new start_link() & stop_link function ops
      PCI: dwc: Add support for new pci function op
      PCI: qcom: Add support for host_stop_link() & host_start_link()
      PCI: pwrctl: Add power control driver for qps615

 .../devicetree/bindings/pci/qcom,qps615.yaml       | 191 ++++++
 .../devicetree/bindings/trivial-devices.yaml       |   2 +
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts       | 121 ++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |   2 +-
 drivers/pci/bus.c                                  |   3 +-
 drivers/pci/controller/dwc/pcie-designware-host.c  |  18 +
 drivers/pci/controller/dwc/pcie-designware.h       |  16 +
 drivers/pci/controller/dwc/pcie-qcom.c             |  39 ++
 drivers/pci/pwrctl/Kconfig                         |   7 +
 drivers/pci/pwrctl/Makefile                        |   1 +
 drivers/pci/pwrctl/core.c                          |   9 +-
 drivers/pci/pwrctl/pci-pwrctl-qps615.c             | 638 +++++++++++++++++++++
 include/linux/pci.h                                |   2 +
 13 files changed, 1046 insertions(+), 3 deletions(-)
---
base-commit: 1722389b0d863056d78287a120a1d6cadb8d4f7b
change-id: 20240727-qps615-e2894a38d36f

Best regards,
-- 
Krishna chaitanya chundru <quic_krichai@quicinc.com>


