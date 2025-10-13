Return-Path: <linux-pci+bounces-37886-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B632EBD2A5A
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 12:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9C20189BBA3
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 10:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8559A30215D;
	Mon, 13 Oct 2025 10:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G8Z3rYKC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE827302773
	for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 10:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760352836; cv=none; b=Q8nyJsXyYRMrjOr/3PI7Dcg4E9/YfHQBXCmm32J19izO2mguptxN+a/f3dNO43HvOH8l0WvzM1kgaH9a8jfwQnAF6LxF+NFYdhmheDyI5b/oUjNGzLNMYCjUGPSPOZELhDGij56rtmPcZ3sleOhsRZZ//oV4iP3aa38uESYEMwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760352836; c=relaxed/simple;
	bh=PGrVddzsp+7uSn3Q4RGd8/KbWB9O/amciu5NlR6lPAM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bX3h13I+DJ6chE0YpdbipJrZRW7eW8pmhEGQVlhYFBuqNj8pb3NAPkOq6yfWsXv8IpJ4rLQW0udTQztEqPYz1ucdUDbNr1wvLIrbgx+G5Bb8G6JRbbIgKni6qW/VtAaOVsZgopkK/ief6Si+LnWB7a/IvQws69XMUll1GAR/Sig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G8Z3rYKC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DAIJSR028760
	for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 10:53:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=nSpFhm6wZSx72T+59s1Y5i
	sO7OlG11POUOOk4wYma+I=; b=G8Z3rYKC85u1o4ZYbO8uuIPHit69XWdY869O//
	STeKBQSAF04scadxlnWvupjAoBsGGVytfQ5qIfD6AE1biCnH+EDBxeiK619lBPaP
	yUlgQODbZmIKFDwlELclFbXfsyzfclKn8a7ftMqc/w525pb67eHpSLFdlo7lPDgf
	HdZNY5X+KY6MyxQggr4sI872zZnFsyOnv0GoCEGzicx00FCu8/LeCxttzs8p8Zvd
	8hJVW34G7dw44hMyZx3Z2ux+3qAaHCbtO7h2QZB1cy5s5PMwrMwQ3UtRFdtS20Rl
	Ul3MV9dUeOW/eT+KLh79GuJXpCh6BZPgIF906YXWwau+ArXQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfm5c9uk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 10:53:52 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-269af520712so85717875ad.2
        for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 03:53:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760352831; x=1760957631;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nSpFhm6wZSx72T+59s1Y5isO7OlG11POUOOk4wYma+I=;
        b=FTW1WPLqMpgvMgwH0zzfiXQ96amUQe3ZUG8pWcVw/u2lAlaYCs3jIKqtGEpkNfFDIm
         8TLNlW4ymRLpy0zya/fIiegscdu+UNU+viYyHNowQKCvqaCO1V0ICxBT7ahGEcLJy09m
         kA+h2heXBmEKFqFOkFa7mDkKzFogOh2nSRMij2uCsApZN588GO/bG5xf4Wy9x1a4q3YE
         lgyZVD0DafKOcugTxNcGU+r21HBTNJ5EcSOoIg5jWEXKUU9e8O963eKyuDOTMFw33cJb
         Rr0Ns25TlHr+CU8V1TfGK9mgCIcQ1zt6g1fKSqVmw/1zyMf6JXWPe6B8UlVlK5szp2zj
         RNvA==
X-Forwarded-Encrypted: i=1; AJvYcCVCVNIZK8BMaAhaeX1bOFBNX0RkS1RIMFez25lJBQpDPRDPKTuTrbHu9GESYthkqdu+Jm0Zs7KE8IM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5rQYo3d1ASOcaF86XKKNo8nS7ndWEZtWsAOCcGpgyEFdItDqH
	47EGLllKq7GickTNs529TVQFaD8TcY+NicodsoGAHWG7mXI/xi7JrZJUZncyiBLIlbm0IMMAvrl
	pj6GiSoYBaKIqY5Fe/mRYS7PwWKNU2OwdYIAtvdWRcb5TXDgHmRwJo7Ogh4L15H4=
X-Gm-Gg: ASbGncvY38LDmwwDoK1+u3kss4E6ur8xuFd7bgpVuYj+/gykxkA4WEI56wy/xaNCtnd
	vkR1LG1yXZ0w95vMtigehqmf0m8hffaz1ICdkortIMm0DHqNuQ3fVpGbBDyylATVjiOrIkLUyCm
	qwZVwwAPTRqwnUGG82HkCom4TuFzGiSV/2USa/gLVh6tQVItGWtUIY4L77+u24uY+0cMX8BvFUN
	5J/JBP1hpOKsg1dk6Z5hrA+k9P9azj6GV7Y0LEnUhWrUl2pQdyTa6jPS2rS37I3xzFsL/QaHmUG
	FLRa3T+mIsfAYnbLCdwd7JPKqEU7IHEkD6d0OIuDdiBB2I5zjjp2RDglB5yieIbUOwEzMnX8pGU
	=
X-Received: by 2002:a17:90b:4b8b:b0:332:8491:ec2 with SMTP id 98e67ed59e1d1-33b51168defmr31117642a91.16.1760352830914;
        Mon, 13 Oct 2025 03:53:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdyC7ikuWKMMJfIGceNEEl83iLYi/IVQ7Xwvv26wG9Zvg9M72QfMfnW6o1K/sHvWgKVRVZ1g==
X-Received: by 2002:a17:90b:4b8b:b0:332:8491:ec2 with SMTP id 98e67ed59e1d1-33b51168defmr31117615a91.16.1760352830404;
        Mon, 13 Oct 2025 03:53:50 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b626403desm11662295a91.7.2025.10.13.03.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 03:53:50 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v5 0/5] OPP: Add support to find OPP for a set of keys
Date: Mon, 13 Oct 2025 16:23:27 +0530
Message-Id: <20251013-opp_pcie-v5-0-eb64db2b4bd3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACfa7GgC/3XMwW4CIRDG8VcxnIthBljAU9/DNI0ss0pSZbvYT
 Y3Zd3f0Ige9kHxkfv+rqDRlqmKzuoqJ5lxzOfGwHyvRH3anPcmceAtUaJUDJ8s4fo99JumChk5
 FjABa8Pk40ZD/H6ntF+9DrucyXR7lGe6/LyIzSCVTom4wFq2D+FlqXf/+7X76cjyu+RH31oxP7
 8E3Htlz0qJJwYfOvfG69aHxmv3gY3KkbE8G3njTeFSNN+zR6eiDMURJvfDLstwAgHQHVWcBAAA
 =
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760352825; l=2747;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=PGrVddzsp+7uSn3Q4RGd8/KbWB9O/amciu5NlR6lPAM=;
 b=d3n0eCMLek1wWfusmmiLdVCVwGQz+5o1KReX4LbIvChgvV8JuJ11IQ8Pu2OveWzJIQOXzD6/o
 +8634PnAcNVCkr1JMI1UfD7xbi3aeHr4OcKi2JDdqCmF0BliFar3EbB
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: jSVkQAFGigs7dZsbuBNGmj8AT2OL2hRx
X-Proofpoint-ORIG-GUID: jSVkQAFGigs7dZsbuBNGmj8AT2OL2hRx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMCBTYWx0ZWRfX+MPH0Q36+2BX
 WbIa3jL7vrCgeUF2ANpwvRPJeqpRUjJ5G+R0m80S1ZZnvUecvaLaw74DEjB5kWiSZejERpwNTgT
 4QS2bwXFkoRRTPmI06z75vdo5KXlLV3G8qQ0a3okAt2tizOFUEoWYMZHkwDVYqBvAjJJaqpfuAB
 3E6dzcEeu7AmPQ47mHiQVzQ49qYES3qThYR/z92Gf64TvrbRXaf5PGQfTRgPd4j/6zSkaeeWK3e
 vp0gmdWrV9s7vMmAlulmn4MWlUwnAwr1uYurgLowZ+K97bTARVro/9kB4TiZOiD2j4OOjvBPrTq
 bxC/qkE5PozkX7mPmQLKJ185aequ7AndPB0/tJ7ssPx8CEc0cwc0liMc2LQz/5r2rw/URv415Qg
 mb8+4XzFe9WTKQ3VdHiQD/ama+0uyg==
X-Authority-Analysis: v=2.4 cv=V71wEOni c=1 sm=1 tr=0 ts=68ecda40 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=76l3OPsZB85xAofE:21 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=act9oNzqP66NUailJEwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110020

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
Changes in v5:
- Add support for legacy devicetree's (Neil).
- Update commit text and comments to use data rates instead of GEN (Mani).
- Link to v4: https://lore.kernel.org/r/20250820-opp_pcie-v4-0-273b8944eed0@oss.qualcomm.com

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
Krishna Chaitanya Chundru (5):
      arm64: dts: qcom: sm8450: Add opp-level to indicate PCIe data rates
      arm64: dts: qcom: sm8550: Add opp-level to indicate PCIe data rates
      arm64: dts: qcom: sm8650: Add opp-level to indicate PCIe data rates
      arm64: dts: qcom: x1e80100: Add opp-level to indicate PCIe data rates
      PCI: qcom: Use frequency and level based OPP lookup

 arch/arm64/boot/dts/qcom/sm8450.dtsi   | 55 +++++++++++++------
 arch/arm64/boot/dts/qcom/sm8550.dtsi   | 79 +++++++++++++++++++--------
 arch/arm64/boot/dts/qcom/sm8650.dtsi   | 79 +++++++++++++++++++--------
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 98 +++++++++++++++++++++++++++-------
 drivers/pci/controller/dwc/pcie-qcom.c | 17 +++++-
 5 files changed, 247 insertions(+), 81 deletions(-)
---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20250717-opp_pcie-793160b2b113

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


