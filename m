Return-Path: <linux-pci+bounces-31976-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDEDB027C1
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jul 2025 01:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B72EF1739BE
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 23:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48FA224B07;
	Fri, 11 Jul 2025 23:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rtzsw9/g"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F7519D07A
	for <linux-pci@vger.kernel.org>; Fri, 11 Jul 2025 23:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752277393; cv=none; b=hJOoF2+KYoxeLiKz4wzXtbRk8mGiodkLS9hFIStGRDVSjmMk2+Ottj3vIUcP2IQGbB3EMlAlgclXH7XPwF9f7XPFqc08IS1JwFoVCTTw6+l2u0vVulV02uuRmjmjJLUNnTYdvlnw1ZtMZclHCBQsx/XiwBL51fxbiCwT9W6tLXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752277393; c=relaxed/simple;
	bh=uqmxYY8UZVW1LCF6+3FFf24eYDjeuWg03QCImc0OpNQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZPkpkHbdHXMtCCmWaYSyz7o9cvQf4lSlXhVJGsht/+LTdw9oF4g9Hts4CsWorffCab8vRWhXh4nJ9dekw6QT2QsdfG6iNFRHt5nHRmYSYyPGonEdwHp1MTiBIjVZKnX1PPKES6QXbtLtIrAebbQBW09+v98dLwrRY9s1SWXMVew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Rtzsw9/g; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BB2Ebi006990
	for <linux-pci@vger.kernel.org>; Fri, 11 Jul 2025 23:43:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=UScbVedHLd1sW/r848pJ9Y
	XPWXT3rGCYp6CF/1ahYwE=; b=Rtzsw9/gQ1swNKee+58wgGjQhNj0DGfT+iLlIB
	MX5GIWNF0G2LA9T+piA4M/wsGHvN2ZD3CUEQXfjAZusZZCK6F8kYitcKGBxSovHt
	+PTnhbJEwHT3Btu1hgN3UqlnRAonAtQ5SetfC5qRmLu8QJaTQrL8L74mD1VvfYzh
	hqao2VJiA2lgkRnz1dV4IZ2od3QvYHyZZTd/ScZ3C+j3Vb7252ao954HVP0l0C2b
	RLasyFDRevCeYiDKclGsdegK0DxgjMV/PFz0kwdTmXwW0t8APQaR+a51Otr2qx4Q
	QvqS1NcvjEhYA0YvvQGzh/FygCmTpVoaDtuCDHKos5BIk++g==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47u1c59sg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 11 Jul 2025 23:43:10 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-74ce2491c0fso3492275b3a.0
        for <linux-pci@vger.kernel.org>; Fri, 11 Jul 2025 16:43:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752277389; x=1752882189;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UScbVedHLd1sW/r848pJ9YXPWXT3rGCYp6CF/1ahYwE=;
        b=iZDCZ9xYhtj9oI62mlBSckabrvcERydGICUqJ0OAodbXDKX0idODeV5SBaceXAIoME
         rmp9FD9ATX8e2pWZXxPS4OBu8dc1kWAXD3nXs0YGS2trXer4ejXf5EuxF18jMPlVI0bv
         0mRU9405jc9xAT3iuOMn6axjn9p/uX2yvnzYAe2rh2yZd30OUvEkcQZtWv8z0oOPqf3v
         Jhe9e+H7cEGU2V1ahtIV/E/A3TSHc5vNIfFYgHP2O4k9rfzpdl2AZHLKdi6w3guHDqJG
         Qzy1wC7fONmIig2zP4q8QupsYVR/1gSY2NjgwKaEblwF+/AwrIzU3y/t08yN1b6835/R
         vfbA==
X-Forwarded-Encrypted: i=1; AJvYcCWD8EtpKv9PY0AZU7e8boM1spswbcB30mnH9NEcJPR4smV6qaqiyyZfhItdFusVK1NonC38AX94vno=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHhA27zZkrkS5s9SIp28sm5xHXojiPUoqkB/wtoLsZciQOGoUL
	8iCoVtbupK86rPXH7sn5HUlHo0S0y2/2R3+VbFgW6Y5///JNzQzH4OOSgxdOV9DEZdw3SNoU+xw
	+it3oEnklGuQbx77gxw/kPrC52PnAvMsRLz84H0mFvLqnKklKkDGnknNyyRX3h50=
X-Gm-Gg: ASbGncsnUb62VxvOiu/Bqc/xxCCeUpiX31SfKCGIMDx9FS/beww+RvHfEr0JzgB5OYI
	U9xeae+pi1n97Lfk/t60fWOmJpW+WJRezTYzeghjDgOA+Q87y0L5CJSkN0l7XcPZA5y7G7HErFg
	5dlhXzf944frK1rptwW95P93JTQUM8qFasszBVpqYznyGnEjc9UAo2T6B83e7bLQjPuXlfHWv7v
	7Xdr4iQando/9SmQ2EYt1xebX/1b36xtVxDMS6OS6ZcJycfWL44Dcn258hTQYu1o6t5WvXOipVT
	dHyCAO5tILednuPr+OtePzvMzNlLP+uGTIzATRp64lyVWg9Y6O44vf2iYDZJiSIMwL6Y6PmcSDM
	=
X-Received: by 2002:a05:6300:6b08:b0:232:1be:1e2a with SMTP id adf61e73a8af0-23201be21e5mr3040875637.37.1752277389231;
        Fri, 11 Jul 2025 16:43:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEYKff5ftWUYSbwOdgNaF2CCvBfwj5knS/+DaIx549oclT/oQGWNgqQeiTHv74yuf8jBoZzQ==
X-Received: by 2002:a05:6300:6b08:b0:232:1be:1e2a with SMTP id adf61e73a8af0-23201be21e5mr3040848637.37.1752277388776;
        Fri, 11 Jul 2025 16:43:08 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f1a851sm5869781b3a.82.2025.07.11.16.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 16:43:08 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v6 0/5] PCI: dwc: Add ECAM support with iATU configuration
Date: Sat, 12 Jul 2025 05:12:36 +0530
Message-Id: <20250712-ecam_v4-v6-0-d820f912e354@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGyhcWgC/22MwQ6CMAxAf4Xs7EiFTRgn/8MYw0YnS4TppouG8
 O8WLhw0aZq8pu9NLGJwGFmTTSxgctH5keCwy5jp2/GK3HXErIBCQgEVR9MOlyS4FaiVrlWJqBl
 93wNa915LpzNx7+LTh88aTmK5/jZogCuhZSfRSNhXRx9j/ni1N+OHIafFllSSm16C2nRJeo3WU
 kFVCro/+jzPX9iv7xPkAAAA
X-Change-ID: 20250207-ecam_v4-f4eb9b893eeb
To: cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com,
        quic_vpernami@quicinc.com, mmareddy@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752277383; l=4878;
 i=krichai@qti.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=uqmxYY8UZVW1LCF6+3FFf24eYDjeuWg03QCImc0OpNQ=;
 b=ePQj2Sv3+x+5h5iTgQSMSvOtQe5NNwKk1cH23V4IhKCIqd0qQNzpgZcVZepv6LMKVPTR5LY2F
 GUwf+QUu89uBiI2CyzHgXKCMMk92+2wEsm4U1fAKwA3GQhMfAhdYQuH
X-Developer-Key: i=krichai@qti.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: mRj2Uhl_XuFFaFMqLrkhWispWy3Fb9Gs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDE4MCBTYWx0ZWRfX03m4vgkaN/rb
 FSaNHqmHpSXLgt9Mu+UDEpprCEzlIDcoqoF0Js8vqUevBcPPTwssqlsUCNe8I7YjjweKHBQb8LX
 gzg3D62d8t3ZG97tUHEl+XGtRg541RdHBFsOACdimuSnl3xXZDAdofbk/OMloEERb+eAbHOe+oj
 OaKSzz8jNkt+8KUZdCtP/A84gtnVW6HDRn8pwVDOihM1AcCg5z0NXY1Ug/nWEJxtO+WD/l6cz8s
 u4XrnjAfPk9o0MLLxknk5AwGvHntkK+YKY1AV9RdoMQTj5S1I2siPF69T6wE6emAV9jHAQIoLfK
 NGYEnf97KfXFMQKWw1boHDcFuh4XoStDeW6U0zB6msXBIfi/O4xX+LRHnkbKrOs+7q+F5UOl8F6
 1nz/1CaheUZhc/S/g40sxzY8a1/pUoMOIWFfIW3J3+jtFkaxxJuB6i/1wYTaYkHargUAbOwV
X-Proofpoint-GUID: mRj2Uhl_XuFFaFMqLrkhWispWy3Fb9Gs
X-Authority-Analysis: v=2.4 cv=N9MpF39B c=1 sm=1 tr=0 ts=6871a18e cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=7ZRfWG0Ds4o22ekFdNEA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_07,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110180

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

ELBI registers are optional registers which are part of dwc. So move
ELBI resource mapping to dwc. Also change the dtbinding and devicetree
to make the elbi registers as optional one. Having ELBI as the required
one is making the ecam feature complicated.

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
Changes in v6:
- Remove the dtbinding and dt changes which make elbi optional
- Use non overlap region in the devicetree and in the driver ELBI
  registers will be overridden using offset of elbi from dbi start using
  parf registers (mani).
- Link to v5: https://lore.kernel.org/r/20250309-ecam_v4-v5-0-8eff4b59790d@oss.qualcomm.com

Changes in v5:
- Make elbi as optional and move resource mapping to the dwc (Mani)
- Make the changes in the code as we made elbi as optional.
- Link to v4: https://lore.kernel.org/r/20250207-ecam_v4-v4-0-94b5d5ec5017@oss.qualcomm.com

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
Krishna Chaitanya Chundru (5):
      arm64: dts: qcom: sc7280: Increase config size to 256MB for ECAM feature
      PCI: dwc: Add support for ELBI resource mapping
      PCI: dwc: qcom: Switch to dwc ELBI resource mapping
      PCI: dwc: Add ECAM support with iATU configuration
      PCI: qcom: Add support for ECAM feature

 arch/arm64/boot/dts/qcom/sc7280.dtsi              |  14 +--
 drivers/pci/controller/dwc/Kconfig                |   1 +
 drivers/pci/controller/dwc/pcie-designware-host.c | 131 +++++++++++++++++++---
 drivers/pci/controller/dwc/pcie-designware.c      |  11 +-
 drivers/pci/controller/dwc/pcie-designware.h      |   6 +
 drivers/pci/controller/dwc/pcie-qcom.c            |  83 ++++++++++++--
 6 files changed, 215 insertions(+), 31 deletions(-)
---
base-commit: 40f92e79b0aabbf3575e371f9054657a421a3e79
change-id: 20250207-ecam_v4-f4eb9b893eeb

Best regards,
-- 
krishnachaitanya-linux <krichai@qti.qualcomm.com>


