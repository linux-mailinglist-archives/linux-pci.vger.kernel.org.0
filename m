Return-Path: <linux-pci+bounces-16548-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 832E39C5B3F
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 16:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43FBB281511
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 15:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D098F20010C;
	Tue, 12 Nov 2024 15:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ran5wv6z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF17156F5E;
	Tue, 12 Nov 2024 15:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731423730; cv=none; b=n0HNMyQLmC6FwvX7+urr83/clyv7QfIswWR8DNvt8L1yirTMdW7wsa2JJS97wJCg0Kdf1q8GvgH/vzM8x0TbEE6wibgMMMn+Zq372VBciUvBhh6E2+cyFk4Z6ZxihSi9KEkRZwzNqlBmRwKtSunxmMMrc2RJcy9OnXSFyke+y+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731423730; c=relaxed/simple;
	bh=XicoZdgnxqoa6iyD0Wx1G4v2zeKKeMj5rBKvOrY16Lg=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=b1qvwkt2jxMmmAwyMJH5cdWaiQA9rT8thHAmccG6K4ot2G10cCyuiXxaHLOjLy5FDeFmQ329EFPqkNOF6U1pd+XL8OAute8Yy4g89CUIgTmzVyr1fHWA69d7mn7f8ei0ZpvYc4NoNcZWpC7yyTZYOtPKafrblL8Ri0VXKAwo+vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ran5wv6z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACD4D99032436;
	Tue, 12 Nov 2024 15:01:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=AscinKziCCkdyt6iqdRGcy
	PxQork5Edfm3oore+GAh0=; b=Ran5wv6zz9FTMWwV3YEbTHDE8I0pjl904wZZe6
	wNFUQPNgx8j69hGsAbgUgsnPxHN66Q8xbtLMSim0KJadqEZaZJIne4XCKT5gmaqo
	DsMDNm1CLoK4+7NJN2hXRPo1Re0Egu2EZeaxjBUJ2C2E+mlecoLgaUTaiGAW2WxI
	J/a9OsoiLq7keIjOlwAbVWwiu4MgFMdUWpecVkT+eAvwc3y3Ip7QxU2kYXSUGB2O
	iLvMK6fJLlZAxtCvoHWuvLC1qfbc336UPkG5gLi3gbwWQvuATIFFvbneYpyISlZw
	Ca0jrGb1jLppE3vb+K7VJGC/rLYYJf5/mf1lks48kCQpHqYw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42sxpqfpyq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 15:01:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ACF1uEm001241
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 15:01:56 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 12 Nov 2024 07:01:51 -0800
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: [PATCH v3 0/6] PCI: Enable Power and configure the QPS615 PCIe
 switch
Date: Tue, 12 Nov 2024 20:31:32 +0530
Message-ID: <20241112-qps615_pwr-v3-0-29a1e98aa2b0@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMxtM2cC/1WMyw6CMBBFf8XM2ppOB1riyv8wxmApMgt5tFo1h
 H+3kBjl7s5NzhkhOM8uwH4zgneRA3dtAtpuwDZle3WCq8SgpMpQKiWGPmjMz/3Ti6KigkytsXQ
 WktB7V/NriR1PiRsO986/l3bE+f1m6D8TUUhhdVUqbVBj5g7Dgy23dme7G8yhSD85bSVTkg3aC
 xUZ5dKYtTxN0wep0g4M4wAAAA==
To: <andersson@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        "Lorenzo
 Pieralisi" <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "Rob Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        Jingoo Han <jingoohan1@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>
CC: <quic_vbadigan@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Krishna chaitanya chundru
	<quic_krichai@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731423711; l=4593;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=XicoZdgnxqoa6iyD0Wx1G4v2zeKKeMj5rBKvOrY16Lg=;
 b=YOezNxp+95XHinCFyeVwFtWcKZvnqwL+WvfWIH6vHOzLCqNBYbd9Ft6yifcw+3xBVe/GY1hqb
 SH34m+Kdu5SCwVYe50sU2RkI3FERDhLL3ih2H82Sdo06WXz4ILO/Rv1
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0tF1UD8sOiWZou-0PsFIalsMY6DAK4dZ
X-Proofpoint-ORIG-GUID: 0tF1UD8sOiWZou-0PsFIalsMY6DAK4dZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 impostorscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411120121

QPS615 is the PCIe switch which has one upstream and three downstream
ports. To one of the downstream ports ethernet MAC is connected as endpoint
device. Other two downstream ports are supposed to connect to external
device. One Host can connect to QPS615 by upstream port.

QPS615 switch power is controlled by the GPIO's. After powering on
the switch will immediately participate in the link training. if the
host is also ready by that time PCIe link will established. 

The QPS615 needs to configured certain parameters like de-emphasis,
disable unused port etc before link is established.

As the controller starts link training before the probe of pwrctl driver,
the PCIe link may come up as soon as we power on the switch. Due to this
configuring the switch itself through i2c will not have any effect as
this configuration needs to done before link training. To avoid this
introduce two functions in pci_ops to start_link() & stop_link() which
will disable the link training if the PCIe link is not up yet.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
Changes in v2:
- As per offline discussions with rob i2c-parent is best suitable to
  use i2c client device. So use i2c-parent as suggested and remove i2c
  client node reference from the dt-bindings & devicetree.
- Remove "PCI: Change the parent to correctly represent pcie hierarchy"
  as this requires seperate discussions.
- Remove bdf logic to identify the dsp's and usp's to make it generic
  by using the logic that downstream devices will always child of
  upstream node and dsp1, dsp2 will always in same order (dmitry)
- Remove recursive function for parsing devicetree instead parse
  only for required devicetree nodes (dmitry)
- Fix the issue in be & le conversion (dmitry).
- Call put_device for i2c device once done with the usage (dmitry)
- Use $defs to describe common properties between upstream port and
  downstream properties. and remove unneccessary if then. (Krzysztof)
- Place the qcom,qps615 compatibility in dt-binding document in alphabatic order (Krzysztof)
- Rename qcom,no-dfe to describe it as hardware capability and change
  qcom,nfts description to reflect hardware details (Krzysztof)
- Fix the indentation in the example in dt binding (dmitry)
- Add more description to qcom,nfts (dmitry)
- Remove nanosec from the property description (dmitry)
- Link to v2: https://lore.kernel.org/r/linux-arm-msm/20240803-qps615-v2-0-9560b7c71369@quicinc.com/T/
Changes in v1:
- Instead of referencing whole i2c-bus add i2c-client node and reference it (Dmitry)
- Change the regulator's as per the schematics as per offline review
(bjorn Andresson)
- Remove additional host check in bus.c (Bart)
- For stop_link op change return type from int to void (Bart)
- Remove firmware based approach for configuring sequence as suggested
by multiple reviewers.
- Introduce new dt-properties for the switch to configure the switch
as we are replacing the firmware based approach.
- The downstream ports add properties in the child nodes which will
represented in PCIe hierarchy format.
- Removed D3cold D0 sequence in suspend resume for now as it needs
separate discussion.
- Link to v1: https://lore.kernel.org/linux-pci/20240626-qps615-v1-4-2ade7bd91e02@quicinc.com/T/

---
Krishna chaitanya chundru (6):
      dt-bindings: PCI: Add binding for qps615
      arm64: dts: qcom: qcs6490-rb3gen2: Add node for qps615
      PCI: Add new start_link() & stop_link function ops
      PCI: dwc: Add support for new pci function op
      PCI: qcom: Add support for host_stop_link() & host_start_link()
      PCI: pwrctl: Add power control driver for qps615

 .../devicetree/bindings/pci/qcom,qps615.yaml       | 205 +++++++
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts       | 115 ++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |   2 +-
 drivers/pci/controller/dwc/pcie-designware-host.c  |  18 +
 drivers/pci/controller/dwc/pcie-designware.h       |  16 +
 drivers/pci/controller/dwc/pcie-qcom.c             |  39 ++
 drivers/pci/pwrctl/Kconfig                         |   8 +
 drivers/pci/pwrctl/Makefile                        |   1 +
 drivers/pci/pwrctl/pci-pwrctl-qps615.c             | 630 +++++++++++++++++++++
 include/linux/pci.h                                |   2 +
 10 files changed, 1035 insertions(+), 1 deletion(-)
---
base-commit: ae43de0875223d271eb6004cfb08be697520f55c
change-id: 20241022-qps615_pwr-8d3837f61aec

Best regards,
-- 
Krishna chaitanya chundru <quic_krichai@quicinc.com>


