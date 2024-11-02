Return-Path: <linux-pci+bounces-15839-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 989249B9FF6
	for <lists+linux-pci@lfdr.de>; Sat,  2 Nov 2024 13:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE6841C20BC1
	for <lists+linux-pci@lfdr.de>; Sat,  2 Nov 2024 12:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD370189F33;
	Sat,  2 Nov 2024 12:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="rgtIwXIw"
X-Original-To: linux-pci@vger.kernel.org
Received: from pv50p00im-ztdg10021801.me.com (pv50p00im-ztdg10021801.me.com [17.58.6.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861C4189B97
	for <linux-pci@vger.kernel.org>; Sat,  2 Nov 2024 12:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730550055; cv=none; b=hD0A/PruwO5ovMI0Bu8eHMfJs7WawIIgSvH1vJQF9X/j/sBipWWq3A2VW0UnoNW5ZR2VewIn88NYzAsXie+4jNwJqrWUt9+7wyLblB/iYOhtVlOLqwKCvfadmj6CWkbJtV6hXo0rCLYOsuz4LvYrIIyY28PvSoR3ZkM0SSGG784=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730550055; c=relaxed/simple;
	bh=H0Anh4HFrQRjO1mxOMTyGJ4FThPLY7gCjAHbPZsENrA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K+KB+HQ7yEa7VSLI56UdqBQfeBmVVaqIhZlrbdBN0FgAJi3YwYchdV9/fi09qATLo1N7WE90DIERt/2j1GxkwkjHBPsU2aAU96112oExSZd1TSRCJtkzrnbVTGOZ25p8yNrQH9Ko4J5I1uO5qDRiKSC4yId7M40C5/TEFp+hDww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=rgtIwXIw; arc=none smtp.client-ip=17.58.6.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1730550054;
	bh=oG+9d97pOTZ0uNP6QCOZSfP+m5EJtrKgtcoSpqFWm3g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=rgtIwXIwfUuQF5DAo7ZUvc23o3fYM+4c+Fv0KQdgqqZ7FnuhqfEnLo5UAImKK5nJ7
	 0ac7GQjkuAS601adPGVqk2RSl1Ebt5e5YWmU17pM/3Wb+/vkii1S8vu/LmCgOPNnSV
	 I/k64jpXBmZvXOb4SSgyd09LFJ7MbBPW5bqWPLcQSwEdYSiSoYPtcojEbrprR2+38I
	 XoKMwWSpDIj1t9P2E/MaDBeRKfemcRufv0paD3HR+Kq3kBT9m7Oz4+fhA2zRRR0iwd
	 RaJ+cTEIXcQBOyNAQ0mU2tSfce3s6FHL5+ti9Uqj9MmWpyG0q/OUx+VlWou7BVuwMS
	 XO57H59WpJu1g==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021801.me.com (Postfix) with ESMTPSA id 7D80B20102D9;
	Sat,  2 Nov 2024 12:20:46 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sat, 02 Nov 2024 20:20:06 +0800
Subject: [PATCH v2 1/2] PCI: endpoint: Fix that API devm_pci_epc_destroy()
 fails to destroy the EPC device
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241102-pci-epc-core_fix-v2-1-0785f8435be5@quicinc.com>
References: <20241102-pci-epc-core_fix-v2-0-0785f8435be5@quicinc.com>
In-Reply-To: <20241102-pci-epc-core_fix-v2-0-0785f8435be5@quicinc.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Joao Pinto <jpinto@synopsys.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Proofpoint-ORIG-GUID: gKRYOFZ5oQZ0BZF5d0RHhMD9maz07hO4
X-Proofpoint-GUID: gKRYOFZ5oQZ0BZF5d0RHhMD9maz07hO4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-02_11,2024-11-01_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 suspectscore=0
 mlxlogscore=533 adultscore=0 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2411020110
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

For devm_pci_epc_destroy(), its comment says it needs to destroy the EPC
device, but it will not actually do that since devres_destroy() does not
call devm_pci_epc_release(), and it also can not fully undo what the API
devm_pci_epc_create() does, so it is faulty.

Fortunately, the faulty API has not been used by current kernel tree.
Fixed by using devres_release() instead of devres_destroy() within the API.

Fixes: 5e8cb4033807 ("PCI: endpoint: Add EP core layer to enable EP controller and EP functions")
Cc: stable@vger.kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>

---
Below linux-next commit fixes a similar issue.
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=fdce49b5da6e0fb6d077986dec3e90ef2b094b50

Why to fix the API here instead of directly deleting it?

1) it is simpler, just one line change.
2) it may be used in future.
3) ensure this restored API right if need to restore it in future
   after deleting.

Anyone may remove such APIs separately later if he/she cares.
---
 drivers/pci/endpoint/pci-epc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 17f007109255..71b6d100056e 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -857,7 +857,7 @@ void devm_pci_epc_destroy(struct device *dev, struct pci_epc *epc)
 {
 	int r;
 
-	r = devres_destroy(dev, devm_pci_epc_release, devm_pci_epc_match,
+	r = devres_release(dev, devm_pci_epc_release, devm_pci_epc_match,
 			   epc);
 	dev_WARN_ONCE(dev, r, "couldn't find PCI EPC resource\n");
 }

-- 
2.34.1


