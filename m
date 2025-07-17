Return-Path: <linux-pci+bounces-32401-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DD6B08EAA
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 16:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 130CC167E7D
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 14:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71052BEFE5;
	Thu, 17 Jul 2025 14:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DUkb5wRy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A64B1A4E70
	for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 14:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752760900; cv=none; b=C+q4kGSnCLnrJLbHq8eAAmGWuVSMKqPNkVM1YJcFcGQrgPxtC94NDdwmQ0sxJnahXewysIqLvziB6WTaSC19vM0ntjD3x8+NEKXeqkmYbYlIe5tFCLExCCWzshLreZ7WOs3BnwST3S0rwPU7/Dn77zARfhizz7NBhxysL7ATms8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752760900; c=relaxed/simple;
	bh=0BTQfC2w5Rd4VcCTtFNmuoBqEatSoZ/OgMG1M6bwx54=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aEA3E0zIme0XJQWigMjwIL4w4WOohV0Cf9wH5l5PMG737YEzUsBEJc2TRdCk8tloxSRHjYoeg1ACYZNBUbxWOZFdsR2grv1KWAujKxwY3oErJ87W+7+sam9pofFdz9pm+hvGkFhPGPZw7oxf/39X1hII9GHzjGhbgWQrtJ8SSeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DUkb5wRy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HC0cvs022268
	for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 14:01:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=pXji7w03b38emMA9vb5J3M
	JvatE27Vxj2JoLrEFkbvQ=; b=DUkb5wRywSO/YzhBHoThRutav7lcjS4xzXeDF2
	Oq2RYGobttVW46n0OFmJkJr/3K9wVb5fS+g8Do6AHOqXev27nRsOTPfzyeNqcie+
	NUjmJThNdgV8SVf7+2VODfenC5VQo5fJZw7Ux6hY3fcNdjCu5+lbjeULN2sbLlnt
	2nlhvdk8Tf2tsD4q6oHinbSM/MNrV0rQ8IdTFeOp7zSIi3fMzrEMiEea1g1EZaTn
	G4GtawRWcnjWsoafFHSYyd+ljloMN3E2xXFz2MXJh+3+XaLgbnEFUtzcVMkTvBVl
	IzXiUyEm8JiCGVwJSOR33z0SvwQIsqdzihsVFVk/suxFTnhA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wqsy7u5d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 14:01:38 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-740774348f6so1073254b3a.1
        for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 07:01:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752760897; x=1753365697;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pXji7w03b38emMA9vb5J3MJvatE27Vxj2JoLrEFkbvQ=;
        b=OsNRrtr7VWuhOTdGUHiMvLPX7Tvv65TeOduJhRCx/9CYVB+EaH/V3HzfOYRc7XVaed
         89Or2kkVq1ZJB9Dy7EDnvaqsgOVE5uaZwYTmeUFWLAR2HBltKLDMthscVcwcfJSb72Uh
         rFNYmB9ee1Pkn0AhmpR7CFcxiwlSQBKagr1XXOlScC23z3H37S6DmPsO5PsbCqRECat8
         CXWA26HT7V7W3YgP8yoWBFEw9bqxXmV1QfXFDvixy8BL+kSAqCuTmfyTnnqQANgcgONG
         +uxqtcoIGLm5Ytf9At9oN5O/n2NmJvXj5R13jp3b8yTmDiqd+9uzZArDY2kuGJzQdQZ4
         9rJw==
X-Forwarded-Encrypted: i=1; AJvYcCXq7nKaf+xFb6DY+V89Fb22ZhLHMSqMdTV4zjYXlq3vcTWli9L/V8LUCS9G84hteXet6yM8O/lUZiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtW/qwEuP/C82Kr0uqwG7UsHm9Y9bBV3toBEH2VRy5vYOLfq+q
	jQjUdGwFi33glgbyVGHGdnF54i8cntIGeXBM2UcqmkDUB3mXwG1Uuy1bHyugishra/HWN18dw2C
	d0S5MnuxrVh+8R1UuaDTRARXA8AtMprvEy5sZ9QIblWOHVlWADzOBaCWV34SOLDQ=
X-Gm-Gg: ASbGncuy0FEA2SZFgCqpIh2alF71bp7Q0MvTD5V/hyPTC2M8zMUVIM7g50h1o0e+CoT
	BwSNLbyZCeqxGWGd1FIbtbgeibnrY/Foufw6gqESLQOoGB/TbhZnig5JoAOTZjSt/0PCzj6+weR
	S3jF3lqSt86GYYNCL2vSuVXXYxGqNt/mno2alCsqAKn5Ok+cOS3uQk4T6lJdtTarFFerSdbLNNW
	6rgVNwEZ3eEfygjEyafNIyfm37WtErmgN8skXkAAqSQ7NRuENSbEIFworuoW740x7gbtG3qngUf
	TGc9eURHSP8B+UniNlXwInE+Z3HlTW2H1oT457+ICGw8185sCia1/K2jcPHTrx4NmMOJVLWA59g
	=
X-Received: by 2002:a05:6a21:151a:b0:238:3f54:78e9 with SMTP id adf61e73a8af0-2383f548d09mr9251729637.43.1752760896662;
        Thu, 17 Jul 2025 07:01:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF45A+lgEoQb8f4TyEa6YkAJM5UqE/OX4TYBGRzoYifUxZTa8/Qrlg8/ommRgyQucY5cADfQA==
X-Received: by 2002:a05:6a21:151a:b0:238:3f54:78e9 with SMTP id adf61e73a8af0-2383f548d09mr9251480637.43.1752760894322;
        Thu, 17 Jul 2025 07:01:34 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7507a64b57dsm10311986b3a.14.2025.07.17.07.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 07:01:32 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH 0/3] opp: Add bw_factor support to adjust bandwidth
 dynamically
Date: Thu, 17 Jul 2025 19:31:15 +0530
Message-Id: <20250717-opp_pcie-v1-0-dde6f452571b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACsCeWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDc0Nz3fyCgviC5MxUXXNLY0MzgySjJENDYyWg8oKi1LTMCrBR0bG1tQC
 91UdPWgAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752760888; l=1757;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=0BTQfC2w5Rd4VcCTtFNmuoBqEatSoZ/OgMG1M6bwx54=;
 b=yZHyhU2ZmPe2y6FRKoFJIShRvrs8JFdyP+hmuU3SAHzGxMKpB3+iCxlbylH9wPkKzi6DgxqGt
 csXPI+55WroBjWicfathL9vSadm88SK0hZ27fR6A63Od80rp/Tj8H8D
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDEyMyBTYWx0ZWRfX6/hfJ80Wea0k
 u646jfZXY8kVgAVeylb1WIDfaO6XG5SUvHNDuztlIMRPkfvyiIMvbdFEM8U1KNSs8+x4RaMtjS9
 AsMTkmUIpJeDav0ldhU1bhAt7ohaRJdzK5FdLCNXK2uB45PdSw2eBK3x/jD4jUmAihyOOASIDi5
 g8YjsMLN66gzlhkcmYFGuP9LQOp2w4jPp/abWzvvQw5b9Pow7a3mRskAt3oJlJS+uocqDxns6zv
 vunCtUzhRxJZYX4hp80fe9ZPhcI8yTBeBWTtxPvCE5mc55e84H0EfADmMp01/3UHEzDsKGPZklS
 LtKH+CccbicrE02UFTpmB/MEOtyVoSpFGQKTr+I2CQiSENYqGRbVW4W7M7vuyun+rmzNAjZ6zQY
 wXSbQy8IXFnY4W75z65F8qtb7Kiue+nE5dXnb6gBMOXkA4DVPcxE64yCMq7g3l5OOnOQgNNQ
X-Proofpoint-GUID: aK3GD71Ovwr6tUmprzGm5_QtgZ3ouqOo
X-Proofpoint-ORIG-GUID: aK3GD71Ovwr6tUmprzGm5_QtgZ3ouqOo
X-Authority-Analysis: v=2.4 cv=McZsu4/f c=1 sm=1 tr=0 ts=68790242 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=KRKipztoQesxEaMeAmMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxlogscore=877 impostorscore=0 mlxscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170123

The existing OPP table in the device tree for PCIe is shared across
different link configurations such as data rates 8GT/s x2 and 16GT/s x1.
These configurations often operate at the same frequency, allowing them
to reuse the same OPP entries. However, 8GT/s and 16 GT/s may have
different characteristics beyond frequency—such as RPMh votes in QCOM
case, which cannot be represented accurately when sharing a single OPP.

To avoid conflicts and duplication in the device tree, we now define only
one set of OPP entries per table and introduce a new mechanism to adjust
bandwidth dynamically using a `bw_factor`.

The `bw_factor` is a multiplier applied to the average and peak bandwidth
values of an OPP entry. This allows PCIe drivers to modify the effective
bandwidth at runtime based on the actual link width without needing
separate OPP entries for each configuration.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Krishna Chaitanya Chundru (3):
      opp: Add bw_factor support to adjust bandwidth dynamically
      PCI: qcom: Use bw_factor to adjust bandwidth based on link width
      arm64: dts: qcom: sm8450: Keep only x1 lane PCIe OPP entries

 arch/arm64/boot/dts/qcom/sm8450.dtsi   | 17 ++--------------
 drivers/opp/core.c                     | 37 ++++++++++++++++++++++++++++++++--
 drivers/opp/opp.h                      |  2 ++
 drivers/pci/controller/dwc/pcie-qcom.c |  8 ++++++--
 include/linux/pm_opp.h                 |  7 +++++++
 5 files changed, 52 insertions(+), 19 deletions(-)
---
base-commit: e2291551827fe5d2d3758c435c191d32b6d1350e
change-id: 20250717-opp_pcie-793160b2b113

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


