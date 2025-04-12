Return-Path: <linux-pci+bounces-25707-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D49EA86A4B
	for <lists+linux-pci@lfdr.de>; Sat, 12 Apr 2025 03:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3BEF19E50E4
	for <lists+linux-pci@lfdr.de>; Sat, 12 Apr 2025 01:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692CC15539A;
	Sat, 12 Apr 2025 01:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qj92Yo8e"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BED1494C2
	for <linux-pci@vger.kernel.org>; Sat, 12 Apr 2025 01:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744422675; cv=none; b=uq53IgGiXrNy6CSnhhKPXMaEa6JA9MfZ61rOeEPU72a9RsVGcunrSL+3XHxOXDbH7D4GdiD9xJbDyId43VeX1YoYFilKJMvwMonihVEkXVhc5y6PJMss76cRCwIm5npNOsp2hky7aaMbFe82sckaAIOZzXa69TMXNTxsdnsarHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744422675; c=relaxed/simple;
	bh=Oaw5BYsMpa1UPPlpLdEixtK2JB8A6yxRcZwiYYqmxCw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f9b+Xiwv8ptRvUCvGJwaAXfixFQ4KCPnA2IkMVq2IIeGtI3p/HPu6g2ENjqplNsPVyXhomnNarpkIkERMQPSNSX89b4fUenC/A4LRzWlGr1pgWomkXfu6QUtgWGBboz0ItRalwGXLkAkr87cu05nnlX6bOGAmjLDE+oo6k+33bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qj92Yo8e; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53C1pDcY017700
	for <linux-pci@vger.kernel.org>; Sat, 12 Apr 2025 01:51:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wXDjDnI/vwlLbmgczBFD5lMgP76iqExSvHFDjdjU4aQ=; b=Qj92Yo8e/+N91FRy
	/T5/wDDpZPvwR8QhdIIph/NCtA/cH4Fa9SHTXJZA05QG1Ot1HfDc5pFtcY8p45Pc
	NDQQE2MuMYAxsKR3F82AykN0reKjWA5i2tA8Oq8LVlyUqhY6i0zJ1zGyPtfkolog
	Eb//UkK07m8D1bsc7ZiPwLvPdeWnM9a1Nmf4McTVJc2vS//gq7obAisgmkAhg6Fz
	Lt7rczteIiiEZTFCCXgj6gv2poHVCZ6XZztyAYJWF/uOkYFcuhmn2/YDG5n5ahWZ
	ol0OrncIWSw66v5v7q4Tz6enwNYVbi6X3nhfWRVtWClnBUQv6QWgd9bZEOhoEe51
	1pFqQg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twfkuuug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 12 Apr 2025 01:51:12 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-73917303082so1690385b3a.3
        for <linux-pci@vger.kernel.org>; Fri, 11 Apr 2025 18:51:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744422666; x=1745027466;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wXDjDnI/vwlLbmgczBFD5lMgP76iqExSvHFDjdjU4aQ=;
        b=ZyfcgCd445aHKviK4QMq1FK1EHt92mz6sNHmCgmPGnmOOAZJGCCFdswRQyizx9c9ae
         b2gNlCh+EBpW02O77iNrwUJ1Ztz//D4oP1oME+48yjMHAo8bh9k6Xq+a8Kkx/JHoGOEL
         QNuq01NQtfa1TkiLWurKCcdgv0dOSptDrDW1RVeqgOQDZ6cBHpNqde0RQiNsWjEwC0jg
         L8oC9eniPzBTnHDsNf5LkqFfgAN/bCUpx8hztSUrGkavyYu9XaJtxmjRbuCHkdPZTNQf
         ddxG8CU+q521UitQ3lQxZt+jNQni5lczmUe5jpGhrWJyJ/5PfCnfGU4i9vzidvD2ZUd/
         4hlw==
X-Forwarded-Encrypted: i=1; AJvYcCU7xywhCIpmQOBZkzYrGdwFgYOefCFIufFeGk3nWWyoDjfea0L9ap42KnQhU2bjS4DLDuB0GS96MG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMfY2MBkSSvWzlLJM7wt1A4fB8uXL3aPA1lY6Hg0JjYb7w1env
	VwLw6xfPfKi2zAw3efLb9v5tZd6Jqai2n8q71KO1t4T2QWK5+DmEshTLS3EiXbNat/q+U/LtcbQ
	sHgMZbFJRIp/YRknqKISbLhJh0kObsZ+eih04Q7SFWM36z6SHKF68GS0HQg4=
X-Gm-Gg: ASbGncsZzJ6sRUPCIPwjgNDsxovI9zEfaNYtKS9Oxv2nBWvt3Ijnxai2T70kEBWxw2x
	PStsAIantuaAoxysjXRgGa8bvNIPDQCmENTwJULMvUytlZc02MdjORT58zNUkgyjoHmJUN0DuLg
	L4uvn6acmikJEfvqaQvoAyYLOYzp7jog8QCpveoZVoGB9XfKpU5eJDulfwblpq0Moqx9V3nPY5q
	vXie4TRjCVl0N2E3fNs2mbVW43JXP78fBwt8T2I5MhM6RCTo47ZLtD481660DnK/Dx67R76R7lK
	twDQseyPUefdriuNeXqpa7c918aK41kpPuX2F00Jgw4W/Zo=
X-Received: by 2002:a05:6a21:1346:b0:1f5:63f9:9ea1 with SMTP id adf61e73a8af0-201797a2f99mr7734235637.13.1744422666150;
        Fri, 11 Apr 2025 18:51:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhQZCbkxSI6PDwHyqW4ekFZNhMWVyKXBuUhJd4fpDyIEb/nfuhTQtDM0Fm4R/yM1QyukaHVA==
X-Received: by 2002:a05:6a21:1346:b0:1f5:63f9:9ea1 with SMTP id adf61e73a8af0-201797a2f99mr7734204637.13.1744422665819;
        Fri, 11 Apr 2025 18:51:05 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a3221832sm5516825a12.70.2025.04.11.18.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 18:51:05 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sat, 12 Apr 2025 07:19:58 +0530
Subject: [PATCH v5 9/9] arm64: defconfig: Enable TC9563 PWRCTL driver
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250412-qps615_v4_1-v5-9-5b6a06132fec@oss.qualcomm.com>
References: <20250412-qps615_v4_1-v5-0-5b6a06132fec@oss.qualcomm.com>
In-Reply-To: <20250412-qps615_v4_1-v5-0-5b6a06132fec@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        chaitanya chundru <quic_krichai@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: quic_vbadigan@quicnic.com, amitk@kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, jorge.ramirez@oss.qualcomm.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744422605; l=898;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=Oaw5BYsMpa1UPPlpLdEixtK2JB8A6yxRcZwiYYqmxCw=;
 b=JL52Wfo8pw6/UQa9GHkETh5g5ITH7gQC8LdiDoKxamZX6i+6eyllC8XztRV8oSG5TFAo1JJWZ
 wIqXMoNPmYOAbk0D/dg0FiI8ZOyVMCK0Y/WT2UnCaiux3Sxz3X94WtI
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: HsRketkKpdx_u8Y1vF3HjszcSWFhm68K
X-Proofpoint-ORIG-GUID: HsRketkKpdx_u8Y1vF3HjszcSWFhm68K
X-Authority-Analysis: v=2.4 cv=b7Oy4sGx c=1 sm=1 tr=0 ts=67f9c710 cx=c_pps a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=5PcvmwL3LSb495PBagkA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-12_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 mlxlogscore=874 bulkscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504120012

Enable TC9563 PCIe switch pwrctl driver by default. This is needed
to power the PCIe switch which is present in Qualcomm RB3gen2 platform.
Without this the switch will not powered up and we can't use the
endpoints connected to the switch.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5bb8f09422a22116781169611482179b10798c14..b974098910d5b3656404bb839176baadd059ae9e 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -245,6 +245,7 @@ CONFIG_PCIE_LAYERSCAPE_GEN4=y
 CONFIG_PCI_ENDPOINT=y
 CONFIG_PCI_ENDPOINT_CONFIGFS=y
 CONFIG_PCI_EPF_TEST=m
+CONFIG_PCI_PWRCTRL_TC9563=m
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_FW_LOADER_USER_HELPER=y

-- 
2.34.1


