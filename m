Return-Path: <linux-pci+bounces-34541-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0186B31316
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 11:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 138001CE8438
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 09:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412EB137750;
	Fri, 22 Aug 2025 09:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CjF4PYzP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0CA29E10F
	for <linux-pci@vger.kernel.org>; Fri, 22 Aug 2025 09:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755854868; cv=none; b=gogLy6CpeoUy1QNpJLhncAaFyaMXuLcrwicjGBM/EoPPS6ptOnzOE1Zhzn8lj1lsc9BqtKxD33ifzWZldg8NH0443YE5tee2mK7lJ9vaEE6BFFZ90qSzILEsfRvJ5Ayh31XfP1/oPGLzuradCU8FtPDiHHRRR2Tre89zGumBP3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755854868; c=relaxed/simple;
	bh=yXJV3kFmbspce5ZH3bdBirn6VeTHhu1tH4YGgNviN+M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=L1f2hCIXieNP3GB17kUE7MNSitrvbfOwKrqXH5jU/FbiVbOpqVE9j+Dxhyurp/70lTtVgxNgKjAEIWwz/AduMIT9xud555tM2UiqRdgsPwIuWqI28ULYOyJq1FJ2H2GYmluIFLQkMu+ZdOgswET99g4/uXz35Z4ybKguVWWdCLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CjF4PYzP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M8UkKG029666
	for <linux-pci@vger.kernel.org>; Fri, 22 Aug 2025 09:27:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=XpL0M86UlKf7ZCJz90gMGA
	89euCiWUR+5qp7LqODIu8=; b=CjF4PYzPh5ruNgkiYayyjeX4/Wrq6aVBMUlldV
	KFYDiFjmTpxQJDA+8mvOgz6WmKZPnWe6ukzbXms/jfXcpwvGkhSzrkil8BG5/b/k
	J6euN2QnYNMEAQcZA0uv+Vj6RS0ioVPWN3VPPzIBdkJcNQucZuV9Yy1XcwWGcwo1
	9b/u/ner8HDTibI47O+0dqDw8AQRnffy2FEC1aVv6uYIzR6SMyX9dF9yT5SGeeyg
	7cDBzKj1OqtLAZYEeMktrgf/Ngl6bKqKhB0zGfPz3H4dUpOzYbalPeJkbckQv4XF
	a8joBLpqzfoP/Hs4LK2INWlgIsfLM5ThPteiZqMbwH0zI79Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52crpar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 22 Aug 2025 09:27:45 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-325228e9bedso1072079a91.1
        for <linux-pci@vger.kernel.org>; Fri, 22 Aug 2025 02:27:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755854865; x=1756459665;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XpL0M86UlKf7ZCJz90gMGA89euCiWUR+5qp7LqODIu8=;
        b=LMQLVPtdq6OSd5/8p2tuZwZXEZrINt1SyZ0mFwvrIBBQ11/GNxaRwj1Uhny82zOAKr
         znAcGAzgwV3Xw34Xkx6G4OVvcXQW3gZsHPi1d4edszGu8wEN/6ebppSgbS1lP4ZaWsKu
         ijY2EcJu0tiqQoJvMFxff+nOr6lNeT0U7oAlHfKgyFveriVeQ9X1CakU2eNDEp+w9Z95
         TE4iTBJ+DVJHxfpcJHtruho/6yNz17l4dFSwXKlJpQtjjFtXZoUy8Y7tbrsGZbbK9Cvh
         VK4Kx4r6ZFhdxYn7aiMNJCr3rCfmhSKvZ9Eu+y0ZvqezWgofjEJmykyY6AKCoUqlGXeQ
         7xGw==
X-Forwarded-Encrypted: i=1; AJvYcCXW8Ue83PTCbVDQ8BtdIuSCishh9I/669hEglIThbYAoJXAEA312//wjyTF/IOOdt54adV6VCLNNeU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy1VTc7/LaDKppmCbtIi+NZevAEquTAummKH2XcgQSAhH8I1rE
	3PTtKnfdosE4VZBXxxsthVBpJkcQ6o7yc0eIvk5XD+WuI3b42PJnYGOPuWIa2UQaPwhadeCK//9
	KA8WTMej77msxh0ajNxf7YdkZ7YfDwmjqKEW4gZkBnY5mYuri0YiGV1lQ0F2d8Tk=
X-Gm-Gg: ASbGnctDw0aLwaeVQ/SL2zyp8ewwAOxjF1jYKddKC6/Sq3M4OtKSzCu81lGBuPQzAd5
	ETAOg6w8JzNjicHaXRDda9GOBKfvPvarEfTRNFynqenIeUoD/sByJ/svWOlHWLDlDt9zLpvGAQ8
	mnjv7uB2BIS4gtjWoLt4p0kRXhYyTX+ZchhijH2/NTyaspHNCS3YT5M27aSUm8h4SKSaz54ZHu9
	Hx1hU44Q4yYLkvHO+7/WhQ+Z4hoWnVez6CjHCa0pAmaWvXZvzWeYS7B4d0WNKxX1SchNCSldzpE
	Dw9mJnG/bgRV3k7Tslc0nGbgoMFVqo0/UadcwS0+1T607/oPjhNVTvTPbTFyBLozvlXSBQfqS9Q
	=
X-Received: by 2002:a17:90b:3e44:b0:31e:ebb6:6499 with SMTP id 98e67ed59e1d1-32515ec135dmr3652771a91.24.1755854864607;
        Fri, 22 Aug 2025 02:27:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYtQzKOaZCDpvTt97KeO48fJ7AYIXggvayF45Tbj92jL5AzTKglrhB+gP4Rkm1fziAbf9Icw==
X-Received: by 2002:a17:90b:3e44:b0:31e:ebb6:6499 with SMTP id 98e67ed59e1d1-32515ec135dmr3652738a91.24.1755854864128;
        Fri, 22 Aug 2025 02:27:44 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32525205d1csm549417a91.4.2025.08.22.02.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 02:27:43 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v7 0/5] PCI: dwc: Add ECAM support with iATU configuration
Date: Fri, 22 Aug 2025 14:57:28 +0530
Message-Id: <20250822-ecam_v4-v7-0-098fb4ca77c1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAA4qGgC/3XM0QqDIBiG4VsZHq8w08wddR9jjLTfJaxa2mQju
 vf9dRJsDET4xOedSQDvIJDTYSYeogtu6HHI44GYtu5vkLgGN2GUCcqoTMDU3TXyxHLQSpcqB9A
 Efz88WPfaSucL7taFafDvLRz5+vrbwEMTxbVoBBhBM1kNIaTjs76boetSvMiaimLnOVU7F8hLs
 BYLSira/OHFzmXGdl4gb0pGrcoY5IJX4+S++LIsH4dIeDwjAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755854858; l=5197;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=yXJV3kFmbspce5ZH3bdBirn6VeTHhu1tH4YGgNviN+M=;
 b=bKdh1xwdvRKX/Dzkk189uKobWstlcTm2FsrwdLTePzDnfecIOI3m1Ce90U8HRb7UB5I854WxB
 V8GP3B/lcv1CjST7S+11GvfCND8q1BOWlmxhCpgr0SK938UseFuv9I7
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: S5Qn3lF8rqdBg4F2B3HQYin8XI65gyCP
X-Proofpoint-ORIG-GUID: S5Qn3lF8rqdBg4F2B3HQYin8XI65gyCP
X-Authority-Analysis: v=2.4 cv=Xpij+VF9 c=1 sm=1 tr=0 ts=68a83811 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=eK1vwzyvm-k7PeNkGdoA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfXwZjTY9SUcXhB
 lOw88gH6y+HNnbCLjrIWLwwF5A6Ca+iW/ZxhDCXkvCY01cb1x2AmUv/imxcz78kjqH5XeLG2n5r
 7t/bGl2mseoY/+PXnSn7DsxTvCyZtdxgjL5znb4v/xpolmuUkkxMZB3CVSFw61IwlSqSZmEuVCr
 okask5K13VCXYaIhKNYleofzV8Mj6FQD5VQ4vfd+vsYJEVQaHQeqXyxdvSmqCdOXfhzTLVrezhf
 JHwDn+0HSloMgZtT5sJIT3rgBCfKYow0U822Ky0DFXVqGGVHY4jEOyJqHA1X1nrQEpqefdoIXsg
 LGaQ0MkdZsV3h1VB/yHhokr7zzP1O8dDEr8Q5+9tY1OMkWn6NCuf5mSyBGhQhkYa00Za6GK3req
 A/lztAP5pSrR+DEXjdFEtsw7pxLWoA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 impostorscore=0
 adultscore=0 spamscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

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
 drivers/pci/controller/dwc/pcie-designware-host.c | 131 +++++++++++++++++++---
 drivers/pci/controller/dwc/pcie-designware.c      |  11 +-
 drivers/pci/controller/dwc/pcie-designware.h      |   6 +
 drivers/pci/controller/dwc/pcie-qcom.c            |  86 ++++++++++++--
 6 files changed, 218 insertions(+), 31 deletions(-)
---
base-commit: 3957a5720157264dcc41415fbec7c51c4000fc2d
change-id: 20250207-ecam_v4-f4eb9b893eeb

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


