Return-Path: <linux-pci+bounces-30392-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E04A5AE4296
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 15:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBCC5179041
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 13:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBE7253F1A;
	Mon, 23 Jun 2025 13:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="w2RcrWWT"
X-Original-To: linux-pci@vger.kernel.org
Received: from outbound.pv.icloud.com (p-west1-cluster4-host8-snip4-2.eps.apple.com [57.103.65.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57CB253B67
	for <linux-pci@vger.kernel.org>; Mon, 23 Jun 2025 13:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.65.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750684704; cv=none; b=aLnYVOKsKH1FYHPhHuVlhxMobKtr5cY1vOAH0xKuh86TEZvPIZAtFZBWXgQkBgXg2Sw8b0Mvr/BlXFViBivgM7m0manqvJecilifqezrUNWcD+xHjknTF4nmg/HibPyhLCxK5lakw3AeIbY9wcq1hYrapdc4auJQpVHjeoJP8tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750684704; c=relaxed/simple;
	bh=sYTdZMwWF90XapDPNA3is4Bwp4J9gIgqdGqN0eKZaBk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AvbN7MTVN6tgHwUA+G5q6EYs74zTOdv1dZXiRJ4GbkML1fU6YoUcFan8nwM9bu0pjbChhXGQbvdNFELdDhE4OoITy8ozQ6n3sFnyNQpetICDEV7HSDqbc6k2UEMZy04LLy4+i0ijvUr4cjohXde5MOzPI0Dat0aONs5AYhb3S5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=w2RcrWWT; arc=none smtp.client-ip=57.103.65.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id 5ABB418004C7;
	Mon, 23 Jun 2025 13:18:19 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; bh=OMbHKj8ufINmQzvBMRMgluViwzlNQzc54nokzS3b81s=; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme; b=w2RcrWWTQ9pvCVagNE/QgnUEXOC3jExLaV/UPkVolEoLH0SDeh0KemU8iH2yg50tFW2Dfz5BKk3qcaDC1TeIhm+4UXl7mLZlWnmGx5MKx9on7EqzuHPf5Ncy5I8scnD9eN5CC1bKOpcSpthrsf+7jivgtzwkHUG/EOgsbCkkWDCy08ra6/ri0xfV2JBRPWYQaHQNiQ2rEKMYWlSDmENKoKwhiYPam/cdqnsvBAPSp4pWCBYJAZ8vqmVor/9XIot+4nI8OeYnb6uW68gm0BS/0kAR/3FJqkFQhI2wsox9TcU8ZmeDVvnM1mbtsCPpo38AMq+erOuoElKj2XH2P3OWcQ==
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id 8239F1800262;
	Mon, 23 Jun 2025 13:18:16 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Mon, 23 Jun 2025 21:17:38 +0800
Subject: [PATCH v2 1/2] PCI: of: Fix OF device node refcount leakage in API
 of_irq_parse_and_map_pci()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-fix_of_pci-v2-1-5bbb65190d47@oss.qualcomm.com>
References: <20250623-fix_of_pci-v2-0-5bbb65190d47@oss.qualcomm.com>
In-Reply-To: <20250623-fix_of_pci-v2-0-5bbb65190d47@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, 
 Lizhi Hou <lizhi.hou@amd.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Zijun Hu <zijun_hu@icloud.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, 
 Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: 2U4nMRVy2HnglEpCHjNt-Xp9W2kywZ8d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA4MCBTYWx0ZWRfX6fdgROnvHIXM
 coTd0/Peakp/CPaoYfduTCANyXV34TnUbsP+jYXjXFiWfgTPVLP1W/ahd+ur56JAGjDhQi4XrRJ
 i1tZke32pO5jLOCgDr/nW5owGmjbMzb2TwLH/uAywhMiD5vTKRfSJQjtMpkzNJ0k5fFR3YnYK0Y
 0hcYA1vEbILKu45ZVV/b7hS0HO9OKyLM1akceFBXEkbtzb8I+0maPY/6NkJ0jr9y6IzHiaS0P+f
 P61Qk+odg5eMb7J34tc2CYMNU2B3vPS4Ytd77iMjIV8O3YXXm1seGqF2+QVhqVtshE5pDb8Io=
X-Proofpoint-GUID: 2U4nMRVy2HnglEpCHjNt-Xp9W2kywZ8d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_03,2025-06-23_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506060001 definitions=main-2506230080

From: Zijun Hu <zijun.hu@oss.qualcomm.com>

Successful of_irq_parse_pci() invocation will increase refcount of
OF device node @oirq.np, but API of_irq_parse_and_map_pci() does not
decrease the refcount before return, so cause @oirq.np refcount leakage.

Fix by using OF __free() to decrease the refcount.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
Cc: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/pci/of.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 3579265f119845637e163d9051437c89662762f8..fd6596b251246c3b64b2558c67652d01f142c785 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -576,6 +576,7 @@ static int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *
  */
 int of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin)
 {
+	struct device_node *np __free(device_node) = NULL;
 	struct of_phandle_args oirq;
 	int ret;
 
@@ -583,6 +584,7 @@ int of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin)
 	if (ret)
 		return 0; /* Proper return code 0 == NO_IRQ */
 
+	np = oirq.np;
 	return irq_create_of_mapping(&oirq);
 }
 EXPORT_SYMBOL_GPL(of_irq_parse_and_map_pci);

-- 
2.34.1


