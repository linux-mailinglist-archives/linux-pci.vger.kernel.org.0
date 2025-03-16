Return-Path: <linux-pci+bounces-23879-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C71A633B3
	for <lists+linux-pci@lfdr.de>; Sun, 16 Mar 2025 05:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91753170713
	for <lists+linux-pci@lfdr.de>; Sun, 16 Mar 2025 04:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4990813B5B6;
	Sun, 16 Mar 2025 04:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oqez6ZB7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC9B2FB2
	for <linux-pci@vger.kernel.org>; Sun, 16 Mar 2025 04:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742098158; cv=none; b=eqWUDmoC5R1TdPBWF4R4k01o6Ej1vc7j5QVxoWReLBBGZgXGEMPGkuee90ckOeA2PHzUThlZyv1JVI5uCqpdOvOn7wT/w7q2NaDLAVqw/zqx2+cBFY1/AE8f0JcePXgO7xWblfyt4t2oZ4buXXw6jHVimJS2q8MdZCQn08V2yG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742098158; c=relaxed/simple;
	bh=qaWWu0XubRBdsbo9d+4oRrNnwNoVBagfiN6TpjpNcaI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YdinK+xsa7OwOuKWMul/VSuwGYTc4PAxyDTIJkeZLvMwY4SnzmYX3X7zpxzn/yVFP1wH2Gt8Z+ihUKYQNiQbMC827MQ+cuG+wwCi7iD62M5D+iXBBEXlG5imp57YMzg+s7h/KcPl+F5N3SCFo2x5C4EMETAtcfni1P/HE3Uv3HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oqez6ZB7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52G40ZRV006571
	for <linux-pci@vger.kernel.org>; Sun, 16 Mar 2025 04:09:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Ly7vN9LS7zdd3ilfjBPyIa
	ufbarnxJGjGeE6ZL37MQE=; b=oqez6ZB7+xF0BNbH1gkKLcaJGur+/r3fUz1N1y
	nfLtvH60TV434IVOVLR4CXQjhdLupvwNA522Ew8XT0U+Diy4bi18oCUZ6d25CxdN
	sngAn3Pgp0JL4/SkP2mAWNQa0AFoKi78P2rO0W9T9F5b2kYO2oJgjbkjWzotQNoy
	fugs35Y+DeG87ckrTcKZcdMpvPy/sBwY9gjmeid7PcQ1DMDyGagiGudtwkv8a/u8
	wilBj+ghn58cZB6r2iJGL3zj0pQMvXNNLElChD5Yq9WWLJfwfG/t5SAk650Vemyj
	5S4Mm1Tl9jy4FXBWCi5jeIOSsAdBpMdQbEWd19yu4CU/vWHA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d1s3snmr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sun, 16 Mar 2025 04:09:15 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fec3e38c2dso2627823a91.2
        for <linux-pci@vger.kernel.org>; Sat, 15 Mar 2025 21:09:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742098154; x=1742702954;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ly7vN9LS7zdd3ilfjBPyIaufbarnxJGjGeE6ZL37MQE=;
        b=wH84V8nrEmfbrLUfbw0mDQQnutmLMHm/S3egh+wV2WjYB1EUyhjO/uSJlcbt/cGD5K
         xwdidjcV4I75r7PtEM3S+C0afbir9Gi8ci+LbYJse+nP7gmCTacuM/hPskaJTCIcCi9u
         KI4AtTau7mMtpNGTGMV9ak8aVFTIPP+ZSu04V4zxXSDqGVLmSFJubyckB3XSoE3pDzeB
         FZYcySa3gabyqrhV15jTSiYUmzudFmVuLFb9ruhmTxx3Hmc7e5w81Iayx7v1aXplaAw9
         Tot9VCq/DHX6w3UP2YYHiBRb0hR055tvbxkQ5H5CNRxpO/JnF3LsELlWfNvPiJjpOBmc
         O42Q==
X-Forwarded-Encrypted: i=1; AJvYcCVKmFywOQSO774xNDoP2gB1KVFPEq//3TZNYxz/PKV/QPFiG8dZlpjtUVVGivOW7Bgh89F0zIwRw0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuxWDTRiQR4fcq17Dco3SALVyLV18aw3dhZgu/O/SHVQWiMPqL
	IjPpQKyDTFD0lj/hbUFLQDimLCuWzOqTDaA0bebuESP56jp56pfYQlxFqoZFHcuxZYpPGdwTBwu
	3z0lnsEkCSiFnjLDMDdJuITDP6uGf9b3Uvmd4LkMOVRJAAxFp4RX0CTadGhI=
X-Gm-Gg: ASbGncsLrb/ZNo7WrPYPHUxxp8xLc7mWg/Jr9mJW1BfCWTuDEYSimecHqs1N/VKZcrF
	V1W4GuNVw2GwU6g+Yoouif1YGxxcfmv2kHW/7+Xa6X9prcDeToH+lQz2didirdv3eHeJiLK1ws+
	kG8d4y5AAYcVdcLnoeQCIHjYXR1pfh7mBGQiwi7WXixq49SyuVbBr/2/Po9em/j2mrRVR1qU2D5
	TATJ8X4ciZS6j+gtq8gZM2bnoyMYf1fClghDDK2avaalAYaw3IsYiefn5OCh8nE5Wj/zFVAvbft
	/H1Wa1NWLKedYZVJOFeo5/t9Jj+lzwqZmBS28k3VrdMjAG1afP0=
X-Received: by 2002:a17:90b:2dc4:b0:2f5:88bb:12f with SMTP id 98e67ed59e1d1-30151cab3ebmr8484170a91.21.1742098154347;
        Sat, 15 Mar 2025 21:09:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLjlxYTdfNJqZhkesiYkuM2USBpUWsehzb+9Jry9ZoBFoQZCtcy0jiQ5jO8MhOA4QR3Rnwew==
X-Received: by 2002:a17:90b:2dc4:b0:2f5:88bb:12f with SMTP id 98e67ed59e1d1-30151cab3ebmr8484156a91.21.1742098153973;
        Sat, 15 Mar 2025 21:09:13 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30153bc301esm3490438a91.49.2025.03.15.21.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 21:09:13 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v8 0/4] PCI: dwc: Add support for configuring lane
 equalization presets
Date: Sun, 16 Mar 2025 09:39:00 +0530
Message-Id: <20250316-preset_v6-v8-0-0703a78cb355@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANxO1mcC/23MTQqDMBAF4KtI1o3khxjtqvcopaRmUgPV2MSGF
 vHuHV25EIaB92b4ZpIgekjkXMwkQvbJhwFDfSpI25nhCdRbzEQwoZjgjI4REkz3XFEO2qmKWS6
 NJfiPF+e/m3W9Ye58mkL8bXSu1vZIwWG0fdhaasuYqO0lpFS+P+bVhr4vcZEVy3oHCLUHNAJGN
 dJJcLJR/ABYluUPZsdjOOoAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742098148; l=4296;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=qaWWu0XubRBdsbo9d+4oRrNnwNoVBagfiN6TpjpNcaI=;
 b=+oB5sg62cYcczDindH2FLJ3cF92jLLKvCvrBc8qft6GnzFAaT6pC+HhVDeSD/MqaPQMeGudZN
 vgi7/521GWJBa3DZUeu5L0KLkPrrZsmQwQ+onLVuIBzP9gJZpxJe/LJ
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=WbQMa1hX c=1 sm=1 tr=0 ts=67d64eeb cx=c_pps a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=DYBN0Cp5FbWaLJN7M44A:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: lDsXQz7RPCPnNkFsiIS99kc8i-PhMPf3
X-Proofpoint-ORIG-GUID: lDsXQz7RPCPnNkFsiIS99kc8i-PhMPf3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-16_01,2025-03-14_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503160029

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
Changes in v8:
- Couple of nits by (bjorn & mani)
- Add EQ_PRESET_8GTS by (mani).
- Remove the logic not to update the DWC registers if the num_lanes is
  not equal to maximum lanes (mani)
- Link to v7: https://lore.kernel.org/r/20250225-preset_v6-v7-0-a593f3ef3951@oss.qualcomm.com

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
      PCI: of: Add of_pci_get_equalization_presets() API
      PCI: dwc: Update pci->num_lanes to maximum supported link width
      PCI: dwc: Add support for configuring lane equalization presets

 arch/arm64/boot/dts/qcom/x1e80100.dtsi            | 11 ++++
 drivers/pci/controller/dwc/pcie-designware-host.c | 63 +++++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.c      |  8 +++
 drivers/pci/controller/dwc/pcie-designware.h      |  4 ++
 drivers/pci/of.c                                  | 44 ++++++++++++++++
 drivers/pci/pci.h                                 | 32 +++++++++++-
 include/uapi/linux/pci_regs.h                     |  3 ++
 7 files changed, 164 insertions(+), 1 deletion(-)
---
base-commit: 3175967ecb3266d0ad7d2ca7ccceaf15fa2f15e2
change-id: 20250210-preset_v6-1e7f560d13ad

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


