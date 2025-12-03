Return-Path: <linux-pci+bounces-42562-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9D4C9F1F1
	for <lists+linux-pci@lfdr.de>; Wed, 03 Dec 2025 14:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 173724E0658
	for <lists+linux-pci@lfdr.de>; Wed,  3 Dec 2025 13:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B392E4258;
	Wed,  3 Dec 2025 13:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MZvFKtRo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D2EIte1d"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2535A2F744C
	for <linux-pci@vger.kernel.org>; Wed,  3 Dec 2025 13:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764768420; cv=none; b=YeVgvvYAfHoVWBb4Nn/Mzw52V7CNNGSrCB1PExM3jdU/yF0gGsMM5oEgvxgAWXymr21utcpDTOCFg7vbVcGAejX784MH0kDlIHrACwVcmImtJ9gMQFgzxzZ9Nfn1Mh5RaSw8GAkQZcDREkb8sWigZISo61DR3+HYVfHRioBLUPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764768420; c=relaxed/simple;
	bh=uJBOxPm6Eimz6DhfdchKbr3oFckVKr97/7nJ/4jxK5k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oCQP7bkiDFaXDnrqCEedk4FtIK84EJERP8usuW4U5WJ5xo68cl26bLY+MTpjPHkxkj/QaDGJ1YxDtOeInENeTQ674vAJXQbi6PNTUT9Eeo6yW5W8ZhstkTmF7EKGbGQ1zwNV8l7S+UsRidvCxvF9Pi8beP3+AShkpi7Ij7z+cXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MZvFKtRo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D2EIte1d; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B37XaO81901723
	for <linux-pci@vger.kernel.org>; Wed, 3 Dec 2025 13:26:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=GM1a2Fk0kUJGP3rjxxqSZR
	GIGfHWv60CItWyO6WDoZ8=; b=MZvFKtRo6xFNZp/seJRdCn7EYmNvIEoi+jmpUf
	t+7Tt61y+sIt+5QGsPD3oAel2eWLID9nMktUWglDDdf56Xk7lb42Mt1T9jrDbTDy
	aT8PZOZhwTcN9KtAZ8WcDFUVaoxaujLuY+RmZIWMv8wLrPgB6qdAkDrQ6mit/uVZ
	GiRcCPQ1POTX5sENkE/+gRlJkCzPS1ZzedkboVBzE3m1lZ8ltLdjUxG+IBCwTO40
	ODVSx051mSXBdidjQ2EOdvC036x9BJel76V121tdhB+055tXvxYO+oY/g8qfMdSa
	XEXucMYEZTY6uvORmo9D7j3naaccQmn4mub2oSxNovZKOmQw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4atgx3h1yk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 03 Dec 2025 13:26:57 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7b9090d9f2eso11148193b3a.0
        for <linux-pci@vger.kernel.org>; Wed, 03 Dec 2025 05:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764768417; x=1765373217; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GM1a2Fk0kUJGP3rjxxqSZRGIGfHWv60CItWyO6WDoZ8=;
        b=D2EIte1dPLPREwz5kowk1MOlI/y+9Tp7fKNkY8etiLm796J5za+lDEHW7zPSrSXbT/
         LyXYRJpblqxFQ0KgSF049zrBrMlk09B1ieHAmsRVa9cNFCe4aXoqAe22JtcqW3EpSt/b
         7wEzUn/vfn7EIzmNfE8hyJs37R1eet+QwH44On7IxP/wpsItImPBgRZpwPTQATwjovUf
         hoIwdlqIVdUY2JlH4DDWnzRG7xRG3W1gvy7KhZKQ47fKYA45YN8uh6VCuWlM3BLtdp0d
         Z7fkFbcm5MbsNQixWI+/e3NNZC1UQVBQF1B0IwUcUY8uqC56ksznN+/pmUg5HW/WNvo8
         dgMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764768417; x=1765373217;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GM1a2Fk0kUJGP3rjxxqSZRGIGfHWv60CItWyO6WDoZ8=;
        b=bTV8gxAjJHpCJlF/8WBLxa9MCOzIf91kzoI+yfGRyI6idv+xyXBi26lJNB3tD/V439
         GCh5b8Y1A3k0I5iP4haObWKruhqKBdC39pa9CInX8F5r/OZ19YwtiwE8YNTf2x9gADFr
         R09yF7gsV5Z2SfR7ZWvjhiDBNhry4FKjrr/M0tOaB2jnfkwtuB5dtNrR6vxyjteBgkN8
         X0nWl+fVXhWpy0zE1eh2FUbwbMdtL4mxa+8/FJWeRnFiG3dikvZ0DKDtnkDOxHvbMSfy
         wdcqxyG1/W4Y9os2qkt4Bdy6Tfovk4HIscBWfNVi357VVTkjMX77KmkigjKAWyDCdrO1
         vkWw==
X-Forwarded-Encrypted: i=1; AJvYcCV9Fzu1jDN5wWT3xKt6Xg17CiWOh+EZIgfQkxzhMLau3jE6Ob8sNHYfHxBdezq9hX6q2nbZM2DYXtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YytHRUDDhvI/TNsnHw53XcIWzl/hgnNQ10IgpvjWCUx8uDT4rGv
	zsTuwo0pmHjpESnnAZvUScu+dA9cq4C5kLnz7i79G9pDdIRQ+RPfSdpItWf/1/Ct4WJm2BJIj4i
	VJAlh+3VnWTQ0wPzGYnU9bgNwucpPiyqI9B46S6+vXJfIWuFWirw1NoxUnIWxEkk=
X-Gm-Gg: ASbGnct9ev6xxBoAgiORJ/Dap/u3MMh7IR3cx3EDk8r6TMA4q2HPuPaqclzquu6hlgK
	M48vGiqJozND1xeNlV7ZHiZ48oWelLiKodIjiHVZSR1UPyhx11r3kMGRD7gUNf8vLcRu790f4g+
	sqbfDWgGQOEgQYnmwyMpOoKU0SVHYWKyn2f6LOnjA9PlQtMjGzKx8IJsn0gn+iYru+kRwJ0M2Hy
	kEB23/E2lDLx6fQ66R5L8IaIxoKbU0kH97HtC+3klmF7aPHaY9WLB7zpt81DKWq0WWMBKNfmPdN
	fEngyPMgpekW9WI5DNsWXV0vv8wfEdXpiwa+x6k3cKs/29WGXAYImKCbIHgp0jCPr3nPTEnQEkq
	u654XxYT7ZNqbzENLbkAIx2XCJqX72jKI5+o4aowuEF0=
X-Received: by 2002:a05:6a20:2592:b0:35d:5d40:6d80 with SMTP id adf61e73a8af0-363f5d3256emr3029253637.8.1764768416952;
        Wed, 03 Dec 2025 05:26:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH34O1CWJT583sOs7/4wtQYGkh3bxAdnLsd5JA1NN4grgg9eTVN1+0lSr9Uz9txglRW0Dx0eA==
X-Received: by 2002:a05:6a20:2592:b0:35d:5d40:6d80 with SMTP id adf61e73a8af0-363f5d3256emr3029214637.8.1764768416314;
        Wed, 03 Dec 2025 05:26:56 -0800 (PST)
Received: from hu-msarkar-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15e6e6e06sm20287524b3a.43.2025.12.03.05.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 05:26:55 -0800 (PST)
From: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
Subject: [PATCH 0/2] Add firmware-managed PCIe Endpoint support for SA8255P
Date: Wed, 03 Dec 2025 18:56:46 +0530
Message-Id: <20251203-firmware_managed_ep-v1-0-295977600fa5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJY6MGkC/x3M0QpAMBSH8VfRubayCfEq0hr+41wYnRVK3t1y+
 bv4vocihBGpyx4SnBx5Dwk6z2haXVigeE4mU5hKm6JUnmW7nMBuLrgFs8WhysZr+LFuR11RKg+
 B5/u/9sP7fms1YT5lAAAA
X-Change-ID: 20251203-firmware_managed_ep-37f1efb69b15
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@oss.qualcomm.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        quic_vbadigan@quicinc.com, quic_shazhuss@quicinc.com,
        konrad.dybcio@oss.qualcomm.com,
        Mrinmay sarkar <mrinmay.sarkar@oss.qualcomm.com>,
        Rama Krishna <quic_ramkri@quicinc.com>,
        Ayiluri Naga Rashmi <quic_nayiluri@quicinc.com>,
        Nitesh Gupta <quic_nitegupt@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764768410; l=1093;
 i=mrinmay.sarkar@oss.qualcomm.com; s=20250423; h=from:subject:message-id;
 bh=uJBOxPm6Eimz6DhfdchKbr3oFckVKr97/7nJ/4jxK5k=;
 b=b/U+m8vYbR2kFPXh8P/G5wa6/MjA8v2RliBAYBT98obx34wyLBHBCBoZqWPLnHQu9FFZVO/Tu
 mIjW0+AZWtgDpDErop+vKDQn95QoCACuvv/MFfYcc7ngg0dN/l+w7Rl
X-Developer-Key: i=mrinmay.sarkar@oss.qualcomm.com; a=ed25519;
 pk=5D8s0BEkJAotPyAnJ6/qmJBFhCjti/zUi2OMYoferv4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDEwNyBTYWx0ZWRfX3m97O73LeYm0
 d6PjpF3sR2UBR8Z2bxGZxKCni4hkO/oXm25oM6+5vCuW4ffz7ZvV/jM94hnaiIgDa9OzFKJpthJ
 EGDvmjt7m0XLb5jwC7MclgT3cXLfopBD/skuunp/oZLBNAdOXG8+rUa+/7viLItNdnUj2lD1t2V
 f6UNMmvtLzP3wtEWZDEescfHEgpoGLInlMhdRHLAVQ/m2hl5rLwMo47TbzDPKhwbrAKeX8xIcJe
 DHA8KhTJLshc8eN6cOm9be4+MfyiWHIEnJghgLw/JG1ikTAwyaMM1Y/ssqnffMYnTzfY8vK0pY1
 pwHId+2u5GfIxZKmVg+RFQGzhN03tPo1C6eJ+fsuDK414ayyewPh2zKxaE0cgM3voQqUKCwf4/7
 ndbrhu0sW2ScbOA9zAqskJJiLupHIQ==
X-Proofpoint-GUID: 40XSU4C7z7fqOdrHvQhWkFH9GymWo_rO
X-Proofpoint-ORIG-GUID: 40XSU4C7z7fqOdrHvQhWkFH9GymWo_rO
X-Authority-Analysis: v=2.4 cv=R/QO2NRX c=1 sm=1 tr=0 ts=69303aa2 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=KnNq_94ptiHzTE3zWj8A:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-03_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 phishscore=0 clxscore=1011 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512030107

This patch series introduces support for Qualcomm SA8255P platform
where PCIe Endpoint resources are managed by firmware instead of
Linux driver. So the Linux driver should avoid redundant resource
management and relies on runtime PM calls to inform firmware for
resource management.

And documents the new compatible string "qcom,sa8255p-pcie-ep" for
SA8255P platforms in the device tree bindings.

Tested on Qualcomm SA8255P platform.

Signed-off-by: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
---
Mrinmay Sarkar (2):
      dt-bindings: PCI: qcom,pcie-ep-sa8255p: Document firmware managed PCIe endpoint
      PCI: qcom-ep: Add support for firmware-managed PCIe Endpoint

 .../bindings/pci/qcom,pcie-ep-sa8255p.yaml         | 114 +++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-qcom-ep.c          |  80 ++++++++++++---
 2 files changed, 178 insertions(+), 16 deletions(-)
---
base-commit: b2c27842ba853508b0da00187a7508eb3a96c8f7
change-id: 20251203-firmware_managed_ep-37f1efb69b15

Best regards,
-- 
Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>


