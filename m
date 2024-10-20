Return-Path: <linux-pci+bounces-14916-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0569A5293
	for <lists+linux-pci@lfdr.de>; Sun, 20 Oct 2024 07:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97346B24654
	for <lists+linux-pci@lfdr.de>; Sun, 20 Oct 2024 05:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D64BE5E;
	Sun, 20 Oct 2024 05:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Yfh2oBZa"
X-Original-To: linux-pci@vger.kernel.org
Received: from pv50p00im-hyfv10021501.me.com (pv50p00im-hyfv10021501.me.com [17.58.6.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF65A17C64
	for <linux-pci@vger.kernel.org>; Sun, 20 Oct 2024 05:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729402111; cv=none; b=GvoziB6PfcJ1aH6EsHfNhczLJLcDgc8Z+rOVqB9WPUeQxSmvg01SN01G6db7H7lsDx6SzDhKniy9iNcAsd9D/sh+j91qSsRqOuBZDI/2SbbkD5RJCQw+aC5txKzKOBw83lptP25fzh3iOd12liqlCxEmHKoifocJNbMz75x9P4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729402111; c=relaxed/simple;
	bh=yRlI5ZQbFQSAjN5ZN2BqMJNtRWxWQcPeZJrENtttJJo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H4I0+ER+xZSPygcF/AecFpGvRKcqrrugW6481AiUJFbQFUkX3SzJWi0/cPlLV12anKJS1pbt3+RAP5HMrut+ahIIHVdEbvvens3Pevp/g5Qt0d7T+jWOjBjBzbudLGgfoEMkximB30hZoqeO5XB3PPp/rzAJEeABqYXYx0imxIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=Yfh2oBZa; arc=none smtp.client-ip=17.58.6.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1729402109;
	bh=KnWmUxlYWWRbTvdeYT3kWc/oYa/wGqdAwM1ag6tzhOY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=Yfh2oBZanXoWXjDU7Yt67Qlkt/SaoaBWFzJwQJXGpmjrNQMCsvnd+owTYQVy9mlqY
	 cgavEfm+Oe/uyPfX5gRM1UYXQVjqQbE9GxBzRR8PcJ3dIi6EQPVLfjJq1RDy26eYH9
	 lV7hA8oqs+SS7UM3n+i6Epg3EYUPsYinm5tZW4xH6lqmXqPnLP8Mm9Q71NyOHJNr58
	 lzQFtugZMN93Dnk8t/QmgYqcuLyfFPye3lcV3tDsr9wl+t/45phSrCGcvOAMTkePX8
	 cYmfs6xLMbkaN0CkQK9VVqPSkSQqqUO0pZnYhdUPImepRcemYBb4LK3xbQqV41cG8A
	 dBYc+GcN/PldQ==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-hyfv10021501.me.com (Postfix) with ESMTPSA id 95ACB2C00F7;
	Sun, 20 Oct 2024 05:28:23 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 20 Oct 2024 13:27:46 +0800
Subject: [PATCH 1/6] phy: core: Fix API devm_phy_put() can not release the
 phy
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241020-phy_core_fix-v1-1-078062f7da71@quicinc.com>
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
X-Proofpoint-ORIG-GUID: gv-M2zT64WpCFnIo56TxGzChfILMIwkn
X-Proofpoint-GUID: gv-M2zT64WpCFnIo56TxGzChfILMIwkn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-20_02,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 spamscore=0
 malwarescore=0 phishscore=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2410200032
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

For devm_phy_put(), its comment says it needs to invoke phy_put() to
release the phy, but it does not do that actually, so it can not fully
undo what the API devm_phy_get() does, that is wrong, fixed by using
devres_release() instead of devres_destroy() within the API.

BTW, the API is directly used by below source files in error handling
path, so also fix relevant issue within these source files:
drivers/pci/controller/cadence/pcie-cadence.c
drivers/net/ethernet/ti/am65-cpsw-nuss.c

Fixes: ff764963479a ("drivers: phy: add generic PHY framework")
Cc: stable@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/phy/phy-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index f053b525ccff..f190d7126613 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -737,7 +737,7 @@ void devm_phy_put(struct device *dev, struct phy *phy)
 	if (!phy)
 		return;
 
-	r = devres_destroy(dev, devm_phy_release, devm_phy_match, phy);
+	r = devres_release(dev, devm_phy_release, devm_phy_match, phy);
 	dev_WARN_ONCE(dev, r, "couldn't find PHY resource\n");
 }
 EXPORT_SYMBOL_GPL(devm_phy_put);

-- 
2.34.1


