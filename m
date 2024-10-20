Return-Path: <linux-pci+bounces-14921-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4559A52A5
	for <lists+linux-pci@lfdr.de>; Sun, 20 Oct 2024 07:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EFF52828FE
	for <lists+linux-pci@lfdr.de>; Sun, 20 Oct 2024 05:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3ACC154BF0;
	Sun, 20 Oct 2024 05:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="FzsUprEn"
X-Original-To: linux-pci@vger.kernel.org
Received: from pv50p00im-hyfv10021501.me.com (pv50p00im-hyfv10021501.me.com [17.58.6.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498022030A
	for <linux-pci@vger.kernel.org>; Sun, 20 Oct 2024 05:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729402142; cv=none; b=YMlEGzqmOgVFSSQc/De11iNSXToZ/a8p/Raz3dW8AxazwsMwGlAIiS1J9UCDDBKNagefCZUbcA70oq5iktkrUwkwXfId6RlQ6mXZS62YDntOAThY3gdMhgZXKxlrdMcIiJj3FUeelmxQB2kn3QK7fQjnryPQKtmV+4eDDmQ1qHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729402142; c=relaxed/simple;
	bh=KAQIPjHa1pT2Qv7ml02HoE4WShDt3Q6Tb2e8TvTKe6g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nVi0Aehgj6vn0KCuSVBR6cHLQCMvBkw+Hg91e2LeJ8bCACPxnMacdZfWiDY0hzD94haPMoISocnl0T7txBrgbNfynNxX1WMUu4x++1CuVOZUN0L8ZS7c7Wf7KZraUKs4F1z9oK+0Sd4Tp4f8Y0czA3yNLDVUqu6cw6EnB6FTPqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=FzsUprEn; arc=none smtp.client-ip=17.58.6.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1729402140;
	bh=Pzj4HJoWnL6JTLVf/LzhBRoFLqsQjjCajmU0HHRJmCM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=FzsUprEnaIdjyWcgh24n4owqgCzwCEevOvHP5TBSaiI+GpFyVFF48q7MSLp5srmER
	 49VkFoBQ5XoQpE1j98Fz9ev9yh+BpUPjVvlh2BafPiLQAfKq2SsJQ07ku9Ojbg/XP2
	 qQjJHhxdEPOqQNcrLMXTrx5ZDPZaVo46b169DrWuHQ7/ae1Hvj/yoA0J4KYc6WN3H5
	 jtMwQfYBRhwhSywsNxKuMi4qXJ3zMT5IUD10mNexJhH0YpjHb6B0tjQL/CKMBbFHoH
	 a5N7/J7iztEt7vk1VaMooWxFcs+nn+rmK9i3u80xPHGABylS8yFXBCxdO4oGvU8vqs
	 Vz/Asg70Uh8Zg==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-hyfv10021501.me.com (Postfix) with ESMTPSA id 24D4C2C0141;
	Sun, 20 Oct 2024 05:28:54 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 20 Oct 2024 13:27:51 +0800
Subject: [PATCH 6/6] phy: core: Simplify API of_phy_simple_xlate()
 implementation
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241020-phy_core_fix-v1-6-078062f7da71@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 0V1SomLf6-r1ySnqSOHR_zWePw_E5J9r
X-Proofpoint-GUID: 0V1SomLf6-r1ySnqSOHR_zWePw_E5J9r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-20_02,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 spamscore=0
 malwarescore=0 phishscore=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2410200032
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Simplify of_phy_simple_xlate() implementation by API
class_find_device_by_of_node() which is also safer since it
subsys_get() @phy_class subsystem firstly then iterates devices.

Also comment its parameter @dev with unused in passing since the parameter
provides no available input info but acts as an auto variable.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/phy/phy-core.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 24bd619a33dd..102fc6b6ff71 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -748,7 +748,7 @@ EXPORT_SYMBOL_GPL(devm_phy_put);
 
 /**
  * of_phy_simple_xlate() - returns the phy instance from phy provider
- * @dev: the PHY provider device
+ * @dev: the PHY provider device unused
  * @args: of_phandle_args (not used here)
  *
  * Intended to be used by phy provider for the common case where #phy-cells is
@@ -759,20 +759,13 @@ EXPORT_SYMBOL_GPL(devm_phy_put);
 struct phy *of_phy_simple_xlate(struct device *dev,
 				const struct of_phandle_args *args)
 {
-	struct phy *phy;
-	struct class_dev_iter iter;
-
-	class_dev_iter_init(&iter, &phy_class, NULL, NULL);
-	while ((dev = class_dev_iter_next(&iter))) {
-		phy = to_phy(dev);
-		if (args->np != phy->dev.of_node)
-			continue;
+	struct device *target_dev;
 
-		class_dev_iter_exit(&iter);
-		return phy;
+	target_dev = class_find_device_by_of_node(&phy_class, args->np);
+	if (target_dev) {
+		put_device(target_dev);
+		return to_phy(target_dev);
 	}
-
-	class_dev_iter_exit(&iter);
 	return ERR_PTR(-ENODEV);
 }
 EXPORT_SYMBOL_GPL(of_phy_simple_xlate);

-- 
2.34.1


