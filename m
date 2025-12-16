Return-Path: <linux-pci+bounces-43125-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1ED7CC358B
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 14:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 12C54302698C
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 13:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0113C350A04;
	Tue, 16 Dec 2025 13:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l+zijw4O";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gsSosJBb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2B631E0EB
	for <linux-pci@vger.kernel.org>; Tue, 16 Dec 2025 13:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765892967; cv=none; b=BTCIURE/v/0cCVGMC3vt+Y3QAQFPJqN82LKDNFqOn1u8ewHjLFs7IS4Y3uDBYjj06jB+R3K5weC0UPw7fIa3sxhDOVjTfA+WsJnI9R36xrEnvmX1QnV3cgJQlYPs55GlSpWt4hBK8KzOW3cGmPJ6hLuHnP4iyMAmSBXNx+s+4Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765892967; c=relaxed/simple;
	bh=o5xvNKoR4C0Nnc69joVwaN6SCdPxQG2DIvrl/F+bC3U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tJyvJUVlNqGdSPFX8y2eehFYlYLHxb6ravqW7kfpmCEiBEbH3sAzPoLE61vTfp2x3WPQ3xlmcIEFDCRitFuijZ55YltWJF07SQ2a3mFOn+4AK2H5h6V+M/H4+1OyTittwrYwCvWAmBmk6Qi+n4jZk9KNGPlSEkhF2oZSjyXDbCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l+zijw4O; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gsSosJBb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BG9Zwf63349479
	for <linux-pci@vger.kernel.org>; Tue, 16 Dec 2025 13:49:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=V+rxAn/mWU648GjzPtnou8
	6WaGgXZuIA7ThGWeN7Ilc=; b=l+zijw4Owxz8KxC+JGXWbxaSuYCgls70OnEtZS
	sNgwmeK0VQOoSSfx3Qg7p6VSqS6ejbu4x0sb6sLpTt/ML3JYVjANT048KDntKZoz
	SOI5yulsb/4aetUCMDHRdBevTiyO4YqG0qScihm8N5N/1v3Q4RpBtQ0iNkzgKWNN
	jufKkiK/AyNpIBLZPbd3pN+p+u0uN9kN50QAsJrqdDkG1EShnGwSOurIsvK2Bqtp
	k9YniD8yBvVQhNMprTvtOxJQqVcXxT+THzTqaExpMsRNMbUqQMWyrI3tYbf4VOKj
	B/o6KUu+Qj0nZQDzmxU8J2++9IHBulcwlesfOKXZsXBNZ2yA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b34xd0y4x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 16 Dec 2025 13:49:25 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-29f1f79d6afso48556255ad.0
        for <linux-pci@vger.kernel.org>; Tue, 16 Dec 2025 05:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765892965; x=1766497765; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V+rxAn/mWU648GjzPtnou86WaGgXZuIA7ThGWeN7Ilc=;
        b=gsSosJBbwVa0G3+Spk6JDAzc50WXUkSwXqEyaminoQBTFWnwLM8rDNlsh/h3MCf1m9
         4SHwtgLJvmoA2EK7HTQ0+rdsp/axO+RwEwGJ5wFeNRHk4v2kcNMX9z9J+fh1qfyywn4R
         Dj2GKp8lsHVvRvszpp2A2fQzW668v7uy6UKs2Q9niJKPcevpNJtvGE9GLrgUNbScnpCv
         iD8AlMAck8o25aSsJ+uJV+gnXXCNcmhXrb7c3fCSpOuejoGB8jjtV+ufsAFdUMDBrXP9
         FDwQf57cKcgdnsivb+3hjaq+FERA6Z3ogSXCzV+UyKloszIYmCQmlYFkQI80osO+W8Ot
         9NrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765892965; x=1766497765;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+rxAn/mWU648GjzPtnou86WaGgXZuIA7ThGWeN7Ilc=;
        b=CEjjxr1n5XNUBMdf2U8RLlNgGRrabXEJW1YX+PsVHYVk6NxLTDs5+AUi4+A74RzQdv
         mMudC60DijCFvCq71Tjgbk498LJ90oQfubOjHu1lZUag/selM6FTUqvcK2SXC1MNWUcl
         DJVGg9Hu13sd99yvrgB+PmMGkIHHbGsQ1ElHFuRCH7urU/iloirj1fsdCPNbM96PjIdo
         geO/IVNtlqjtBQXQ9PbmfxZTRBnJekQgesHJu9VmWLBeaS2iM0S2s18VS6x49gw6LAg7
         lE7g9HfPVlpohIn1D6Z1WLpKHRGJhgyhsHtz/95Lf8r79Kspm/BG84+1piIteCxRWIbS
         VllQ==
X-Forwarded-Encrypted: i=1; AJvYcCX951gF9+U0s1Au+lW1Z6xBvwdJ7JVrL7D6zHv2mtLmciCwOgNc1gY4m8hta1ff3GVCGGGMN+4zgo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRoQhlWXw8o/7PT9VqIsokC1fmIC+nJDH1COTZ/ilUY1ynRDRr
	1gps2jFGCDKrc49DbLNPF9Z2IAuqr7xf1kyUe0bM/HH1maT8mUem+OOP/IPofqEkYulr5QZVP9z
	lmaPI0nkhrT37lqPTsB605tSIyVN6ch0XWPlQRiRphlT6qZvLWDjBtcpgUtvTZE4=
X-Gm-Gg: AY/fxX5pgZP1+ZDks8Iebtvkhm1pn3E95DuXGDPNAtGHCz+xDQg6IojjpBfVvNjNv5G
	WssYCmA/h+VMt8xsd0nwomAyq51ZP0YDOYcWny/Z2pMIuhLf3wjlGkLdX7H4oQKZLv473vWlpbC
	Gb15I0gVD4hvHw0QnPjNQpR6VyuOGz+TRqZJ3IttDU0XgrYrSHsam00dlsClEhcYRxnDa5P9DcH
	/ywCkUAS4/dWE4I6f/OW6m4cSLn4ndQ6jv5Z3uio0jS4c5j1uzUScxXGeZfrxaeT7iokuWwM3UT
	o6I6USyJnhJmJTREN3KzTAylpRxb1baCVu8OJKsfyG6w2b+ox6p5LLyy/75eGEi/+vxea8511EA
	jJNGHNCT7mQBu3yf67xzcr+OaO7O04qtdoRuK7aU3mQg=
X-Received: by 2002:a17:903:3205:b0:29e:93be:fe50 with SMTP id d9443c01a7336-29f24249725mr144744435ad.42.1765892964828;
        Tue, 16 Dec 2025 05:49:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAKXygWf35qhSk/Tz3e5SfENRSdNoTOVMnG6GfAoB3QzpqiKmYIT14hAq2L9SEFKFdUBDDiA==
X-Received: by 2002:a17:903:3205:b0:29e:93be:fe50 with SMTP id d9443c01a7336-29f24249725mr144744145ad.42.1765892964265;
        Tue, 16 Dec 2025 05:49:24 -0800 (PST)
Received: from hu-msarkar-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a0993ab61dsm99697165ad.46.2025.12.16.05.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 05:49:23 -0800 (PST)
From: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
Subject: [PATCH v2 0/2] Add firmware-managed PCIe Endpoint support for
 SA8255P
Date: Tue, 16 Dec 2025 19:19:16 +0530
Message-Id: <20251216-firmware_managed_ep-v2-0-7a731327307f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFxjQWkC/x3MQQqAIBBA0avIrBNSmoiuEhGSY80iixEqEO+et
 HyL/zMkEqYEo8ogdHPiM1bYRsG6u7iRZl8NtrVorOl1YDkeJ7QcLrqN/EKXDgE9mqHrEQeo5SU
 U+P2v01zKB+KQF0RlAAAA
X-Change-ID: 20251216-firmware_managed_ep-ff5d51846558
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        quic_vbadigan@quicinc.com, quic_shazhuss@quicinc.com,
        konrad.dybcio@oss.qualcomm.com,
        Mrinmay sarkar <mrinmay.sarkar@oss.qualcomm.com>,
        Rama Krishna <quic_ramkri@quicinc.com>,
        Ayiluri Naga Rashmi <quic_nayiluri@quicinc.com>,
        Nitesh Gupta <quic_nitegupt@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765892958; l=1375;
 i=mrinmay.sarkar@oss.qualcomm.com; s=20250423; h=from:subject:message-id;
 bh=o5xvNKoR4C0Nnc69joVwaN6SCdPxQG2DIvrl/F+bC3U=;
 b=K0sCqutIlQr1O/9My9V0l/e7XqEkbfG2wiQCpSpWHYjN/DEHuypaMHTRq01r0NDVlu5uLeLW6
 MNjgRpSRG4ADj1WFwoZPBNn5R2KhHHMhMaZ9VPN5cbveYsH2uXxEXQ3
X-Developer-Key: i=mrinmay.sarkar@oss.qualcomm.com; a=ed25519;
 pk=5D8s0BEkJAotPyAnJ6/qmJBFhCjti/zUi2OMYoferv4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDExOCBTYWx0ZWRfX+rnDJut0SRda
 5Sgfb2hqMm6d+/MPcXvgdTNQiVMRXA0t0wqLuyfzP3tLHMQtYaBSDZYHUQUVlbX6GwTstrX9GaB
 gCxRMbvHu2/WL9ZjiQA5mwj6L2K6HPVDSm/c3lYt9kjZFHL6Jk+qBdLeraOf7QjsYN1uAW+ZRN0
 93+0a+c6DpBkH5PqWarhbwN1/od6aPGgGlQTUjJyRqNePhvghO3KGZDKSy43Ar6SDeztd64yi7h
 8HF7LOwUHYj5JlIyTDGMMxTQ8LsX1CzpzCEb0g+GNaJPSh6BNAe5Y0uayxXEmvY5S+pd4m86rgB
 c5NpithL7RHIcBL/KCUdDOmoFuYh2LsyPnSImBHB1tQGnUuhFP8Lxax1XqtFJQYqllKAjhFFmkr
 UVgBnaX5vXhRyE61D5nTHJYyLpNvUg==
X-Proofpoint-GUID: UbpombcvJqacNvn_0BtYbYkAqAjYzeP9
X-Proofpoint-ORIG-GUID: UbpombcvJqacNvn_0BtYbYkAqAjYzeP9
X-Authority-Analysis: v=2.4 cv=T7mBjvKQ c=1 sm=1 tr=0 ts=69416365 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=KnNq_94ptiHzTE3zWj8A:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 clxscore=1015 bulkscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512160118

This patch series introduces support for Qualcomm SA8255P platform
where PCIe Endpoint resources are managed by firmware instead of
Linux driver. So the Linux driver should avoid redundant resource
management and relies on runtime PM calls to inform firmware for
resource management.

And documents the new compatible string "qcom,pcie-ep-sa8255p" for
SA8255P platforms in the device tree bindings.

Tested on Qualcomm SA8255P platform.

Signed-off-by: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
---
Changes in v2:
- Updated dt binding as suggested by Krzysztof.
- Updated compatible string to match file name and compatible.
- Updated driver as suggested by bjorn.
- Link to v1: https://lore.kernel.org/r/20251203-firmware_managed_ep-v1-0-295977600fa5@oss.qualcomm.com

---
Mrinmay Sarkar (2):
      dt-bindings: PCI: qcom,pcie-ep-sa8255p: Document firmware managed PCIe endpoint
      PCI: qcom-ep: Add support for firmware-managed PCIe Endpoint

 .../bindings/pci/qcom,pcie-ep-sa8255p.yaml         | 110 +++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-qcom-ep.c          |  82 +++++++++++----
 2 files changed, 172 insertions(+), 20 deletions(-)
---
base-commit: 563c8dd425b59e44470e28519107b1efc99f4c7b
change-id: 20251216-firmware_managed_ep-ff5d51846558

Best regards,
-- 
Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>


