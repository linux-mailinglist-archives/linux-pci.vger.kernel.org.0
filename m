Return-Path: <linux-pci+bounces-34970-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0A0B3955A
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 09:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC926200A23
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 07:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE9D2FF64A;
	Thu, 28 Aug 2025 07:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hfUXVyXf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51622FE58D
	for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 07:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756366514; cv=none; b=lZq4EJDQdEvvgT0WfMYFIXysIE5/mpln84zFjl7ImG8eiWbBT5LC7QfHkL/6QgeYCV41xWbxaRlenaM2fyXSHqs7IO69leXxhBnNFj7/cMctS7cBXnI1e0pFbI+cI8ywvZk73gROJMqbX5egpnxNgOgKXJ4aLaeXhMlrrEk/+M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756366514; c=relaxed/simple;
	bh=nfRxF5NGtqrSzfg0wLCafldDGtD2uBMbtfCRBPzXISs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Zv1LJz4kHSm6EV/Ij8Sa+UdKfYpSVNPC0hVebtT8sAEI72SfN1ni4sY6ZAf7Faqjqfa2sBD89JItotma9nHirbZtS96isTmv27EKItctrsGDwJLWOksxOT6pxkN+BrhG3Eg16GY8UaIZkOTgRmvHeg3hvBJdSh8MS1QizeAmKbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hfUXVyXf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S5OAL7016167
	for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 07:35:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=UxDAHgpTpOhpjxbWGpIpsF
	8+wpA/NdIwnbq3kmWJ10Y=; b=hfUXVyXfawlS3PrVn5GawW10hs9AnkNTlLICzL
	qE5CzTF6l04LtzCPKmjZL8WN7ppYAU7Fp3tkdeTygueeXdmRn8yrRr0EgZE7ei6Q
	lxFcoIyNzsPj8nUn1LD7X5RXxfWzYtyUY87pPLE0yKu8WvGtA8uD4215kk+eQWFP
	gWKfvMdWCmcXXytRDtNxkUvOTzpjO7xEm79SXpohdIjSm/ECxr2YBAy1Peka3vvi
	A9L4sokDpwsqqn6zgFk1zPFyDxJvP8vGFssZ5jag+uIMUl+iakO12xOHmF69fQv3
	Rp8dNtMOTYh52x5TULeGZ5zWv3nq/BxT/Z2wUJ5hvzp/FHNQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48rtpf1np3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 07:35:11 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b47253319b8so600494a12.3
        for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 00:35:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756366510; x=1756971310;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UxDAHgpTpOhpjxbWGpIpsF8+wpA/NdIwnbq3kmWJ10Y=;
        b=USfidEyCbtLC6piVlYJ3NNFzXFgWfrs15J2/vljTySHkNZ1jGMKzIdv9Tc0SD6KbU5
         XA6Bu2dQlbEMXGmrRapx79DogthY52ULsT0+KxI/94CMFx92xOXZO1jgvcav3ZXRWyT5
         Toby8hBffqtKs0OL0bcsiMJqJxW2IgVUOAFOn+CmYEkum0BpfWoW9ZH4WvpGBXF+gpNn
         xT2UAmA9YcnhuDgftSuyMRueR7dJKFFf+PxLANgFaGhsSB5fJ4muOewqZNHwuYYgEXxk
         W0jRMjGlzYpXnckXCRyjgu+vNg/c6l9lk+jL0cHVGKLUrwR1VJSu7flCC40MR90AMYH4
         FHLw==
X-Forwarded-Encrypted: i=1; AJvYcCWGNdOHF640ZlcLVPUvafooPHdIDf9k84rYPemQi/v5HsKYJwz6zX9z2hRM6EKsyaQIW3hs+exKLWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeOgrRbTMSEBVxtlSSy2CFO0cmdTSU0WPmYKw+n0iU73p0+ZzX
	Ln4aOI9t8477pOONroh493/6F9k2fispVdkwAzYnFr66SZclikAPAtblEjLa8uy/vykivvJrs/o
	0MBEfc3BIUOoSxupmikD318oc/ht25cHYpMGPNudIzJLDUi8yTGC86ukVcVL3cnQWrseF08g=
X-Gm-Gg: ASbGncuy9aQ7iOqFLApvvly+QtyZOtzkFlJ1xXVaB5q7IuCN4hdWBgQ+bMyQHDeuDzj
	a/JQrNsGXlxX9B1VR20tZdd+7jeNa07HIcDfQFnvZYcgODwgflGiQOM6R3UhO5Yoc7940blGxNV
	8udQrJod/IifOnAHmBspL8q5dxYVNbKMGefxqg70s4dQmcm1pNjt5MvBJ36wvU6qqnNDc0wnF+P
	CIVyQeQLST6N9haKzKk3KgRGHqk+1PAYdLYVvEEayczBQM19Wa+MDZ3gD0XveTYG6PvZIXfg7+Y
	PTKzCBxxtYTWJY7MwHhE8IbH0u6tt1VBgzlfk5wNsihwyS9MDEvoFV7DxVoearrt8lkVEFBTxqo
	=
X-Received: by 2002:a05:6a20:9189:b0:243:7beb:8424 with SMTP id adf61e73a8af0-2437beb8edbmr19770300637.46.1756366509900;
        Thu, 28 Aug 2025 00:35:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8KJaQSZvxyS9mpzIUMG0blLe+SWobD6gLnmd7P+50PWKvT3W4yCjAe9vVKzztRe6tw8mKrQ==
X-Received: by 2002:a05:6a20:9189:b0:243:7beb:8424 with SMTP id adf61e73a8af0-2437beb8edbmr19770240637.46.1756366509328;
        Thu, 28 Aug 2025 00:35:09 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4b77dc7614sm9605810a12.8.2025.08.28.00.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 00:35:08 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v8 0/5] PCI: dwc: Add ECAM support with iATU configuration
Date: Thu, 28 Aug 2025 13:04:21 +0530
Message-Id: <20250828-ecam_v4-v8-0-92a30e0fa02d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH0GsGgC/3XNQQrCMBAF0KtI1rZM06RJXHkPEWnSiQZsq40WR
 Xp3p91EUGEI/CHvz4tFHAJGtlm92IBjiKHvKOj1irlT3R0xCw1lxoFL4KAydHV7GEXmBVpjtSk
 RLaPflwF9eCxNuz3lU4i3fnguxaOYt98dNJAZYWUj0Uko1LaPMb/e67Pr2zanh81Vo0y8BJO4J
 K7Re2owykDzh1eJq4InXhFvNAdvCo6lFNvrLfzgKnHNP7giDkZ7K1ytlCt+XJ+m6Q31ITboYgE
 AAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756366503; l=5373;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=nfRxF5NGtqrSzfg0wLCafldDGtD2uBMbtfCRBPzXISs=;
 b=L7J+dI+faUp/nAQMwdwLGe8DGzvO32BRkKBYbpuJABhKNmoOBQtyPXIpAGx/jAv/4KY4bFMrs
 ggla+6hpYmtDlXxaK1N7FBpw/daGBl2UGrzwd8D2w7AqXvMBXJVVBI1
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: g0xEzMnWochwQbhQz952u5kvmvVBL3Mp
X-Proofpoint-ORIG-GUID: g0xEzMnWochwQbhQz952u5kvmvVBL3Mp
X-Authority-Analysis: v=2.4 cv=Hd8UTjE8 c=1 sm=1 tr=0 ts=68b006af cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=eK1vwzyvm-k7PeNkGdoA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI1MDE0MiBTYWx0ZWRfX7MjvG2oiP8p6
 d5V19FRJ80KrrO/v75G8ul9CZXqg97xO4daS8PkIoP2RCQH9unUjgxtH0FBc0PLw3uPirR0sOi9
 6mdNsBGmyqf+xXO3zM063/D8yzrGAW1zWsIKUfX6C9UOojXwh+gQKCs3WnjntIAQY6f2Wz2d2nn
 920yK/ipJNpSCvlYVy0rIVsNxnYq3DWmUWvpIVSUgtoxOyQHxvHF+9VmTtVK+SQJKYyYTis+W2T
 d0GjF6ANXp+bJ2MH0xki+SBJNsX0mnCtIrbJXgsf6mb2TXLLUoFr6rSz7M/eegZa5qOK18KQLWe
 dgXcDV7uM7TVRv+OgdDwCsfNn2mY68pmVMCIabUmRQLFHek8OdJ/T8HqmwVoPAd0CpeqLHP6a4S
 +/O8z9SU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508250142

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
Changes in v8:
- Added 256MB alignment check for config space address (Mayank).
- Link to v7: https://lore.kernel.org/r/20250822-ecam_v4-v7-0-098fb4ca77c1@oss.qualcomm.com

Changes in v7:
- Rebased with the latest kernel.
- change ecam_mode to ecam_enabled (Konrad)
- change dw_pcie_ecam_supported to dw_pcie_ecam_enabled
- use FIELD_GET & GENMASK for reading elbi offset (Konrad)
- Link to v6: https://lore.kernel.org/r/20250712-ecam_v4-v6-0-d820f912e354@qti.qualcomm.com

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
 drivers/pci/controller/dwc/pcie-designware-host.c | 145 +++++++++++++++++++---
 drivers/pci/controller/dwc/pcie-designware.c      |  11 +-
 drivers/pci/controller/dwc/pcie-designware.h      |   6 +
 drivers/pci/controller/dwc/pcie-qcom.c            |  86 +++++++++++--
 6 files changed, 232 insertions(+), 31 deletions(-)
---
base-commit: 07d9df80082b8d1f37e05658371b087cb6738770
change-id: 20250207-ecam_v4-f4eb9b893eeb

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


