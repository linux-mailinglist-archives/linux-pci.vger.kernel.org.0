Return-Path: <linux-pci+bounces-43773-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C63CCE52F7
	for <lists+linux-pci@lfdr.de>; Sun, 28 Dec 2025 18:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 76E8E300206C
	for <lists+linux-pci@lfdr.de>; Sun, 28 Dec 2025 17:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0731D5CC9;
	Sun, 28 Dec 2025 17:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SyhN8Fj4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Dp/qrla5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E645464D
	for <linux-pci@vger.kernel.org>; Sun, 28 Dec 2025 17:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766941284; cv=none; b=aAhp1xXE/2EETMt7WEGQ7l8UjoEeb6gutmtJKp4kYDS6ikGCt79bAQA0l/9ESUiUqVzhnvlft/BTBNizns2Kp/Z+E5ffLbBs9B+fw0g9ujbxP1chv1DOHZ1MuDcNGocaTXvNmgmk2u5Jg8oqY5ixreHydf7jlyppNM1Qse/zL2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766941284; c=relaxed/simple;
	bh=lCxl2n5aD6Bb9zv77JM6BQ3kRr5ZEjbzp3hesNEVqg0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OXmxHOHDIWjSb5Q3J/bK4J6+zRWsm+sZDnDqgFY94+SMMYItDDWqp9ap6Q4HNRXhKA0t/gAEXDhPG4qQXuOvueazRKzK9nHOBChoCRoPA1UcoQIgASAnqVfwkJu2uZX2cHDNPsRppXWPERZu0CyDysDss/zPxVOW57/FMk9kCZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SyhN8Fj4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Dp/qrla5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BS8XNou2053448
	for <linux-pci@vger.kernel.org>; Sun, 28 Dec 2025 17:01:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=b+7B9SJgNJm4sR8RVhnBTK
	Tux/7l5bt1WKzbOSx4CCM=; b=SyhN8Fj4JfHu2Pn5S+cFk04tl0u/LNelNQf+tY
	D2gcvLE7719Dh6nEBEZyegB0lRiLMOqRL4/+JA2FAV34djTh1Us+Z40oyReEUmy5
	NOuNfooaYh0JMWMI86yhVYU8/7+zRAG77lMlX3iKJVErQQN/TgcA905uta4+J/KH
	hFLFH6GHLA+HE0KBHA2JZeuhYuzvfUCuE0g5MHLPwEd6wOFCE1onkjnRw/N5tU6j
	XCAC8+LFXY9/AUQQxutMAELNIGWC2kL8QSD1+ebG5V9ya4O4bGmiCfx+HZ69Vz5V
	+cg+xMoXfm909Qj7iZoOMO4EQhJ0Oaiux74uFt4Nt7psYACg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ba6sg2gfx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sun, 28 Dec 2025 17:01:21 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7b9ef46df43so10080960b3a.1
        for <linux-pci@vger.kernel.org>; Sun, 28 Dec 2025 09:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766941280; x=1767546080; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b+7B9SJgNJm4sR8RVhnBTKTux/7l5bt1WKzbOSx4CCM=;
        b=Dp/qrla5JFPzsss5uE/azI1GsK+2UPvIBbstcCGgDbLVY8vZK1g7w6HA1f9kLwxFkz
         m/nSWxAMPrYUFou49FYWXKPWaggBX8XoG4BesUGLqgGOjtYf0bfWXlynCq670XHlu72c
         kl/bxU7jIrUPaqH7g9q3gGHoLEDQyUrG8siTzq4LT+fLueqxRarxr66zX9YBKVclpyIn
         7JwoISOt286uOqhsDpExzYmtrArO81VEKcCby4TU2KNjWXZaANJz7UwDlMA7MCGzOCaf
         eDbvTvV8SS4lhmPhvavhhNlJoNPvm3dxeiRjmz2NLhoS/srm1QPZ/40c08Yq9B7bpMGN
         Ze8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766941280; x=1767546080;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b+7B9SJgNJm4sR8RVhnBTKTux/7l5bt1WKzbOSx4CCM=;
        b=wAeawC/ijCGHG0Qjc3uaIeLbjOzac5C04vcVXm5c+Ji5Ai+1/LSGS+qqBNPm0ariyS
         pHmWLoPM9am5LMpevrEPeOMlIanrzyJaGXCR3+N0vXjXJpAGDB2AaQI9kjD66JlqAGum
         QYPhBvZCHc+aaVAANKlKHy71wB+yNcRXY8ce3xMSrr7Sa9NHDHTo5F8H9v/hdbSfdQTm
         VlX2m6mTRJEnBlQ6p+CqeyHqEbpmIVi3LTYJa1B+YVF0JWUg9jEoji9kDmP1nat0EqLI
         c+bJi8FrQMsAkNa56bKax+gVGQLf5K8NJ9CpLo2+6dj9d9J5yX8NufRFsIQ9QseISUs/
         uC+A==
X-Forwarded-Encrypted: i=1; AJvYcCWk6OjvdCULfYCBoOZJAcHlLjAEgR/K5Q6BSbCYhdh5T3S7o4AGhR9Xm9nAKc9GWHcoX96EwNV9ASI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCZHdQrPJUVtYk56I5BRtkWrlNZ+RZ6eNe0W9ZNs+kF1Pie4x/
	amAZynBw/zAmLeuSUQ/U9hbMxUeSe+lbc/faOuKnoIF/VavTWoT4kIP2xp2smHZQzgCST3DOhNM
	i80rUZIYNjRW4R+iAUIU3YzyPSNo0TeznPHyqPC8hq/FZ4+njsJH/QieEnFTx287BZHUargo=
X-Gm-Gg: AY/fxX6thDQoXULyPsA/JvXQXjDeZiXIjf9E4wHX/H8YNJdPupBapA2XDwCsGUJLHFn
	lh32ZY9u5kWGTWqkiryd7/4AvFeCpGpsCsaVQ7kTFykN0P5hxMkOrWtpa0FNt/TN7ZZQvDGeheG
	aFNDKatGxhR/r6u+gP9OwRMi9PIX3cVRragH2Ga97Fkc57+SzZDiXV0b8LXznEpUXAE5W7moYOR
	PIu55M5Ejc73onlifhZzcIyPBzXqPYXhcDHWAllthlSQs8bFeImmGc3Urv3qPq91Bilfih2KGrh
	H7m9LGF7iFxlRdlalpoJQEePtlZ0JGvFwCdmjUbuK0SEAV+YOt796CIL4Cb+muS4dKgGAJf7B+O
	OhIlkOkGv/zDGf0slaj+PNPQcaOkh0uJrHhE=
X-Received: by 2002:a05:6a00:ac85:b0:7ab:3454:6f22 with SMTP id d2e1a72fcca58-7ff648e4b26mr29080837b3a.16.1766941280325;
        Sun, 28 Dec 2025 09:01:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHb9mwgHytfvSq+b5K7BOcjZZAV6Gx7cYLWysZuXgYYAy05VYXb5dQJbI15XSLOV5ECpUVkXw==
X-Received: by 2002:a05:6a00:ac85:b0:7ab:3454:6f22 with SMTP id d2e1a72fcca58-7ff648e4b26mr29080783b3a.16.1766941279755;
        Sun, 28 Dec 2025 09:01:19 -0800 (PST)
Received: from work.lan ([2409:4091:a0f4:6806:90aa:5191:e297:e185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7ae354easm27053925b3a.16.2025.12.28.09.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Dec 2025 09:01:19 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH v4 0/5] PCI: Add initial support for handling PCIe M.2
 connectors in devicetree
Date: Sun, 28 Dec 2025 22:31:00 +0530
Message-Id: <20251228-pci-m2-v4-0-5684868b0d5f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAExiUWkC/3WNQQ6CMBAAv0J6toRuW2g8+Q/joZStNBHBVhsN4
 e8WEpSDXjaZzc7sSAJ6h4Hss5F4jC64/ppA7DJiWn09I3VNYgIFSMYKTgfjaAe0KjkvOatLqzV
 Jx4NH655L6HhK3Lpw7/1r6UY2b9eEXBOR0YIqUUvLLEOJ6tCHkN8e+mL6rsvTIHMpwtZWHxuSj
 ao2oqlqK6D5Y/ONDd/fPNlGgioEaNSi+mFP0/QGNszM1R8BAAA=
X-Change-ID: 20251103-pci-m2-7633631b6faa
To: Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-ide@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Frank Li <Frank.Li@nxp.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4147;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=lCxl2n5aD6Bb9zv77JM6BQ3kRr5ZEjbzp3hesNEVqg0=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpUWJZyvHz/45h4posumn1eViZOd0E2qGRJDadW
 VpJVYQe0AOJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaVFiWQAKCRBVnxHm/pHO
 9XXJB/9VGjuweTs1AAQWECsLaA3eY7wzGJFn+vbSYPinXe47ogqWEn4NoAHg6C08SUvgrNYdAKv
 XP7Drzzma8hav/IYwzhAHA+uRUebMvbiFVtbvio49KAFO4YNm/tb9IOoWGxoZUrKScGKOnnCieW
 SWdreBMlvafOu/CRTCc/gVCc1j29qsqdVKQ4bEO/7as9VT2gJDh0b9vVpBbz7Rq80zpByeGYVKM
 dQuJm4h9KdeUWLPTxRNylnpVwINpQz2q/tgC3RpMPd1hL9dVPOF/9VF6tqblzQpruMYpdLpaU2r
 odu8CdUoZryRE+YQeC2kL7TCwVzAlsvzUAi5GoxQ27L2Z8Kp
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Proofpoint-GUID: MbN-5PpXbb1j15lD_6Azi2LE0IQ-BbZ5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI4MDE1NiBTYWx0ZWRfX9gWwV/Itp88o
 9xS+9M1w/7JKXpC47Pocc4APo3xOeBE9k+UNnTJMgaVMXyPV/ck1klTh3z56B4uXKsz+gAlfEBf
 pJLVTg+N2E35stNhB5+dsof/eRBD1A7yRL4czZTT1tMBZkuVM6l1AqIT14DfCzNMt/3I/prOPT7
 3z7TqlBEEkkNToFXZn2ocThkEZr507m0kTKOvL3TWLs1LOQ8x7AFj+raYf6cbD9B+0VFS8yxzgv
 dr82pzln7TgmlH2V7P7cq1nymvndxirTllQEl/ZX2J2w/4oYZLNfdAurkLADa8BFtYoaUBr7GZf
 +U+4fj/CMhshU1LyGC9XwWckFMNGPIO1GDsluB//Cn9k4JskISBNQd6r1a5AJpy5VWcuBfycEuG
 M3ZA87+EuINAgO0Av02qV2ReAm/FuHd2PEeQ/ns+iBjHVM0LA6CM0/ituLZKfMXCcPT8A7cg4vl
 u3C79r+BuHv3lxuWvRg==
X-Proofpoint-ORIG-GUID: MbN-5PpXbb1j15lD_6Azi2LE0IQ-BbZ5
X-Authority-Analysis: v=2.4 cv=Y+L1cxeN c=1 sm=1 tr=0 ts=69516261 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=otkVNQseMVp4AOM4PXIA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-28_06,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512280156

Hi,

This series is an initial attempt to support the PCIe M.2 connectors in the
kernel and devicetree binding. The PCIe M.2 connectors as defined in the PCI
Express M.2 Specification are widely used in Notebooks/Tablet form factors (even
in PCs). On the ACPI platforms, power to these connectors are mostly handled by
the firmware/BIOS and the kernel never bothered to directly power manage them as
like other PCIe connectors. But on the devicetree platforms, the kernel needs to
power manage these connectors with the help of the devicetree description. But
so far, there is no proper representation of the M.2 connectors in devicetree
binding. This forced the developers to fake the M.2 connectors as PMU nodes [1]
and fixed regulators in devicetree.

So to properly support the M.2 connectors in devicetree platforms, this series
introduces the devicetree binding for Mechanical Key M connector as an example
and also the corresponding pwrseq driver and PCI changes in kernel to driver the
connector.

The Mechanical Key M connector is used to connect SSDs to the host machine over
PCIe/SATA interfaces. Due to the hardware constraints, this series only adds
support for driving the PCIe interface of the connector in the kernel.

Also, the optional interfaces supported by the Key M connectors are not
supported in the driver and left for the future enhancements.

Testing
=======

This series, together with the devicetree changes [2] [3] were tested on the
Qualcomm X1e based Lenovo Thinkpad T14s Laptop which has the NVMe SSD connected
over PCIe.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts?h=v6.18-rc4&id=d09ab685a8f51ba412d37305ea62628a01cbea57
[2] https://github.com/Mani-Sadhasivam/linux/commit/40120d02219f34d2040ffa6328f0d406b1e4c04d
[3] https://github.com/Mani-Sadhasivam/linux/commit/ff6c3075836cc794a3700b0ec6a4a9eb21d14c6f

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
Changes in v4:
- Added graph property to SATA in this series and PCI to dtschema:
  https://github.com/devicetree-org/dt-schema/pull/180
- Used 'i2c-parent' instead of SMBus port
- Reworded the -gpios property description
- Rebased on top of v6.19-rc1
- Link to v3: https://lore.kernel.org/r/20251125-pci-m2-v3-0-c528042aea47@oss.qualcomm.com

Changes in v3:
- Changed the VIO supply name as per dtschema
- Added explicit endpoint properties to port 0 node for host I/F
- Used scope based cleanup for OF node in pwrseq driver
- Collected review tags
- Link to v2: https://lore.kernel.org/r/20251108-pci-m2-v2-0-e8bc4d7bf42d@oss.qualcomm.com

Changes in v2:
- Incorporated comments from Bartosz and Frank for pwrseq and dt-binding
  patches, especially adding the pwrseq match() code.
- Link to v1: https://lore.kernel.org/r/20251105-pci-m2-v1-0-84b5f1f1e5e8@oss.qualcomm.com

---
Manivannan Sadhasivam (5):
      dt-bindings: ata: sata: Document the graph port
      dt-bindings: connector: Add PCIe M.2 Mechanical Key M connector
      PCI/pwrctrl: Add support for handling PCIe M.2 connectors
      PCI/pwrctrl: Create pwrctrl device if the graph port is found
      power: sequencing: Add the Power Sequencing driver for the PCIe M.2 connectors

 .../devicetree/bindings/ata/sata-common.yaml       |   3 +
 .../bindings/connector/pcie-m2-m-connector.yaml    | 133 +++++++++++++++++
 MAINTAINERS                                        |   7 +
 drivers/pci/probe.c                                |   3 +-
 drivers/pci/pwrctrl/Kconfig                        |   1 +
 drivers/pci/pwrctrl/slot.c                         |  35 ++++-
 drivers/power/sequencing/Kconfig                   |   8 ++
 drivers/power/sequencing/Makefile                  |   1 +
 drivers/power/sequencing/pwrseq-pcie-m2.c          | 160 +++++++++++++++++++++
 9 files changed, 345 insertions(+), 6 deletions(-)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251103-pci-m2-7633631b6faa

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>


