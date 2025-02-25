Return-Path: <linux-pci+bounces-22328-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27565A43E0B
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 12:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 331BA16EA40
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 11:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4F82627FC;
	Tue, 25 Feb 2025 11:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LLrGEkgz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFCB1E7C0A
	for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 11:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740483943; cv=none; b=fzzkG1bfiGwVzzbKZoGIMFbPyOEuWwB3clfsyGbbxQDq5vxVotosHuRjJTfxvM8+mERqKGonb+SrW5n6mzs0dxqYbt52WKclfjKwvbItX9XhVE0ZWDlYOFPwevmMZKKn4nOPTn1J6kjDv4gFUQ33x39kcu3WVkELfSzgvg6Roqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740483943; c=relaxed/simple;
	bh=DWkFzyUNSroNJbrok6V9w/pFXCdIMs59dYxdSxifuTU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YyNwyJ3+N4852D3nslS9D1VmIN/tQhE/GljEuXFxV3/J8MVDonDJ/PgcQfxcXwI410JevVFvXUJSuE7Y2MN388zVbJToyu0x3PGDESvkyMlvD8CSgbTqVv8q6o8huiFDdPmCBR23q8EWBg4gpf3l5TgYEG1La7hfq3y1ij3un9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LLrGEkgz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P7hKmw012817
	for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 11:45:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=TW/r5bOMKQEdl/fm5iKEjy
	IL+RUW8fkuKadv/ulCZKw=; b=LLrGEkgzQfqghVs/1rD/PQxocAEg15oonSF8U/
	7ZweznkhQwOkIqWl186VCLXjYITvBRQLonf3JaFniGhnIGxp1XBR/Fb6kjpmqqVW
	xbja/hkjRdEVtTm7VZK3PQUNbSI8IK7WMOw2krqz9a5PfDPQ8m2gUWNb/0hSyFrn
	9mAJRE1rhGQciUU9qqacgBTocSizs45BTodYVvUMo0szC24cmO/LoxnCmgzfxGwL
	0cB2BuAFlW4GMR9uCqYxHqOqotyB9DFh5PHoGue1jMp5hAL6q0fmXPY4auyBYkSm
	63AqJE3uItmuLbNPbQMUBLzCfZFGFYXHTEKGtKo5zrZKvu6w==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44y65y0qc4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 11:45:39 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2fce2954a10so15666767a91.1
        for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 03:45:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740483939; x=1741088739;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TW/r5bOMKQEdl/fm5iKEjyIL+RUW8fkuKadv/ulCZKw=;
        b=TgFKP330znpSH4R/6WSH7rFNOpXY1uX6RnpZzxjhoZ1uCZN22S8MEHaRu7EdFqCYq+
         4tOAyibppJmpMeGYDM49nGaWaEuxzlyj/GglzvFST8BpEp0yb8ICV56nw2TtnKrnaT5G
         W8YQYoVT4dW2qkbQpkWhBqLomb6OhiKHgVU3Xdlldv4CYAfGk9rv6Iwg/vn2cJ7vvJ6x
         Jyk7Q3YOQ5InqVhNv+DF+/aV1LNhE2jWXEyGh0LSt80lEMFd3QLXGX0qGGiZtI3pN2lC
         hC5kWP84ad3FbeP+XM3lic3YLDxb+MX1iRbbYPOLoQgEGbdOAznAfg5Zue9esiyd79Hm
         dV1g==
X-Forwarded-Encrypted: i=1; AJvYcCUNH+AXUL9ADhG2x/6zYjVq8E/F/LM+wfVefIo8PRMGNGSji67/IWEiGAmhT5/cxBCJdOvD+KtweRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOBBvhWSqPHJpKt5J5l72P++kGrX3Mi/j2U8TRSYs+sRHaEmG/
	bvB8bdKe6fcdbnQFI1+NCy22+VeWHFKBXd6MPkysLYWfJjHCu7yH3y9xHvC9DqEAJxwiRaNPTJp
	5/1eyiU+a6ddnGsnb+qwDAJlJtE4NoyuP00if8LjvynCWOoLhXgHRvfb70QM=
X-Gm-Gg: ASbGnctEGUb785IOvHMPsQI+yj78yfzMj/LREMbIEo/rykGsTHiby6HLD77UDpXOVtG
	omlHIq20Kfwo9zu9jWq7ciW3OA1cBxjHSXIDC6cPZ0x9DlVPhBLv1MMfzdU2e8Rr421LVOY0F47
	3Tk/wLkh+K/DKBmKF7RO5TZ8DAiBle1rUUxEezcd6DMGCVYB6fl3QrRxYvOZmBnT6uDvFaXW+Mk
	dwBVBZetfj3nTXD0ITw4zG/tLicEavi45jAEEBximQfegSM5uEBzccA67cBD/+fssjgnTE5/T0w
	QtLo/+QUB1+Xz5qO5jbtpdiAytmoAuzZYxeKnojRJU4Ihv0ho7s=
X-Received: by 2002:a05:6a20:2444:b0:1ee:c390:58ac with SMTP id adf61e73a8af0-1eef55609d8mr35663339637.34.1740483938662;
        Tue, 25 Feb 2025 03:45:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWBhzAVbfQ0L1U8HV4Uzb/8b9X8qD7HqTBOw4AUiTbZkGzedrzw6VJc8oD/CmX66NqdU/U1A==
X-Received: by 2002:a05:6a20:2444:b0:1ee:c390:58ac with SMTP id adf61e73a8af0-1eef55609d8mr35663285637.34.1740483938268;
        Tue, 25 Feb 2025 03:45:38 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a7f9bb1sm1331790b3a.92.2025.02.25.03.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 03:45:37 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v7 0/4] PCI: dwc: Add support for configuring lane
 equalization presets
Date: Tue, 25 Feb 2025 17:15:03 +0530
Message-Id: <20250225-preset_v6-v7-0-a593f3ef3951@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD+tvWcC/22M0QqCQBBFf0XmuZVxxVV66j9CwnbGXEi3dkwK8
 d+bfA6GC+fe4awgnAILHLMVEi9BQpwU6kMGfuimG5tAymDRVmgLNI/EwvNlcabguq8cUlF2BPq
 vSx/eu+vcKg9B5pg+u3pxv/afRQ+Nv1JT1oRoGzpFkfz56u4+jmOuAe22bV+4E7scqQAAAA==
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_mrana@quicinc.com, quic_vbadigan@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740483933; l=4008;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=DWkFzyUNSroNJbrok6V9w/pFXCdIMs59dYxdSxifuTU=;
 b=jDiewY/1+DFurlRHILiMVCI5fF7O7vzQdKD4Aykn8XCHJdefZvosHwamZPKEr8d5WiC3PUPlo
 lyLmva5NLIEBqKn7Tj5gRwYzai7Nl2PpQ+Lxl9xKLzyCLCY3bF/K0UW
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: Ujj9IHBpZ9T183beGWqCO4EHksKRklZz
X-Proofpoint-ORIG-GUID: Ujj9IHBpZ9T183beGWqCO4EHksKRklZz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_04,2025-02-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 mlxlogscore=970 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502250082

PCIe equalization presets are predefined settings used to optimize
signal integrity by compensating for signal loss and distortion in
high-speed data transmission.

As per PCIe spec 6.0.1 revision section 8.3.3.3 & 4.2.4 for data rates
of 8.0 GT/s, 16.0 GT/s, 32.0 GT/s, and 64.0 GT/s, there is a way to
configure lane equalization presets for each lane to enhance the PCIe
link reliability. Each preset value represents a different combination
of pre-shoot and de-emphasis values. For each data rate, different
registers are defined: for 8.0 GT/s, registers are defined in section
7.7.3.4; for 16.0 GT/s, in section 7.7.5.9, etc. The 8.0 GT/s rate has
an extra receiver preset hint, requiring 16 bits per lane, while the
remaining data rates use 8 bits per lane.

Based on the number of lanes and the supported data rate, read the
device tree property and stores in the presets structure.

Based upon the lane width and supported data rate update lane
equalization registers.

This patch depends on the this dt binding pull request which got recently
merged: https://github.com/devicetree-org/dt-schema/pull/146

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Changes in v7:
- Update the 16bit array in the array (mani & konrad)
- Update the couple of nits (comments, error log format etc) (mani)
- remove !num_lanes check as this is not needed with this series (mani)
- Add warning prints if the data rate is not supported and if there is
  no devicetree property for the data rate (mani).
- Link to v6: https://lore.kernel.org/r/20250210-preset_v6-v6-0-cbd837d0028d@oss.qualcomm.com

Changes in v6:
- update the dt properties to match the lane width ( mani & konard)
- move everything to helper function and let the helper function
  determine reg size and offset (mani)
- update the function header (mani)
- move the num_lanes check to the main function (mani)
- Link to v5: https://lore.kernel.org/linux-kernel/20250128-preset_v2-v5-0-4d230d956f8c@oss.qualcomm.com/

Changes in v5:
- Instead of using of_property_present use return value of
  of_property_read_u8_array to know about property is present or not and
  add a macro for reserved value(Konrad).
- Link to v4: https://lore.kernel.org/r/20250124-preset_v2-v4-0-0b512cad08e1@oss.qualcomm.com

Changes in v4:
- use static arrays for storing preset values and use default value 0xff
  to indicate the property is not present (Dimitry & konrad).
- Link to v3: https://lore.kernel.org/r/20241223-preset_v2-v3-0-a339f475caf5@oss.qualcomm.com

Changes in v3:
- In previous series a wrong patch was attached, correct it
- Link to v2: https://lore.kernel.org/r/20241212-preset_v2-v2-0-210430fbcd8a@oss.qualcomm.com

Changes in v2:
- Fix the kernel test robot error
- As suggested by konrad use for loop and read "eq-presets-%ugts", (8 << i)
- Link to v1: https://lore.kernel.org/r/20241116-presets-v1-0-878a837a4fee@quicinc.com

---
Krishna Chaitanya Chundru (4):
      arm64: dts: qcom: x1e80100: Add PCIe lane equalization preset properties
      PCI: of: Add API to retrieve equalization presets from device tree
      PCI: dwc: Improve handling of PCIe lane configuration
      PCI: dwc: Add support for configuring lane equalization presets

 arch/arm64/boot/dts/qcom/x1e80100.dtsi            | 13 +++++
 drivers/pci/controller/dwc/pcie-designware-host.c | 69 +++++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.c      | 11 +++-
 drivers/pci/controller/dwc/pcie-designware.h      |  4 ++
 drivers/pci/of.c                                  | 43 ++++++++++++++
 drivers/pci/pci.h                                 | 27 ++++++++-
 include/uapi/linux/pci_regs.h                     |  3 +
 7 files changed, 168 insertions(+), 2 deletions(-)
---
base-commit: 3175967ecb3266d0ad7d2ca7ccceaf15fa2f15e2
change-id: 20250210-preset_v6-1e7f560d13ad

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


