Return-Path: <linux-pci+bounces-38544-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E613BEC3AD
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 03:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4025C4E31BA
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 01:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CFC1F4606;
	Sat, 18 Oct 2025 01:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ISBtsi1r"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8811E9B31
	for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 01:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760751230; cv=none; b=DABzSFCaT4PSMLLZyq5kHgizK/fiuMOZGDlZIjb4nR1BgQqZle4dsdeSklKMqDgvpvQri+7OwOUzmbLP7tZSsxCh7lD+KS4ghAukRgCMi4iVXaPMnTSaQwsMtGJeeVfqOgH9FKsXVG1ccw0D/PXt2VG29iUpf5InEI6I+1F7FxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760751230; c=relaxed/simple;
	bh=I0wlRKT1XyxrqdOXDDuPSFf6E6TDNjkNPLI2YKlf8Cs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lk9KOf6kJVDe35a+h7ketVdbQpFy5LmnPdhZF1+bCkYu4Ktz6LvjO0XHJ1zfuOzzRBaQdSKzZLCQc3VJ90VIP7xfBWvc0EeHyxsYQOijs84WMHjfKDaJelSfXzjkSfEBbuBqsm4pV+rrMKa9iMlGg8pIVStin669wvLnGBEGRo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ISBtsi1r; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59HJGDbT006817
	for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 01:33:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JKHfuVsy+oceJ8iDUBL9LmTN7OlbK4Cqz9zKDF8RHcY=; b=ISBtsi1raIQvBuPy
	a/0azRHlBDi8E3xun+fkzWu0lQkHAF+Dxv4STbBlVGm1cWpqWVlYJMm+AaqJM8FE
	4Tpj+PL2SVmtcv841bwWH2tgtdjo32kZHzFW4UOQaVgO2v5YR6GLHKTECzjyaqzP
	qbEi1GUgYIdLT3PfSnStvnq1rVxKACL1wfogW0cmlRl52ECie7Ud8wVZ+kIzhhd6
	pRwOaz88B2IdF0i9Z4Hrpz8GimQB6BLl9T/P0cMMJMvAeIF3z1WTs8J8VwqKhZZC
	tzrivNzF/Ih/brckHDDcKgTNSy0Rvn7btZj/GLDFlG7RdWNIb3CU0/Ii7jbrlK7f
	WDkkQw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qff1649t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 01:33:46 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-33428befbbaso2981910a91.0
        for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 18:33:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760751226; x=1761356026;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JKHfuVsy+oceJ8iDUBL9LmTN7OlbK4Cqz9zKDF8RHcY=;
        b=AAGOI3bP7H4RhMGYW3hQVguxK6a2Rj1W+leYc9MkIjSsFjKhZEjnEF/iJ6NvcAaaOd
         MYyLQ5PcSOuhC9AZihfRjgrLskAeG07ei/+7MjXbVwqBbO1OI546vysg1gsLxjVDgCcu
         E7sILCgSgIXd0MRPHXh2x+rGIKoRxW0wUUhb0gwXdseZ+jBXHfhASBco2F4dV0Y9Vjt8
         CiIANphb0a00ef//4nbl0f7eWYa1/KxjcRtZiaA7GCTy4MEIjSSekvu1TEomfwGmPrZM
         8/ETogCkMssw1x0R+WXEs6W5hi+EAG3KtX2ovTyKgB7SxhKbb2J+7zpAk++S6S5xltQN
         GK+A==
X-Forwarded-Encrypted: i=1; AJvYcCXClusPZBQulMxB2J6ZgWmgcxNJtLDZr4eaZKavzhGbB56hx593YbWyBVIgLUVtdMUJbhXNaW+e39g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9wz8TWPmaZvD8tthMIqNHJVhGAZqvhak+uSSZzJg2XXROkCyQ
	wwvM6cz4OaHJh1cUh/4Vq5T5be0BfhIxRbVT2ZbOP0sCsZVZV/g2WPsBNGIT8ZzhP67Z4Q0TlNF
	VE9heNoTtUmjG8uScWRelqw/mtWahllRknEuHxQNuMNJtbdHZZst4tkFotO1bsZs=
X-Gm-Gg: ASbGnctQ7d5y1l2JlNKr4ooI4krKpeCdSLfprr4jdv7SuAvxo5dtvvpEYbZh73cEIgf
	r46dxbgrzc7QEacezPENVD90IcojKbYu1RIhf8VUB/MGLXWkka2rb/MdsfzJIv1nQpMlsdJM9WW
	rS/0z2zG8hLBVXmorT9K7eHtL1vC2M++OohZDygmMmWdz39kjm4oSIj7Jinp5OK73A1nDW01PVj
	FXlYOgF+R4/W4VIgX9Xk8LMFwAo0an2OxuGD4eoyRatxSb91Zr+1dy6JnoIRozWEmGWDqT/A0nt
	QPVDsgXbBmG/itIaD75ZWFHzKEhYFI1edND7N8qnuN0hXJILkBxQl9plNwcgOwLEsekdfvtv7nN
	znTeX5r4UKBtV1daM7nkR+UX85TrwMpWfEnA7AokFkLzYcA==
X-Received: by 2002:a17:90b:4c48:b0:32e:d9db:7a86 with SMTP id 98e67ed59e1d1-33bcf85313bmr7318074a91.7.1760751225987;
        Fri, 17 Oct 2025 18:33:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCLJHcffGnBNSb1uIKAURYiSRJBdo8k5B6+vXHyLSCH9P8q78ibRunDV+Bq0HRBxM8f0QGsA==
X-Received: by 2002:a17:90b:4c48:b0:32e:d9db:7a86 with SMTP id 98e67ed59e1d1-33bcf85313bmr7318051a91.7.1760751225561;
        Fri, 17 Oct 2025 18:33:45 -0700 (PDT)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5ddf16bcsm791695a91.4.2025.10.17.18.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 18:33:45 -0700 (PDT)
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 18:33:39 -0700
Subject: [PATCH v5 2/6] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 Document the Glymur QMP PCIe Gen4 2-lane PHY
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-glymur_pcie-v5-2-82d0c4bd402b@oss.qualcomm.com>
References: <20251017-glymur_pcie-v5-0-82d0c4bd402b@oss.qualcomm.com>
In-Reply-To: <20251017-glymur_pcie-v5-0-82d0c4bd402b@oss.qualcomm.com>
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
        linux-pci@vger.kernel.org, Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Qiang Yu <quic_qianyu@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760751221; l=1530;
 i=qiang.yu@oss.qualcomm.com; s=20250513; h=from:subject:message-id;
 bh=lvTnRsMiPSJ5k4uuUJ+DwrEJUHYQxAxGH4V/2h81Rsc=;
 b=58rn2PyPvlKLrWvBfarUKaCmgk8vu5L7E3vZhvNxLJ3/SZ1oHBgGJTx8qTgeCYyNgvFK+RKyZ
 f3tBW0+bzbBCzqZL2jqGRhhwuoFHKBtUmf9KBWvv2jIb/NCfvcdJi7B
X-Developer-Key: i=qiang.yu@oss.qualcomm.com; a=ed25519;
 pk=Rr94t+fykoieF1ngg/bXxEfr5KoQxeXPtYxM8fBQTAI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX21hP+rU9jNJI
 xae62mT9TAxLxAZaUTu5lU2jyHn3J6DVvJdz/36F1gtpg6Jk/HLcqoGFMteXqd71DS7coaK4XSx
 MkgkR5FGklBxHa26uAUk1cHVpgBQvy/4ZDF9SWyixVBB16J6nA6CNwC1F+KRZOqAzKjPQ+LrGxw
 rtAU6VBXIG4ibEX9Wu0s8NAQTo6lD52jkISF4oTdPwhxNxLdtsfnNLpXmdxSxTzQ4TTfI9xZDYK
 A9TMXsBA/Y9xCxsgysqgAuogisFDVyP4xJ/nBvnjI0HqNOML0eDFSgJxxeNfSylLDctHHNSVHeC
 NGJBvnvA2mHWQGeH1D+0rLZSbrfJxqbFsrBHpyBSw==
X-Proofpoint-GUID: EqtBdznud-uXIBi6ReFbBrd5aoJXq6v5
X-Authority-Analysis: v=2.4 cv=PriergM3 c=1 sm=1 tr=0 ts=68f2ee7a cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=G_jr2P4fny8E_LuvC7MA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: EqtBdznud-uXIBi6ReFbBrd5aoJXq6v5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-18_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

From: Qiang Yu <quic_qianyu@quicinc.com>

The 4th and 6th PCIe instances on Glymur have Gen4 2-lane PHY. Document it
as a separate compatible.

Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
index 3adeca46d9aadce103fba8e037582f29ff481357..b0d1efb84fcf5abc3fcd9146f89c903a4ec84dba 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
@@ -16,6 +16,7 @@ description:
 properties:
   compatible:
     enum:
+      - qcom,glymur-qmp-gen4x2-pcie-phy
       - qcom,glymur-qmp-gen5x4-pcie-phy
       - qcom,qcs615-qmp-gen3x1-pcie-phy
       - qcom,qcs8300-qmp-gen4x2-pcie-phy
@@ -179,6 +180,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,glymur-qmp-gen4x2-pcie-phy
               - qcom,glymur-qmp-gen5x4-pcie-phy
               - qcom,sa8775p-qmp-gen4x2-pcie-phy
               - qcom,sa8775p-qmp-gen4x4-pcie-phy
@@ -215,6 +217,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,glymur-qmp-gen4x2-pcie-phy
               - qcom,glymur-qmp-gen5x4-pcie-phy
               - qcom,sm8550-qmp-gen4x2-pcie-phy
               - qcom,sm8650-qmp-gen4x2-pcie-phy

-- 
2.34.1


