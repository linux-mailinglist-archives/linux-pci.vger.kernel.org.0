Return-Path: <linux-pci+bounces-44328-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9E4D0788B
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 08:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9157D3047192
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 07:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C4A2EBBB3;
	Fri,  9 Jan 2026 07:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BoEBzhfi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MsvDWh1i"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCC429B8E0
	for <linux-pci@vger.kernel.org>; Fri,  9 Jan 2026 07:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767943279; cv=none; b=tpTVHVUeOzA7SJoyBT+S7TM4GyfNr0ulb+aAQReNmXYWW4jqbxRCjZlDXqHIR/isRBWpz2JpKZZaafif9mzYE3bzb/afiUgs9AexTl4JZWecQ24Y1VSgORy8mG5qX4TD5Eo2XXblS4ric/e6hD8oyRG5Y7unMHuTBT1B463KdQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767943279; c=relaxed/simple;
	bh=2iLTHGWWp4AzJ7oli8atcmBSsHfhHA2O0yBWHWcnRNs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=i3XW2QyAvVollnFi7PK7F2Hus3MdUh4zD8rayaC4/U+5thmOj0l+njHg1780xxU0YKEUXgcQWeLOU7NH9K8ip0J1qH9qCQz1DuCySfnEURh+cwojI5mcl1qXlaD+2c5pEPVD+HZWHa2RPv50hyt5ZfNiNh6U42Y/VEIm0PRCJsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BoEBzhfi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MsvDWh1i; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6096ETRY3019530
	for <linux-pci@vger.kernel.org>; Fri, 9 Jan 2026 07:21:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=w8/JF4/tv+7RolLNf/bATg
	nZLPU/tYClxfiouVTfnE8=; b=BoEBzhfiEu9C8OxNDpUZR1L+WlHQxrirT5yAj9
	cWij1FcNbWSZPZu2AFk72pzlUpAmaRgyQOUaqzTlDtswEGmPB4aQ61hH49+L1rq9
	DCwJyqz+ssfW8Ywi39mERZd0atmz9n6qLbioJwZVyEUAP0NQJhgNF/OiTeO1/lwP
	0Zuxs1/6wsFsQbH8HigyMVdqndX/YiqWBrBW6R2NnUA3NZM/l0LEFOEZAgxXoL5e
	LqwLU13M2WdLeOj2A6oiLta8HjFmAgjzzekVXZSmSQ+XOPmKwIKbMXzuDFb4tJSb
	caGpJRlIOzYDBnV6f57LR/wGOzolr2AcxYtloEbC7+lKg3CQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjjk3hqn8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 09 Jan 2026 07:21:15 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-29f8e6a5de4so43838625ad.2
        for <linux-pci@vger.kernel.org>; Thu, 08 Jan 2026 23:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767943275; x=1768548075; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w8/JF4/tv+7RolLNf/bATgnZLPU/tYClxfiouVTfnE8=;
        b=MsvDWh1iwBcZJYg8oQPk73CpBuH+D1yHfgTxGfDWXjmLoqP+GjEjzUqo5K0cCGc746
         s4LbuYSQdAoqCjZeBwfXxm1C4xLVSl9w2ceOairHNVEBWRJlSXQ2lvT+w2GU1Fund7Nl
         q2/9pGV1QZw1mkLfdcaovRvZND7JMhOe2HR4h6q/OKl+84SFI7w0LLQjC98jhJzwhcAw
         pWJSmMNddclC9JNR4DyCNLSm1Aa1owmFnRY/+BztGpQiFPdVg2+jhGzBX6YzEdy7sj1b
         47g6S3rRFGHbfLBBZcyu7Jd4Nx0KT3KdkEMi7gaQ0xmVjZ3YTbm+Ije2QUG0a5eX0ag9
         dm0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767943275; x=1768548075;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8/JF4/tv+7RolLNf/bATgnZLPU/tYClxfiouVTfnE8=;
        b=fT6ItdTRyhJoRY1SM7O76v+InSW3lc7yHV8jhnNgLTS3z0Ixl8U7c2JID+ZfahcQM9
         RPOjzDH6pr7SG2gI4OPl83hQFL6md1qoN55BB50bpmXWxLQaFDssUJqWzkcWNwT2OvxT
         i6oF/JPRpjpDTwueCid5q1vJcM7QEoh84qh2dT9vevlwG3o+Uxs2VcJYHC820Mn4YbLi
         Bhd1C5joAOGV7YwDSWp9DfMZswsJUZFJgNyQfuzgrCjuZwF5FRW98ujpyw9oPRekWt8G
         Yqi69l3TDDuJjHhXmxWaJKnDtmxMzm5mQUj7gT4B19mDr96Vv+wjcq1RonMENlpScKjc
         gxOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVl2XIrLvghiu55GeBYTGqaE8mJzAQlux/3TASypY9LW36QGRAycOuMMIAKbDyUmQ238exRB4ykuVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy545j+CfzUQdmVT3P2agma/GNsj5JGemzNVixDvoQk9F2mSyQz
	tqio2PzLa/P1ObMh1P2QSxqYmDn0mkQ/7Tv8tziFSzEZi7oMDkHVmvbFxJ9Ir9H5BN/nbiH2409
	ZS+b1x/5KdW5Yzi07kk7ejJ9AR7uy06OYGU8m23D8gAG+JvrWds/ydw12cQlNsVjthbZW5gE=
X-Gm-Gg: AY/fxX4/RO06Fl127vtiEi80GM7spjS4U3V04CtikaLvqvYEqBcNZGqAjh+j6pYk7rx
	cWVthHrYpJWZ5fGy+ABdzHnq7o6PG6qIIy+5KZxwoVTkpio9klzIG6YBzp1kIeAy11d0sgnps9B
	DMj+UqPHuNwrsOYGennm74mwtc2dl16ZuXt4xjolSSRvCeAUTHw8PtdgL/34ZVk9eytTHnuhnk6
	hQeE+2f6P89j8gmTZ41QN6Dw6exMLDRDuIoAfBYuztOSs8Pnu3sSU2wo5tPvOce+4GkqJ2Bh4Mq
	uT6HeEU1o5ARSqX2B07jCHNiB4tXzE3f5EZzFRE5I1fmfQcUm683DnDI65AN6veOJc81CQHLUri
	W5I3eXHXMukQIE22BbuwpFCoVQhxtp4KJz9OLsCXftuHQ
X-Received: by 2002:a17:903:19c8:b0:2a3:1b33:ae30 with SMTP id d9443c01a7336-2a3ee4a653cmr68655995ad.51.1767943275033;
        Thu, 08 Jan 2026 23:21:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmX85K7l00KBW1kA6f3TQ3NMAR6fIywTS9QpDPhMAiF3kY9dOi0NzcCSQ3m6cZ6XwkDmcefw==
X-Received: by 2002:a17:903:19c8:b0:2a3:1b33:ae30 with SMTP id d9443c01a7336-2a3ee4a653cmr68655745ad.51.1767943274505;
        Thu, 08 Jan 2026 23:21:14 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819bb4c85bfsm9510369b3a.30.2026.01.08.23.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 23:21:14 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH 0/5] PCI: qcom: Add link retention support
Date: Fri, 09 Jan 2026 12:51:05 +0530
Message-Id: <20260109-link_retain-v1-0-7e6782230f4b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGGsYGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAwND3ZzMvOz4otSSxMw83TRDC0NjA3NLE/NUEyWgjoKi1LTMCrBp0bG
 1tQDBpc5xXQAAAA==
X-Change-ID: 20251001-link_retain-f181307947e4
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767943270; l=2484;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=2iLTHGWWp4AzJ7oli8atcmBSsHfhHA2O0yBWHWcnRNs=;
 b=ieJv0ul7NIphohRIMQNN6yUm+5gKS7whPVUUZtuXY2TeKz3puKJwi0QVvzHH5JsVCQwJ30t9W
 nWs5yjR+ZeRBqwJ15FQLxGnQ+FCMeD5fWD3NrNzUS04gRCgUgnsQ7eN
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: hLnlnu22c93QGDRVjoSv0-6VKKsvvcx6
X-Authority-Analysis: v=2.4 cv=EazFgfmC c=1 sm=1 tr=0 ts=6960ac6c cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=gKsALX6-UOwXnLYYSJMA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: hLnlnu22c93QGDRVjoSv0-6VKKsvvcx6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA1MCBTYWx0ZWRfX8SItShMHaUSD
 r9BawZaK184eqbmnDP57NVA/yX9a9Zi7W+a0LsaxptKiiKVTRma5I5BKFuZx3ArJLKfnoa6rgzj
 kSqNCc2S3bRA12A7YIRhEBhFw7oqaTUxI/1vJX6qQqzbppdu6vrm7d08k/YFSUl6DFkh8YBKfCx
 atDsfJ6B7Rasd8x5GMazsLRAA3e4fwzuosPg7YWZolbwtzd/SByRCzHbeWbZLtel18sPwKtMNkC
 cZNHll4EMOOyOWl+849bTSho168zMuhO6KLEO3K9F3h/W4Gp+zISYP3SIFk7TG8GM7s+F9E1kA4
 Eqhi62369lvVGrj7WnnlMEyVo8skVqBgOlpQjMzdzxt39V+3MFcAhyeZcbK4kDLM5xcrqlunw9s
 vsOrR7YXqmsB/6HDziIemfX7ZkMKKXnxAoy4cMG5DI5E52l9euuOCCOl/VFGfMWNeSxPAmmNHaP
 Lhk+Bl0Opsd4Q7fUm4A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_02,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601090050

This patch series introduces support for retaining the PCIe link across
bootloader and kernel handoff on Qualcomm platforms, specifically
X1E80100. The goal is to reduce boot time and avoid unnecessary link
reinitialization  when the link is already up.

We are not enabling link retantion support for all the targets, as there
is no guarantee that the bootloader on all targets has initialized the
PCIe link in max supported speed. So we are enabling for hamoa & glymur
target only for now based on the config flag.

If the link is up and has link_retain is set to true in the
ithe driver config data then enable retain logic in the controller.

In phy as we already have skip init logic, the phy patch uses same
assumption that if there is phy no csr and bootloader has done the init
then driver can skip resetting the phy when phy status indicates it is
up.

Problem:-
1) As part of late init calls of clock & GENPD(for power domains) the
framework is disabling all the unvoted resources by that time and also
there is no sync state to keep them enabled till the probe is completed.
Due to dependencies with regulators and phy, qcom pcie probe is happening
after late init which is causing the resources(clocks & power domains) to
be off which causes the link to go down. To avoid this we need to use these
two kernel command line arguments (clk_ignore_unused & pd_ignore_unused)
to skip disabling clocks and gendp power domains as part of late init
for initial version. Once it is resolved we can avoid those kernel command
line arguments.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Krishna Chaitanya Chundru (5):
      phy: qcom: qmp-pcie: Skip PHY reset if already up
      PCI: dwc: Add support for retaining link during host init
      PCI: qcom: Keep PERST# GPIO state as-is during probe
      PCI: qcom: Add link retention support
      PCI: qcom: enable Link retain logic for Hamoa

 drivers/pci/controller/dwc/pcie-designware-host.c | 11 ++--
 drivers/pci/controller/dwc/pcie-designware.h      |  1 +
 drivers/pci/controller/dwc/pcie-qcom.c            | 62 ++++++++++++++++++++---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c          | 28 ++++++----
 4 files changed, 83 insertions(+), 19 deletions(-)
---
base-commit: fc065cadc7ed048bedbb23cb6b7c4475198f431c
change-id: 20251001-link_retain-f181307947e4

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


