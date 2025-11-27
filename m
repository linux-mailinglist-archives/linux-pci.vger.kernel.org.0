Return-Path: <linux-pci+bounces-42212-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD3AC8F482
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 16:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 155D834D488
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 15:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32601336EDC;
	Thu, 27 Nov 2025 15:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XbjLDulC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Aztyget/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785C0336EDF
	for <linux-pci@vger.kernel.org>; Thu, 27 Nov 2025 15:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764257481; cv=none; b=gNtWCdi7cog8EcrfH7X86MKDajBcHvEYxHTa47DvqpnHJDuGlXjeHyOPJtSQzOsFmDOf6ykbr36fX4T6j5XihEMboCOk7jKAXcAk58damo3h03xDS3/YMgknYXm4rYBrO5eCf5dWvc6uT5dOSRUGmjtJ372xJPHgtfBsv8REtj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764257481; c=relaxed/simple;
	bh=lv4dBKqxLyjp77PBEf8fzvjGHtU+jVpXznqOTVKlVp0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CtmuPy04h0fV430NqO/uyhfalUChNezEjqix1kHcbakf3i8xknTpNZJGxIcx/Z4VhbfP9WobhkjdyWdWqfD5412NrPzTOlz+N6I3+R5z+CYJ1MImqAX0fr3hO2IX0RLl7+ZdfJTC+ZjSIeaKNS/Pi/pXfxEcoydIknDqJJ8C0FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XbjLDulC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Aztyget/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ARD2Y3k1023020
	for <linux-pci@vger.kernel.org>; Thu, 27 Nov 2025 15:31:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=bTv+skRnWxBY4zQ/qTJiMs
	0T+FjJqZMGsZTyb8Mcm8o=; b=XbjLDulCAdUkq8Zz8xSAfyZDbjhFnrpjyrb3sn
	AtCzcxQAk1A4/3tqa8K6bdZSK9OZDPCmcCAXVh3tOcfKOvNceFh9vP7muYX4wc0h
	tvLuGKbBCDHm8/yP+s21KU4ngqzXrqnLpwPN1ec612MluEVp4Mzf1NF3H8guOMU1
	SaE92yBQw1mUc+2xdZ9SD3Igl0/5l0YkaS3S2KSQHsp9h+vhR0Hw3ugFaxk/j5GV
	nk4pCF1Admix2DzA0EWgiFiO9gqW7MHw+hwC8jK4v+iMO8SOiEtnVEKqPGajR8x1
	9VUi1Zr4jVb8fZh2xxnV/NhTQy3GVm61jKKzbHKKxhehZv6Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4apq66gb7g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 27 Nov 2025 15:31:18 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-341aec498fdso1124803a91.2
        for <linux-pci@vger.kernel.org>; Thu, 27 Nov 2025 07:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764257477; x=1764862277; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bTv+skRnWxBY4zQ/qTJiMs0T+FjJqZMGsZTyb8Mcm8o=;
        b=Aztyget/RHSF9wNldl/j0A4EBVa7G7ChwbKXRtCq0ZfmYoAx4sbICI5bo+0z9TQeEX
         5ZmHj+QeUaN5+hxaSB5Q40hKmGUiuyOv0wAhLZPazD2MKgox5EnE4O2gaAwrtStfOIcX
         qkTPj5bpyMKP5ZYgAb7Jky2U38w2k9ZTR9lJt7ByGXPgFA+YsIiCJFB43pz7hV7kfr4D
         +l7gqlHvyHErXf0eK4zyevkHvaCaTC7PQoKXJHvKo+UrdZS/8s24oC/lMf7FvYMGiplz
         CGWYkGhP171EuQMSfyHVHOeq6tOf4zypByN0E6zuyy/oqVMHyPXv0eJtRwe6q0NwpbNF
         CCAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764257477; x=1764862277;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTv+skRnWxBY4zQ/qTJiMs0T+FjJqZMGsZTyb8Mcm8o=;
        b=jwmfBBqXTFy3YRfEN7yvl9lGYZAH+AUa73YJI8v9xBK94vA5KjLgDxHUudi3FFBBd1
         8qcSQoDoNuO7a0UWb/xOHCHN12QGjcHaLTGutVuh/F5LpmbPzt9Qe6VuM7DQvD8vlr0a
         TzpAnNiJfYfF2aoQRxIO+32ZrryGgAvXuULYKBnitYfhSQbFfx8zVQpBuCzRzmJ956b4
         8IpqUZ13BmrRek39OOoK14ij7+zJ5+18/ZQA26Izpz4bGhEPw0v4dxBvyY59nEIuBje3
         JoItHRVjSn9tTLAAbkSorMJuFXJo2c6un0e4UXqsIUuUMuxd16orNbq9RRreBqFKhXuv
         A6uA==
X-Gm-Message-State: AOJu0YzPWK6mj5IfqJIC61WfPbGG7Rzu7VJs0+kWbUF0kSsXHMtTeJmN
	XhyJGGMf7qFgxuR0B2sXzGf5pj+dglxeYdBhWqpJfyK9RzChRBwTNKXnPBIWED7br6zUnCGvSWX
	9tgFq9bwdBEtW8v60eVQ7GOaYFDoB2IMvboubwRUfd9n0Ek/E+D6RiCQOSVdvlCQ=
X-Gm-Gg: ASbGncsxLZLwAzZQuEyieDwImtd5Rx5oc9YNJcN6nUxf5AWk93L8iygBkZKgSaUtaFY
	XRUW7fbDgBz/G43uotNFIVOKqdNggv66AzwvJqQnGcs+erHhSRe4gtA8z0R8TVbk0dZUvZHzdB7
	MJ96v3XevhGA7ZdDMzUk69f28BVQspnr05TMqoomZk6JZgoDQmvmmmlkR6r6lPqAO5qGMHFLqtl
	LuSfgudWYOvzp9fnMFfJgP/xxet+lksUe4Gv5nHXM0OMCvrjFLZIcMSXnOsYkgHbZo3YEDU4dep
	YSCeEI1B2utZlPlWdk7BxONcsdVTEt5hnfwwGSOba0B/m+mQZc/LUrKrhOG8KO6OS/2pg4sVNzB
	Vde/iwByhOUiqZ/NxFrjsNg74WbSmsdW0FuhVlr8u3xU/9g==
X-Received: by 2002:a17:90a:d00c:b0:340:e529:5572 with SMTP id 98e67ed59e1d1-34733e6cac7mr21267676a91.8.1764257477197;
        Thu, 27 Nov 2025 07:31:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcpXUstFl9psAS6Gx8M6//WR3/e3A1aEjx1JVWfbgtQ5osET1uda2Q913gJvIqiuVLjhFu2g==
X-Received: by 2002:a17:90a:d00c:b0:340:e529:5572 with SMTP id 98e67ed59e1d1-34733e6cac7mr21267643a91.8.1764257476690;
        Thu, 27 Nov 2025 07:31:16 -0800 (PST)
Received: from hu-sushruts-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3475e889832sm3592940a91.0.2025.11.27.07.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 07:31:16 -0800 (PST)
From: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
Subject: [PATCH 0/2] PCI: dwc: Program device-id
Date: Thu, 27 Nov 2025 21:00:50 +0530
Message-Id: <20251127-program-device-id-v1-0-31ad36beda2c@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKpuKGkC/x2MQQqAIBBFryKzTkhBF10lWpiONotURohAunvW8
 vHffx0aMmGDRXRgvKhRyQPUJMAfLieUFAaDnrVRSltZuSR2pwxD9t8qtTMhWO8iqh3GrzJGuv/
 muj3PC51JqkxjAAAA
X-Change-ID: 20251126-program-device-id-2a5dd6cafe1b
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764257471; l=918;
 i=quic_sushruts@quicinc.com; s=20251127; h=from:subject:message-id;
 bh=lv4dBKqxLyjp77PBEf8fzvjGHtU+jVpXznqOTVKlVp0=;
 b=5RfBAESBesbAUT1/4ewz5k/zfKisXA2tW9A+lAAwn2Ah/ZZMm8EtQGKIm7u1zMjt1TKVTS8X9
 SA2GhD/Z6FXAG6h0naXV+0F2kvJEqdMYhC0XHokV9E5A+4iUtu1qU0T
X-Developer-Key: i=quic_sushruts@quicinc.com; a=ed25519;
 pk=OrUHTxBaSg1oY3CtCictJ5A4bDMNLRZS1S+QfD9pdjw=
X-Proofpoint-GUID: MbMTPuXH9WJ-pNyeW9Uf7Sq0oi50Kyxl
X-Proofpoint-ORIG-GUID: MbMTPuXH9WJ-pNyeW9Uf7Sq0oi50Kyxl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI3MDExNSBTYWx0ZWRfX1UbvYF/Q7WCW
 uulfyCJzrVdID4laN2LrWDhiL0wO21TRxCh0zDuZ7vojICM4aRKPub2fxCqZJu/C+9fmPzpqKYs
 +rAdrEZ2NREq4dJy92snPkNE8RU2LWnqLhWGZX334mpCYNesr2lV47BsDjg9x2a9cvGt2EcW1P5
 GS/TwuBz4WgOb3Ne7kDGLG3O+NyjlOn9nBY9+v6s3DC+FbVCslax/ayl5C0czK4+QQU1CTolF5T
 pqefU00p/C9sj8r0Q9Sd9vdTy4DPyoIy2GccqnZHS+Jkn2iiwS/ANVfNjP0Buopo9b71uQwFcRd
 vXF+8Fa8YkVKFScvyNKo6lAn6q+a/VPOxEpZIzvRnPkwWe/nqDWjBuQrhnK+SNjhklU0vp/vz/t
 jUDY/zoLF54rcNFwQz8GotYQdFc8NA==
X-Authority-Analysis: v=2.4 cv=BYHVE7t2 c=1 sm=1 tr=0 ts=69286ec6 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=sSXGd-9XW_a8K-_bqFIA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 clxscore=1011 suspectscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511270115

For some controllers, HW doesn't program the correct device-id
leading to incorrect identification in lspci. For ex, QCOM
controller SC7280 uses same device id as SM8250. This would
cause issues while applying controller specific quirks.

So, program the correct device-id after reading it from the
devicetree.

Signed-off-by: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
---
Sushrut Shree Trivedi (2):
      PCI: dwc: Program device-id
      arm64: dts: qcom: sc7280: Add PCIe device-id

 arch/arm64/boot/dts/qcom/sc7280.dtsi              | 2 ++
 drivers/pci/controller/dwc/pcie-designware-host.c | 7 +++++++
 drivers/pci/controller/dwc/pcie-designware.h      | 2 ++
 3 files changed, 11 insertions(+)
---
base-commit: e26d26ba210e5371c153de892ae45a63b1a34ff8
change-id: 20251126-program-device-id-2a5dd6cafe1b

Best regards,
-- 
Sushrut Shree Trivedi <quic_sushruts@quicinc.com>


