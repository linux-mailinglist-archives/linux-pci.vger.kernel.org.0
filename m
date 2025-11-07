Return-Path: <linux-pci+bounces-40554-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE53C3E774
	for <lists+linux-pci@lfdr.de>; Fri, 07 Nov 2025 05:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 057B53ACBF8
	for <lists+linux-pci@lfdr.de>; Fri,  7 Nov 2025 04:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84D7247280;
	Fri,  7 Nov 2025 04:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ULNAOEnn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OXn9lTJo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5877826ED59
	for <linux-pci@vger.kernel.org>; Fri,  7 Nov 2025 04:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762490631; cv=none; b=C2DMMTdYDU7vlat0oxOFkWtHrOm1s+xmxS9MxJN6ZfC0xYjR6y6TsWPcAqnVkZtU99IV0wUPYrkmUqKQE755d2YeBPsKq1FJpkGqCa4w18oI39iUPJNunG6johV4LTatE5DIJRTc2FEDvHZa17biZzO/mXXU2hT3xFKQcfqnYno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762490631; c=relaxed/simple;
	bh=b/OstpgQdPxEZ88gQf9VC6a9dVIu7gF7ReuXlh3rFIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NsmhNdg53MSaK+170R74eamizNS8+Y0gmJcCa/5TDDgG68esVh/dVRUsB0h4fG8Ur2YXkygT7ojPSYgqDrkkkBYR/qmGBQjyafZFutfRazoPNs8MGaTy0L89J5bQuYNDZXxmma/Xni3lNrImzVg0vacuHvmlxGoXJT+zHRFHy0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ULNAOEnn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OXn9lTJo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A6Gs4bl583527
	for <linux-pci@vger.kernel.org>; Fri, 7 Nov 2025 04:43:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ekiVpYGZ4cu
	OD+sx7L1HrtYsiK1aVYOs0lLCXxJpsWQ=; b=ULNAOEnnL+hBjCQmkiQ0SN5w7Ax
	4eFCoLfaeACCI7LjpGyg61OgwZgvTU5WJodGIMs5jFQovE2iIxPqmvLBHNTmaD5B
	aUkurQMLnxvQx93x4ROjc8/rGj6Ex0OfV2HVGFJRhQU9X51pMRt7lexJVTL7Y+Yd
	66Pk4gD46cN187w7h89ZkFgQBnKeHTWqA9H5VaUe81GL1FYwHOhD58LC1gAFDy45
	Il7I99lOmwZnXefQlYmxF54Iu6BT9MafYyoC6vpAqsIibN+otiM74fcrqiObV34r
	B84qIF2bL9BqPt3Ll2Me7IumD5sRsEpZjdqCBpbZ9/7RlG/d0ILah2iVW4A==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8ykths7w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 07 Nov 2025 04:43:49 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-ba795c4d4a2so300870a12.3
        for <linux-pci@vger.kernel.org>; Thu, 06 Nov 2025 20:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762490629; x=1763095429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ekiVpYGZ4cuOD+sx7L1HrtYsiK1aVYOs0lLCXxJpsWQ=;
        b=OXn9lTJoOxJmI65G1F3IdTHtw7+rKGDxQYdcrZoGrrJIKz2DLl3BKWORrLa9yAWoH8
         fTOJFfwVVRX0pKqaFJKw3eHiXiSPeR35azUAc5K+PvFqRHuMwqKnj0EzwLjDKHngnMXm
         230r9+6NueH7cHvWFXjNzxHC055jeg9piVfmfGbWl1bLzrR4pPWjmr12tXm1K+d6JGT1
         CMGtqf4erJCJ0lQ9V4gi4A79pl5FAvoZFk7+KkH12hPf/qRlFbCPt4snBC/KXOAibHqQ
         g0xABUX8HEYWlzNVYh6jnui+anmdYwmY+VvOTT3Ph+aDOUTOEfGhERETf80pDVhRhMKe
         38TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762490629; x=1763095429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ekiVpYGZ4cuOD+sx7L1HrtYsiK1aVYOs0lLCXxJpsWQ=;
        b=IsRQCNTJzDmtwuw8Mr37KhMQbwk2LHZ4pEM23dA3yRAOASDKWG4W2JrjFHR4OHWMx4
         1UvA5ZSihHafIJqNzNrIYQi/zFpNVo4znVTV4zZEnr8zhU50qLE80ntTeLdTzMcS4REi
         ivOa4XySUiWL+m4ljFzSguhv2hv5EdOL04iH11PFaKablxgxA2alZXHaHsBxlfZStVnh
         XyGmWMxJ34h4ZDAV1vJcS/V0Yyi6nCkJ952+bsqKpnJPVJLIu5zeqsNh07yHxzPum/N0
         U0EYX94myUD995WbtySyehZaH9QpBKFi0qUXTa1FivAmABZ+tfXcdmXJ+Tnm97yVneeM
         Fh/g==
X-Forwarded-Encrypted: i=1; AJvYcCVTU2ptH7G8fiNNuPZ9ZOlefivXhMM8ApoKZ6RNosTAKwP5vIxpn/wv781bFCWSaN+767j7eGeLODE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWTFITdfi9sH6PLhqXyOMxfaeYKPbLFPyniwgn+FV2XfX/54H8
	OMi9yiIsqawg/glKhOdBs1tP2I0INcbL/Fizozm6G+KHrF5tvBoOCnF+NzIy8EsNAmG3f/tongT
	GOhvBBvcyxLqe9TbT0rv1IUiTDtNxFuNKZqKTBHPIU7y850aDEWUgV51qbQSQrHM=
X-Gm-Gg: ASbGncsi++W/QhDGlfE7E09qNf9j4wBYBomTIZnshiVFgpZHbzyZYGRlFg3+wQ0oytX
	7YFDq1/izUkWxrbUult/X0iRFuFLBvOLs3sN9cIE4GyS1NOQQkC24IdjHO/FgtOkvUCDnxxfqP/
	TtQEAexLL+kYknGo/8czW8h3oKcGvtm9g6J63NvzPgDzbTV1dEdQvL4pIVmDLuISZ4CsQD0p8dy
	kKuReuHPC4FXMi7VYN0CllbxHCkrQfctqThGzkNmxilMl1cWUzqhSWFd8hCnWDg177W/wug+EBX
	Ua8Icg5bEhDYqt26sG2DZuCv/W1Vfn9wgO3P1bmfd50YX86sLzCiGTT4Vus0Wqn9Cqgjx1FADda
	/VtJJdrWx9Cbu9biE5A==
X-Received: by 2002:a17:90b:3504:b0:340:f05a:3ed1 with SMTP id 98e67ed59e1d1-3434c567d1dmr2104206a91.21.1762490628781;
        Thu, 06 Nov 2025 20:43:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHwhgbIYkIV3jnOvnUbxhrs6DJqbRycwl6rMp5sHfMFHfNxlRh2Oyieg3TzKQFs69y4s2c8AQ==
X-Received: by 2002:a17:90b:3504:b0:340:f05a:3ed1 with SMTP id 98e67ed59e1d1-3434c567d1dmr2104169a91.21.1762490628210;
        Thu, 06 Nov 2025 20:43:48 -0800 (PST)
Received: from work.. ([120.56.196.127])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3434c332f1csm1142624a91.11.2025.11.06.20.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 20:43:47 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
        bhelgaas@google.com
Cc: will@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, linux-arm-msm@vger.kernel.org,
        zhangsenchuan@eswincomputing.com, vincent.guittot@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH v2 2/3] PCI: qcom: Check for the presence of a device instead of Link up during suspend
Date: Fri,  7 Nov 2025 10:13:18 +0530
Message-ID: <20251107044319.8356-3-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251107044319.8356-1-manivannan.sadhasivam@oss.qualcomm.com>
References: <20251107044319.8356-1-manivannan.sadhasivam@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=bOgb4f+Z c=1 sm=1 tr=0 ts=690d7905 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=NqeMpCPRvvPHbudmJ2rC7w==:17
 a=pvCTKC4ah8od1FUW:21 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=J0DKTq5R2LgoJC8wmisA:9
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: hnuTSufJIzGWfPpuh2iQVpwCcIRCZDEd
X-Proofpoint-GUID: hnuTSufJIzGWfPpuh2iQVpwCcIRCZDEd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDAzNCBTYWx0ZWRfX7rbyCgUQPJf/
 pz0RMSkYVd9QVMH7sRrsxfbX34SPJ46qzyiLRzNcwz/eq3JGKwFGTppj/ySXCxSIAUobT7rra64
 6s16qWu491+gEmKnwNsb97GEOstuQLErqx0ESwGsIPSHt/vLmCa13yqMlPPrLtiCg4SCATT/sxQ
 dt0W2LCRRfrwYZ7bQggUWzXnduZVjqig27nPwvi/YGvwsGLHxrps1FZy3kcXGwzzMDANmKB6DUx
 1ouao0o73tBtdMMgEo5TcLifLdM2MKff/Qfqkt+sKRlh992PSdZDkpp2EnKpgFXwqdVxduH9cCD
 G1AHoMPLb47zfJ+ELsmwhKy0sNZgr0MKUtKzq01jc64benn+OISzK4YS8ZbqVemGQ3UU2ra9FRS
 6FoJ1hKFbjySYNC3LJYA13lkXd00sg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_05,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511070034

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


