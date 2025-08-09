Return-Path: <linux-pci+bounces-33662-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A095BB1F3F3
	for <lists+linux-pci@lfdr.de>; Sat,  9 Aug 2025 12:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4839E72616B
	for <lists+linux-pci@lfdr.de>; Sat,  9 Aug 2025 10:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AE3268C55;
	Sat,  9 Aug 2025 10:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jdFO7fwK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581A9265CA2
	for <linux-pci@vger.kernel.org>; Sat,  9 Aug 2025 10:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754733601; cv=none; b=j8aLisdoZZ3gxqEeTMXaGyj5lyIIxtMlUubzuY4fRZpcLxgBw5NKt2raqvI+72yegJ2dlhCEU7HQme11uDYBIFkdjAR/bSTssp6P2t2gujveuW16C+/5KLwAnC2XWh2S4EmliatXPfX1ZIgoAxJYpbK2L+5fWYUUWHMOK9haC9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754733601; c=relaxed/simple;
	bh=D98uYM9Z60IMUSi6ICuga1Gz5L3qO2+oE/TUIJZiRHI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N5UvjHAZgIhjyFEZmeCJGqPK3573A9HMRsKDLc0C9Q8mjkNRDEEg4HGO1YlnXZX7ZL2Ev44khOSvbrbe8qA6fQ9Z3EpYTVuFdbGSYuQjwnNJ9X2+wV0liLfB3PyakcupneulQ1AiGV7KxmMDRC3dw24B7kfPoA6d7H303BsioKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jdFO7fwK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5798V8Ng005041
	for <linux-pci@vger.kernel.org>; Sat, 9 Aug 2025 10:00:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	o84ehtqBVBZmVKt19QIWtMIRk8uHsOjkSCs7whgckXU=; b=jdFO7fwKcoFS04Uh
	l1TAi96gPHVqHpox9gHpMTIt+lV+9g9oeEEt5UCZabhIYSaP1DNIlwjqcodAXRDc
	ad5iS+khF6Qo/sTtLQFV1Rws9s9WmHrifedCdOWMQPuEPCgMKRPx71t5Apu07+wE
	GBf5P0mhjdxSn2JG4/avFRVFWWRL+2lq0RU7X3HKgUMowjRE5Y7+lSEenj/rGPcP
	1jpITAes9wMbEHIOTSQ0PHksD0xTolo0GPQIjGf0ZNTuuGlieM8UoaIDZqSKqYlY
	3uFi6I4oArVNrYmSsAEYtkW4DRUKn4eDOmrKt5XOypoB98OZS6P9j2n5TPCXJO8Q
	ptZzUw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dy3g0cua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 09 Aug 2025 09:59:59 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-23ffd934201so23065415ad.3
        for <linux-pci@vger.kernel.org>; Sat, 09 Aug 2025 02:59:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754733599; x=1755338399;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o84ehtqBVBZmVKt19QIWtMIRk8uHsOjkSCs7whgckXU=;
        b=o6Kpd448HBx3L82ldeumjAkcoYy4vyTwVywBX9jQafVJ4oN5v1KnQ5E9pmlUSBVbw3
         ZPoEKEWatAv3Nmd/d8w8fiw+J4WrWAJsl1HyWALpZ0xsZOKNOmkqfXdP7exjQ7LyrSgq
         GSeRtG3GEwpGDfW3u852VJy4DBBD3Z/Wa4pw7SPU1i+PN9O9UTD7cLWp34EYKopjZwSZ
         R/7Avy5jSVk+4wu4nw1pKhMQMLvJN45CIUn2ak91aFwqJnC3Zdh5eTDJ6XFJ9suBjMvv
         sY4yL9fr+pFQkDg9pfj59iZm8eABqE5xofU5EWika/4lv4+GieIfQV/o7bSdlusO/wr4
         rKlQ==
X-Forwarded-Encrypted: i=1; AJvYcCX59RXjV26P08WIGeijahYh0hx/f3WrS8lqg5/gv063mtZxD5lp57Li4rvcURXWEqHO2DUhrRsK5pA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR7Bbvjtj4vFV3I5rlhXWp8kw8/TgJ7QeabGdf3Vv5ZPYRQV0z
	hFXF+GcVWa3yDSsUkZAjXm2GfqsbRRaUZzxsFQJlOLQH/dxJ/DgWfUb4IhGSXVGIespjnzhKMDG
	m0V22cl+/hUtkhRsupAGc+YsYRGbcQc73fsp1eWMmRFP21jshpPgCZ+TCQ4gKBoM=
X-Gm-Gg: ASbGnct5pGrGhdpDbTzKy2VVWBqURAYWt4V3cZrZE+MaOd0MTt2E00YHodvKAFt4WNl
	rZrd1fbN+6RkjG5OkVD6+6rBDGKXEk15sxoG492eZXRfYZTa08L9co4W34udBfxLU6CnqPn5elZ
	kH761WSBAvrKtzwEJc70/Aj9HLaMzV684DJat1p4qC7ywsWM/NgRG6XD0SmstDu98Ogr3qHM1JN
	gGz/WsAc63BHevJenJB3IinGrmxJB3ha/v9hBzvoQHKF/Z9h/UGlDC8tR8JbbZ2ezq08Cd4vrA5
	tW/DQNiWMxbmaFutAioRwBkEqeb+TJ6RUpBWvbg4veYmGJrD3Hy9iaOeVYe3q/9zYamciES3xvA
	=
X-Received: by 2002:a17:903:40cc:b0:240:3f0d:f470 with SMTP id d9443c01a7336-242c20440bemr81620885ad.20.1754733598890;
        Sat, 09 Aug 2025 02:59:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFI8IHqimLHr7wh2wQyI+Q0XVDvkBIylGOeXLKFZACnOrlfoFT+ysYaqiBD387svYbfkd+bJg==
X-Received: by 2002:a17:903:40cc:b0:240:3f0d:f470 with SMTP id d9443c01a7336-242c20440bemr81620735ad.20.1754733598457;
        Sat, 09 Aug 2025 02:59:58 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899b783sm225962845ad.133.2025.08.09.02.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 02:59:58 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sat, 09 Aug 2025 15:29:18 +0530
Subject: [PATCH 3/4] dt-bindings: PCI: qcom,pcie-sm8550: Add SM8750
 compatible
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250809-pakala-v1-3-abf1c416dbaa@oss.qualcomm.com>
References: <20250809-pakala-v1-0-abf1c416dbaa@oss.qualcomm.com>
In-Reply-To: <20250809-pakala-v1-0-abf1c416dbaa@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_mrana@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754733575; l=894;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=D98uYM9Z60IMUSi6ICuga1Gz5L3qO2+oE/TUIJZiRHI=;
 b=gwn0lQcGmzLXQ2MXzzYuJm+/nUNsSuse+BknbwSa3jTeXGEUH9LwXwJokOA4GGTXYiB0fuw4P
 GdXwSPgi5sMCf+G5eNlCvWOacfyXIUz8Jdwc3r/BLfu1OH6ZQTtDlg6
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=X4lSKHTe c=1 sm=1 tr=0 ts=68971c1f cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=ly1VyIkaSgMpB_u5KqwA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzMSBTYWx0ZWRfX0Y7S0h3bilvR
 rW5kTg+yqVkWTEx3r2J+BuZ+dDvbIx1sA3AtIxZu+13jjfgXc3sEBYDlCz1vVfSkFufzyVNnhjq
 Oh1J34SqoqFYS/2Nw+LCsKXEY2k6EDc4PNYLe/JUt3+z5jdrYie4DgxS+t5Pxh9IUG8n95DVJah
 m9FE3QNG9FbNExyHiVbuyVXiBymhuaD0TwHT+jeox9ufSyi5KzhZHVc8eR9tZqdm58p9DTvvQMS
 YaIvWi2v+GMdI1OYR8czK7cZ5+kiyz/5ElmAOCKJKzO4QQIRnw1pUc73a2Ry618UkdAecuaXwQU
 ZY4dZwkSVhp8AGY+IlTDHRflqGntv2q+xLDyI7hHcNrOVc/GqHBFN3LWXaSV8OAf5i4tEApdmRu
 Kj8MmenN
X-Proofpoint-GUID: A-0h9zksfgbMlCwLPZL3zm0fTl5kdeJ5
X-Proofpoint-ORIG-GUID: A-0h9zksfgbMlCwLPZL3zm0fTl5kdeJ5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-09_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090031

On the Qualcomm SM8750 platform the PCIe host is compatible with the
DWC controller present on the SM8550 platorm.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml
index dbce671ba011c8991842af6d6c761ec081be24cb..38b561e23c1fda677ce2d4257e1084a384648835 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml
@@ -22,6 +22,7 @@ properties:
           - enum:
               - qcom,sar2130p-pcie
               - qcom,pcie-sm8650
+              - qcom,pcie-sm8750
           - const: qcom,pcie-sm8550
 
   reg:

-- 
2.34.1


