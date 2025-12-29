Return-Path: <linux-pci+bounces-43789-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE78ECE665E
	for <lists+linux-pci@lfdr.de>; Mon, 29 Dec 2025 11:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 455833016196
	for <lists+linux-pci@lfdr.de>; Mon, 29 Dec 2025 10:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A58B2F3C3A;
	Mon, 29 Dec 2025 10:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LZebAHCs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TdNzUBG5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EAC2F363C
	for <linux-pci@vger.kernel.org>; Mon, 29 Dec 2025 10:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767004974; cv=none; b=DH6rKazRld9yugRmWh++q4/IH0nJPQutadxXqfnmvvudT4STm1+ayA7GBLifA6y9vITOPe8zD0Y5PU7K8FmCfSjZxnxMQjvRXOO+UvqQ5HLTPLeX/VCDKnxNHjtKZQj6Km2Udkojk1/hqvAoMf6SRIBoBfIYfx3kqyWA4Uof+WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767004974; c=relaxed/simple;
	bh=PwDxGVqlPCalaJqsrWiJVP8Bkv6pzkcROQ1PZGyP8Eo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f0keU2KF++EKadYqIsrBDxPXnnfv7v8IIujIwB7/WM5XSAeGsny9/w4tjRpPVi6nHmJbvV1tPazV5MKzjyks9sl++FM5EKhR5uH/wMNzWqmm7nk9vywDKnVUG5D0d+ci8FjYpEzqxJ++uhhle5IsevsFrWxJqzEYGSE8JyAPFbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LZebAHCs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TdNzUBG5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BT9ZhCt2995712
	for <linux-pci@vger.kernel.org>; Mon, 29 Dec 2025 10:42:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HwdN1Hzsrc+ug6247grY+gZgtiGh816xfGCrunPfDc0=; b=LZebAHCsgQRJVWfr
	I+cljWa40/K1txRjB2F1ibvInYbxq983UDVddqPM9k1UAbOTBLXFAvHfnQS89F1P
	A6TUtBe/iIVTMEYbJedF43k2PqAJFTJm3F801Z16QeOVgTPp/ldrKxY/k+4QqG5f
	/mGgvvtW+CZH+iAfdQba0dhsy9fIYkOMlJ6bNZdts1ZATXvqNHwE3d0d+lT/lr/f
	LTmgzT6fF5aQlN8yLk8ihkOiOcpQw2tbs3an11Sj0pxSvm8oDmJh7BdRjnnOO5zT
	pRmeq6t/YNpKpqCZ0F9c/eibTCt1SS6piO9veETgBVu+iVuQ8ea5kn9v4HLEaAi3
	mjURzQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ba8r6c1kq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 29 Dec 2025 10:42:52 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a0f4822f77so251805425ad.2
        for <linux-pci@vger.kernel.org>; Mon, 29 Dec 2025 02:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767004972; x=1767609772; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HwdN1Hzsrc+ug6247grY+gZgtiGh816xfGCrunPfDc0=;
        b=TdNzUBG5s0GxYOLMRvj2EcBO0KMyGDDLT5xuqoWXRVquqhQp1O1fZ5kHFo1qJgTvWT
         5GMZiMyb0IhmNmSWSrzwNAhv40/S5LIpyU8wYw54f8RnZ8bIUqIS63nZR81j5rYIsj+t
         7v26Zs6jEKU6RT5P5zdJIfEvNH++Mrx/yXb8DIHxw7A3wbY0riCnAkqIEosIYRe7dSZc
         ikU1osePVjNKF1iFEnGR7IRH0KS1t776xZ9NDRwgg1E2z9MmSebKGGuG5ZcEX7y86LKZ
         iq68GtQkWliwBGRXd0LT1QBlL6IcsDJ0P16Ayxif+wGvZchxvW1dsEY+D20BnZCCTZAA
         vOlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767004972; x=1767609772;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HwdN1Hzsrc+ug6247grY+gZgtiGh816xfGCrunPfDc0=;
        b=afUfuvojFSBL5OhOD3+0F284EeVLCfcR2A+gZ3HY1xh1JENdkxRXOkb6r22MlsV47k
         pRop+5JVT0koXzimmpIrblyUBhyMDFLjEHkIZKaYsnAkued38/EHPXzqHdmoKdBe90pk
         XJ53adsRPyQ2XRsYtIyLqB+cDcpl64IjkfT68Z7ohTvRhMn9GoZJjpcJ5G40+8XIbg5k
         J5VwK730GFtlCaz8gIDmSVJADHyNxt+tWL4kyW/XDaNdcdY6vROVyAiLg8yiTo2B2UXA
         VK7sdPHi9uz7GNCxYHMEcyfvjEWEXQLtTa6mc8UEZ+dXWGmOyR5WGPY24DWd5XZLmssX
         I1mA==
X-Gm-Message-State: AOJu0Yzb79kL8jtLljxaRJvtkVzWds+pSVgrnMbafmg+mkOjbY/T83lT
	YwHltpdngO4W1kJBIiybOcJdcPt0U4LMrjY6hyUkAsLoW0GXj+6zOyzvyAOTyLsmuTlegnfbpQd
	SKb6vjR1lGEpb5KJ2BnzclOkHuh4EvAYKX5UhiSD58H6UDBz/+TEjnwohe0Y1jRo=
X-Gm-Gg: AY/fxX4Mc6aFoESKMLiDkIfMWD9jLIU5bNSXB1v4bT0OhL+8KEKO2jYD/LjVljQusIB
	rEblYWzgdjtWp1zkbqFIugO0B4kF/gwvu85s2P6i+EDPT5jHCly+fZ/icSKqajlCROTN4tpWNGy
	zVNp6m9fQ9qOH43A6P1bQDdhM07TuOxkj94mYomENVuzNO+GABs7R/9aECUW2/Sf20E1K/V0Cd1
	SwxPR9pp3YIhnKJfHa9XWTyASwj2F1UxyYmOJMna5ZA52hcc/0RyoaCdZJyhkwM75nNb6bfZPbv
	JOCgP6+fTMMdW5S1RqjPFnZlsn1BcDfAJyiRnVSjTE+Mc6UaqmZ++FO6dJGJCfFjS/vAAMRbPDu
	5IJ3EHFC9PTfpmPh+Lt+qf1Bj3d3ETiKK0LKKXM/qU2qN
X-Received: by 2002:a17:903:228b:b0:24e:3cf2:2453 with SMTP id d9443c01a7336-2a2f2c56453mr290588515ad.61.1767004971743;
        Mon, 29 Dec 2025 02:42:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEioKFGNJBNeeqVZgzXmhPFsUS0ACvTBBn1SY4kNRpxoJLiA7uLug0gT1p3bVGZUFUTysadJA==
X-Received: by 2002:a17:903:228b:b0:24e:3cf2:2453 with SMTP id d9443c01a7336-2a2f2c56453mr290588295ad.61.1767004971298;
        Mon, 29 Dec 2025 02:42:51 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d4cbb7sm273412365ad.59.2025.12.29.02.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 02:42:50 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 29 Dec 2025 16:12:41 +0530
Subject: [PATCH v2 1/3] PCI: dwc: Fix skipped index 0 in outbound ATU setup
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251229-ecam_io_fix-v2-1-41a0e56a6faa@oss.qualcomm.com>
References: <20251229-ecam_io_fix-v2-0-41a0e56a6faa@oss.qualcomm.com>
In-Reply-To: <20251229-ecam_io_fix-v2-0-41a0e56a6faa@oss.qualcomm.com>
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, macro@orcam.me.uk,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767004963; l=1914;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=PwDxGVqlPCalaJqsrWiJVP8Bkv6pzkcROQ1PZGyP8Eo=;
 b=6/isTRmSRgxo+TugjzFqCVCXMPDX9AlprjcXjqTnJ4b5O/wACitsNUSm8zo/yTf6VtJbzGdx1
 liJTqd4KMTKAvLR9DeUsgYhTVFsSOAw7YH9bmWMumneoELk0d/+bsEK
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=Raidyltv c=1 sm=1 tr=0 ts=69525b2c cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=5cqX_iqSVL2xjhDF-JMA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: vdAKJ5bCB1yXVY5F1ZZ-msrvNfHlWGLc
X-Proofpoint-GUID: vdAKJ5bCB1yXVY5F1ZZ-msrvNfHlWGLc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDA5OSBTYWx0ZWRfX+GVTKThK3O3Q
 X7rYrkkU56XvhJCM7fhmQTBlzHgZWIMZQRLW5iBkfRYB7IaKg93svO3E3f2PPalnYkPyRN2D1QN
 ZmIAYnNuLhWZviqn29CNVU5EWZiHccJJSY7ftj81wfly9js+2Ffx46hPUhwJMUDpKDcvcZNM9SP
 spi/q2ConpJ7unNrXfCMrZyI5xVw+Viy0J5FivaWNwfCuYOx96HD8Vza54roa+WQ4da9mU+wOea
 VCxnWU4kNk1SoFpypCwH1g8PSPcx0QplBWCDfBs1D6S6mL/9i5dMipEUKY7vAjc6dAO16p551vX
 9cmQOd9mHp/cqkReYxhxEhPaP98ZLqmuINQRozhOzBPnlwj4+gu/m4YUeWMSow0ZWdvYJYx8mtl
 4K83At6O6fes8rQjEVNnbxt20YX4AxO7D0kZWghtd6DwGx4QHMzp/RXHZGkouq/qZwnRlX3Jf4M
 XoDyTi/bH/jiDSGeSig==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_03,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512290099

In dw_pcie_iatu_setup(), the outbound ATU loop uses a pre-increment
on the index and starts programming from 1, effectively skipping
index 0. This results in the first outbound window never being
configured.

Update the logic to start from index 0 and use post-increment (i++)
when assigning atu.index.

Fixes: ce06bf570390f ("PCI: dwc: Check iATU in/outbound range setup status")
Cc: stable@vger.kernel.org
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Note:- The fix tag shown above is for applying this patch cleanly,
further below versions we need to manually apply them, If any one
intrested to apply this fix then we can submit another patch based on
that kernel version.
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index e92513c5bda51bde3a7157033ddbd73afa370d78..32a26458ed8f1696fe2fdcf9df6b795c4c761f1f 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -896,10 +896,10 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 		if (resource_type(entry->res) != IORESOURCE_MEM)
 			continue;
 
-		if (pci->num_ob_windows <= ++i)
+		if (pci->num_ob_windows < i)
 			break;
 
-		atu.index = i;
+		atu.index = i++;
 		atu.type = PCIE_ATU_TYPE_MEM;
 		atu.parent_bus_addr = entry->res->start - pci->parent_bus_offset;
 		atu.pci_addr = entry->res->start - entry->offset;
@@ -920,7 +920,7 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 	}
 
 	if (pp->io_size) {
-		if (pci->num_ob_windows > ++i) {
+		if (pci->num_ob_windows > i) {
 			atu.index = i;
 			atu.type = PCIE_ATU_TYPE_IO;
 			atu.parent_bus_addr = pp->io_base - pci->parent_bus_offset;

-- 
2.34.1


