Return-Path: <linux-pci+bounces-20845-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFBEA2B68C
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 00:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D41743A661D
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 23:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370B523771E;
	Thu,  6 Feb 2025 23:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ptIgSLPK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5EF23770F
	for <linux-pci@vger.kernel.org>; Thu,  6 Feb 2025 23:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738884551; cv=none; b=E54wut+6y+i6nHB/kHdVNiaEJ74adGf2EiHxZkdtb+/waBDWkrVDSjoSzMlp7dFVQIBdzGs+Cjo8ynGUbC1CVt3Nd9rWb6LabW1gA5zdSw9o5JZu10LKhUkkAZoZuG5wN5jyRW74aNkWYOK/y5XDhNabbCGNKD34QBioEM2KA5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738884551; c=relaxed/simple;
	bh=oxBfLTZdXL8ZaQ+RGvvB79FuQ4Hav3x0rRtUrfoL094=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JV9sj5AZPmu6xs8lbIBlOJsGKWY7PxadyAxqCxbCtjOV9SS8jCgYq1sbumFVctnUxdU8UPtHd6dy+hfpiIg/Gp2LAghnKsYYKTKtZuRZCCcPKF8kZWg7XnI9oTk1CHw33r9fPoDka23mdFaW/UP9hW8HYMc369o0emHMDtDppt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ptIgSLPK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 516HrTaa017448
	for <linux-pci@vger.kernel.org>; Thu, 6 Feb 2025 23:29:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=dpZ6su+P1oYF13MEsL4+5m
	JyK1Vwo2Uj6+roerGXEPE=; b=ptIgSLPKx0SQetApTgqxDoRw1g11h/SZLJyyzU
	miZhdv0iC2frHFQAFgC7CQ04oQZva2HU/KDgzZzHirOQfS6gsRCw94Dn7pU6XQ3Z
	pOkOH4t4Snjl1+t1XeMxQAwRpbSu1fDGX1YSkRi0vGsYviGYnv6k+tEwH10oCDia
	BhGSkUt0xOPV2g00ekBn3Rx4tKq/qm0YWuS6uNvAI0VJ8aJbYQnjEgg1MpH/Cc/W
	fB0Y8IJceij5DPupF+I0RGhiNCzk9vlb3xVr5GwUO9TcYF8VUHILuDSQjMTCtNj7
	xF4dGswtyyXK9r56JhBVxRU8m2aogaVgB8WE7FuEmfPZTpoA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44n1vngpwh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 06 Feb 2025 23:29:08 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-21f464b9954so13025145ad.1
        for <linux-pci@vger.kernel.org>; Thu, 06 Feb 2025 15:29:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738884547; x=1739489347;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dpZ6su+P1oYF13MEsL4+5mJyK1Vwo2Uj6+roerGXEPE=;
        b=jJjtlloxznUd9+jmjgMP5AAeHxH50bTRprJKGYaOV7wdzk5ZHKAu1U5tdb3PMlcoA/
         WoN76PipfrQ+o/rolnsCMT5xSDBWdyuP9YCWvqG23bxWDlz2zSnA+uGA1w4fRrgYSIuc
         pwZWkBNE4RqHeow4PUuh5F+RBF+A/x0UlM5auQlnLGSwWR91XkKh8c/PVf4//pAkOQNw
         GXNp3bO0qUy158gMmWmiE40GrVMTMAcSkRr3C74c20YND6fVocnfkFXxWkAbSWqO9GoE
         SUCdlrWvk/QQGEtI/Gfi9dljlToNvWcsHoFUm/hb29CAwKV3SpjQ0zpyt6Pso07dKEQr
         U05g==
X-Forwarded-Encrypted: i=1; AJvYcCUHxoYIoxJU547el8RjUBBWkeXHCwH+L+m8NmpKkg+ONTST8js2AiHYYHZzVswHUBj4X80t1IM2VPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAbx8Qs0EbFQ+SM2rxCNFgs/qgGaYESo2YXXc6YBlQXg7NWhwP
	6tn1R9NVZGqRsfaTsJD05vklxAQXdPHr9qEdws976ZNs5Tol6Bx9euRoD/koqqnP4Zjx3mNH1hF
	ymkmmcWSQVLWc3NBKSiuTKHXEum+CrMyqskWKeDgWdWeaSvHypU8VpsUR7ddlXzDIIvM=
X-Gm-Gg: ASbGncvQ29htYT/josS2Mx6x5KPKLfS+fvu6btQY+/q+AO7voXdtV0o7llFwilC22cn
	ZJoxzSgLF7u6OFD7CZNVri8YfEx16F6FnZM4+ROpOB+T6LrhHlH3Op7OWBuu/Vfl8mac6EDYyzX
	NaQNb8qzMMlh7xlQprCghAHwB1uwN7YhC7NyDcOuwc1uRzlSHle6s+pcFYKShyj/1TCkU2ESE5U
	3GE2tF5lN3HncDY37n/rSVYC4YMqqPqJ4m+EAgr0hFMZPNkK06ZArRLlSJP8MAWdLry/U2D0KY6
	Za6DZmgr9oW5/n6/fL2PU3o832+JL/FylkAsXuId
X-Received: by 2002:a05:6a20:6f06:b0:1ed:d780:feaf with SMTP id adf61e73a8af0-1ee05290924mr1616911637.6.1738884546624;
        Thu, 06 Feb 2025 15:29:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGxmXBVvH1fpX/BdAfjS95c5Q07NgLnx+DigG5tdrqzE17uXKKnHeKeKCiQd7KexJ11AQqGoQ==
X-Received: by 2002:a05:6a20:6f06:b0:1ed:d780:feaf with SMTP id adf61e73a8af0-1ee05290924mr1616872637.6.1738884546221;
        Thu, 06 Feb 2025 15:29:06 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048ae7f6esm1845905b3a.74.2025.02.06.15.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 15:29:05 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v4 0/4] PCI: dwc: Add ECAM support with iATU configuration
Date: Fri, 07 Feb 2025 04:58:55 +0530
Message-Id: <20250207-ecam_v4-v4-0-94b5d5ec5017@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALdFpWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyTHQUlJIzE
 vPSU3UzU4B8JSMDI1MDIwNz3dTkxNz4MhPdNJPUJMskC0vj1NQkJaDqgqLUtMwKsEnRsbW1AP1
 9uXNZAAAA
To: cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com,
        quic_vpernami@quicinc.com, mmareddy@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738884540; l=3998;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=oxBfLTZdXL8ZaQ+RGvvB79FuQ4Hav3x0rRtUrfoL094=;
 b=Qwbi5zyvH8rfmT+Wv3pa+qBkexhAhioDvey0+mkUJGVmlYr5Ium09a000b1HakE9EEh7+5Ui5
 8SRakNl3nMaBTQTIqBljjJpePvZtBFjYwRdTSL1aZmP64DeCHXeLGap
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: 5ISL2hvZ8LTJeMoaI8-pAletGQRX7KKB
X-Proofpoint-GUID: 5ISL2hvZ8LTJeMoaI8-pAletGQRX7KKB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_07,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 impostorscore=0
 mlxscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502060182

The current implementation requires iATU for every configuration
space access which increases latency & cpu utilization.

Designware databook 5.20a, section 3.10.10.3 says about CFG Shift Feature,
which shifts/maps the BDF (bits [31:16] of the third header DWORD, which
would be matched against the Base and Limit addresses) of the incoming
CfgRd0/CfgWr0 down to bits[27:12]of the translated address.

Configuring iATU in config shift mode enables ECAM feature to access the
config space, which avoids iATU configuration for every config access.

Add cfg_shft_mode into struct dw_pcie_ob_atu_cfg to enable config shift mode.

As DBI comes under config space, this avoids remapping of DBI space
separately. Instead, it uses the mapped config space address returned from
ECAM initialization. Change the order of dw_pcie_get_resources() execution
to acheive this.

Enable the ECAM feature if the config space size is equal to size required
to represent number of buses in the bus range property.

The ELBI registers falls after the DBI space, PARF_SLV_DBI_ELBI register
gives us the offset from which ELBI starts. so use this offset and cfg
win to map these regions instead of doing the ioremap again.

On root bus, we have only the root port. Any access other than that
should not go out of the link and should return all F's. Since the iATU
is configured for the buses which starts after root bus, block the
transactions starting from function 1 of the root bus to the end of
the root bus (i.e from dbi_base + 4kb to dbi_base + 1MB) from going
outside the link through ECAM blocker through PARF registers.

Increase the configuration size to 256MB as required by the ECAM feature
and also move config space, DBI, iATU to upper space and use lower space
entirely for BAR region.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Changes in v4:
- Update the commit messgaes and do minor code changes like adding
  export for the api, adding error message( mani)
- Link to v3: https://lore.kernel.org/all/20250121-enable_ecam-v3-0-cd84d3b2a7ba@oss.qualcomm.com/
Changes in v3:
- if bus range is less than 2 return with out configuring iATU for next
  bus & update the logic of ecam_supported() as suggested ( Konrad)
- updated commit text and update S-o-b (Bjorn Andresson)
- Link to v2: https://lore.kernel.org/r/20241224-enable_ecam-v2-0-43daef68a901@oss.qualcomm.com

changes in v2:
- rename enable_ecam to ecam_mode as suggested by mani.
- refactor changes as suggested by bjorn
- remove ecam_init() function op as we have removed ELBI virtual address
update from the ecam_init and moved to host init as we need the clocks
to be enabled to read the ELBI offset from the PARF registers.
- Update comments and commit message as suggested by bjorn.
- Allocate host bridge in the DWC glue drivers as suggested by bjorn
- move qcom_pcie_ecam_supported to dwc as suggested by mani.
Link to v1: https://lore.kernel.org/r/linux-devicetree/20241117-ecam-v1-1-6059faf38d07@quicinc.com/T/

---
Krishna Chaitanya Chundru (4):
      arm64: dts: qcom: sc7280: Increase config size to 256MB for ECAM feature
      PCI: dwc: Add ECAM support with iATU configuration
      PCI: dwc: Reduce DT reads by allocating host bridge via DWC glue driver
      PCI: qcom: Enable ECAM feature

 arch/arm64/boot/dts/qcom/sc7280.dtsi              |  12 +-
 drivers/pci/controller/dwc/Kconfig                |   1 +
 drivers/pci/controller/dwc/pcie-designware-host.c | 142 +++++++++++++++++++---
 drivers/pci/controller/dwc/pcie-designware.c      |   2 +-
 drivers/pci/controller/dwc/pcie-designware.h      |  11 ++
 drivers/pci/controller/dwc/pcie-qcom.c            |  77 +++++++++++-
 6 files changed, 218 insertions(+), 27 deletions(-)
---
base-commit: 92514ef226f511f2ca1fb1b8752966097518edc0
change-id: 20250207-ecam_v4-f4eb9b893eeb

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


