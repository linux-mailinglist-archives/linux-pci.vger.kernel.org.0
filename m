Return-Path: <linux-pci+bounces-30393-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 470CBAE428A
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 15:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38C19188D66B
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 13:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB0B2550C2;
	Mon, 23 Jun 2025 13:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="W0o6O/ey"
X-Original-To: linux-pci@vger.kernel.org
Received: from outbound.pv.icloud.com (p-west1-cluster4-host2-snip4-4.eps.apple.com [57.103.65.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C40254B19
	for <linux-pci@vger.kernel.org>; Mon, 23 Jun 2025 13:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.65.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750684706; cv=none; b=EA+pUkYg8DTgWLoI1QYXfSDlxpRR+NxNAxdfEqpsQ6d7j/VC5eVB4v0jW0UgYOhy3uJgiZGATm3t/McIv98ZZ8nM/XfunZZ4lx+tYiqJNPzG1FZ9ScUUB32n/zNLbD/jicmwyD+9GYqF4svlyniTsMLbM2Gz+jc54497jhBqp1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750684706; c=relaxed/simple;
	bh=6uy0LFYrWg7xHF33/zV+z/ktLd3QRfymC2Ad3yoEg8w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EdHX8azH2dG9deB9Qnm4Cm6dYfcBw58erZF/h429URzeMwMJZaKfmztHgaV1oviPK8mbIH9QB43KOvwWVknKgTIHTimDcC4o6vzXWNxgBXsobiP0RXwQmLi9u6vz4Vr9rnDQ0jmafQQvmP9yGrwQLT1j+WoBaYro+O3qgxHxpxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=W0o6O/ey; arc=none smtp.client-ip=57.103.65.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id 66EBA1800262;
	Mon, 23 Jun 2025 13:18:22 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; bh=kFGiyhJP9jhxrKXxczAwa5t3gkxlw1rtSDudPa7j8BY=; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme; b=W0o6O/eyil0flsQgBkQtR4Tj1efmrJj+DQ94v0LaWLeJxXLXGCLntRHkoR1EiwzYK36/FnLuxNABbqt7Zo+YSLs4MoV1EmSzKQe83cteP265sLg+c9RKoAwAW/+Ktw7no+C39aWJb4pfH6YYF2Ss6qBgdvT0OwXkjDREeD6THyVAKhSBr3/iL1oi93b8ZJRPOuHnbo17ulJLi10771drVvC71qrfBI1nGw1ee/sYUtF73LV61Ah4SQObKSJ2DXU1aLV+eUqV9JPSNrbxCj5rnrU/uGcFqITiGBvevoQ4l5fjNI35OeIxGi32y+FuleyfTpPusEXZbeOeMc83ezbGpQ==
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id E1D1418001FF;
	Mon, 23 Jun 2025 13:18:18 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Mon, 23 Jun 2025 21:17:39 +0800
Subject: [PATCH v2 2/2] PCI: of: Fix OF device node refcount leakages in
 of_pci_prop_intr_map()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-fix_of_pci-v2-2-5bbb65190d47@oss.qualcomm.com>
References: <20250623-fix_of_pci-v2-0-5bbb65190d47@oss.qualcomm.com>
In-Reply-To: <20250623-fix_of_pci-v2-0-5bbb65190d47@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, 
 Lizhi Hou <lizhi.hou@amd.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Zijun Hu <zijun_hu@icloud.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, 
 Zijun Hu <zijun.hu@oss.qualcomm.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA4MCBTYWx0ZWRfX5IyL5d3hacHV
 JmvSNsdIJqbBln/AfO+vK5mmc9jPjy7xcfhgJj9uM8wsrTxgGd/j0OBXs7L7iKXXI6vFLAwwymB
 ibPaduNYnLtyzUuEfquOEAUIoqYXchEIbZF+hSwEUFHsEFrE1MeIOG7gjxPKUxUfbFIbdIj2qQg
 nfZ2yjADXoPpQJ1haLl+i0prQreinVKRug7olf9TzneQNV1ZKZrvGTlWQdOWL+CdRJkPEd5gzl5
 Se+NLwMWXI22fg2EuWnU2LTMTXAPolVECbHmuKAadik0bux1BIXyvqEkL6uRWUGh5AZ+uarpQ=
X-Proofpoint-GUID: 9hyoxXXMA-oA7DkAHi2A2t-wJ08qcvp3
X-Proofpoint-ORIG-GUID: 9hyoxXXMA-oA7DkAHi2A2t-wJ08qcvp3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_03,2025-06-23_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 clxscore=1015 adultscore=0 mlxscore=0 malwarescore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506060001 definitions=main-2506230080

From: Zijun Hu <zijun.hu@oss.qualcomm.com>

Successful of_irq_parse_raw() invocation will increase refcount
of OF device node @out_irq[].np, but of_pci_prop_intr_map() does
not decrease the refcount before return, so cause @out_irq[].np
refcount leakages.

Fix by putting @out_irq[].np refcount before return.

Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
Cc: Rob Herring (Arm) <robh@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
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


