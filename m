Return-Path: <linux-pci+bounces-25699-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90757A86A27
	for <lists+linux-pci@lfdr.de>; Sat, 12 Apr 2025 03:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5015B7B8231
	for <lists+linux-pci@lfdr.de>; Sat, 12 Apr 2025 01:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303CD137C2A;
	Sat, 12 Apr 2025 01:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pZHKPAf4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30AF17BA1
	for <linux-pci@vger.kernel.org>; Sat, 12 Apr 2025 01:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744422618; cv=none; b=nGQc/Qp6uk6M7B/NHb5cdtHqZQY3z/UfowHQcVe7FD5Q33fLNP+U93L4GFVF1hjzQgwMwHct9X7PMASy7b9cYPc7wEhJCldhVXKkMqwXot19KROuswqwMubAAXN6aYcO4spkBKF+RcTPeuZyI1IQGf5ZFbqIvBYbPnN1kSTeDLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744422618; c=relaxed/simple;
	bh=F06wMmbFxYTFemBMbMgSeaaJoLcDhLClB7vdxd897/M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=V+rG1KHNPww0mKemNQv5EMqhCne8knNxBcvQJbNFwlfVPXsGIs6fvxpAlktC9mnvAUUCazQkDKU4Uo3s1NjUAhTWRbstzoAJqcP/dGifUZU5+3TSYyd+IRptpmrHbcZCeh1GVMsjTRlKf785jGEsgzFGO6nQuKNT7WMFpb+GIXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pZHKPAf4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BGhrnl016309
	for <linux-pci@vger.kernel.org>; Sat, 12 Apr 2025 01:50:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=mBOUL7Ly7wIjBrc+0VGX6O
	dRX/g3i7R7so4TJrQCsRI=; b=pZHKPAf41azqh0bN43S7px21vdJYK1vvRfLnNk
	O0G6sPUD6zy4gF1bfs83E6d8gBnDyGZYZO4/+leHxSRsFF1cNOmea+OOLwa6Y8vI
	uF1xcjcshxsRXTNEwZLMYT938NnHr+WiQFxhXrmQDxXp8OZKsevyiofeT7MspYOf
	LFV+GvbqvOrKuuApknGKWdkz397hjr3hUsqt9to0ZkULOoWGwJ/6szrUKTqkx5jW
	ldqtKNlV33QzWZBGMsVqBTLBj1/hid9wn98lthqPSNOnvY1mbIuvrRZMjOBntFr0
	KV5wQOUjr4IyrY1NntzVv6AXIRL9jDfekQR9zu/+ZapSFBag==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twc1uv0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 12 Apr 2025 01:50:13 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-af2f03fcc95so2736447a12.1
        for <linux-pci@vger.kernel.org>; Fri, 11 Apr 2025 18:50:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744422612; x=1745027412;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mBOUL7Ly7wIjBrc+0VGX6OdRX/g3i7R7so4TJrQCsRI=;
        b=QwLM0T7TjQWpnXjefRwF7evJAT7omHqyli8pNGHW41CYgh/UkfUU67oSWFj8WwqGSn
         /IyGPcwTru3pE/iNpOPR9gxmHTgjoMhO2pdw2FS8r/8LkKE6cbYfReX9TN+tf/aCvIrh
         rdyz+zhfCf0Ty9wGMx70P10L1kxE6MkUiRtl6kxXnX9QhiHCYfeJvgwPlh1I0cu7V9Mt
         glMMnidFigjotHQDtWJlfhaodkcL1meczOFXKksI34mUe8fyAbuFL+m6KC8XmBZAC8xM
         HJixc5ZO60db01sKm+YN4wtpaonJHweCXjZv8PagtZpI3NzLmOsdW2VeBenGRJGsJfWL
         4Z2A==
X-Forwarded-Encrypted: i=1; AJvYcCU/BF/ENoN4N5l6HCAvkkLCjwjCYxmBUh7j5wyYx/4d8l1n4YgsPkvvdESAXnMYqtOXDzhscaK5eLk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjfh2kEDzW+5A410GL5SDrAVc4/ZiBJepVYsFzpVuv4vEceQth
	4zD0jhovg7qFvJPVNHy+NBRoHfNACkD6khmVi8DPsaqtrmlCCcvYin+2YI6GcZ72aXDasysL9s/
	lspZWMSdfgqptcuCZapvw65q+7PI2afm93GbPd4Gq38Z+SQ7xUUO06fMsdNk=
X-Gm-Gg: ASbGnct4OdFT8hrdBeHvZHQJa7ZIL3WhnFEe3/D13KwufrDuC1yuxDTLBobhA1i1e9r
	qWNHFDlVeyMPLvNzp8tvYPFLtf5Z27k5Cxuhw+eQiF4VaCLMbP/P6pDFhlisz4jyP7nng1yjsVf
	6llirWCyJNNi2ZzwYJdEOyjMl16ywCNbiFb6ktIDfJ2txVqYXdIVR99n4f4s/lblsI/N8KzKTCK
	qkSUeB7ArVj43VkCXlqw4raimxKAEb1iSMnzxJTeRgnd4OhMQiOJzOxJ5vY+a5v1M/AFl63bWJj
	szBRYTnPkO7qpxMn+dHUekvcrfHS32MB/sQ6c5GMWpEHV2M=
X-Received: by 2002:a05:6a20:2d29:b0:1f5:8a1d:3905 with SMTP id adf61e73a8af0-2017978a7acmr8016815637.7.1744422612036;
        Fri, 11 Apr 2025 18:50:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEckR8nN7DenrRPoT3+S6q9TDZrwtYFdy7HnDpeVsCcrl4ONSwFiRFNB9bkSFnSeZR3ujRlhg==
X-Received: by 2002:a05:6a20:2d29:b0:1f5:8a1d:3905 with SMTP id adf61e73a8af0-2017978a7acmr8016771637.7.1744422611478;
        Fri, 11 Apr 2025 18:50:11 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a3221832sm5516825a12.70.2025.04.11.18.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 18:50:10 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v5 0/9] PCI: Enable Power and configure the TC9563 PCIe
 switch
Date: Sat, 12 Apr 2025 07:19:49 +0530
Message-Id: <20250412-qps615_v4_1-v5-0-5b6a06132fec@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL3G+WcC/2WM0Q6CIBhGX6VxHQ5+Bamr3qM5hwLJlqJQrOZ89
 9DWRfPm2863nTOjoL3VAZ0PM/I62mDdkIAdD6jt5HDT2KrECAgwAhTwNAZOWR2LmmIjNAcjKS0
 FR8kYvTb2tdWuVeLOhofz7y0ei/X9dfhfJxaYYFpqUIqdoAF5cSFk01PeW9f3WZq1/lWB7VVNB
 M9zWTbKiL1aLcvyAeTNUSvoAAAA
X-Change-ID: 20250212-qps615_v4_1-f8e62fa11786
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        chaitanya chundru <quic_krichai@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: quic_vbadigan@quicnic.com, amitk@kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, jorge.ramirez@oss.qualcomm.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744422605; l=7519;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=F06wMmbFxYTFemBMbMgSeaaJoLcDhLClB7vdxd897/M=;
 b=w2stRzO7LQ6HEC1BoUxL3ivndaPMdPB/moDlULcOmxKM2KVbaEN9L2LPDRim2ZYq4EIIjUSkh
 mgr8Yqf0nH8Dj+dI6byhMI71mNK1/Eiht8lC5rdDvBV65zpiGdPbwTa
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: s_ZqUZN4L9IDeC6KtttCw4JJ6ATnA8uk
X-Authority-Analysis: v=2.4 cv=KtdN2XWN c=1 sm=1 tr=0 ts=67f9c6d5 cx=c_pps a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=ECfEpi3OZSfKmhroNToA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: s_ZqUZN4L9IDeC6KtttCw4JJ6ATnA8uk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-12_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504120011

TC9563 is the PCIe switch which has one upstream and three downstream
ports. To one of the downstream ports ethernet MAC is connected as endpoint
device. Other two downstream ports are supposed to connect to external
device. One Host can connect to TC956x by upstream port.

TC9563 switch power is controlled by the GPIO's. After powering on
the switch will immediately participate in the link training. if the
host is also ready by that time PCIe link will established. 

The TC9563 needs to configured certain parameters like de-emphasis,
disable unused port etc before link is established.

As the controller starts link training before the probe of pwrctl driver,
the PCIe link may come up as soon as we power on the switch. Due to this
configuring the switch itself through i2c will not have any effect as
this configuration needs to done before link training. To avoid this
introduce two functions in pci_ops to start_link() & stop_link() which
will disable the link training if the PCIe link is not up yet.

This series depends on the https://lore.kernel.org/all/20250124101038.3871768-3-krishna.chundru@oss.qualcomm.com/

Note: The QPS615 PCIe switch is rebranded version of Toshiba switch TC9563 series.
There is no difference between both the switches, both has two open downstream ports
and one embedded downstream port to which Ethernet MAC is connected. As QPS615 is the
rebranded version of Toshiba switch rename qps615 with tc956x so that this driver
can be leveraged by all who are using Toshiba switch.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Changes from v4:
- Rename tc956x to tc9563, instead of using x which represents overlay board one
  use actual name (Konrad & Krzysztof).
- Remove the patches 9 & 10 from the series and this will be added by mani
- Couple of nits by Konrad
- Have defconfig change for TC956X by Dmitry
- Change the function name pcie_is_link_active to pcie_link_is_active
  replace all call sites of pciehp_check_link_active() with a call
  to the new function. return bool instead of int (Lukas)
- Add pincntrl property for reset gpio (Dmitry)
- Follow the example-schema order, remove ref for the
  tx-amplitude-microvolt, change the vendor prefix (Krzysztof)
- for USP node refer pci-bus-common.yaml and for remaining refer
  pci-pci-bridge.yaml(Mani)
- rebase to latest code and change pci dev retrieval logic due code
  changes in the latest tip.
- Link to v4: https://lore.kernel.org/r/20250225-qps615_v4_1-v4-0-e08633a7bdf8@oss.qualcomm.com
changes from v3:
- move common properties like l0s-delay, l1-delay and nfts to pci-host-common.yaml (bjorn H)
- remove axi-clk-frequency property (Krzysztof)
- Update the pattern properties (Rob)
- use pci-pci-bridge as the reference (Rob)
- change tx-amplitude-millivolt to tx-amplitude-microvolt  (Krzysztof)
- rename qps615_pwrctl_power_on to qps615_pwrctl_bring_up (Bart)
- move the checks for l0s_delay, l1_delay etc to helper functon to
  reduce a level of indentation (Bjorn H)
- move platform_set_drvdata to end after there is no error return (bjorn H)
- Replace GPIOD_ASIS to GPIOD_OUT_HIGH (Mani)
- Create a common api to check if link is up or not and use that to call
  stop_link() and start_link().
- couple of nits in comments, names etc from everyone
Link to v3: https://lore.kernel.org/all/20241112-qps615_pwr-v3-3-29a1e98aa2b0@quicinc.com/T/
Changes from v2:
- As per offline discussions with rob i2c-parent is best suitable to
  use i2c client device. So use i2c-parent as suggested and remove i2c
  client node reference from the dt-bindings & devicetree.
- Remove "PCI: Change the parent to correctly represent pcie hierarchy"
  as this requires seperate discussions.
- Remove bdf logic to identify the dsp's and usp's to make it generic
  by using the logic that downstream devices will always child of
  upstream node and dsp1, dsp2 will always in same order (Dmitry)
- Remove recursive function for parsing devicetree instead parse
  only for required devicetree nodes (Dmitry)
- Fix the issue in be & le conversion (Dmitry).
- Call put_device for i2c device once done with the usage (Dmitry)
- Use $defs to describe common properties between upstream port and
  downstream properties. and remove unneccessary if then. (Krzysztof)
- Place the qcom,qps615 compatibility in dt-binding document in alphabatic order (Krzysztof)
- Rename qcom,no-dfe to describe it as hardware capability and change
  qcom,nfts description to reflect hardware details (Krzysztof)
- Fix the indentation in the example in dt binding (Dmitry)
- Add more description to qcom,nfts (Dmitry)
- Remove nanosec from the property description (Dmitry)
- Link to v2: https://lore.kernel.org/r/linux-arm-msm/20240803-qps615-v2-0-9560b7c71369@quicinc.com/T/
Changes from v1:
- Instead of referencing whole i2c-bus add i2c-client node and reference it (Dmitry)
- Change the regulator's as per the schematics as per offline review
(Bjorn Andresson)
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
Krishna Chaitanya Chundru (9):
      dt-bindings: PCI: Add binding for Toshiba TC9563 PCIe switch
      arm64: dts: qcom: qcs6490-rb3gen2: Add TC9563 PCIe switch node
      PCI: Add new start_link() & stop_link function ops
      PCI: dwc: Add host_start_link() & host_start_link() hooks for dwc glue drivers
      PCI: dwc: Implement .start_link(), .stop_link() hooks
      PCI: qcom: Add support for host_stop_link() & host_start_link()
      PCI: PCI: Add pcie_link_is_active() to determine if the PCIe link is active
      PCI: pwrctrl: Add power control driver for tc9563
      arm64: defconfig: Enable TC9563 PWRCTL driver

 .../devicetree/bindings/pci/toshiba,tc9563.yaml    | 178 ++++++
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts       | 129 +++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |   2 +-
 arch/arm64/configs/defconfig                       |   1 +
 drivers/pci/controller/dwc/pcie-designware-host.c  |  18 +
 drivers/pci/controller/dwc/pcie-designware.h       |  16 +
 drivers/pci/controller/dwc/pcie-qcom.c             |  35 ++
 drivers/pci/hotplug/pciehp.h                       |   1 -
 drivers/pci/hotplug/pciehp_ctrl.c                  |   7 +-
 drivers/pci/hotplug/pciehp_hpc.c                   |  33 +-
 drivers/pci/pci.c                                  |  26 +-
 drivers/pci/pwrctrl/Kconfig                        |  10 +
 drivers/pci/pwrctrl/Makefile                       |   2 +
 drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c           | 628 +++++++++++++++++++++
 include/linux/pci.h                                |   6 +
 15 files changed, 1054 insertions(+), 38 deletions(-)
---
base-commit: f4d2ef48250ad057e4f00087967b5ff366da9f39
change-id: 20250212-qps615_v4_1-f8e62fa11786

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


