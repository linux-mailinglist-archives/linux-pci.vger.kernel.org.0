Return-Path: <linux-pci+bounces-40677-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 586CDC4526B
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 08:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0175C188BFF1
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 07:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88F82EBB9C;
	Mon, 10 Nov 2025 06:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MgXZU2aD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J2IdDCaR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0422EAB81
	for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 06:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762757991; cv=none; b=FaiVy2b4s31yh10xfCSya/Mv4QJ4WK8SUknGP3AaBZWJW/XelMzugRfYwrDqa6VXJL38tu3xGwTkHutnN+UMyFALBPwMpieo2xcFn3j9GEBE5x069tX/ajAP+WLkrt6DBlOTdcpI7jyR86BRAvA6uRqy+OdloiHvIp5jskCz6Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762757991; c=relaxed/simple;
	bh=MlBpvBCbPlpavQdjhzK0i1W4DYTe41ZJ3xa89pUGCSU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JDmecOrcN24CVzdKKpM/v+V9qaeQHMEDfJdJLL6eXos4rMg8gntSAW9Yw7vZmXjGafLIJkVfhER3cZXvdM1NwFbi9xLNU/LiYAWJdehZTgzZo0zyCzjcUp6MeagbBStLAscngRTVHUZmhBLH3U5w9i5kcHDbtbHtPcOkjN/Kmg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MgXZU2aD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J2IdDCaR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A9MiYJW1743936
	for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 06:59:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ndeqO3HV+qWIIzmyoo516KQK3+RZYZgFO/0vx7VdV+8=; b=MgXZU2aDCE2abuJU
	xVL88LI0Sc+ly50PvKHIDHlQkdcvfir1LlDjcfnUc278LIvyqPv2+RdTPVyhrXMe
	yftpS4S8rWs51S9ZELUHRIbcWHfS40kUVybADAIiB4J45tQB3ZxhaMO2znkN/Zo1
	ZeH2GifS40bEjB62Xw8/OtgFjpVRLUevl1FSlvo1fXmRuqo/Wbb00OieIJEusduX
	XeYQbwWR/dZwzSJmTVmtd+1K0dfZXKxdZu3aMZ8vaubc6tHAE9qV3CbYOfvR73S4
	86twAX3tZFyMQ4NQ8vlM+4aRSd0uEe0/TOHi1G5EjjHmT6O5UH9TJOzt1RykFXxn
	cTBwJQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9xvjbpb0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 06:59:48 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7ad1e8ab328so2354027b3a.0
        for <linux-pci@vger.kernel.org>; Sun, 09 Nov 2025 22:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762757988; x=1763362788; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ndeqO3HV+qWIIzmyoo516KQK3+RZYZgFO/0vx7VdV+8=;
        b=J2IdDCaRHvGNE9r7kW3qdq49Uo2tOnQ/ZnJV4T8NLImRhLqhR/q8xsjqp2RNrQ4sqM
         xfnWKwH/YvdfMkixxvhj+74dRnjkB+OKNHWAUpjCoBEhwmE2e/mRGBA8o5FKu2W6xVEV
         c28Hz1FniPtrOqNmFy7rnkZ7wZFdnfKqCnQFUTDXGmCK9qRHWAQp5Qcri+LAdrcMJBZo
         TuX6R9FjahyHiyMhlc+E9EnyJJiHQdES+QFSuqGJkOEbv9S8I317tL2IwTDuJKoySxmV
         G8f4GIZEseoqTbapNxQUK9OJRHrwRy7IbloSj5gEemXL3aA1GUPxzwUgRVmBX3oqCw0j
         k7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762757988; x=1763362788;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ndeqO3HV+qWIIzmyoo516KQK3+RZYZgFO/0vx7VdV+8=;
        b=TAxVyerHqbTqtOwhg+J3nRjmTmFGgBJPFLBmi0nVb7UqilVeUZkMceNkyjub1EBpun
         yVDzSZkKLWBnqHQrf7NwNqQmwq70lOCnkKi728H25IQno5OYYF003ZFhcYKvrV0DbTwv
         AZQRixfLWmRLdBnmU5SiRaa8wYoKyiOtyFtrv8zUWqBIiXdcZ1XO3soMG7qGJXl1+ruP
         RwwXkJ1kW9fng4qtYve/Mb04r1YKeg0Lz8N4v2tizY5uW09pNR9N9L34K0j0oPu9zdVM
         hTJCWjmKtfBF/sguC/5/tqD07D3Nd+Qo2sbaxfcPvx2i4OEWPaEep8AKNdq9h276Hyhd
         wu+w==
X-Gm-Message-State: AOJu0YybMsjg8nTa/lfffe4JmJ6C/2DeuQtRTW8fcn/d6jExCWSbKPaq
	bBz6BZKc2Xtmkt/mBqHNRbep1xHK+xeXwZs3ckL/HlBb/Pz6PbnLObSUJbzJAO76Osa9K5Jx44H
	jMVVSsuNqGU0rn9B4we5d/sj9vwpg+dV4By64Ki7g9q5kOh96ie1/KSTqOy0tsjawnnW8SJXvHf
	wv
X-Gm-Gg: ASbGncuZhmWKrUl9b3W3FKFMxXyVU5kF550Pa7qpNlTEhUVJdeP45dB8L+NraIHW/mb
	5JWktrs7bQSASOOSZp+/GMo7M9gKSw21e/OqjHU6KCuxIsCyq+DgCJAGlXOuqOEmRzsZBVfaify
	Zd+CVx+tfPdJR1ik+fwbsw7RtJNIXwJsiOV8Ld0ljDCeg0U/zawj7bQQKd/rDQ4TX/uAMyiYDi2
	7jJk3SzVoHceRc0nJeGkWvdR8/QNY5Gb2zg8qel7PtLsYpHOP9twueYAWw3xC4etYcxclKMNOgS
	nhNm1dUyprfvQz+N+gtJt9j0DGk2CN//oCcWHgpW/Z0OfnJo5M2gxiO+bg+EUFUTCGhLJ//iksi
	+ak6l26jSOfJxdKo/FMaEEDN4f9mQLJ78B8ksD2IUS7QkcQ==
X-Received: by 2002:a05:6a00:1813:b0:7ab:4106:8508 with SMTP id d2e1a72fcca58-7b22727b3d2mr11405642b3a.28.1762757987783;
        Sun, 09 Nov 2025 22:59:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9Wr9f0r66H9rwqF4Xlv+qtiT8NKkKIWr4Cwcpsbko/RHQUMUohydItYXQB7fQ8tTRs9obwQ==
X-Received: by 2002:a05:6a00:1813:b0:7ab:4106:8508 with SMTP id d2e1a72fcca58-7b22727b3d2mr11405611b3a.28.1762757987302;
        Sun, 09 Nov 2025 22:59:47 -0800 (PST)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9c09f22sm10565900b3a.20.2025.11.09.22.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 22:59:47 -0800 (PST)
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
Date: Sun, 09 Nov 2025 22:59:43 -0800
Subject: [PATCH 4/5] PCI: qcom: Remove MSI-X Capability for Root Ports
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251109-remove_cap-v1-4-2208f46f4dc2@oss.qualcomm.com>
References: <20251109-remove_cap-v1-0-2208f46f4dc2@oss.qualcomm.com>
In-Reply-To: <20251109-remove_cap-v1-0-2208f46f4dc2@oss.qualcomm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Qiang Yu <qiang.yu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762757982; l=1155;
 i=qiang.yu@oss.qualcomm.com; s=20250513; h=from:subject:message-id;
 bh=MlBpvBCbPlpavQdjhzK0i1W4DYTe41ZJ3xa89pUGCSU=;
 b=EQepD2Vcqy5GPW9ijLmu/zs6vxi8fDQ2Lv8SRbKkFFEU3o66oiKVRykJBWQ+i0qwcWUdPqAcM
 yebt2JJpPhCC8vUudQ10Eaqu2Ro3ZvX9B8wuhT9JfMf+Y0nFJFsoVb3
X-Developer-Key: i=qiang.yu@oss.qualcomm.com; a=ed25519;
 pk=Rr94t+fykoieF1ngg/bXxEfr5KoQxeXPtYxM8fBQTAI=
X-Authority-Analysis: v=2.4 cv=QuxTHFyd c=1 sm=1 tr=0 ts=69118d64 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=m0zduzYP25AcjJBpPoEA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: EJesR0D7m2dPhdWjUzhxoOtCWZ2ibBNG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA1OSBTYWx0ZWRfXyKiI4XmDFaIn
 7hMVVmI8qp+saakY0uU2SF21A3UqkosD+GtO+cdi0pGme+OKiJaDVIOGzM6swgefdEjnGACPkFF
 0oSNkYaTEIdUvnW6V/KHbWGyaX2oeF3Tu5s0FGj9BnRtfoWOIaABr8X/TV4HuDHwwmd3edF4zm7
 JO6ZV3B+qUbRDULuEW1rL1iT0knyTEFcEzCyXZUaoQIzT9J2lDBtxMsyAYHPa/dGa4hhgU+nERi
 KpOeb1ZzxV/8F7quRQIq7SHQkvbRlmWgFMmX/i47QAzNtnyLSi2yv/IS3np8tv4zPZKFyUtkfPd
 wnxD5HYnlHpZZ6CEd9pTJJr2U1x1TEGXz1+CO+mv33og0DU0oLb6ZSan1uEmRDwuHeTHUl5XnKX
 S9hx+Szh7L+63S8lqlzRek1WKw5QwA==
X-Proofpoint-GUID: EJesR0D7m2dPhdWjUzhxoOtCWZ2ibBNG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0
 spamscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100059

On some platforms like Glymur, the hardware does not support MSI-X in RC
mode, yet still exposes the MSI-X capability. However, it omits the
required MSI-X Table and PBA structures.

This mismatch can lead to issues where the PCIe port driver requests MSI-X
instead of MSI, causing the Root Port to trigger interrupts by writing to
an uninitialized address, resulting in SMMU faults.

To address this, remove MSI-X capability unconditionally for Root Ports.

Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 805edbbfe7eba496bc99ca82051dee43d240f359..09443ffbb150e9c91bfd3b2adf15286ef2f00a2a 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1350,6 +1350,8 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 			goto err_disable_phy;
 	}
 
+	dw_pcie_remove_capability(pcie->pci, PCI_CAP_ID_MSIX);
+
 	qcom_ep_reset_deassert(pcie);
 
 	if (pcie->cfg->ops->config_sid) {

-- 
2.34.1


