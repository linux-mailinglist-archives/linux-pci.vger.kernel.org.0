Return-Path: <linux-pci+bounces-40454-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EE1C393EB
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 07:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5455E3B7A76
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 06:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B612E03E4;
	Thu,  6 Nov 2025 06:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ON/A/ePw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AW19Ratd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4204D25228D
	for <linux-pci@vger.kernel.org>; Thu,  6 Nov 2025 06:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762409647; cv=none; b=HVUYIGYKHwKye49rqxNi5q81Az2DXldH6MMqd9xTscaWt1gyGpIRF5JjE9PNi5V4lRvVeG0ghfT4oydBvV6zRxOTP/eHiE6PPMPkDeXcqPuHBKN416mbyTwxOmFIIolF0pz/wMoXvCjVjIVnUhaAPTAlReEaWANSkXQZDXC9nEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762409647; c=relaxed/simple;
	bh=5Eowp/bww9m+te35duy+Gu3+ggKypneeWBbKzwgmR3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e0ETWTMhTje26XUlDyLiAOh71+7cbI8EIzXmObWsj/YA4FHV/zGguBR4+g6ZwSNlLkUTShs7bhDhADACvXdtBr72FGkJmM9aPPaFGlB/WpgosCs93P7qzz2D6kMzR+rsRcZcZ+zsnoTICvugC8ePq/vJu2IRB+EhWmiWDJDIwRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ON/A/ePw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AW19Ratd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A60b6SQ2388977
	for <linux-pci@vger.kernel.org>; Thu, 6 Nov 2025 06:14:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=6f0QmtnZfh1
	cR6Ofnzn6CmW/kfWGJZlpWWAuS2d12t8=; b=ON/A/ePwcX2KNW8OyWlf/ctISBF
	8YbVlajt0/DMtybn006v+IF7NLVZP3ErKkw+H7mq4l7LEMWvdik5fxvfup9FtI10
	XOX+KotT/C6PA38QFsK80YMSZgW12Ju8TSswvS85G+K/QnKz9OV7OocPfoYXXXio
	AJeXVP6SysN6D2yKJo8HKIVRxBWml6K5bDat/QCyRmgiU+yX5uLlxnDQ+9JfAPsw
	zOMvs3qXIyJo3YhU5yDuu209dsevq15S0sNpLjLE2tDzI35hMnJhe0c2OXdJQ/uc
	Q+aozpDUpMQzb6LruJAZcT6/nF5/HKlF4SvyV81U9smK8R5Xbd32tfVUwZQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8h9urspc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 06 Nov 2025 06:14:05 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-29523ed27e0so8612305ad.1
        for <linux-pci@vger.kernel.org>; Wed, 05 Nov 2025 22:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762409644; x=1763014444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6f0QmtnZfh1cR6Ofnzn6CmW/kfWGJZlpWWAuS2d12t8=;
        b=AW19RatdpEPIl2ezyoxWragYwSpoMicIjrzocXMInaZN3By0bhs7OTVCLNiWiYY3KW
         QEQk6bdHjIOiLaS4yQy5y91OHVQPwfkO/K/9K1mZfwTB0YndTi62qkas3rLSOLnVPIWi
         SlPh400VKr5pNg5OG7oOTMz2+E//cwX6cnYhD4yvWfUdCbUw5Kt9k6uH1QaAaDliDRs1
         1NxE1cun3B1VzT09ocfY8GW0Egr3sT/CRhZPXvvsOBS0/2e/lBwRwt2iyz1Z4Ff5XoiC
         65NqnNK0DnE0lp1RePrWTwadS4kUfF+U6mWSelfc/byLsQaowgKpbiKWxhJmYODsXs7b
         h1kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762409644; x=1763014444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6f0QmtnZfh1cR6Ofnzn6CmW/kfWGJZlpWWAuS2d12t8=;
        b=VPUkqKzVNE4MKCeMO/TMR7DYoClHCFUGvK8EXJvYOkiir4h2UBRgbUfZF8k/tzf67C
         WxyYiGmB9iYxrm1Y77nMc7tb+lEf/P3eyQAMW27XLV83/RcFiJRAz3oa6Lji0/M4z3mB
         tJRgwecwvp+fqKjgxx9RGVYthXhtVbwZ1eU93nyLZGo2/+qI7uqQvqzDA3jViufmpd+y
         ViR31P8CMd4gKu/v/vC5s0LHnHMntUbuEUq0aaCrRJoEA55wu7qGdiEX5aVxCS0pNCEx
         D1UFnubYz8q93rGEF1W0txwIGu4gAyByfunmHxCfM4wS9JmrGySaLVFy4sOUSIX8d7Fu
         COLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYts8vtnK356yfVS4iJ4tHr9AGJQt6NTIrbDCWlnYNluBgRNWhmEEBkj89LUgyeNJ0o8nQ998cJJE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4Gc8nuRZRKOqrDwUWlhtDVAt/lUK1ucFQY4exLXXjsG56q8zC
	DNxaiSUsqfDWgRtgQEDVyXYY6tWNYKnZ50mwWtANklKlK0j0Dk+G/Decg65raFV/jbLRrRelxCP
	fHydIgSPbzgVR58OrZTCLcWZFFYYPZIOoS7+kjPEeNpPnhuizz6uGUxT+gw3FN+l8PKybpxE=
X-Gm-Gg: ASbGncvl98OgFALJ4dpDIB6ioH2C/PSTkj7WRCvbi8TMR9cc2rSHv5CnoXPl1Z1xUBK
	Iq4NLKwyEIXZtd6thvx0iW8fFtFzN7KoAsMGyZ9eYXT/wnLetb3B/17ySJRRIbWaTUH5grcIEZI
	Zr6VzB+rNEfgUDpuqF8mjkY2SDJ1Udfch6dOWqAE+JJVRJ91bC31EIlyV4ssWf3sZSlbH2MGeaW
	HWdQDOAjN5B4v/8kqc6++ejAmqqWku2PgUPMLZOEjfzB7X636SnKkw9+53UD5JDBRAvJzgy8B19
	lX/Ebr2mBxZz5YCIhYpQcm6eBiLY1/vr7LzuCC+igRd7oZmcaDB4s/ROzYFsoQjTZgCU2tNqI40
	S+2hnsihISOtEsC4d
X-Received: by 2002:a17:902:ea0e:b0:27e:eabd:4b41 with SMTP id d9443c01a7336-2962ad11330mr76435725ad.7.1762409644084;
        Wed, 05 Nov 2025 22:14:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGau024seW1k+6gAt1RgfaQE2/cFqOhIHoNflQP4yhKsBt34XSgC8/NMQQqGMjUdn+s4cLbug==
X-Received: by 2002:a17:902:ea0e:b0:27e:eabd:4b41 with SMTP id d9443c01a7336-2962ad11330mr76435285ad.7.1762409643591;
        Wed, 05 Nov 2025 22:14:03 -0800 (PST)
Received: from work.. ([120.60.59.220])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c73382sm15036305ad.69.2025.11.05.22.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 22:14:03 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
        bhelgaas@google.com
Cc: will@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, linux-arm-msm@vger.kernel.org,
        zhangsenchuan@eswincomputing.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH 3/3] PCI: dwc: Skip PME_Turn_Off and L2/L3 transition if no device is available
Date: Thu,  6 Nov 2025 11:43:26 +0530
Message-ID: <20251106061326.8241-4-manivannan.sadhasivam@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=R5UO2NRX c=1 sm=1 tr=0 ts=690c3cad cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=tomDxdmRQcfPzRosr6lsLA==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=JlmoTVlqZe2UTokRIjkA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: f9CGNKri26S0UwUhguhnpnnrl4zz1jFi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDA0OCBTYWx0ZWRfXxeT2vH1745iy
 9lnzgA4kQCS+fpwmsyInOSNYLVS0ZYS7uQWCrNmu01qYp0mSYjwPxatoti9s1t1vVw2ji9fQm/h
 igd8sblU/2UxxbfyJSpWZ58D52tm1lME7ea69/X8BiV7cXQX3tZM8SQ3V+07vgdHd8lSvfR8cft
 2mLH7S+MXCEPMCIzD1uEqZTVicdviKIb0ZFyxXWxSGji5AAGKUrYIobJoVYJbrhA6Shh1fkfjW9
 AU1gdxe343FHg0kZ0HnOfcdTC4DjQADTKAiRZJz6BUy+lYRwsdszx3atMsqyJ5geLH0pvN5Q32D
 qG+2Y3OQpehzJmysea0oJ4OjNgjtbbUEV062MkJMrVfsUgr5uO2dN7PEqcEto96Sh57ySq+gG4F
 R/YKlixkZpF/xnDJ956gWye2yEfGNg==
X-Proofpoint-GUID: f9CGNKri26S0UwUhguhnpnnrl4zz1jFi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_01,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 adultscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511060048

If there is no device available under the Root Ports, there is no point in
sending PME_Turn_Off and waiting for L2/L3 transition, it will result in a
timeout.

Hence, skip those steps if no device is available during suspend. The
resume flow remains unchanged.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 20c9333bcb1c..b6b8139e91e3 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -20,6 +20,7 @@
 #include <linux/platform_device.h>
 
 #include "../../pci.h"
+#include "../pci-host-common.h"
 #include "pcie-designware.h"
 
 static struct pci_ops dw_pcie_ops;
@@ -1129,6 +1130,9 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 	u32 val;
 	int ret;
 
+	if (!pci_root_ports_have_device(pci->pp.bridge->bus))
+		goto stop_link;
+
 	/*
 	 * If L1SS is supported, then do not put the link into L2 as some
 	 * devices such as NVMe expect low resume latency.
@@ -1162,6 +1166,7 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 	 */
 	udelay(1);
 
+stop_link:
 	dw_pcie_stop_link(pci);
 	if (pci->pp.ops->deinit)
 		pci->pp.ops->deinit(&pci->pp);
-- 
2.48.1


