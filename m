Return-Path: <linux-pci+bounces-41669-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 409B6C70950
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 19:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 5728929122
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 18:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2187B2FD67E;
	Wed, 19 Nov 2025 18:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZNdcde/H";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FmBt7nJr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03CE3128C4
	for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 18:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763575830; cv=none; b=EKqe5Ib/zRsIAB+Z81vd1+uGb7OpnQ1GK/sikZ6qIxP2tCWBxQXyNt370Z0PsQpOFz3+PrErqQFYtggNwPaafHBt3jW3WRgXcb6TD4mR717DwXU0DQDoXDmkK6rZB78GO71Hhctu0/9mNrGBUssHLiENHIIYMWBG5A+yl/xX5R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763575830; c=relaxed/simple;
	bh=aB8AQU5T79GE8yEjbX3yEliqZgfm3QNVjb6a8THRBX4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JoLqNfOzeyWbq/Zp/YDHAvrsDP7NFcuXy5OIWR9yXUfSTOInCnDx5qA0s7YJXSQiavbAlCZxFZ6A8GwRge+SWCVA/uZIwRkCdwue8B+6V1sRrVcR2h16X6il8zM2sZHSBIRlEIi3y/E1Pjk5J3c2l6ihg4AzvMJrx5Zt1TZ96H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZNdcde/H; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FmBt7nJr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AJFkSt22061106
	for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 18:10:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M13z2nhJ5XNNt8OBEkRgQFiRfSl+F/tnKBCTf6qisp4=; b=ZNdcde/Hv4gTLz0i
	qagLhtLdd8qfSoQA9bdy3IT1DNzeNom0L6tzmK3uVTUOqz7Layo1L8GUa+C3+887
	95IwVoRFqaF+7CkN48W3m++4O77PPGk13WHKmcv2DpDS/S3jCTEtiZRnukxtQtMm
	o55GtzE/N0HeBacYmy77nrzkxdxqQ58NRWVaT26lo0ixlKObJZheKQ6c6yglyfEv
	oFDNkmbSHpSkYh0GnMAvnDJ289yxGtRaJEuNxHf9oXKY5IdRLPX2UvbwxO1yv05T
	jtQF14G+ivgPDPtftN6q8ewpqFfPcpj7VKgGfww1TgM7If2nEYQMo7VfD5NWK/jw
	HcMLcw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ah9fu9ym5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 18:10:23 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-297f48e81b8so163195ad.0
        for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 10:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763575823; x=1764180623; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M13z2nhJ5XNNt8OBEkRgQFiRfSl+F/tnKBCTf6qisp4=;
        b=FmBt7nJrAyrpxmpjHVTozMqJPiB+DJBY8RKEWjcI7gC/FrcHr0w3/xAUnBSe6Q80an
         JtawBYwTZ2XO2pkI7jvlJcv2XH2dO3rYfh+Y0Bup0TgWi7jVeI+ermTSU9SRaSmkCuhL
         zbke4HnqklVOgPzftx1Yd4lxNcHCzTZYoiqHZB4RlMANXx2I/rS3jmuoIz5C/3pV2Z7O
         Yazi4SnZpkIBUxc1u2SfrDHhcf4zCvOvNc8gmpDoBEk2QRmfeD+RgFl0wVBp2xNsodWw
         hEuYxA6MnYEYPIs25v88UQZx/F/RqB/BfR/e5LLMnTqp7E8JNhhVsZD3820sHFrDaw0L
         emxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763575823; x=1764180623;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M13z2nhJ5XNNt8OBEkRgQFiRfSl+F/tnKBCTf6qisp4=;
        b=w3R5itPjwR2Z88BXJ+CExUs0+GjZnZXUXr31wTU9+RnKgpVheGzJ2bF/oS2kfMBn4X
         96uKdsdOKkrycilaTqF0mvR4S4OcWouLHhD7IRxogcvx58V2gBbXXFdQJhe//X0hUdVU
         d3qowtHcdXJ2TxoPWA6g/RuZiN8Ah/hkrl2Ubbz4sRnznGQsrmn6cE83Z2fLEFW8VpwU
         scHovC26Xga+irKcRStsnTr0uhcPI4Saf5k/QA65Ip/6SNixCwO5Ih5rSH4f7oGVoFGH
         TwCfWN+C6o9odRLRTuZcEpUCQdWzgh/HtdUj39x+LhSR5BBdFmvAnOUjMK5zOzCPREow
         gVWg==
X-Gm-Message-State: AOJu0Yw9LTDdmBAaUO7VvICnXH34EP7JWoUGfFwGIdn7QbMuNZ9yPPRK
	HWL4qWy+VCs3fEw0QmHAOZruKgbJW83GUS8Zx9hdSjtOrbITrYTJCEYXMXFZootC5DXAQE+at+T
	ovtWbXM1UJmshnCS0YmuyChv9HFQMce6p1llufbh8pw3HovWxUEbppOpScKTeXIw=
X-Gm-Gg: ASbGncvftxQw4SZs3glvOfcw8FGqz2b/nll5l5b1cKpUs9MlBPKK5AoCkXOvbrgZW3y
	Hg2nIXhEV2EQ6jJBtSZSAiELttrs76Zgml5m/9ywmi6qq5uVQz9ciThJbgCfGrdYJ0qH/XF/I5z
	QioGo0GBJFZBnDcCQtyCmIK+21GZggIVpbNkwJD9pq7EMO45WqPtJ1a/NWj8KhYNHzzmR3pCA3D
	mri2QHFG3rHgMly6d5sJcDd0W24MYXrkEBfDQcZHRkn8P05BDKtsN7vXJGaEn8sEGvMp6p/7sGD
	DygpVT26DjVqvRfKk7K1wI0JUy6zoEBzrL9bGwBVaFxbpv6fQTQN91KAVbG3/T4OOZ8W8nlspVC
	XrviT4BmxIB/npSvXNS1UTd87K7Txzfsh0EC/MCY=
X-Received: by 2002:a17:903:1a90:b0:269:b2e5:900d with SMTP id d9443c01a7336-29b5c0b3ca9mr918595ad.5.1763575822645;
        Wed, 19 Nov 2025 10:10:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7ZN9s2BxP3STc5lsVm3YHhRFutnEWOCIP3ZR8jYDADQVNljE4X6IilASjwkOZu5k9soId1g==
X-Received: by 2002:a17:903:1a90:b0:269:b2e5:900d with SMTP id d9443c01a7336-29b5c0b3ca9mr918165ad.5.1763575822195;
        Wed, 19 Nov 2025 10:10:22 -0800 (PST)
Received: from [192.168.1.102] ([120.56.197.63])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b111016sm1408865ad.6.2025.11.19.10.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 10:10:21 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Date: Wed, 19 Nov 2025 23:40:07 +0530
Subject: [PATCH 1/2] PCI: dwc: Skip PME_Turn_Off broadcast and L2/L3
 transition during suspend if link is not up
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-pci-dwc-suspend-rework-v1-1-aad104828562@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1100;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=aB8AQU5T79GE8yEjbX3yEliqZgfm3QNVjb6a8THRBX4=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpHggDw7uT50wCuHAJeUJpbSYo00637n44xxTrW
 qCCA3gYjZmJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaR4IAwAKCRBVnxHm/pHO
 9RIyB/0eWUbFMn4mUD4N851/q3ujQ8LdgHgJhkb49RcDa2GLr4w653BIi2hEXIQGwCEMKclTn92
 8T0/OwibDSct5/qwZeTuqU9WIJeK2B+NuTfCkkkSSROuvPVKlBTYR8aC/HmtQG6skiDZ+PPAhhQ
 UgpE9lQNP+gYCgSqhUR/BZeuXnW1YP64KEJKRM27siyKpcn/1gjfrvnRoXaFrhrbDksaeN/jCq7
 CUxd0i58XbOTyrTerOyFdplxX7yOrA9U0u5qtPa+IRDG0yk3fYANuUAoComfRgekR9i3Q75jChY
 LK1//zeGVzzga6lsXC1leSORSqGvFnlfHBhMwE1/Lc7ax6bb
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE5MDE0NCBTYWx0ZWRfX56mZcz52cYgt
 Yd+Hm2Y5bqYECK/fDjiGTEU9Ogsx48pdveDZpHGsqzGcfPZGR+V5br5ydmEORCUVV91xaWZKtx4
 XITmAZgob3SnmGTnOc2Xw5zmZO0up06KdjBdPF1Jav3qezLThOBY6h3PC93LbO0u/oWe4jiJyte
 XqpONW8zbToSmL+wXFfz+lBMyd5olqJxvqaBcOBpQgCmHV+b2/8ytbO3xTJbxt+jzTXf7Ok/a3C
 DtoVB/2UGrYAnUz8oQGNHBIa9e5UN6zB34TkHyWdEwsSIO9TRpToGRYoIzRZHiOfJg23vKZgvRy
 ThQ0eJ4pYIfnvj8AjZ1CxBWb3/jo8iA1zquf2ajRg==
X-Authority-Analysis: v=2.4 cv=KZTfcAYD c=1 sm=1 tr=0 ts=691e080f cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=xeX0Tm50+WxWVv+NCdhSGA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=aqWwvIXvDE_FxjdaEBsA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: AJM2ltDeS4DTpTsgSJDvfDZDyo807fJB
X-Proofpoint-GUID: AJM2ltDeS4DTpTsgSJDvfDZDyo807fJB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_05,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 malwarescore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511190144

During system suspend, if the PCIe link is not up, then there is no need
to broadcast PME_Turn_Off message and wait for L2/L3 transition. So skip
them.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 20c9333bcb1c..8fe3454f3b13 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -1129,6 +1129,9 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 	u32 val;
 	int ret;
 
+	if (!dw_pcie_link_up(pci))
+		goto stop_link;
+
 	/*
 	 * If L1SS is supported, then do not put the link into L2 as some
 	 * devices such as NVMe expect low resume latency.
@@ -1162,6 +1165,7 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 	 */
 	udelay(1);
 
+stop_link:
 	dw_pcie_stop_link(pci);
 	if (pci->pp.ops->deinit)
 		pci->pp.ops->deinit(&pci->pp);

-- 
2.48.1


