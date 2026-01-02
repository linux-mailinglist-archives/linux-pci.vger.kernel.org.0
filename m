Return-Path: <linux-pci+bounces-43934-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 529EBCEE95B
	for <lists+linux-pci@lfdr.de>; Fri, 02 Jan 2026 13:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D8F81300160E
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jan 2026 12:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48A1312803;
	Fri,  2 Jan 2026 12:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aKjlJvH3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cM/OOk3A"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63AB313E08
	for <linux-pci@vger.kernel.org>; Fri,  2 Jan 2026 12:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767358150; cv=none; b=rCpvEzCfOc8k5pxVQQnmp9LpblHsIcvYR1NwjrcLCbhy9XZZK95t7XRRZaoJJ/JWOqIMNzLo9fyvXBC1uUpUB4uEsC1MezXTExc5b8N88mfKVPT/F/+k/WeuvyG6mecigVQ6d7EF021Mn9CDBn2QVn1BivMwuY0jSl2lbTOFfV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767358150; c=relaxed/simple;
	bh=mJwqXFaTtAuCHQy2FvWbBjeBAAII8gsU4tM0L71n+OA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mfx+Kwgdmm9inTJBE37jrTktNLmhYEZ5ZWKKh2gQ+ZH/aWnyAAIqWow9bIi67wLCylc6UEqvMRYwRo9ARQ/qfbxJpd8nO8Sd4N2o9NyoZ1ThhTDPp/iIqHBK/c4Dc+ZcM3NbPb0u94rpWCIYhRtwl7sTDDgZHTjdovvkq57BJck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aKjlJvH3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cM/OOk3A; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6029WSKI618624
	for <linux-pci@vger.kernel.org>; Fri, 2 Jan 2026 12:49:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=0wfWJirMhWJX42Yu/+htNC9US6ZKbNc21fi
	MHrEP+Vs=; b=aKjlJvH3CvMqWTQEol6Gf8rcqFc67Z9yisxLucZeHO/fmxOu4eS
	63FjNh07bHkvdi5aQniiUVELe1iQALOjRGztqLBITBzYHLrIoSbo44nF5s02vImq
	mof0LkyILVTROHF1NQgZG4ezsYOYQYdqkrb/NkW7fM5mZAA3OChgUxXwJD+WoRMF
	u25K94F/ITjGyE6LV9wHxwXH/foZabaqSy0Dtwm+CvJWAn1RI3KlUMtzWRYpfgwE
	1dJ77+VdnTBq+dq+vv48bBHB6gDnq+NYiX1oUaUNGgOEvaZdCO9a7GNG18drc8xe
	AhNkcJ+XkyQbJn1MFZ9ZnYNCIwFF/VRilGA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4beb4wrd6w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 02 Jan 2026 12:49:07 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ee0c1c57bcso478117851cf.2
        for <linux-pci@vger.kernel.org>; Fri, 02 Jan 2026 04:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767358146; x=1767962946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0wfWJirMhWJX42Yu/+htNC9US6ZKbNc21fiMHrEP+Vs=;
        b=cM/OOk3APPdyejVVTA5G7SzZbw5o5FxGQyY3A7fWGdylzmwQCtSfhxYyMB7mXOA3xW
         zRcR3y3YIODLVj79j87mMgu/+rRApkQN7GQET34sX5M/J/l15DlLkM3Uzz1OP6jidZIr
         lea0mlofJ8ETHpI3DGUjORqmzthsi6A10K7gnbgxqt8VKOIzmCCRgfX5XF8wu/DmOtSf
         tGTB+maf+FXPgGy/gylXtg+J4BZKcGvJbt+gWzugjo6KSWnzXElR6+TF9VSvsd41KxNe
         hHB81JC1y09BUJ8tKwc3SN9ZuMQZ9EX9Lj7jxb25rvflEKGe5BmPeB59giX6IzB+py4I
         7kxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767358146; x=1767962946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wfWJirMhWJX42Yu/+htNC9US6ZKbNc21fiMHrEP+Vs=;
        b=h+2IDOfRqpLJFw/ijunF5M7c5ZvhjziHXLvU72sf/6EuJ7vlqhh6RXWKsCmbvmCwZP
         1/CD8BNlR4eS1OSfunCNZI0pFs1kYE6IJ2wvy+TpE/B7iCDaoqNSfArpUJwxqzyXpziQ
         NDz4gqMhrASiK0cjIdR4ZCC49if1vUkw2iZ0jFLde19i8WQKM4C6Uwhp5w9CG0hT1K1z
         EZY5l0tRv9dBb9Og+S4pnntW7WjJWZItWusa+UJrL+gKSrVS6iCkv4M0rcFpb3h2MP5I
         UQvDr9H8AWUzP6+TUH64dzl4I2Vmbr85kGeY+oiHfj+YAXzsGxbA2AGybUNwBI60W4Pc
         rP/w==
X-Forwarded-Encrypted: i=1; AJvYcCXxE1ijhPh3AvaBrQDqolJ07Prp/E3AyHQbOhWPL1zNnx+zH6g2x0gdNkwhxlwPnoutZeJvVb74i7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE4mckHRY5MRxSaz2QJzm5ROKMQUSkxKooLbZW2pMdBhF5vZHD
	cTiv5R6sdqVGZjJwWWr+Oj+6TnlTjA2RpkHzOdPMJiBQ5giw+S/xXPM5rTAk+DWMEvA/Rt3z5tY
	UGWP4WJFKpcXS77VRI/8zskF6Hys1xqqZbHIgZYzaiT1qyTD+Z63J+lF1NrvsdDQ=
X-Gm-Gg: AY/fxX7RlHt7l+YKiLQ10s+TEWGWcpzd8LBNIhrkuYQ2/mG32vf+q0YEWXCYFLHbKRZ
	UO5PPTkL+lG5jj906JNrKqPpwH4UBQaiBLTVTPO/EAZojUXhg7xpk8BDiT2FaQNUzwH3MfX1Nui
	21PF2BgijX/wA6bsuQmig3B/nd+El0Os39obe7Y7VhJ3UG/F7Xjl2kVjc0e94oNKRnMutkayNte
	DcV70kUE3lG2qxMuGV9pV193YttVWwdW1QrzX+Lek+1gK72wyZ0rKe68Ss6QfLQJ2sVfRlEiwEL
	xeirhwQZBjc5gf4Rw8NQhAAHNH9FoqMiae1az4GmBlkldlAfp+AxWa1zBo9sc4MzORznH75NwqK
	juHve/tlQA3NkK6Ih857XlEXvdQ==
X-Received: by 2002:ac8:5781:0:b0:4f1:b7a8:679c with SMTP id d75a77b69052e-4f4abd9e68cmr649277231cf.63.1767358146576;
        Fri, 02 Jan 2026 04:49:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGEbV5vWoAdJFjT40fh9m7OPDlEL8i6bYC8PZP+0GOYhR/fbRhbEkDnsbVfPIfQHknfCM/BZA==
X-Received: by 2002:ac8:5781:0:b0:4f1:b7a8:679c with SMTP id d75a77b69052e-4f4abd9e68cmr649277031cf.63.1767358146192;
        Fri, 02 Jan 2026 04:49:06 -0800 (PST)
Received: from quoll ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa46c0sm84804526f8f.34.2026.01.02.04.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 04:49:05 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Tyrel Datwyler <tyreld@linux.ibm.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH 1/3] PCI: mvebu: Simplify with scoped for each OF child loop
Date: Fri,  2 Jan 2026 13:49:01 +0100
Message-ID: <20260102124900.64528-4-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1596; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=mJwqXFaTtAuCHQy2FvWbBjeBAAII8gsU4tM0L71n+OA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpV768w+9m0LylLR2oOecaNnHLaCLt8MzrFPJiF
 g4VrzeYvquJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaVe+vAAKCRDBN2bmhouD
 1zafEACBlmhts5g2H8mb5E53KIC6QygvGQ04AnFOSCxB87xQPYgIrS/LwAV546fMLYetfx3a24m
 WpW3wy2tC2rkhs534KHv28oHdQBjgsO1goiYibvwbVojEHKnh7JDO+iGGM0HvmJNBhu0+2bHK8a
 1gKHZDRe8wDzDEPRaHuqE60BZVzDx73LP9Qhc8bHCF5bHsJBi8b2i2TmMVvOnThOAni+qbOj880
 +AtHOgRJsRIbbNtJve/h4YpQDf3PFfEoq3X/jMRK+2h/56jrdegcT7lOxWGogvoUZNgYWabwDM7
 d5WNJ3F11NfgAiSTfcoyBWXD8CiOBCLazxnk4aaeDN9JSd/6lEF8DsCaWPsjZTm+mwHKmsBA6Kx
 5vCrwYvNscWaeAwP58XoYDgVHBJbraCb352GxNvUGd7QeiYlmQKCkcbLRYSVhFox8sKM5adN04m
 vH2Chfn7oGEW1+CSnjuCSq20LbvEPZ3mBf+kjUUhhYkH+tlMvZ/xZyubNVShVgZERmNy/WkLwhX
 JP6UmdBsauAIg41Kl0Ul2DkShHP4q3P/03t6fwkzS3NOaux+diVe8MAoZWh+cw8T3kvhRBnduyh
 OhZFLmHp5V0m+BU/DrceWt3/eEhz7/Hs2y5CB/85mKAU7ThX/MgEhFwTi8zB97667nMLA4jTtqm Otj8IS7CICNtzGA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: wOsOw6Hmu0pAC9LMXyg0RTxWV_jLzbuD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAyMDExMyBTYWx0ZWRfX017GDzF7CtsG
 5tPCoAw8TC2FikP05BGkGd0LnbxRoqheaYNe6alVF/ZzClgbo3vlbcUtpmsFkIw8a3nFpLsU4Xy
 s9Z3NX7PD4CerZnuvgt1zidhZQjcNkZb2u9aM+EstZYBHZrGYlEC4LuNG+IPHgu5ogEhPhwxu71
 PIugYKujiGVXPyizeF7mzHF4hkN31tFvZLR+5B5spLu8WqGt/k5rvoH1ASMcmPJYu5ogZO2f8Bc
 LqvVjq79Uw4GOXxQmU6l5aTx2Q1Pf/HOAtA5QbiKxpeRooOOfCmZWvgusa4qUSLOdlBd5bHrntu
 J+rExd51W2JW7He+DVxURW0aXfTk1j/fhMGLDOi8LqY9EfV+IoeGilFx7FmS/72IySAcowl7Hwt
 RON2JUg0UpFNPZ8Ou5ngNRco6o/fjea9RH8H0Kurk/ac5hLhnjvgxp0+UJw31gZFb0/XTVwx23Y
 kIMIOC++waCRBYYjOlQ==
X-Authority-Analysis: v=2.4 cv=I5pohdgg c=1 sm=1 tr=0 ts=6957bec3 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=r4sBWMy-QYfdzbUQJWcA:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: wOsOw6Hmu0pAC9LMXyg0RTxWV_jLzbuD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-02_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 impostorscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601020113

Use scoped for-each loop when iterating over device nodes to make code a
bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/pci/controller/pci-mvebu.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index a72aa57591c0..4d3c97b62fe0 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -1452,7 +1452,6 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 	struct mvebu_pcie *pcie;
 	struct pci_host_bridge *bridge;
 	struct device_node *np = dev->of_node;
-	struct device_node *child;
 	int num, i, ret;
 
 	bridge = devm_pci_alloc_host_bridge(dev, sizeof(struct mvebu_pcie));
@@ -1474,16 +1473,14 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	i = 0;
-	for_each_available_child_of_node(np, child) {
+	for_each_available_child_of_node_scoped(np, child) {
 		struct mvebu_pcie_port *port = &pcie->ports[i];
 
 		ret = mvebu_pcie_parse_port(pcie, port, child);
-		if (ret < 0) {
-			of_node_put(child);
+		if (ret < 0)
 			return ret;
-		} else if (ret == 0) {
+		else if (ret == 0)
 			continue;
-		}
 
 		port->dn = child;
 		i++;
@@ -1493,6 +1490,7 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 	for (i = 0; i < pcie->nports; i++) {
 		struct mvebu_pcie_port *port = &pcie->ports[i];
 		int irq = port->intx_irq;
+		struct device_node *child;
 
 		child = port->dn;
 		if (!child)
-- 
2.51.0


