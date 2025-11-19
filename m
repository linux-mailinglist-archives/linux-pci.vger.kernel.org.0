Return-Path: <linux-pci+bounces-41670-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B71C7098F
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 19:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2641434A133
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 18:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96242327C1E;
	Wed, 19 Nov 2025 18:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NT2/O0sE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jjcUpBkg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38BA35E526
	for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 18:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763575838; cv=none; b=PAaJO1w59R37YmducOeFwHHFq4XeBYQznrk+TjCEDOWWq55tm/uFOKbb3VwBri9MdXV22W7GxSAYrEkQPfX8d+z0PlnVuJEnkGXC3oEVMoj7L4k93p4NYs/h7Foy05wJmYjPFlmZCp1fzMpcNBPYKq5oedPJup+p2ROwtrLte2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763575838; c=relaxed/simple;
	bh=Cf0vCAl5snTvRcvHYoqSDh6FCeDaD461npSza6EkeXo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aNQB4gvTsuzmHMEhDY9JI4RxhZpPZXqaYD5Ppl7R4P/G/M1ec3PxWLhXWrTlDGyymUoNitgc+jIhX/8+Nu9gZlUIoa7U7pSuSNxetFwXqsAU89BIq1JUpwLtqk+5IVnP3MrPFjL3xc+GfZSqnrvR+jT707XzCq4SetfPivkLLYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NT2/O0sE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jjcUpBkg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AJFkIpG2111943
	for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 18:10:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NVTn4Wtau+BZ+/gvjqlvfniNUMfKB1rE87mf5c2GkIU=; b=NT2/O0sEvIIpcRO9
	KYQt1yGAxO8rNS8QA5IMHe4aEwtu7Yo+SMslOfZHwts4aDR/IME2LzWUnypJcYHy
	BMZH1RTbTnP8YUTE0z++3KP5x18XTfAjTpKGa/uwHe0HM5OB+HVTmtsMZ7FPOc9H
	dj+d1ljAQnEB8txQoOw5znZeEpHjLI1ntDoGaKdpCMzoTk5Xi5CWS27E8aFPLrKg
	o1C9VSe0X/0gcSEvsfoMfqRUr+rqjZSmLjGMSUg8ftEHBQUGP7/twyzE2I5xPVp2
	V6xNUMYlQ6hYg5mRidpmRmTpSnopOG7qC2EKeiO91Kfz8KKDhr7hPS4QwpCINqPG
	aT95NA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ah65t2j9g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 18:10:29 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-299ddb0269eso454705ad.0
        for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 10:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763575828; x=1764180628; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NVTn4Wtau+BZ+/gvjqlvfniNUMfKB1rE87mf5c2GkIU=;
        b=jjcUpBkgNkLBHjnWaav6yICtMcBh1fzVMY/1xOHShN85Nc7oVuccDuxrY6FH7UTDhm
         1QHDqkD+oEwjVxnoYMUAvb6j+vRSXeEuYBA1pYm/bsKYznNnsXNHTsmYO6LNQL1l6C7C
         4QeRT5DuY7JjHrp9VnhKlyTNJJkUkfzN+Pivsf2UgcHpW6RRjRDqPXrkv62aiRUjjOmO
         rg2dMU2xAq912znB3jp9F1CYR/67EFBW9I+PeJvN9sDpTs1JJf7vOYQaVuei1t6LXO/l
         SJrKMyVSbBFTODPSnpL8M3XOecRBIP0Iz/L+RSYlIQ3pt13yj5S+Ut335n+F96CNagtq
         NORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763575828; x=1764180628;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NVTn4Wtau+BZ+/gvjqlvfniNUMfKB1rE87mf5c2GkIU=;
        b=qQSEU/8Ht4dmZP6DjVw/KlyZLpybS9T+OjzlMecGFzaTxEH06d7igBUzwVdGCcLC0S
         oNf/cFkBHKhSbxkXP0hNlNi/+DfCbHz+UYK+f8vHl0OLDeJISBJuXKf6MUGfGhkZUggl
         k3PclwtkMe/+gR/zp1jKB3ZxqGQMDDMtOOwlOt36nw5oDc1VMNCd3VLH+HCNR67cXC3v
         y1qGXSJg6vj62ptVeuWiaJ1Ba1VITZ9dp+CBS3MQYw/wiKb4cEMPUMUSLaqrSAUYXCYx
         /XYS6QTMKdwzkk9Gb+6yUegFyO8LkQt3DznuXsvAs0NOMChNyib2k1LTrPRWzSTZUDgO
         LT8w==
X-Gm-Message-State: AOJu0YyenuxFPxTENbmx3MNXVTuyfrZsNItFEJ76VkQJB+AafpzLrLz+
	TQKOrzSVJlY2duSjiEifsDOuKlLmvU60CuUdLoNe2PZF8vwWAtBew/jasbZrFEOYYpIALgkp2GZ
	AX50hQ/o1m7tNy5Kq+gXOIW5CusPvQvo+C3DrVFamKdOIakHD8yZjnQUnkw9KY34=
X-Gm-Gg: ASbGncuVIMVmz/pzrR2eKXcfVzbGUuYjCeyxzLoAkM4KJUkaAkYAjIdviIPNbwipEyF
	/r5VxuWSXItTa4wnol8QBhWMxTCIm7sV/VvxH7YwEz7LFSO7xQnGbzrJ1anivXvOxbIX/d3ivr6
	jnJSW/Z32R6OpzdP/e+OO5b8gNRK+zvYYtGckU3i+CGm/ye3Ao1TElamdeNm4NZYpPNxxRYRoAK
	MN8IyFUud/OmnSyWLyeNaI+j1xIKka+TDA8G9l8nZccybWeE02uJXcSHRYPQyB+Kfs6X53R/LaY
	ycQg4Hk/Sd/sTm/QGrZGlIfVcST7Vu1t9eSBpt4QdJwLoCCE/Xxk6tswDE6XYO0O0OWonDej1bu
	fW75LoV+kVTaVbKQVR5TI0GZRKRMgDxtiSBn1FkI=
X-Received: by 2002:a17:903:1745:b0:297:e267:c4c1 with SMTP id d9443c01a7336-29b5b13e439mr2714885ad.55.1763575828332;
        Wed, 19 Nov 2025 10:10:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZw0/65yXbHehlekHt+yFKCCXDOMWobOiCHVD+AV0GO+o43yJA4Or2y1cJKFlSuOyj30JjSg==
X-Received: by 2002:a17:903:1745:b0:297:e267:c4c1 with SMTP id d9443c01a7336-29b5b13e439mr2714585ad.55.1763575827796;
        Wed, 19 Nov 2025 10:10:27 -0800 (PST)
Received: from [192.168.1.102] ([120.56.197.63])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b111016sm1408865ad.6.2025.11.19.10.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 10:10:27 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Date: Wed, 19 Nov 2025 23:40:08 +0530
Subject: [PATCH 2/2] PCI: dwc: Do not return failure from
 dw_pcie_wait_for_link() if link is in Detect/Poll state
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-pci-dwc-suspend-rework-v1-2-aad104828562@oss.qualcomm.com>
References: <20251119-pci-dwc-suspend-rework-v1-0-aad104828562@oss.qualcomm.com>
In-Reply-To: <20251119-pci-dwc-suspend-rework-v1-0-aad104828562@oss.qualcomm.com>
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        vincent.guittot@linaro.org, zhangsenchuan@eswincomputing.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2652;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=Cf0vCAl5snTvRcvHYoqSDh6FCeDaD461npSza6EkeXo=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpHggD9y2nMg+sO9+ekIKG7d3/hu2igXML1Pytq
 eivFLhFiOGJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaR4IAwAKCRBVnxHm/pHO
 9WtLB/43To7RvUQDZ9SZLwlAmaPnM++cTTYx1Pn6mQ+QDM4fxeib9sxVbcCMZ1V/1lJwNljdUCx
 0vpvP7WHw7+3ewMxD9nwEQfyHiCfvhL3Nz+1YR9qa70FCkb5B/Ky1pRD6HFlOvmllik+2ke3ZfN
 iNAuD2X1xPxHjLciDrWNjGd6axxf+5pfOmxQ5geXUR1ZOiLEnijekGWXdD7So77QKKsH5BGJ0Mn
 KMVaAjPgmIaRWhm8AfGzaErlbCqb3oWJAmbJ6qAX78t5uxYK7Qohbh2y5Ioe3n8sSpLc80OyOHl
 JNzP/uDMDpmAW9Q6opjsBlTFRCsyiHDEUUUvloKZ2HboeFOm
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Authority-Analysis: v=2.4 cv=avK/yCZV c=1 sm=1 tr=0 ts=691e0815 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=xeX0Tm50+WxWVv+NCdhSGA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=mPLJVkjgqw7R4SvY3gYA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE5MDE0NCBTYWx0ZWRfX8o5LURzvQNPq
 P2huulYwgRBLXnDpe0hbIQWWrE+ry9ijRmQrW06OkfrxA6zzfl5Ma8COI250KHi6g/AyWYMuA6o
 9VipEzLidcUE8sIyMc3Z52HhBuyS7RNujaa+2y4srEBtV8Vh/Tb8xHetkRfM6G6S9FBCYuMf3Vd
 C+MGaN3dU5yk1le5+drJF7NZ1qwOCXJgHmbikqqDXDOya2yEn4YKszUpyQWI8Vj1ruOb2i3t/YZ
 gZ5c49vHc280AETNzjMIuX/idelhKL0S7Pjw+Y/M9EbEJ9TTpSmyqxrshvv9D/VoUoa5ey6G77M
 8gEJjLTw6E+yLTb1WXGMkWWNn3+On329+jLwRDAyy/qGD4fwt5NJQrjkIgPdS2OhKUyqudXrmv9
 SncwLwkDU7rjUV/vlmVWk3+PlgN3Og==
X-Proofpoint-GUID: BDUdqw5O3TLX5moPLa-2uH9jdTVUY5LA
X-Proofpoint-ORIG-GUID: BDUdqw5O3TLX5moPLa-2uH9jdTVUY5LA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_05,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511190144

dw_pcie_wait_for_link() API waits for the link to be up and returns failure
if the link is not up within the 1 second interval. But if there was no
device connected to the bus, then the link up failure would be expected.
In that case, the callers might want to skip the failure in a hope that the
link will be up later when a device gets connected.

One of the callers, dw_pcie_host_init() is currently skipping the failure
irrespective of the link state, in an assumption that the link may come up
later. But this assumption is wrong, since LTSSM states other than Detect
and Poll during link training phase are considered to be fatal and the link
needs to be retrained.

So to avoid callers making wrong assumptions, skip returning failure from
dw_pcie_wait_for_link() if the link is in Detect or Poll state after
timeout and also check the return value of the API in dw_pcie_host_init().

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 8 +++++---
 drivers/pci/controller/dwc/pcie-designware.c      | 8 ++++++++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 8fe3454f3b13..8c4845fd24aa 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -671,9 +671,11 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	 * If there is no Link Up IRQ, we should not bypass the delay
 	 * because that would require users to manually rescan for devices.
 	 */
-	if (!pp->use_linkup_irq)
-		/* Ignore errors, the link may come up later */
-		dw_pcie_wait_for_link(pci);
+	if (!pp->use_linkup_irq) {
+		ret = dw_pcie_wait_for_link(pci);
+		if (ret)
+			goto err_stop_link;
+	}
 
 	ret = pci_host_probe(bridge);
 	if (ret)
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index c644216995f6..fe13c6b10ccb 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -651,6 +651,14 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
 	}
 
 	if (retries >= PCIE_LINK_WAIT_MAX_RETRIES) {
+		/*
+		 * If the link is in Detect or Poll state, it indicates that no
+		 * device is connected. So return success to allow the device to
+		 * show up later.
+		 */
+		if (dw_pcie_get_ltssm(pci) <= DW_PCIE_LTSSM_DETECT_WAIT)
+			return 0;
+
 		dev_info(pci->dev, "Phy link never came up\n");
 		return -ETIMEDOUT;
 	}

-- 
2.48.1


