Return-Path: <linux-pci+bounces-40453-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E85C39419
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 07:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F100B4FB793
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 06:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243A22DE1E6;
	Thu,  6 Nov 2025 06:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NNFlPNMo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DthdEz89"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730622DF132
	for <linux-pci@vger.kernel.org>; Thu,  6 Nov 2025 06:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762409640; cv=none; b=Uda1Vrfib0J1zHbWXUiJGGmJcHQUem7ff1jjSR81fcJYRlYJIKk4Y71n8uR4RS9MCCaqfQKPmIM/5Pjv0//krzatOwioT3hIRjKy3UN2d2W3xRpY0o7NZgp8bdqyJuCIW+LOjADaIACU1J/cc//rtVnVvIB9FxjRsKmqcCZoDaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762409640; c=relaxed/simple;
	bh=b/OstpgQdPxEZ88gQf9VC6a9dVIu7gF7ReuXlh3rFIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ra5T89zjkpqPUjQG3PUe29K3PPPMdaDtdSS1u8cxJGQjY3Xu2veH88VdO7EItfPmUNN53ECD0mn7X4fHlchEdoCn4LCktYnwc1Yb9aP7OdvFbtlCOK7AXfp/vOuOiU6uLvFJIZV92gD9OEyt1dDigVY/rWLJp6gj2iNK7f9hQTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NNFlPNMo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DthdEz89; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A60bGn22389154
	for <linux-pci@vger.kernel.org>; Thu, 6 Nov 2025 06:13:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ekiVpYGZ4cu
	OD+sx7L1HrtYsiK1aVYOs0lLCXxJpsWQ=; b=NNFlPNMotHJzq/cpAt/J4osS94f
	N1QIDw/g9cy31ZSQJP23uKoPgZmeLwNibRzw17SLBhaL8VssJc0mATxSsuK/35Mt
	JyRUY9CJg4MffxCy+WII9xAMW+YgE746J5oIpJW3jdaveyOyJaNFeRRQNKlPQHBX
	Pokosgf3CGjP/Po1peRXNlkirm45B47x/YkR+CjDlvNwktcC6pmTF7vgJkxTsSlB
	ND5FsHeoYK+8/dnbOiZFok5dWm96lINwZbaxfMcIz3ifVknLklmcRJj+2kGUlzb1
	q7t3RFQ9mOy5jXkVbUFPjiMjI7U5MAjDLZg3FKo/v+k9VmwU6E57qKX9n/g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8h9ursnu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 06 Nov 2025 06:13:57 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-295b713530cso8813595ad.1
        for <linux-pci@vger.kernel.org>; Wed, 05 Nov 2025 22:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762409636; x=1763014436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ekiVpYGZ4cuOD+sx7L1HrtYsiK1aVYOs0lLCXxJpsWQ=;
        b=DthdEz89yGXHjHYxaXnv1cNBryHsPngvVZuOmY89IHkysp04yN/jAzpJnegwlC+2ok
         iXR/L326I7Jq1sRLxYy/RJCfJjLAvATtCb52GhY1VznGyJeJdeR2rpSvx77x3TK1jBxy
         k9dbHgVybdO1r2ToPriOvTzEVSbaBb8s0aaHKdotuJ7suSKqrbu1NTpEtcqMI1ZsdMnX
         ARPdgYa46je8YcsmFJEGKKOHqfNshUi2oTiSENeNK1jJeDE508Cfhy3FCDpTI6xnojTv
         gSkB5dj8uMuQEWkFRzcqU2ahXa63sc2MhHkaMZsfWv39sYsdUXvnIr50G15kMnTzR8zv
         1v2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762409636; x=1763014436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ekiVpYGZ4cuOD+sx7L1HrtYsiK1aVYOs0lLCXxJpsWQ=;
        b=p1bMqK7tVmtRGBaS+ohIxhck+XDkZPuIELu5hWT8IvcTYpTZB0Izx710u3Crfy7kKK
         db8uou19kQCZ08Pix65tm68D2dxP3Gbd6IkH3SdaJLIUbXLFMfnhZO0RjzhmP3RFUDxq
         2RngHtIY5UGINuIA4vSXGNVNgLlFkJnqX3XpwaDnoJ/iLJ4wvMElopLHPGA6wj125S83
         9NrZycD0fYqEVUjPZn+DsjQ9A07vCF6wdB5GFHkpx4aSvSEI+NKM/Fz+JqwnAVvMtu9c
         KSQS7TjhKOMWgzNAMEAWFZMJGCFrOSVBT2PGXBnmF0d6jf7/fZednqUOMh0ulKi7PXB8
         dGfw==
X-Forwarded-Encrypted: i=1; AJvYcCUmEQJyYp21hdgkenTb2tlbUYl/9NQ2KRwN781SjKbaxUr1bBmnTrKQswzmAQgf5c7ocr8gPn22Eqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIssHPwt/cfmhbp4rQQIEhh04yCGNiAh1yaeOtbC3o8zhhnIBv
	MLn6l80sq9mhlZh3od3caxwrACFaoVvZS6mPKvBhOpTLQJE4OcCCZSv9JfSnZuOYBiw+cd8vsAA
	nPoV0VlcK6WdUjzFh5OCW8fQLJfeqbmbKWll22lpsHLnc2h0F+Pwglns4UeIKpHY=
X-Gm-Gg: ASbGnctrFvI9d7h8xDrWVcSvl4GOG/ypkLAi+WG+LM5yVVqMZmBdWrhjv/QO1wLZMpV
	MFahfXDYY4BrEwkmq11Lao2gVMLyouQmdKk8U01C1fURq2Ma78cz6mZzoN1vGL85USI/2rrbyOx
	OIrXKa4zphzRPRcLL/WSdhUZAOJ4JBXHRF5b50pw/wALFUqeBLwqrWp0clAkr8new/0/LiHS2cv
	I8uy2IrCTNM9wuq15dJxoiTdmUt+Nu8SWn+i/+qdq9kAjLVUONO9AnezMvbwmjzf3vTTilKaWIX
	t0N8iyriYdTrYSmgtWj098MwuMj1m+qcjx4OlX0ALgeJS9RgiJOZO8UUVrvZPMKPZoOjV1jiNdP
	fS3kwU8hJ28rLM/R5
X-Received: by 2002:a17:903:1a2f:b0:296:5ea8:ed7c with SMTP id d9443c01a7336-2965ea8eeecmr15364505ad.17.1762409636388;
        Wed, 05 Nov 2025 22:13:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGd+XJvpr5YFw1E4aixknmuqd76EwZo1ROcav4B5CeitIgUuDOOUVEABQbOKyCFB2odzUE9oQ==
X-Received: by 2002:a17:903:1a2f:b0:296:5ea8:ed7c with SMTP id d9443c01a7336-2965ea8eeecmr15364115ad.17.1762409635918;
        Wed, 05 Nov 2025 22:13:55 -0800 (PST)
Received: from work.. ([120.60.59.220])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c73382sm15036305ad.69.2025.11.05.22.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 22:13:55 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
        bhelgaas@google.com
Cc: will@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, linux-arm-msm@vger.kernel.org,
        zhangsenchuan@eswincomputing.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH 2/3] PCI: qcom: Check for the presence of a device instead of Link up during suspend
Date: Thu,  6 Nov 2025 11:43:25 +0530
Message-ID: <20251106061326.8241-3-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251106061326.8241-1-manivannan.sadhasivam@oss.qualcomm.com>
References: <20251106061326.8241-1-manivannan.sadhasivam@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=R5UO2NRX c=1 sm=1 tr=0 ts=690c3ca5 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=tomDxdmRQcfPzRosr6lsLA==:17
 a=pvCTKC4ah8od1FUW:21 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=J0DKTq5R2LgoJC8wmisA:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: v-C2C8nAZd-S8S_G2mUL8Mq0o333f_2K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDA0OCBTYWx0ZWRfX7TixJz5cRdhh
 DzGEh1Zh1D+RwuJq7UhHvQ0meJgtn3WPQY+s8aFPGcCuD/zvMWzEYIdBf51W2Ghbs69Vbo3/+6G
 7GQsGUfEgd9B+BMD/kCQtyVx6bZgAKAU/0mM4AfTr2iJP12x6mnT569LpzFcgsYUhaoW0uYO4yp
 f4OAj4UXTRELpG41VeYqK0qrl8Ozfc2j9u8OLwp6upciyBpuKgLqWvKaFLi3HdDxqtrVxAw6VlO
 nvzWTvuq/bKzewK6NWo2bOFXQArqmKPL4I9JaIvA0OMoUOeau0YsDHy8mSBKnzVr9CWU+StO4ta
 9jxBZxFtwZmXxH+1hJ9MjhZZLXdfBrn5O+WBHzPCeUtkTMI+SDaLNH0CBlOwnTUond4V8ENjZOT
 TWc26WF2uWE+DrCeYmQ4KTq+CIWjXg==
X-Proofpoint-GUID: v-C2C8nAZd-S8S_G2mUL8Mq0o333f_2K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_01,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 adultscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511060048

The suspend handler checks for the PCIe Link up to decide when to turn off
the controller resources. But this check is racy as the PCIe Link can go
down just after this check.

So use the newly introduced API, pci_root_ports_have_device() that checks
for the presence of a device under any of the Root Ports to replace the
Link up check.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 805edbbfe7eb..b2b89e2e4916 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -2018,6 +2018,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 static int qcom_pcie_suspend_noirq(struct device *dev)
 {
 	struct qcom_pcie *pcie;
+	struct dw_pcie_rp *pp;
 	int ret = 0;
 
 	pcie = dev_get_drvdata(dev);
@@ -2053,8 +2054,9 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
 	 * powerdown state. This will affect the lifetime of the storage devices
 	 * like NVMe.
 	 */
-	if (!dw_pcie_link_up(pcie->pci)) {
-		qcom_pcie_host_deinit(&pcie->pci->pp);
+	pp = &pcie->pci->pp;
+	if (!pci_root_ports_have_device(pp->bridge->bus)) {
+		qcom_pcie_host_deinit(pp);
 		pcie->suspended = true;
 	}
 
-- 
2.48.1


