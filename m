Return-Path: <linux-pci+bounces-34359-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CD4B2D67D
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 10:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 516AC3AD2F5
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 08:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD1B2D8DB9;
	Wed, 20 Aug 2025 08:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pl5OA4gy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902842D8DDF
	for <linux-pci@vger.kernel.org>; Wed, 20 Aug 2025 08:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755678540; cv=none; b=fCuLtVN/hI1x2Ieib/DyPy16qEo8FzhLMyMrwjbA5ScR3MdtGhlR7ICjC1o82U5sfLH95GwAcbV6dqwee4x87W6Lj85sp2z/2ap7haO+7gyQW1jVIFkPRxymkB5pYDmbh+xjU/10dOPGLfDR/SDovOgPc05nV/8EFRl7rPMlnSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755678540; c=relaxed/simple;
	bh=X3NDtfC1cWu4dZtZLIAVsO8gp7pHZCRAiBFgCH8/6vk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uNw8Ujl8KTko/Zj0WRSzVcDABgNfx1QHbvpZMv/zf9kTI8AL2h/7IFTKQqeKvpO61bcDKaBz0SjBBww8x7jmvCHhdCLjYNM575lvseVo3uJPBjmZi3SGk7/7Y16NCcBnGJ+/17609kpZ57tB5lxGRHWboinGlC5lyZRTphErdf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pl5OA4gy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57K1p5IU007725
	for <linux-pci@vger.kernel.org>; Wed, 20 Aug 2025 08:28:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=CmpzBPwQa+UjpZQOJQ44S6
	K5zRjPKs+C8GINcEnHLFA=; b=pl5OA4gyHZ/A2X+swKQtiGGlme5I94/YwE+0Vc
	gMuFGicFfawwc1BMi5fvYpaHJ5FxplboXH6rdT5u73cuW8SkH9Z8u3h1vvscpett
	byseLhHs5oGVVvab1AslbfukrHqbgok7IqIidGjbVgvkOh6Iqx87rUBEY9BhqvLP
	AB/2+qFwdU4ziELB+kZm0TnjnOWuCee0GKCWKmJiMLJuTrKGjuA7TpRMYVdGxCHb
	r2qpLc8E84jVn/TRaUwAYa5+nn9M7yOqAee2rMTxjdMlyjQWmQcH2PKrAGUb7J4M
	HWZ9xcHFV4kc8JmO9y3hzTeIqEhkU85rz14RgI34DDd1mYgw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n5290yme-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 20 Aug 2025 08:28:57 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24457f4f3ecso76291995ad.0
        for <linux-pci@vger.kernel.org>; Wed, 20 Aug 2025 01:28:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755678536; x=1756283336;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CmpzBPwQa+UjpZQOJQ44S6K5zRjPKs+C8GINcEnHLFA=;
        b=hywHrwQoYugrNs78oocXFlrmj42yvZ1op0j06fBOtPlO9+dPrwFpprF2IRuECNXzCp
         hsv5l1Uf7mCUNUej8ZWvtqVLnht8W+p6g3cZDvsm8o6CMUlUkMcgoho0G5HNz1khXk2x
         QqMGmLGe2ERjjxZBQY9WKzYu2R1BCxcucN8AHS0gm9+rw8pUudMfCGZOUD5UUdOSmktN
         TGDaxieIV2V8a0btggc9GHd6vg/4uHWYqT1+amiIxUf+6dWM6QY5vHvk2puCDepQXSjI
         PcbSxPEbwYzI3qSSXPzre8w4ENGJeZaAItkKB6/LaYgpaJCwvJpyIeScLDzscC1dp1Ip
         EmYw==
X-Forwarded-Encrypted: i=1; AJvYcCXgPKS6xeluLxxQiJsD8u9dYmCOAQ1NVigiJr8nHsUu95rqnpUaKLgQtCLOCml3ZdIwpwQYmedqXM4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0mqj8rFMLxuZ9JaHmJU2ADDxw4jcFUwApzAmuE3f38AIZepWT
	Mi/OAecWMt2bVipj+QCmhs/gSMDQUngpDOprYCX+8xtChF4C1Yle4SVVrR987gDvqJBebLMan9+
	ojeWsK1CAzrWC7HJD9d4c4BsoWjrw7YwyI4wIijsuK7Fgzd5On0WofykEguNU7zI=
X-Gm-Gg: ASbGnctJSuTnbSQ8uBvt9quWXrZb9ECEtb0HLJS94Lp4r6Nb66/yXm3VQsMZ9grUBNk
	gV5eUT7VCLdHTWUAiqakvMc1/nfMNI/xjyM65lg542sWujGox1AB6Emumgx2OiRaGJuLy18zWuC
	V6Ax41v3D1ouJoChgGZ4ExSKFBvozxCMv2OZwjdiMDlKjqmzUr/zdKD5bgEuHQkOLzKXvdCOpin
	PpN2HE0L+V0idgBeJhdtRBb1TQ5m6qokfBVoLPhkV4WIVv5I6pyNUeSCPvhLkQt0KuoUkYNQ6E+
	fZFK5PGf4muOUOB9qYXmKaYmNYIvOqqWmIqetgZezUl8Cnw+ZYcudXIjznQJ1MgAmjc8SPXANLU
	=
X-Received: by 2002:a17:903:2bcb:b0:235:ef67:b5a0 with SMTP id d9443c01a7336-245ef20d792mr25821685ad.36.1755678535861;
        Wed, 20 Aug 2025 01:28:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE28MvmINjA3w1k9bCVvrE2GtApQELBr0tWyQ7h+61pd2i/ZqCXKwnJwegPF0yabrIA+03Phg==
X-Received: by 2002:a17:903:2bcb:b0:235:ef67:b5a0 with SMTP id d9443c01a7336-245ef20d792mr25821355ad.36.1755678535439;
        Wed, 20 Aug 2025 01:28:55 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed53e779sm19037735ad.160.2025.08.20.01.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 01:28:55 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v4 0/7] OPP: Add support to find OPP for a set of keys
Date: Wed, 20 Aug 2025 13:58:46 +0530
Message-Id: <20250820-opp_pcie-v4-0-273b8944eed0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAD+HpWgC/3XM0Q6CIBTG8VdxXIfjoIh21Xu01kSOyZZCUqzmf
 PfQm7ywG7aPnd9/Ih5Hg54ck4mMGIw3dogjPySk6erhhtTouAlnXDAJklrnrq4xSGWVQcEUVwA
 ZieduxNa819T5Endn/NOOn7UcYPndiQSgjGqNRZsLLiSok/U+fbzqe2P7Po0PWVqB/3wJ5cbz6
 GNS8FxXZVXIPz7b+mrjs+jbUmmJTDSYw46f5/kLho+vVycBAAA=
X-Change-ID: 20250717-opp_pcie-793160b2b113
To: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755678529; l=2759;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=X3NDtfC1cWu4dZtZLIAVsO8gp7pHZCRAiBFgCH8/6vk=;
 b=jvLCZHoCMOTClHYyPiRo6iC71xvLNWiHrbOs1K6j42UoXYh7pSLv1vP5mYe0LBq8j3wAWZZyj
 Q0mt2IKGsTJATDNObUD4OLFkvFofS7o8vw7SE/guC2H5a/XhPLczeI3
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=Aui3HO9P c=1 sm=1 tr=0 ts=68a58749 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=76l3OPsZB85xAofE:21 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=8_GxwEYHqknyFer8HbIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: mLUcaJJtEv5fGMH_-DRSCOcn5iV40ED6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX9Npgv9H0v8ln
 7eAkqT7eqeH0e6kfj5Mo/3L3pfFven1FG4clH6opGacJAB+O8xHLMAK9Xyb+wXLwYA2t2c9CG3r
 0wNk5CluJ+Ew8vQ+d0QFdQPQ8VQ1mbIQo7g5DSsPdgxY6rI6/AOIZUMR1lbAbri0CK6TD+C5lwd
 2cE9W7sBeAPYtLfV1SJN5VL5UGPWuUl8odjZNECxLbUMxF5APV4QxWqx9xVRGtAXjRiBrDxtQ+s
 dr0y99R5dF4mtF2HCJDebBU3+9c5YGrqkVgsLoI6lz/kSXZNsCqDUoLcIj5gqzxqD3b1p7ARDw0
 SK99YwjvcrqaAdmvSi1VQoMh2wn00uQqASyS+2/m8/cx6PjLmktfuUONum8RFGOF5Viyu2nf7Hl
 TqlvGPz4+7YR/8kbUGyPvsDTEhU0AQ==
X-Proofpoint-GUID: mLUcaJJtEv5fGMH_-DRSCOcn5iV40ED6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508200013

The existing OPP table in the device tree for PCIe is shared across
different link configurations such as data rates 8GT/s x2 and 16GT/s x1.
These configurations often operate at the same frequency, allowing them
to reuse the same OPP entries. However, 8GT/s and 16 GT/s may have
different characteristics beyond frequency—such as RPMh votes in QCOM
case, which cannot be represented accurately when sharing a single OPP.

In such cases, frequency alone is not sufficient to uniquely identify
an OPP. To support these scenarios, introduce a new API
dev_pm_opp_find_key_exact() that allows OPP lookup for set of keys like
frequency, level & bandwidth.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Changes in v4:
- Included dtsi changes for all platforms.
- Made the changes as requested by Viresh like adding comments, some
  coding styles etc.
- Link to v3: https://lore.kernel.org/r/20250819-opp_pcie-v3-0-f8bd7e05ce41@oss.qualcomm.com

Changes in v3:
- Always check for frequency match unless user doesn't pass it (Viresh).
- Make dev_pm_opp_key public and let user pass the key (Viresh).
- Include bandwidth as part of dev_pm_opp_key (Viresh).
- Link to v2: https://lore.kernel.org/r/20250818-opp_pcie-v2-0-071524d98967@oss.qualcomm.com

Changes in v2:
- Use opp-level to indentify data rate and use both frequency and level
  to identify the OPP. (Viresh)
- Link to v1: https://lore.kernel.org/r/20250717-opp_pcie-v1-0-dde6f452571b@oss.qualcomm.com

---
Krishna Chaitanya Chundru (7):
      OPP: Add support to find OPP for a set of keys
      OPP: Move refcount and key update for readability in _opp_table_find_key()
      arm64: dts: qcom: sm8450: Add opp-level to indicate PCIe data rates
      arm64: dts: qcom: sm8550: Add opp-level to indicate PCIe data rates
      arm64: dts: qcom: sm8650: Add opp-level to indicate PCIe data rates
      arm64: dts: qcom: x1e80100: Add opp-level to indicate PCIe data rates
      PCI: qcom: Use frequency and level based OPP lookup

 arch/arm64/boot/dts/qcom/sm8450.dtsi   |  41 ++++++++++---
 arch/arm64/boot/dts/qcom/sm8550.dtsi   |  63 ++++++++++++++-----
 arch/arm64/boot/dts/qcom/sm8650.dtsi   |  63 ++++++++++++++-----
 arch/arm64/boot/dts/qcom/x1e80100.dtsi |  90 ++++++++++++++++++++++-----
 drivers/opp/core.c                     | 107 +++++++++++++++++++++++++++++++--
 drivers/pci/controller/dwc/pcie-qcom.c |   7 ++-
 include/linux/pm_opp.h                 |  30 +++++++++
 7 files changed, 341 insertions(+), 60 deletions(-)
---
base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
change-id: 20250717-opp_pcie-793160b2b113

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


