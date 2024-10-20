Return-Path: <linux-pci+bounces-14918-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E0A9A5299
	for <lists+linux-pci@lfdr.de>; Sun, 20 Oct 2024 07:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FB672840CF
	for <lists+linux-pci@lfdr.de>; Sun, 20 Oct 2024 05:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F8816426;
	Sun, 20 Oct 2024 05:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="agl/5G5a"
X-Original-To: linux-pci@vger.kernel.org
Received: from pv50p00im-hyfv10021501.me.com (pv50p00im-hyfv10021501.me.com [17.58.6.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B4415E90
	for <linux-pci@vger.kernel.org>; Sun, 20 Oct 2024 05:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729402123; cv=none; b=sQ8iCzEO2SpDe2B4B0tQ2XutuIHeArHCDjKwwKQXls+2iXvtyQDT/3NbJFXmzvVxKcGXQyNX08ezURJBqMfIQqUKmjp7k1N+xLc+0hz86Gn9i+3FOc6rhNnFbabB+irm+53nkD8gqaAJThYZVQ+4XtJ/Tiju/jQPcicBEFaNkJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729402123; c=relaxed/simple;
	bh=ZOEJdZ+Y3uBV1dJVvv1OBBlfxG/5hZGvIhfygbRzcEs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lQPjku+vYjBiRYJkTPYtKj+l1vj7yawlh48mermZntVTl4OjVmBGp8CT2zCDRgCcWDl64o4EmOdqB48fmY37Y+7s4IvJENvrUnSeFlvA/yg2jH8UICs56VYOYM68U7w10gL0H7C4OixWxdpdIwm4EeD/O3vKxTh+1BPWOuVNXyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=agl/5G5a; arc=none smtp.client-ip=17.58.6.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1729402121;
	bh=4UkJl6ESTHl0MKzkJU4NiOf/LCaIG4/FzrobNoV6pGo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=agl/5G5aRiA/jFm9Z5d6jJMG/1kcv7KbHcP1dOJ30kvE9JiD6zhw22+qXm3HiR7ps
	 Wy2Wh0ZdOeP2xGhQYTTsxqfDQrpBorcxcjs0mi1EzdW4uSEmwsE2pTIjOfb7T+jLmB
	 tohHnrKZ6m0KxnHZO3hIUwK0ZLKmYY7/lDP9LKtc6h2EgpjeG61ZsxkmZTCU1l1RxO
	 YBU7LTQT/G3D2VxNdDC/MXLKV2XLw/8RZDgeAbCF5csG6U87xZhT4sQCXD8U3S1U4E
	 KI7UAvMi1Gn+yVFWW5RwGV3QwQMPbN6oAvOWKs2en5yJYJCBn3cGHM+8Ui/hpTt7i+
	 VdDEGYC/OvQwA==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-hyfv10021501.me.com (Postfix) with ESMTPSA id 3E7BC2C0130;
	Sun, 20 Oct 2024 05:28:35 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 20 Oct 2024 13:27:48 +0800
Subject: [PATCH 3/6] phy: core: Fix API devm_phy_destroy() can not destroy
 the phy
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241020-phy_core_fix-v1-3-078062f7da71@quicinc.com>
References: <20241020-phy_core_fix-v1-0-078062f7da71@quicinc.com>
In-Reply-To: <20241020-phy_core_fix-v1-0-078062f7da71@quicinc.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Felipe Balbi <balbi@ti.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Lee Jones <lee@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, stable@vger.kernel.org, 
 linux-phy@lists.infradead.org, netdev@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-ORIG-GUID: U-x97Lqmim6E_t_TfbzbHgSP6RIq63vt
X-Proofpoint-GUID: U-x97Lqmim6E_t_TfbzbHgSP6RIq63vt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-20_02,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 spamscore=0
 malwarescore=0 phishscore=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2410200032
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

For devm_phy_destroy(), its comment says it needs to invoke phy_destroy()
to destroy the phy, but it does not do that actually, so it can not fully
undo what the API devm_phy_create() does, that is wrong, fixed by using
devres_release() instead of devres_destroy() within the API.

Fixes: ff764963479a ("drivers: phy: add generic PHY framework")
Cc: stable@vger.kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/phy/phy-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index de07e1616b34..52ca590a58b9 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -1121,7 +1121,7 @@ void devm_phy_destroy(struct device *dev, struct phy *phy)
 {
 	int r;
 
-	r = devres_destroy(dev, devm_phy_consume, devm_phy_match, phy);
+	r = devres_release(dev, devm_phy_consume, devm_phy_match, phy);
 	dev_WARN_ONCE(dev, r, "couldn't find PHY resource\n");
 }
 EXPORT_SYMBOL_GPL(devm_phy_destroy);

-- 
2.34.1


