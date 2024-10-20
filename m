Return-Path: <linux-pci+bounces-14915-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FD09A528D
	for <lists+linux-pci@lfdr.de>; Sun, 20 Oct 2024 07:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C4351F21449
	for <lists+linux-pci@lfdr.de>; Sun, 20 Oct 2024 05:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D8DF507;
	Sun, 20 Oct 2024 05:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="rjcm4E9b"
X-Original-To: linux-pci@vger.kernel.org
Received: from pv50p00im-hyfv10021501.me.com (pv50p00im-hyfv10021501.me.com [17.58.6.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8606DDDA9
	for <linux-pci@vger.kernel.org>; Sun, 20 Oct 2024 05:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729402105; cv=none; b=lv+kRghzPwIn1ZO/srJTLAMnkQlmfKgSJljl7DAbZ2F9lBJrM+pDUVzUs9sf/S0NQr5CR/PXyZ708aApsqZL+wPPLJex45PSaz7yX1C+TyUvrXSn2BFUlgrDsGUpJ92VLIosPh7VIYByiXpiof756karuYeSWtWWnSfGnCU2FAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729402105; c=relaxed/simple;
	bh=lWpKg7cZlxk5+I5dEu0m2KWp7mH0jRj5PAELGzya32s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pv7V7iM6TIQWZnUkjdGCQpqG2OpR5Zbdtyy/N/rO+3SYMfx5HNum+rFebY9r07HMEuM1wHOcwj6LzBFc+32mhJF3tF735gRVTQnkCfqnm8HliSyOhQSQk7er8ueLfh7bOUU7jvoLr382JFrI5qRADsj0zEhe12WtoK2jkfZNlZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=rjcm4E9b; arc=none smtp.client-ip=17.58.6.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1729402102;
	bh=+3UjV7BU0TIkt4Lhwy86UL8JylbnLsp4ODES3JsnJc0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To;
	b=rjcm4E9be/d88baHvpjEDFn5al/Fz/NXhsYtKGzKnafVfMRwuJdWdaetj2P298Uol
	 TTjVNcX4qkwkOuO2C5BiGI5I2wGfoc0zs4c1cIUIpLvkIGG3DowwSWqEgEkzsDi2iz
	 QnGnkHDTsXLBUiIKEAcHctWo9CDJRdYITP/6k6r1usb+LdEniQeLKz6herCHFcRu+q
	 JM1CHMn+QvmHDDojbnjvnQkSKWBPEDASEqMufPPBrATP5w1XuU6w0Xlmnp04eIRBAi
	 VnwOewVctf8wtkcUAlcNflBPxT8gHwsJJqv1N65Ls8/D9+DM469oRyzZDOlrRUxvIf
	 6+1IYBnTg2ybw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-hyfv10021501.me.com (Postfix) with ESMTPSA id 515E72C0141;
	Sun, 20 Oct 2024 05:28:16 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Subject: [PATCH 0/6] phy: core: Fix bugs for several APIs and simplify an
 API
Date: Sun, 20 Oct 2024 13:27:45 +0800
Message-Id: <20241020-phy_core_fix-v1-0-078062f7da71@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANGUFGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDAyMD3YKMyvjk/KLU+LTMCt1U48QUM9OUJEuLNHMloJaColSgMNi46Nj
 aWgDfOHg9XgAAAA==
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
X-Proofpoint-ORIG-GUID: cUMa0O_M1qQTEfDmNyMtrVfExnK6Tj1_
X-Proofpoint-GUID: cUMa0O_M1qQTEfDmNyMtrVfExnK6Tj1_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-20_02,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 spamscore=0
 malwarescore=0 phishscore=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=574 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2410200032
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

This patch series is to fix bugs for below APIs:

devm_phy_put()
devm_of_phy_provider_unregister()
devm_phy_destroy()
phy_get()
of_phy_get()
devm_of_phy_get_by_index()

And simplify API of_phy_simple_xlate().

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Zijun Hu (6):
      phy: core: Fix API devm_phy_put() can not release the phy
      phy: core: Fix API devm_of_phy_provider_unregister() can not unregister the phy provider
      phy: core: Fix API devm_phy_destroy() can not destroy the phy
      phy: core: Add missing of_node_put() for an error handling path of _of_phy_get()
      phy: core: Add missing of_node_put() in of_phy_provider_lookup()
      phy: core: Simplify API of_phy_simple_xlate() implementation

 drivers/phy/phy-core.c | 39 ++++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 21 deletions(-)
---
base-commit: d8f9d6d826fc15780451802796bb88ec52978f17
change-id: 20241020-phy_core_fix-e3ad65db98f7

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


