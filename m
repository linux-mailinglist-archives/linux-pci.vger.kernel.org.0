Return-Path: <linux-pci+bounces-18247-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FDA9EE426
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 11:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 308AB18879EF
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 10:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D85120E325;
	Thu, 12 Dec 2024 10:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m6y+Hs1K"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42CF153800
	for <linux-pci@vger.kernel.org>; Thu, 12 Dec 2024 10:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733999575; cv=none; b=lyx0fPFoPV4fazY4T2FQ2NqmNGIx0v/F3oTWZ9tnfDX5BmsQtFOfsPNZuv+5uMp8J3qfteP3Gi/DJdaeRXE7/C6xNsaaFauoOLFZzFTnvg/I7p+94fPbwhEYI27rYShhsVWggTYOr6jg3VKwgzekO5NoypmX9YXV9bou7X+46MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733999575; c=relaxed/simple;
	bh=bxd2KxdukoFBLKHWSR4dEbD3FlpHwRsSJWIrFzkd7Aw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MJ7Fx6ybMlPsN8GN1EQk40wqoiZzZpe/wjn+lOr0Uh8QSw1w6YI+kBMlXVPqR7ZDyREMPVa6tE7x1aloNOYvBNuZuJy2wKlp3ipoJMMMe5enc3Uw5rHA5I8LMsCcNLpDAlojjp/eNhdfHLgEkaNxF5mgBsC/GSL8XC5OH4isd/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m6y+Hs1K; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC7x10b015012
	for <linux-pci@vger.kernel.org>; Thu, 12 Dec 2024 10:32:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=kssPaDPxup65Dty2dKSXA+
	jcEELLywxLYi1f+671RSg=; b=m6y+Hs1KR4Q0NEMez5Fi6c0CdG9prgxWYT9D44
	GautF2jzEAhX7uVPfNUgnQNYEFt50SluD51n5W+YMjCuUyU9SvntS83vDYwxobSB
	NTXGjYg0iNbOP4vjhROxU37hBgorASECs3oy8tEEpfFrKojsJg++bEHFkX1e4Je6
	9naMJtVPL6A9aidWgKnUN19ZNoO4QDthOoCr3n42Lqs9gKItedAWgo3mYUWzAizJ
	t7kUnxmfGaWQDh03WCABq6mQJmq/5PC9grQkIFeQF8Z80kmUyZLcLeUSZauGzkGb
	R5rBraAR5SVf278KzveWV8BhsANYDMOZiwgzBNq32srrPxhQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43f7dpktjr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 12 Dec 2024 10:32:52 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-216430a88b0so5188175ad.0
        for <linux-pci@vger.kernel.org>; Thu, 12 Dec 2024 02:32:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733999571; x=1734604371;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kssPaDPxup65Dty2dKSXA+jcEELLywxLYi1f+671RSg=;
        b=HDg7sIX/8WrRKAAANrN75YS/pJk+ueIGRPpReJxnyN2ti6SecO7kGj8zbqugo4EE/Z
         8o0RXFa8KK5a4WR8qiZpplUzJp62hfeXizumlM7uU42xHDnF3nT8YhEXcUnMNA4FVr8f
         dPYu2PcpdJMy+t96dc5qhTD7wX78tZhWYtZlQ5+1N0UxSgRvr0CW0hvOo7R3pNOolCLP
         DApaTkXFKUa2Bw6++xsuPM3MnDYhYPSOqdfwZkytWnfyOvHidZ9mNvjBGsCm9cLt3lba
         oGefH/rFPeP0AgOgeHeNh+MsPzFQgNObAP80HEMzqqwejr4PNQKs3FxuL4c52Xm9ZoJo
         SZuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFdfIReRgRuO3XwAhIw4YX/Tw6xyj4De9nLd1lak2Q6zf3/5YP46PGFjzWISSFU4fkMub/utLkDEM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+16Voc8VwTLadbss07jAVz2L5WjBf3aaWfnr2jrB3DZBLJuf9
	1c+Es8F601TO0AIacKRkPtR44UqxhIrbINNZcx+tMXcEuksBcQqA5mMteIzlQix2JX6N9S7Y23G
	sr4l+xv0cCLFm6q15VDPkNfEY4JkvYJLJ5Hvz0lRLzT/XflWfWp/dxlWhadI=
X-Gm-Gg: ASbGncsj8qGIkyrAla1A7meqiObDfHOEDvJu+Xy4V7bp5HKxCClCOGOmcZwGyvxQT/+
	c2QECxqYp0MXpfvgPhT6HBY9casJXAjty7lNK8SXK0+XyprvCns+hP7AcqXc3ddaqWQCM9SOmqC
	bo5VGYDvRB6a1wdkkDrs2zmUw8odCER+guK/aSY/L762vhyBXLeS9Ix5kaoF1YEJ4N9wcXXTFbu
	gsHbfOX4x03sP5znGsH8UFSy6fetRc7GfCAg/9abMdx8+b5JbLd86BnNBcKql0d/XqJ6+1d0DiD
	tVI9mUaGDWUWQWrU
X-Received: by 2002:a17:902:cecc:b0:215:a3e4:d251 with SMTP id d9443c01a7336-21778395944mr107145925ad.6.1733999571141;
        Thu, 12 Dec 2024 02:32:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYe777zzUhTHTuqNo5FOPq34CzI9d/38zQqThsmvTBvj9oBnfzkvHRdu1IFQisMei1L+OcTg==
X-Received: by 2002:a17:902:cecc:b0:215:a3e4:d251 with SMTP id d9443c01a7336-21778395944mr107145585ad.6.1733999570764;
        Thu, 12 Dec 2024 02:32:50 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2178db5b42asm11102335ad.244.2024.12.12.02.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 02:32:50 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v2 0/4] PCI: dwc: Add support for configuring lane
 equalization presets
Date: Thu, 12 Dec 2024 16:02:14 +0530
Message-Id: <20241212-preset_v2-v2-0-210430fbcd8a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK67WmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIxNDI0Mj3YKi1OLUkvgyI11TE8sk88TklEQgpQRUD5RJy6wAmxUdW1sLAAB
 PgsxbAAAA
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        konrad.dybcio@oss.qualcomm.com, quic_mrana@quicinc.com,
        quic_vbadigan@quicinc.com, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733999565; l=2373;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=bxd2KxdukoFBLKHWSR4dEbD3FlpHwRsSJWIrFzkd7Aw=;
 b=DS3iYf3bome2HEuPcLoShlifxY9EyuIqIt6CCIxnuV6YhKtpdI2UDLVPPd//UbAY3ahz4aSGy
 OU70Bfc0teGBz1gwKR8IZuS/zGEbcE/XzgfqMvBQRWkC7nxD/j1OwX0
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: BKQzWU_qSyzmVKm4e5rCvTq2hHqpOol7
X-Proofpoint-ORIG-GUID: BKQzWU_qSyzmVKm4e5rCvTq2hHqpOol7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 clxscore=1011
 mlxlogscore=980 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120073

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

This patch depends on the this dt binding pull request: https://github.com/devicetree-org/dt-schema/pull/146

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Changes in v2:
    - Fix the kernel test robot error
    - As suggested by konrad use for loop and read "eq-presets-%ugts", (8 << i)
    - Link to v1: https://lore.kernel.org/r/20241116-presets-v1-0-878a837a4fee@quicinc.com

---
Krishna chaitanya chundru (4):
      arm64: dts: qcom: x1e80100: Add PCIe lane equalization preset properties
      PCI: of: Add API to retrieve equalization presets from device tree
      PCI: dwc: Improve handling of PCIe lane configuration
      PCI: dwc: Add support for new pci function op

 arch/arm64/boot/dts/qcom/x1e80100.dtsi            |  8 ++++
 drivers/pci/controller/dwc/pcie-designware-host.c | 21 +++++++++++
 drivers/pci/controller/dwc/pcie-designware.c      | 14 ++++++-
 drivers/pci/controller/dwc/pcie-designware.h      |  1 +
 drivers/pci/of.c                                  | 45 +++++++++++++++++++++++
 drivers/pci/pci.h                                 | 17 ++++++++-
 6 files changed, 103 insertions(+), 3 deletions(-)
---
base-commit: 87d6aab2389e5ce0197d8257d5f8ee965a67c4cd
change-id: 20241212-preset_v2-549b7acda9b7

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


