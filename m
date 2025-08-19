Return-Path: <linux-pci+bounces-34238-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D48E9B2B8C7
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 07:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D1991898746
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 05:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A24A1DF254;
	Tue, 19 Aug 2025 05:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TAGhn60E"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACCB4A35
	for <linux-pci@vger.kernel.org>; Tue, 19 Aug 2025 05:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755581699; cv=none; b=pspy8AnwGzLthmhT2q0AVVV8GaKMY04E3wUZFw914Pox77vPom6vl2Y4IbQOzKHAzjYyAI51+6xEQeLb/Oagq6uIu/r6ZBH+ha4reVijLGjYrrs4I93CvQoILfAvUvRhzOKrEBpXrM6oYxowhSrZSmS5B9HNFAM0UlE/iIY6UgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755581699; c=relaxed/simple;
	bh=OIx1Iyga7xol/jnwq90PT1IW2G315NN22lx0c4JUQlw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LyDvmAeRWfiMQT1DWpZAlyYgGX4/AU/xBD774+3dje3PrZC2fOP6RxYzjuFRXyMxe6C50EqUaCKzzSNlgY3m6Sx5PwgC5OEoJ6YYyPKp4+FUDlg6kAUo7G8/84EZY1w6lZst9H2hJVIXMneT1phFAc/qd/23UP8oKB3er1dgUX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TAGhn60E; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J147Dc022517
	for <linux-pci@vger.kernel.org>; Tue, 19 Aug 2025 05:34:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=sVZk2H67L/WBxeFp1Wyf1S
	K0wuc0uW8l4sg8p00ph1Q=; b=TAGhn60EuII4yC12Jeu9v8hyXggTV8P0sUwp0I
	vwNBWsdQrwX//qyt532pLcs8pyqFIKJDApkqNY9iMgSuxHu7+8VBxYm9HMOVadwb
	TPZjTbIrr1uD/KqLw5jZ+nwjsLUA89e7M4RjiyZfy963XOkSIp1SnGSGTMTMG6+E
	zkLyyOZV1DxzBilj5JYgHqkae/c6X1UQCSKkXFwaMpZ17T260v497sCo1FzfJot9
	kGnoTpF6282xbaC7iwoXM7+XjQmQDfXztTihJ/Ol6kF0PM/m+mL20/j3VOVzeh+B
	9p4MWQvtE50aEqkZLnLEErlUQ9XwB9o7dQJTdbovILYqpajw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jj747b5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 19 Aug 2025 05:34:56 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24458067fdeso59504345ad.1
        for <linux-pci@vger.kernel.org>; Mon, 18 Aug 2025 22:34:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755581696; x=1756186496;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sVZk2H67L/WBxeFp1Wyf1SK0wuc0uW8l4sg8p00ph1Q=;
        b=BW6AFa4zAQKdZPqUvfNBBYb5wgiiCjXVDj+bUb+Xreknqh0K8WA5dVp1eyhdF8/RjL
         EbJJgoKNfjnhJiuilH0z22wekAS0fMoiTJK7A5TWs39nYpE1Z7kVrGMD49mjlB0/8bvR
         6WzQtPfWYfgv+KtTAyRWl2UzJmv33djF1R19GD4ikkbQ7hmoLhzdJg03Rg+aipRY5Lxd
         0R7Fi92WLSRFJevsknOrfD7sS1MxmnEa0aXFUx+cuI2kXLUIUPvZiCLy6W+nuoHwXS8L
         AAN8XALEoMYKWhFjs4Glg5i6HePN5DLDLhplWTVTAdGwuZtNH/PdY2LtJayKkFlQ3VXL
         tA3g==
X-Forwarded-Encrypted: i=1; AJvYcCVFkd14bXrEfKkyXw3g3WVE+bYfb9wFNFvQKNMf7fuldxZlAYT2UMa+ZPgjUUixkKPCP7XHejGbxsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYV7jlu3DS1cLiN3sN8+jkb4R43SpHpJvqD80vvq3owDDnfyMd
	20m8znPti5v/Xs0U+TKAK58LlRZLOVjZIJreDavcKnMwZtfaxhYTvDN76eoZWmToGqyM5mPXkYY
	4YME0A1PER7u3cMnU0oPmEsz1KmZ3d71A9sOYvgr0etk4PZqF2cwsnPvHl+rQfsg=
X-Gm-Gg: ASbGncvdOeLExNKl4fZTIopAJznHFPc/6qsj2343s/mZoYm52l0shoPjFQQZnZpcXI4
	6jqiwkTJZteQnKKir2v8Fx5IQbRm+jwqP+MT3zCXjlFuGYi2UnxMR+71v0+0G4XeOHKP0na45Iq
	iFMAsVuSsI8IrubuM/ZXA8mrDGYcy9tMQeEAxuDg5gx0Q/dN45E4VSWzZj2Iew7n7b2g4EY2Z9W
	uQXYoNZOLbjLwkuVj1ijyy9H6xXejnwm3cyRMRhAECiDCIJOs/wMnhXsNJZHD3GX87NvunDQbyR
	TNNZccxF9XuxodpSD+FevjV27fjIvHGxMG369YjpsfDUEynaA+CqLmkttI4arnZsYtgUtw2gJWI
	=
X-Received: by 2002:a17:902:e943:b0:243:3c4:ccae with SMTP id d9443c01a7336-245e04daed6mr20517105ad.49.1755581695943;
        Mon, 18 Aug 2025 22:34:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5YDHiAEug4URrgHRdTWxQhKxSO/jr4WB7YjQEHWL09fZuEQUh2DeUWHL+iY+53aJtoaRPHg==
X-Received: by 2002:a17:902:e943:b0:243:3c4:ccae with SMTP id d9443c01a7336-245e04daed6mr20516675ad.49.1755581695476;
        Mon, 18 Aug 2025 22:34:55 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d50f710sm97004785ad.86.2025.08.18.22.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 22:34:55 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v3 0/3] OPP: Add support to find OPP for a set of keys
Date: Tue, 19 Aug 2025 11:04:41 +0530
Message-Id: <20250819-opp_pcie-v3-0-f8bd7e05ce41@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPIMpGgC/22MQQ6CMBBFr0K6tqRTKAVX3sMYA22RSYTWVhsN4
 e4WNrpgM8mb/PdmEoxHE8gxm4k3EQPaKUFxyIga2ulmKOrEhDMumARJrXNXp9BQ2RRQsY53AAV
 Jc+dNj+8tdb4kHjA8rf9s5QjrdycSgTKqtan6UnAhoTvZEPLHq70rO455OmRtRf7za6j/fJ78l
 BS81E3dVHLHX5blCwDYvZrnAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755581690; l=1992;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=OIx1Iyga7xol/jnwq90PT1IW2G315NN22lx0c4JUQlw=;
 b=W2tUO+yuFOyuQQzlAiU6aTdVmNDccmjQW2ybg2rMLmNVV9fv8BkrkRBJAtL4lSdlXdX/H+XES
 PIOdHES99COBHlKljUzx+qf1rdMrwbc1GXFol29i1HcgS83xSTlSWoN
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: cjygREd8ywWMUJk9_51sWtRGZPwoJKvN
X-Proofpoint-ORIG-GUID: cjygREd8ywWMUJk9_51sWtRGZPwoJKvN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAzMyBTYWx0ZWRfXxo95OnzyKbR7
 R5Sd/a+0QZ/4IEko++Dd6kikxLINHGxL96swXeyE58H+qovf0OwD8va7nzU8hGMNWOY/tS2Fqz5
 Q6FcR5HWxC2ienITCf8/hvOxk1pSBZiHkze+SSljCjM/9gQ8shFgm/VfAqhoDrY/BFPQmYaeNvr
 t0CFTfSmC8Ejlwnm1iiKJiJE2kiCMUFFIEqowuwJ9S7weC/WTN83KcShvwKFBfRhiMnZR1Aji6T
 TYeHRWRTiseexc/MS9PTM7iFP30a3rHanjYzYKN3pFToJDEp/2bLyaqwHvp2sSndDw6erlZbhaz
 +Gr2pal4xrc7DTihvbSkuFDXVxtVUoI91ctcKN5dgpBSb1NQDoonic3IvXQlNDJtBFMuLulvaqI
 bEYBUVZB
X-Authority-Analysis: v=2.4 cv=MJtgmNZl c=1 sm=1 tr=0 ts=68a40d00 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=76l3OPsZB85xAofE:21 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=RZHP3SvTWnTKgiXxB68A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0
 phishscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160033

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
Krishna Chaitanya Chundru (3):
      OPP: Add support to find OPP for a set of keys
      arm64: dts: qcom: sm8450: Add opp-level to indicate PCIe data rates
      PCI: qcom: Use frequency and level based OPP lookup

 arch/arm64/boot/dts/qcom/sm8450.dtsi   |  41 +++++++++++---
 drivers/opp/core.c                     | 100 +++++++++++++++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-qcom.c |   6 +-
 include/linux/pm_opp.h                 |  23 ++++++++
 4 files changed, 160 insertions(+), 10 deletions(-)
---
base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
change-id: 20250717-opp_pcie-793160b2b113

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


