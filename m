Return-Path: <linux-pci+bounces-25378-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB753A7E13B
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 16:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA7723B138A
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 14:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E881DD0E1;
	Mon,  7 Apr 2025 14:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="xr+G2O+1"
X-Original-To: linux-pci@vger.kernel.org
Received: from pv50p00im-zteg10011401.me.com (pv50p00im-zteg10011401.me.com [17.58.6.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611AD1D5ADB
	for <linux-pci@vger.kernel.org>; Mon,  7 Apr 2025 14:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744035329; cv=none; b=eZOARgl1YrTwnwIXElc60QMDkz9nmOm7+8mXe5vqpqQGB9Y7GFC0J32mqJ6b0vZLSLZ4hUfjoixSuY1ds9sNgYGnlEgHhAYUosTuSynTFqifdt21W+Evr5ey04UZapzIVxER1WIPUl3Uk6UrrHSoCKZZmXX+B78ZlQVBR4ovWVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744035329; c=relaxed/simple;
	bh=k/NhqmXqMjAs3F5HQX7dTOQOiXyVG5PqWH6nYgei5uk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RsP8GEgkjwAxYqVEudKbI1RMlsgZjdiApzHXXqwYcj2qAlPTj6YciIut6qAt5/wUSrntSA2XQeAtVQ8Hl4hkM/tReJX6PlqWX12iAtDFMI0GSrzkE8bWtypsBh3dH/+/wiUf8cqjWoJC3ptCjgc4oX6BUJhNiW+PNfwP/8+11Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=xr+G2O+1; arc=none smtp.client-ip=17.58.6.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=7T26VJuyJwbsZaiErydUQg8Z7WGtRiOyU46qoCQwJq0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=xr+G2O+1OkvFDakPR8RugdYj0JoTfu3Q4LA9OcPtv8bX2/sti1M3/hvRS5ptBh5sK
	 5BTSDXx0JLKu1pEnVLv0VbhnXT8dCsl/qvnh6PdfbptrixH7PoH+seHgLFFGhqSf9+
	 7r49DjiNoqIy1RymUfcRKBv5xjCOU8HBRb6CttQycbr5/wKq3SsF07HcakFbbe6sUc
	 FgvYvHzgGgjjtTvf8/24vV3U70M9RrDGaybbNWHng/WRgZl6z9gFz3JAB3UHOtuuR6
	 b21UvmJVIaMZjlIJEHQ3GiXge73LMzYWXNiwyyB3Gc9BuYv/JWGFQY40GQDHFp8GSa
	 M78//f6w9sCQA==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011401.me.com (Postfix) with ESMTPSA id A125534BAA93;
	Mon,  7 Apr 2025 14:15:23 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Mon, 07 Apr 2025 22:14:57 +0800
Subject: [PATCH 2/2] PCI: of: Fix OF device node refcount leakages in
 of_pci_prop_intr_map()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-fix_of_pci-v1-2-a14d981fd148@quicinc.com>
References: <20250407-fix_of_pci-v1-0-a14d981fd148@quicinc.com>
In-Reply-To: <20250407-fix_of_pci-v1-0-a14d981fd148@quicinc.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, 
 Lizhi Hou <lizhi.hou@amd.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: scVNjPYyeNyxt7kvVJyThEgLIdHRpPJp
X-Proofpoint-ORIG-GUID: scVNjPYyeNyxt7kvVJyThEgLIdHRpPJp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_04,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 mlxlogscore=853 clxscore=1015 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2504070100
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Successful of_irq_parse_raw() invocation will increase refcount
of OF device node @out_irq[].np, but of_pci_prop_intr_map() does
not decrease the refcount before return, so cause @out_irq[].np
refcount leakages.

Fix by putting @out_irq[].np refcount before return.

Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
Cc: Rob Herring (Arm) <robh@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/pci/of_property.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
index 506fcd5071139e0c11130f4c36f5082ed9789efb..4250a78fafbec4c29af124d7ba5ece7b0b785fb3 100644
--- a/drivers/pci/of_property.c
+++ b/drivers/pci/of_property.c
@@ -258,12 +258,16 @@ static int of_pci_prop_intr_map(struct pci_dev *pdev, struct of_changeset *ocs,
 	 * Parsing interrupt failed for all pins. In this case, it does not
 	 * need to generate interrupt-map property.
 	 */
-	if (!map_sz)
-		return 0;
+	if (!map_sz) {
+		ret = 0;
+		goto out_put_nodes;
+	}
 
 	int_map = kcalloc(map_sz, sizeof(u32), GFP_KERNEL);
-	if (!int_map)
-		return -ENOMEM;
+	if (!int_map) {
+		ret = -ENOMEM;
+		goto out_put_nodes;
+	}
 	mapp = int_map;
 
 	list_for_each_entry(child, &pdev->subordinate->devices, bus_list) {
@@ -305,14 +309,12 @@ static int of_pci_prop_intr_map(struct pci_dev *pdev, struct of_changeset *ocs,
 	ret = of_changeset_add_prop_u32_array(ocs, np, "interrupt-map-mask",
 					      int_map_mask,
 					      ARRAY_SIZE(int_map_mask));
-	if (ret)
-		goto failed;
-
-	kfree(int_map);
-	return 0;
 
 failed:
 	kfree(int_map);
+out_put_nodes:
+	for (i = 0; i < OF_PCI_MAX_INT_PIN; i++)
+		of_node_put(out_irq[i].np);
 	return ret;
 }
 

-- 
2.34.1


