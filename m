Return-Path: <linux-pci+bounces-44332-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F26ED07894
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 08:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 571A0301B311
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 07:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C442EB856;
	Fri,  9 Jan 2026 07:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oSqF8QgM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IcxRMuEb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D812EBBBC
	for <linux-pci@vger.kernel.org>; Fri,  9 Jan 2026 07:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767943294; cv=none; b=oXjtS5YLhzbosDrIuQMPTSXE64oNpYGAyFDqdoCJhEFLvJm5Y0ROj0EP4+7x8pTYCLZbsbajFNHRi+vq6EtkqxronAI0bk/ycTUSjqnYLYewhXRSMR2K7MNVmBlPQBh6EbytAoem7pLKn8OTGnNZzW8Sp/K2pCt16E4gNUXQWCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767943294; c=relaxed/simple;
	bh=vinmZfaj1r+n5Dx0UgKPAqqqJqXxuE6TZN5VPmabgjo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=em0HXF8hK+mEqcJo+hT2h3AZUo46xUqaVkJoizBCDEaqwjjQXZwmmjrE2eYyf6NBGPlJegwoR/9R4JfJoVEYvfujYgcyzjC6Cp+jB1MDg1UlIVCNNkYtIvJrXoTpKaAO8zskPJLLKX/MKIn+nbPtZt4VcHp98Vnj4r+/T9pE+pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oSqF8QgM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IcxRMuEb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 608MmYpA3214264
	for <linux-pci@vger.kernel.org>; Fri, 9 Jan 2026 07:21:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bATFQdgkSJQNtrjTPNUlAQXLkiJbzJjL5+F3AAAsVSE=; b=oSqF8QgMtNDLGz4+
	XwJrZs+Kv4Kg79Qp9FJMAvFRCHRvU6o8kDFAs3e9TuZAEzaArrSFZXzRVyfSOrOq
	7hYRlhcLNxHO4QZx5EH7zxrKBRxw/zn+GJuhvdCqwuYvrLn71GvnPcGyModHd8VI
	PtVRvg3LWAbBiR3uSUKVEWmIRKy9OMxYnLCkN9Wqi8ieunynauGtpyi4FV/Zw7kC
	WrQ5MeT4F+fsEt6rdxmJYP6lqBuppgYjdlgsR+m6YnkLZOoFW3+8OhWgwtxHz9BY
	yh1pg54w4rKINHc02bMl27pMu/0QznERgFiJFwkzAekMh3spnE4vNBzQqND9XF98
	09B7+g==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjjt0hkfb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 09 Jan 2026 07:21:24 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7b89c1ce9cfso3716518b3a.2
        for <linux-pci@vger.kernel.org>; Thu, 08 Jan 2026 23:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767943283; x=1768548083; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bATFQdgkSJQNtrjTPNUlAQXLkiJbzJjL5+F3AAAsVSE=;
        b=IcxRMuEbe/ZDPXJXMzswhRP/cqYPNCQYtlE8zsqA5GbTExA2wYPqv5vbgcmRr5BCoD
         g3zJqMG6bSh/FkwATMas7l11R8WUEwYor+YzXqVp9hukDUS+qMi72sG3jkieMUF7VeYx
         cQa9ssSu7omxAm8EfXVkhpLKuSRpIYqZForN7y+T9mG+slP2ib+vLK5SXTKRAOL6chHi
         +LHktGLSN2m1K7PZbwWF+LUgAp9kC+JvkEKmKXE34fjqv1U0faGgocKjKlIetkZ3GlL6
         Wk/9AwMWB6AlXoK7eUyGq6buWx502PhK+gAi3BDT7/oS5q8bKWu0UYu8CO2GmtnSMr4U
         hOIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767943283; x=1768548083;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bATFQdgkSJQNtrjTPNUlAQXLkiJbzJjL5+F3AAAsVSE=;
        b=bFh3/vxkHfbZc4DiHeBNwaR10BzYVJQAlAiaZA+0CJunrvMWdiw4+nul14pzrYr1HX
         9FtJ+StHMXeTbAAzSORuLwjKzcWCoOi0hzq3k1M8MJS98wQYVmkiD5kS7n/fYCzBQkYj
         w3M99U73zNeWtoD3MZD1UCmlllZgiZ8Yzx5bi9I7+BxufM/hg0pULy/yt9k+hluKiq3K
         nd9+PVmO76BqpZRcB+4AT+mrYEMNYUwgrVJFe9brDGXw0ezT8A7dBxL1c78Hg6lYbzc3
         ngbpxJfViuIxJ1ncf+uvdIJruH2asvknR6sJd4M6MX2b2TkBx+6qFplVCSnOlrnKAwHu
         BvqA==
X-Forwarded-Encrypted: i=1; AJvYcCX9QUJ2m3kj4Ha4RzxL86Ck+kcdHGN9ENNYwLWVl+teni8pktHYh1KqtYDxDt5L9Lr7KGoQ28dSn0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOKpfx4m7FnlVo6fbhBb6IswH34wTn17qvBU5HI3tnGrzYsQyK
	WbnuM/u1CuVFIMdeJ6bhm/3hx3ic+kSeZ42IkhaUVF59z1vMlx2ewTSrP2nJjlVZ0PKQB+epQIg
	NDiElrL7euVeWubZm+7xbtulpQKT3Wfm3Gf17zUQd0FowVoW/wGGneW/Iu8sZ5k8=
X-Gm-Gg: AY/fxX5iL/pzD3MM6VTyRFiRtAA/Mt6HVbL4mTycKEpM9sHH8PK6iyPhd9RkgMUVp6V
	1xwMkfBdyFHU2Y5rFpocdZdJOcfUROI5IZ28m2JMTi7l70SLAegnXDMykNCOHgw1+IzoU57n6Tw
	LxAi4pqnqOpTBrNaYXgIBt3u1d8g2YzLT7W4djUBDOYgibl7TR7Ukn9qprKgEFIP7QijgXjUGF8
	pP1a4gvH0rekkKjZjYqkklAh+K7AB0GclbqzvFe2cIcMReONaKMjCxdrQT3/weEC526afA0aRHf
	5l08hjxKjd+cncw0DzlJg/TEiBztb6k/tR2epiIi0fSVTYnqVqXQkrDM3A6G9gIM+ZXH5YoRXoJ
	VK57MvxNpk2IdOU+viL8OEW0KpwHoyNPnStf8kUVcCt15
X-Received: by 2002:a05:6a00:32cf:b0:7fb:e662:5c8 with SMTP id d2e1a72fcca58-81b7f6e3a8cmr8329189b3a.30.1767943283379;
        Thu, 08 Jan 2026 23:21:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnlV0I7WmCaNsCQSf5sgFNBK7QoW3YQzRGNWGVyGJy0Kc/9qDvIlm+MyH3UrATitJaDgV/Lg==
X-Received: by 2002:a05:6a00:32cf:b0:7fb:e662:5c8 with SMTP id d2e1a72fcca58-81b7f6e3a8cmr8329155b3a.30.1767943282856;
        Thu, 08 Jan 2026 23:21:22 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819bb4c85bfsm9510369b3a.30.2026.01.08.23.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 23:21:22 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Fri, 09 Jan 2026 12:51:07 +0530
Subject: [PATCH 2/5] PCI: dwc: Add support for retaining link during host
 init
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-link_retain-v1-2-7e6782230f4b@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767943270; l=1912;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=vinmZfaj1r+n5Dx0UgKPAqqqJqXxuE6TZN5VPmabgjo=;
 b=31EkDX2BCydzu3cUHMOBpwb+Vozz0SRCXZY35FhypsrEw2cStV6ElJ16tG5VtEjEcfOtRSzhF
 doiP34NClqoBN8WcG5MNDF8pK50+/PopXJJ4iwhUG+DWtH9V8MgRTna
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: 5d2oVWuIql3IgET2-srD6bKlURAClClH
X-Authority-Analysis: v=2.4 cv=VJzQXtPX c=1 sm=1 tr=0 ts=6960ac74 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=Py5lcOcq67Lbq8UMOfUA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: 5d2oVWuIql3IgET2-srD6bKlURAClClH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA1MCBTYWx0ZWRfX5Dpw0Q0hL+uR
 axTIMMbMQtJ+iqJv3ugLnrO4a+GoWT1eK2f2iTv19d06dH6NTL7h17ucQsMU8Oj0nzDrtW9rfH4
 BBaSHsA88ufLENO8nS04J5fZrh7QzuBWKeZwy8k2U7/FYTNBNCdkLvg8+RweMZU1PULt1Zb1zxy
 M7A3ljH5P/cnyL1O7v3Qelv4EfXYU0SxlOcbucCvLq4GM1MNRpLSI9xVVGkLZvFcuaXcXZeUQAA
 wFFxzXaXoVtM8KIDqlyLpT2EvAmPlEEvKRFc4Wtvw4UvV0H8q0IGcqQN3pWS0up8dZEmyZNf3TM
 0e7zaGfeoI1uGGAUDLG2PA5gbn+hnF3YXCPqxKo/+zIMDz+LQLW6gvI2gyAGBLg2Sz26+JhvSxr
 +fM4LjELzwYHvvRHJSvrp5WB0+iSngw1+isHJl/DL3+sXtCZwp9L7vXpAlLTf4SVwniSMDf2kC3
 y5UEywyCIvjjSgFycLQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_02,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601090050

Some platforms keep the PCIe link up across bootloader and kernel
handoff. In such cases, reinitializing the root complex is unnecessary
if the DWC glue drivers wants to retain the PCIe link.

Introduce a link_retain flag in struct dw_pcie_rp to indicate that
the link should be preserved. When this flag is set by DWC glue drivers,
skip dw_pcie_setup_rc() and only initialize MSI, avoiding redundant
configuration steps.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 11 ++++++++---
 drivers/pci/controller/dwc/pcie-designware.h      |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 372207c33a857b4c98572bb1e9b61fa0080bc871..d050df3f22e9507749a8f2fedd4c24fca43fb410 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -655,9 +655,14 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	if (ret)
 		goto err_free_msi;
 
-	ret = dw_pcie_setup_rc(pp);
-	if (ret)
-		goto err_remove_edma;
+	if (!pp->link_retain) {
+		ret = dw_pcie_setup_rc(pp);
+		if (ret)
+			goto err_remove_edma;
+	} else {
+		dw_pcie_msi_init(pp);
+	}
+
 
 	if (!dw_pcie_link_up(pci)) {
 		ret = dw_pcie_start_link(pci);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 31685951a080456b8834aab2bf79a36c78f46639..8acab751b66a06e8322e027ab55dc0ecfdcf634c 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -439,6 +439,7 @@ struct dw_pcie_rp {
 	struct pci_config_window *cfg;
 	bool			ecam_enabled;
 	bool			native_ecam;
+	bool			link_retain;
 };
 
 struct dw_pcie_ep_ops {

-- 
2.34.1


