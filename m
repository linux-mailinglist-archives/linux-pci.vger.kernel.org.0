Return-Path: <linux-pci+bounces-44331-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38071D078A3
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 08:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E42CC300EA03
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 07:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246E42ECEA3;
	Fri,  9 Jan 2026 07:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jHmMav5R";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z10n94BH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8832EB87E
	for <linux-pci@vger.kernel.org>; Fri,  9 Jan 2026 07:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767943290; cv=none; b=tYIriKYZxWmC44s4T+jgR2yBV/re5uKeIRcNv18GwKeWnztIIAKcG8qpMKEpUZL8P8YbMerWTwlXI3epZFoF5Ntn5EAD7TwX2ZN6ciWRZVxhCiIeyR8FyE2BqL3fcuPXuYk4m+H55DCI4fj5dRaf7Y5u4dq2dT+sCjWs0lyTVOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767943290; c=relaxed/simple;
	bh=Q8+lBQYa1gwtIcmp/3kuabaN+M+86SlNF+xR/NMG0uk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n7OjJ9KlUJzSbEjpwHzh0JAcLlDyzG/8dbmrIyzn8mg0vRIvqnT9dVI/Q0loVO31WcCm+VfAV7LL6WrAEqtSP39rzuiB/m+ggmln2mBdzztyObJz4w5jvTIspzfDNz1i7nErfT51c7NhFDgsQmVx/pVdoxXexuTga21xZUQxTZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jHmMav5R; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z10n94BH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6095NEBE3165848
	for <linux-pci@vger.kernel.org>; Fri, 9 Jan 2026 07:21:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	guGTs/O1+KX/IddGJcB1UdQ/HB/cP55e3A+v7+B61bg=; b=jHmMav5RCAwEPaLR
	LBWihKxXHzXtkJml0VVjuou1ek7FVDiBvLhniT00D3tkuz3Ph9/7xLPiNO8ts8dL
	Q8snvDhPnkpZvdKJ8be8+Cx6G4GFn4fCAVxtmNS/fh9CArEZ0BLxB2oWHYzFpARr
	XvR+EBwTyH/2tAUKvtgTHknu4hL5DYSFj6NX1ow3Nsnep4ii1k1jNHUXPsFQgJ1M
	VNmdDsaOuBIc2LEtjCv+mnTvDtySvNW6weIfpvm8dhqZjvTaU1GKp4TlwXdvrhGs
	SDO5uBAIBZ5/MVbKAzLfb/bVj157jobWilfc6BiZSqLL79kjVLjf9KEwJxFYE/b8
	V5vsww==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bj8923xqd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 09 Jan 2026 07:21:28 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7d5564057d0so7821963b3a.0
        for <linux-pci@vger.kernel.org>; Thu, 08 Jan 2026 23:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767943287; x=1768548087; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=guGTs/O1+KX/IddGJcB1UdQ/HB/cP55e3A+v7+B61bg=;
        b=Z10n94BHQkNOKgVoM3cGrO/aPeuNz1PrJombjW9f2rtt5QI9wfeIcfKuLccmhUfDxk
         0ExZ4KllmCRDJ3Brz0TOjfMhd7//fjLJmxbYC39SbkEWLuaf45zkRm0k6SHnZgNDYpY/
         /I0jXB9WXIFSuCKMH+sJBoyX9+/ugZYWXK4b9nPLT+aqHC4MTRi+BA26pT+R7ccYSISG
         cZK95HFNcWiYL0mohOZbfhchkVc5k/6Z3HG8Y7KYJetsue7Glb5e44otRQp3WrMVQKQx
         V1OfHEb55pa1oliPNclSONnAosljgrz6JlFmfYmQQfbksY0OE64NCa3aWgtlsTifFIWL
         Kf4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767943287; x=1768548087;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=guGTs/O1+KX/IddGJcB1UdQ/HB/cP55e3A+v7+B61bg=;
        b=PWzwQcHpWlpriXxYrPMLhyj17XS/YrKZ0ABc0xZ6KwJzSB3IoqohJuh7dcw1tiDiCt
         YT9JIp3/7i5o6lX5a7J+R1A39Fo6sGDV0ijGceI8SOM3dJSfKaD6USsnxXEBqmc8Eyx4
         qcy/JTUJmTm+TMpXkFlPF5sUqZ4mL5SMu8TFjqgEA0l+l7dtrwlO3CWfEj7XaJUySImu
         U6emkClk5XGrORCy+DptzsrmDERKsLwz5zDIxfUCtCA99zt2sYnCfgQSELsfxgxfaY/p
         ruqM0oU9vJ5kblrmbZt5vIg4Yn68CN2Guqde1x8cJwgaq+6E+7stmp0NKRzb9DoXlOub
         I0mw==
X-Forwarded-Encrypted: i=1; AJvYcCXl7K+o1drr4pGM8er8MnQy2zhzrCoYz4dLDg8jabEcHbnIjKvszKB6Yvs/ASvsiQXHGFDUlFWDLR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU3r3Bd+o85xx+5mey21f/bD6mgm0mObnV9zEkOwML2gkPIvnQ
	1MBEoqIpBKfZfMDkzc0vonh0j1qn9xhh7JRNjKW5edumW2mGqhLDOGy/EtA3sIBWD/+D6/7/GY9
	pTtbaWYkTDXNOtJInkIqKZfA4h/Pah832q54Mo0cQTjC8fmpN6eyWVhbqk4jXPac=
X-Gm-Gg: AY/fxX7VjV/BFz3amD+gSEETXSZxnP0vU3Cn57Vhri+QKlZJ3O9yC9oBo4Hi/7qKMlf
	zakpgb60UMTCkz41MORURhBUI9VK9gxzr7EntZpRIKrd89dh5OLWsibk2HK5UX32paVipjAGMva
	YQDZUyT/WA222l7U3fC2ef6osGyDfRo9QR42SpiXlDA3i9ARpE+w9zXOZ0lAkpf31nJyra9CQ3D
	JWARzBdDjskZ16/csa1b90MBRSx5jC61If4wzjRYnhpnvDvIgCVO9ml0r+tzPE+I/Z45dQ78k1s
	qtHZdgnfn13W9RyUa4Ws/GcfqWS0bdWC7arc+1f3PxkB1aJdx4/r/Xo2nSkYQXcpjo6ZEXKzFSb
	YmADQtFJcsX81ItkhsCl7cLC/2q9f7BAkT7SI80kfbIAC
X-Received: by 2002:a05:6a00:ad89:b0:81e:b93a:ab17 with SMTP id d2e1a72fcca58-81eb949ef05mr109784b3a.15.1767943287506;
        Thu, 08 Jan 2026 23:21:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHHO/gTWbofCIbVPKFC0FzAlp9Te+YLm5t90cM0UJujZ0kZxgVI4P5Y2KLOWpErfRjlJU2oQ==
X-Received: by 2002:a05:6a00:ad89:b0:81e:b93a:ab17 with SMTP id d2e1a72fcca58-81eb949ef05mr109775b3a.15.1767943287110;
        Thu, 08 Jan 2026 23:21:27 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819bb4c85bfsm9510369b3a.30.2026.01.08.23.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 23:21:26 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Fri, 09 Jan 2026 12:51:08 +0530
Subject: [PATCH 3/5] PCI: qcom: Keep PERST# GPIO state as-is during probe
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-link_retain-v1-3-7e6782230f4b@oss.qualcomm.com>
References: <20260109-link_retain-v1-0-7e6782230f4b@oss.qualcomm.com>
In-Reply-To: <20260109-link_retain-v1-0-7e6782230f4b@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767943270; l=1606;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=Q8+lBQYa1gwtIcmp/3kuabaN+M+86SlNF+xR/NMG0uk=;
 b=7YI5V7nEUujpXnOmp3l/fb1YAPFx6zBRbuPbaO3yNRw0oukGrQ0a1Ora1XFfVbDewrYHatld6
 n+neRReQcqNAII0gT6zmA6BhgsYMZkhIeu6GLIB2gaqU+psBqT8DuE6
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=M45A6iws c=1 sm=1 tr=0 ts=6960ac78 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=Py5lcOcq67Lbq8UMOfUA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: sFCEK7sUUmGgRqnMsBAIj6bu9WiIpwpw
X-Proofpoint-GUID: sFCEK7sUUmGgRqnMsBAIj6bu9WiIpwpw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA1MCBTYWx0ZWRfX0KueH2FC/E2U
 plheSt0Raio+cbVZS7GaaNb0X4YK2Mnd8ylpWDVfWuOxKR6io4f7yZQM1ZLNmFL7Qg5GwFR58nb
 CtbZzDHOB0Nd6w9gRfF/YJx3H69QnjJf+Vn6VlTe5fmy1dZMaQ4IGjrq+79KLDe+tEX9jmSvEBh
 cUpY8RMgrTpglHUrgblDfFwfs0fjfRUVRc1wylToB0pOTA+vPmWmcm6PFvBec84jMkHowvyjUtA
 PL1ViHsKl19LZg2OfLZC52AHYFa5c0+HE9TXtkMrEhCf/OPy9ezU9WMpksb8LXTl+zdMgB/4BeQ
 Jxs4m5DeWAHFcmwzUegb9eMoeLveY52fpWJbBDvKZInOboAbrXngfQYxYD48h39IU5F8NtKL4Hi
 erB/dFGe1en4qhfruc3nVyVkpPgG5OSgwSZNFAwN/veyMd1l35eFcw33/fUpMjSNZwoC3hkuPMb
 /b/KZz1xdTcZ3IVc9cg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_02,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601090050

The PERST# signal is used to reset PCIe devices. Currently, the driver
requests the GPIO with GPIOD_OUT_HIGH, which forces the line high
during probe. This can unintentionally assert reset early, breaking
link retention or causing unexpected device behavior.

Change the request to use GPIOD_ASIS so the driver preserves the
existing state configured by the bootloader or firmware. This allows
platforms that manage PERST# externally to maintain proper reset
sequencing.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 7b92e7a1c0d9364a9cefe1450818f9cbfc7fd3ac..9342f9c75f1c3017b55614069a7aa821a6fb8da7 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1711,7 +1711,7 @@ static int qcom_pcie_parse_port(struct qcom_pcie *pcie, struct device_node *node
 	int ret;
 
 	reset = devm_fwnode_gpiod_get(dev, of_fwnode_handle(node),
-				      "reset", GPIOD_OUT_HIGH, "PERST#");
+				      "reset", GPIOD_ASIS, "PERST#");
 	if (IS_ERR(reset))
 		return PTR_ERR(reset);
 
@@ -1772,7 +1772,7 @@ static int qcom_pcie_parse_legacy_binding(struct qcom_pcie *pcie)
 	if (IS_ERR(phy))
 		return PTR_ERR(phy);
 
-	reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
+	reset = devm_gpiod_get_optional(dev, "perst", GPIOD_ASIS);
 	if (IS_ERR(reset))
 		return PTR_ERR(reset);
 

-- 
2.34.1


