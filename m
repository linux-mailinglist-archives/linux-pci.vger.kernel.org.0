Return-Path: <linux-pci+bounces-21046-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB910A2E560
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 08:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0517D188A6BA
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 07:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5C01ADC86;
	Mon, 10 Feb 2025 07:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nxzkasaS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31272433BE
	for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2025 07:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739172623; cv=none; b=T64wtHkp5mPTHS3R6yXbxczHLpRVuUI8gP0nDoXUPVPU4tggNoZAZay4ULfRIgi0xoIp5LqeRn5QQWofxjovt2E+OnPxnPXXYIlFE8Hr6SZt49mqek7+U07n08AliRyAbcWgZveAhBYYK8x9sbPCJ7ooOHXwwnMo74VMy4m8zuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739172623; c=relaxed/simple;
	bh=slLhMpSJJdwndSGj43LuZJR6xaoQ2VL4N7qxs/1ccWs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hKP0ZjxWdQMx/lt5wFd55swqt5hkmE/Ns2E8cR4hlpKqXNVjPsDjsndiSiJL5hIFpE1z0Uj4uzW/16J0hGX8/6OMrQUuto9EAv7Mw1dytqb84PTzisALCFMNnzoPDP48yDwOxXmHdsCo8eR02s94csa7KdJOcvS7YHU8kzIWfuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nxzkasaS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 519KOHVB024818
	for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2025 07:30:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=2N44XOUfRsiL9wdoBfQENr
	t7OwM73cjB5lGkBRnELKU=; b=nxzkasaSjzpAKeHrONU+HG2H87p9LHxB9QyCEZ
	eiPEy2mtx+Vyli0gf9rJLg64mOGhe4cRioyeaHecOAyGlMxTFX8MeWOzMqdjKpQV
	PwdZIJ9OkKZ0x2+0O3OnRfUi3B02ddX+GHorvyO5wASQ6V9Eq8A8nybrRwkN9hy9
	i4kP+NBys0vDVjwKFZYOCz7bKGRs4zZ3seBSSgqQDgtng2jo1VRPdRYqn7bFJeZF
	GiKx2dawKMePlY+ewSaktQzygBNyhi42QQbZkhfmL/d9rUSYk4mVPHx4UkuumDyI
	iEqVG88NFf5cPqIU4z6hAnyq+qAnIlGWrxYBD7H6NYL4KCcA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44p0esbem7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2025 07:30:20 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fa1c093f12so10179958a91.2
        for <linux-pci@vger.kernel.org>; Sun, 09 Feb 2025 23:30:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739172618; x=1739777418;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2N44XOUfRsiL9wdoBfQENrt7OwM73cjB5lGkBRnELKU=;
        b=nyQ5lbKB7FhXBl8bxsEQ6XKSBvfg4gFyhhDTElmkvPxSf8MvzoAKEyTXlnpkjGO0T5
         5SYyRM+wgDmd+O+XKrEwa7YJnQzNRDz2Ly0sSBj8hAvhPk97ZFqLkc9RhxhW6QAxEYH4
         XsLCoM2bWwf7rMx49+7cA0k294stsEcMhyT9j/OHbp2ZzM4XEt/mEeeGvACEo14wBp7t
         i2Om/CFkH/soBdydhN2hxkiw2nUGyS68hYKHlGEZMSmBbEWba1ZGZ1sGhA28LVApHU0F
         IJqwZrrvMH7UAgaXoU+RFKEhQ+5KBlbsEMWVAJo2F4oFficb/RfKirU/g7nH8NSAR/X/
         bOQA==
X-Forwarded-Encrypted: i=1; AJvYcCWOFCJFPJrs+pYK58NzNPFJyYmrqoyDvLmssI9EFCw2b1MfUegAvtff3XP2RrRq9po4o2c/iVAHe+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrzKK6EDS6fd4jI8t5yDOkh6dLbMkjmt79T6P0z+yZKGA/pA+T
	f9LzdIXEgC0KAlIkPmobmfsjob2+OzOh1eKaGG3+gBFHFH9djQOfC92MJCzEynC+unHfQOJNbO9
	Kl3IoLn0rDJgqvGpfX9CITfC3qY6bE2nWykt9m3GzFGW7bb69rORFY01/Nfo=
X-Gm-Gg: ASbGncsL3Z9dJqZLl7rLQg5wSuqpjfPrC9wIGSqsDKfGXg7NTj2z/JURwfONz9u+Ffm
	g07WLdFUgjUjiLyqOajphBWUmvKKmtH1zCV/SAcNE5K/27Zcw7d3omTuIAVa7gVEh18NbVEw7J2
	p19a3uW+wDWF1LbhWv2pJfiZEUNVWL8ueWG3dRREyWPSvZwBP/6QP4CbMZmjGxITI8eSzRhuKtC
	aSxrRENGCIBTVJTSo4r78/bBLm982Wj9MSxXxmjqra3zAtMclrXU9fPZDGk4qeG/C1dCWr8/W8y
	4Jga9BTA3LYLlXDjFd877ls3TQnQKFk6m9U1kqdl
X-Received: by 2002:a17:90b:3e8a:b0:2ee:d797:40a4 with SMTP id 98e67ed59e1d1-2fa2406925bmr20502323a91.8.1739172617605;
        Sun, 09 Feb 2025 23:30:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGN4MPBj/gNkBJSl4K+uu0IlsMKlgud7xI9RdM/DkK2Nk+i4325OmVAwkbY/k1LkLrpv4l8SQ==
X-Received: by 2002:a17:90b:3e8a:b0:2ee:d797:40a4 with SMTP id 98e67ed59e1d1-2fa2406925bmr20502283a91.8.1739172617172;
        Sun, 09 Feb 2025 23:30:17 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa09a6fe28sm7918507a91.26.2025.02.09.23.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 23:30:16 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v6 0/4] PCI: dwc: Add support for configuring lane
 equalization presets
Date: Mon, 10 Feb 2025 12:59:59 +0530
Message-Id: <20250210-preset_v6-v6-0-cbd837d0028d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPeqqWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyzHQUlJIzE
 vPSU3UzU4B8JSMDI1MDI0MD3YKi1OLUkvgyM13DVPM0UzODFEPjxBQloHqgTFpmBdis6NjaWgD
 6TlWuWwAAAA==
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
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739172612; l=3582;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=slLhMpSJJdwndSGj43LuZJR6xaoQ2VL4N7qxs/1ccWs=;
 b=6jbZlKyuen3sErbah8kE22949DfBYXtgyzuwaUxenq72bkZkrEU2gdwJUybLu9B2j07m0m22p
 BIVkQnNmx03DgNGjz9vsNHQ27bDjvIjXuk6sZKHlqqP8p9M7+LKXeoN
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: N5MaKgWH0C3x4NmONEavRDquaLAyZyGi
X-Proofpoint-ORIG-GUID: N5MaKgWH0C3x4NmONEavRDquaLAyZyGi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_04,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=978
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502100062

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

 arch/arm64/boot/dts/qcom/x1e80100.dtsi            | 13 ++++++
 drivers/pci/controller/dwc/pcie-designware-host.c | 56 +++++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.c      | 11 ++++-
 drivers/pci/controller/dwc/pcie-designware.h      |  4 ++
 drivers/pci/of.c                                  | 43 +++++++++++++++++
 drivers/pci/pci.h                                 | 27 ++++++++++-
 include/uapi/linux/pci_regs.h                     |  3 ++
 7 files changed, 155 insertions(+), 2 deletions(-)
---
base-commit: 3175967ecb3266d0ad7d2ca7ccceaf15fa2f15e2
change-id: 20250210-preset_v6-1e7f560d13ad

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


