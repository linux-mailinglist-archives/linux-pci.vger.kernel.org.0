Return-Path: <linux-pci+bounces-35426-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E91DB43244
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 08:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F658567ADB
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 06:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A376267AF2;
	Thu,  4 Sep 2025 06:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P5j2/8Ub"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C129326463A
	for <linux-pci@vger.kernel.org>; Thu,  4 Sep 2025 06:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756966999; cv=none; b=fGsNIS8/mMz2UrUF4qGQWu22jNDVyJyR9y6Hwgiv/i2J7IFXrklGKcVUk9PpAxaL6dc1YMDKSZ/d1MM409aX5/aIzdMuVBgitnDKajeFB36ZIRFJDH67AmJshLeFDqXpTZtMrazD5AKQExkDRL+4Mia4QR0FAdWiaHLX48V5RDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756966999; c=relaxed/simple;
	bh=A64x7+BNXYv782ni3wGjbjBf2GE5tylgSfS7zkngzrU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=o3ChDpdET1vc+InE9PvBquOhmItUpMAPA442TTMP4UF/fumrLXwQA59uVQxf1MDubxLP3s8xGZ9OSdrKH0Ke51s0apE/Nke0NvZEGoc0lAzors54s+AAgn/YwJfaP9ngzda+wCGTK7XZ8mLA5AJkX3eFo0egPUcylyWiw6CNrGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P5j2/8Ub; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58415Ynu004224
	for <linux-pci@vger.kernel.org>; Thu, 4 Sep 2025 06:23:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=8mnxwcogrBs5wXZPmzs5x+
	48L88qADEjdwSP1+OP2Ic=; b=P5j2/8UbZ+fDsvGa+8Wzu+18b5PWMRIDoJ1SRO
	RHVKUbPSgwv7QjvmvBqhOt73odjVyT5A04tWn5GAwVMpJTaBWFlNnvMLF7a7W77P
	hz5m/alBTx9+LmA3iaJ55UXovkROxqxYqRtKrj6N1jHCBTLIhqZP9eGKj70Aao6s
	i1DX20eH+Ykl80xQzZ6xguRts89otj39/raJOLGGEZxsuHhlMOuUnVHDmwRkXzDC
	poCkCqd0VQTvX2+PHcB4W4cCZ7WG/rMHjFzvg11vvveOVorofhnTJ8EzPe9hTRbM
	qokYsXdZ5iDLvZ15iHyMZshaYrkqmQWPJ0cMhcdIQkUPoOSQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura8xaga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 04 Sep 2025 06:23:16 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b47156acca5so599936a12.0
        for <linux-pci@vger.kernel.org>; Wed, 03 Sep 2025 23:23:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756966995; x=1757571795;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8mnxwcogrBs5wXZPmzs5x+48L88qADEjdwSP1+OP2Ic=;
        b=e9P/D0KL+T7My4eL3AinQKmyCSgU4muAl6K4PC+vVubqjsU5NkkRejBMCDW/NXi9a3
         BHObpCRn8yqPOdwQhHnPvsemoQ1oxjFmdEZGoHnu3XL5XhVQbTmpkl2R13LjmdZIob5Y
         /6vE+AT4yKhwxqEVJwdtUDtsBiP2HkOwrGU5FoeVOJfoGQUVKGmSwnedyTTRfekIe1GY
         31cVuhhnbOmtlHxuj72MORgmvnInjokdftCYqB8guzQkVivDuYUArSBmttQRC1k4KVkf
         ept5d/5ht3OCW4SHDkhlIhyQ5h/KrxsawFxIDEp6q6/0WxOgWLlS/xOIcAOOqGmJAYGH
         rRRg==
X-Forwarded-Encrypted: i=1; AJvYcCVprxu9WimADJprOIyQ/Zi3fza9iYFVTlIe5jrsHM3gZwtzSgUZNoK4RQuAM8+KaPADGSQtfT1dJ7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YymqJljyX8oKhneQR1hkZo//cBlGyGWxgmrK26OmeEoay79fpa8
	zvGxlaqn3IbN+xZPPt08ReIdHiQUqFh1RkBPdOofDfOh98Rl0mYyDxMyOfl3Pkdg/6Y/TZ8Kg6N
	Ho84GKENy529DiO/UWPu4KfPIPru5tklqp7VPLdZyFr1pC5M2QOWz+0Vc/QMpxjg=
X-Gm-Gg: ASbGncur9utkDavXe6Do8WdNhLqgiiB6xc878fbDW4bsK8oUMWhBvM/EpIYkJRF+3fz
	mKYVdv0EA9MgKE5Rpsscyhp2alzwwmfXP1z96x3osCBIXcbOOlQfSJlnWRWGX3X2efdR/atbaTT
	k6ImJn0lKqE+iu/1AjiwVtJA9U8CX1qsuTdp+Fs4e0/hv6pI2vHfzvDp6cPtXeWKUQVFMmd74Vh
	6bX4zW0QJaTXj/21U1y07Pbw7ZJ1MgQCCK5tmI/Ye6r/Od9g4CBXVrTGf0xaBbgSZpUtbiE079F
	EJIMroJmrtdfV74b8oQVwcJrI1ZLsYpwDUJlITnv/T8OCvKk7TFRS41yJjieFXaBAZLd7ep2r40
	aTBdsQNv6jPykPmQ=
X-Received: by 2002:a05:6a21:6d8a:b0:243:d1bd:fbac with SMTP id adf61e73a8af0-243d6dfb77dmr24913300637.7.1756966995211;
        Wed, 03 Sep 2025 23:23:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlqYG4j4tCAUQjllJWSXIoBHjaLsyGVsWcC+ZkPeWO4oTZkGeYNcQReC2fOyY0NlmWHVGzCg==
X-Received: by 2002:a05:6a21:6d8a:b0:243:d1bd:fbac with SMTP id adf61e73a8af0-243d6dfb77dmr24913253637.7.1756966994711;
        Wed, 03 Sep 2025 23:23:14 -0700 (PDT)
Received: from hu-wenbyao-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7723427c127sm17120911b3a.62.2025.09.03.23.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 23:23:14 -0700 (PDT)
From: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Subject: [PATCH v4 0/4] PCI: qcom: Add support for Glymur PCIe Gen5x4
Date: Wed, 03 Sep 2025 23:22:01 -0700
Message-Id: <20250903-glymur_pcie5-v4-0-c187c2d9d3bd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAkwuWgC/33MwQ6DIAyA4VcxnIcBBhp32nssyyJYlUTFwSQzh
 ndf9bzt0uRv028jAbyFQC7ZRjxEG6ybMOQpI6avpw6obbCJYEKxignaDeu4+MdsLCiqwRSl0qV
 udE3wZfbQ2vfB3e7YvQ0v59dDj3zf/oAip4wyBYWQleJVy64uhPy51INx45jjILsX5T9DoqEMH
 vhZC2HKL0ZK6QOfhwR68wAAAA==
X-Change-ID: 20250902-glymur_pcie5-bec675b7bdba
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Wenbin Yao <wenbin.yao@oss.qualcomm.com>,
        konrad.dybcio@oss.qualcomm.com, qiang.yu@oss.qualcomm.com,
        Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756966993; l=2136;
 i=wenbin.yao@oss.qualcomm.com; s=20250806; h=from:subject:message-id;
 bh=A64x7+BNXYv782ni3wGjbjBf2GE5tylgSfS7zkngzrU=;
 b=h0WX++anw1r4++tGfxwRySxcmOfq17vKXcxaWu4NTzGiCweIF+C3zdU52Ej9BLOfwpmisYL8k
 zxXXbwVobu6DTD4B5D6Fss26SLI9vduVky2/yeeCTyk3Xl7ip6DosNb
X-Developer-Key: i=wenbin.yao@oss.qualcomm.com; a=ed25519;
 pk=nBPq+51QejLSupTaJoOMvgFbXSyRVCJexMZ+bUTG5KU=
X-Proofpoint-ORIG-GUID: bQcnTSLeINg3CqU0lN4FEAwd5ZTarKX3
X-Proofpoint-GUID: bQcnTSLeINg3CqU0lN4FEAwd5ZTarKX3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfXzTCd/i2CJmZM
 I4C1mwyogfMuW8x/ai2Fjj+Vbe6QvnCZFij8Tu4dqXR79GhmVxkfASl6BQDxpCgUkONL2P9yVa+
 Wlns9e7oP9si07WHAhkkiyEqXxE1UOi7AG773+rJMeVXoYQ5svreXpwElf0VuN7uVbK8RpR4bgW
 Qn+1rMFniSLy6JMqC4O/vERH+Ntj6FalkpDnsZH+Xnz6ukfiJg5wddtD8j4A6Rxgrz5cEw/cirL
 YpRrEDqol8rxXcSWXb4NjAbNMHlNv1FyEv+uuSUVf7wmfk6MRn5V97goDUWiEqshmDibqFnmSFq
 w8vhVnZKeA8t9UlS8i6FPYgF30jidIW0NVJSqpG7+ya2mkJOevmBdWOFNJtKQsrXPN3skJsSylE
 R3E+Wom7
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68b93054 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=TkXPrYfmiUOmToh-xYcA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300020

Glymur is the next generation compute SoC of Qualcomm. This patch series
aims to add support for the fifth PCIe instance on it. The fifth PCIe
instance on Glymur has a Gen5 4-lane PHY. Patch [1/4] documents PHY as a
separate compatible and Patch [2/4] documents controller as a separate
compatible. Patch [3/4] describles the new PCS offsets in a dedicated
header file. Patch [4/4] adds configuration and compatible for PHY.

The device tree changes and whatever driver patches that are not part of
this patch series will be posted separately after official announcement of
the SOC.

Signed-off-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
---
Changes in v4:
- Rebase Patch[1/4] onto next branch of linux-phy.
- Rebase Patch[4/4] onto next branch of linux-phy.
- Link to v3: https://lore.kernel.org/r/20250825-glymur_pcie5-v3-0-5c1d1730c16f@oss.qualcomm.com

Changes in v3:
- Keep qmp_pcie_of_match_table array sorted.
- Drop qref supply for PCIe Gen5x4 PHY.
- Link to v2: https://lore.kernel.org/r/20250821-glymur_pcie5-v2-0-cd516784ef20@oss.qualcomm.com

Changes in v2:
- Add offsets of PLL and TXRXZ register blocks for v8.50 PHY in Patch[4/4].
- Link to v1: https://lore.kernel.org/r/20250819-glymur_pcie5-v1-0-2ea09f83cbb0@oss.qualcomm.com

---
Prudhvi Yarlagadda (4):
      dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Document the Glymur QMP PCIe PHY
      dt-bindings: PCI: qcom: Document the Glymur PCIe Controller
      phy: qcom-qmp: pcs: Add v8.50 register offsets
      phy: qcom: qmp-pcie: Add support for Glymur PCIe Gen5x4 PHY

 .../bindings/pci/qcom,pcie-x1e80100.yaml           |  7 ++++-
 .../bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml   |  3 ++
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c           | 32 ++++++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v8_50.h      | 13 +++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.h                |  2 ++
 5 files changed, 56 insertions(+), 1 deletion(-)
---
base-commit: 356590cd61cf89e2420d5628e35b6e73c6b6a770
change-id: 20250902-glymur_pcie5-bec675b7bdba

Best regards,
-- 
Wenbin Yao <wenbin.yao@oss.qualcomm.com>


