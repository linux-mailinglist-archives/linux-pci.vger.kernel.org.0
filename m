Return-Path: <linux-pci+bounces-14920-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D05A9A52A2
	for <lists+linux-pci@lfdr.de>; Sun, 20 Oct 2024 07:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2EAF28111D
	for <lists+linux-pci@lfdr.de>; Sun, 20 Oct 2024 05:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7352984D0E;
	Sun, 20 Oct 2024 05:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="ou5YHP16"
X-Original-To: linux-pci@vger.kernel.org
Received: from pv50p00im-hyfv10021501.me.com (pv50p00im-hyfv10021501.me.com [17.58.6.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA9618B09
	for <linux-pci@vger.kernel.org>; Sun, 20 Oct 2024 05:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729402136; cv=none; b=VTgU0hDDjXMwjmyMQY9JTuSCVtXirvY9nVbeZaTpMir4LA4wVaNb11HHFlSqIrux+yFD4UlRFLfRMNyXGtxkbrIjanwvc28aZiXwvZ+9DVex9IejhXFOCfIHV5JSuMW2oTZSH7uZxWhHM7A8uxzSeee8c8LAONtTC9b5bKQpnpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729402136; c=relaxed/simple;
	bh=yLaDk8wi94a039VFqD35D/AkXGEihK7L1eKOgEgRtOg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sRLttXeoezNhz57R+MdksXRNgjONL+Vj373XO0ScKyThplaLdORAxHj1ISQJrg4CIDy2A5x2FuSfBSNJh5gfowYHCZvSk6Wp2DAaf3iyJYJPGGs3FDvqdfJirDU2gxRciakodks/idp+VxewO6/xZMR+O2ZrX3h0vXur9mFQ608=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=ou5YHP16; arc=none smtp.client-ip=17.58.6.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1729402134;
	bh=rVON13sMMqtKSwCrl4E1Uhkm6hLNfvRtGi981NVB7Gs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=ou5YHP16ry9CgCybtpG62r35ZB2cpiklwmT1he10nlofB7CO0oQAY7P6knGVfStrr
	 yBHd4FL3CbryCTpHZiGvlUqpAwIJuCz1SGhnCSMegnb0s4chbCotaXY5qCM7iwVsNm
	 x9gTXClBdLxoOSTIa/hsOwn5k/IFUpuhe8+O84o2bpcvE9ZNYahhHOm/NMzj5flyGg
	 Gu69Wosh8q8FpXgoaGr5LnQQpxlJcHOliGHy+88OWLHps3KIDYPV0MJ8y0AbgpBwuY
	 p4f0Qq0jSPQ1Ae9OWaKCljqZAv3IVssLla7cnWNzd4dazBw8+ni3tVqzaGCfj3xMCd
	 fj92LWGujUoww==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-hyfv10021501.me.com (Postfix) with ESMTPSA id CD6C22C0130;
	Sun, 20 Oct 2024 05:28:48 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 20 Oct 2024 13:27:50 +0800
Subject: [PATCH 5/6] phy: core: Add missing of_node_put() in
 of_phy_provider_lookup()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241020-phy_core_fix-v1-5-078062f7da71@quicinc.com>
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
X-Proofpoint-ORIG-GUID: hKZD5y-4RY3sylApKTy1YAx6Oj9Jx6jl
X-Proofpoint-GUID: hKZD5y-4RY3sylApKTy1YAx6Oj9Jx6jl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-20_02,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 spamscore=0
 malwarescore=0 phishscore=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2410200032
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

The for_each_child_of_node() macro automatically decrements the child
refcount at the end of every iteration. On early exits, of_node_put()
must be used to manually decrement the refcount and avoid memory leaks.

The macro called by of_phy_provider_lookup() has such early exit, but
it does not call of_node_put() before early exit.

Fixed by adding missing of_node_put() in of_phy_provider_lookup().

Fixes: 2a4c37016ca9 ("phy: core: Fix of_phy_provider_lookup to return PHY provider for sub node")
Cc: stable@vger.kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>

---
The impact of this change is wide since of_phy_provider_lookup()
is indirectly called by APIs phy_get(), of_phy_get(), and
devm_of_phy_get_by_index().

The following kernel mainline commit has similar fix:
Commit: b337cc3ce475 ("backlight: lm3509_bl: Fix early returns in for_each_child_of_node()")
---
 drivers/phy/phy-core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 967878b78797..24bd619a33dd 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -143,10 +143,11 @@ static struct phy_provider *of_phy_provider_lookup(struct device_node *node)
 	list_for_each_entry(phy_provider, &phy_provider_list, list) {
 		if (phy_provider->dev->of_node == node)
 			return phy_provider;
-
 		for_each_child_of_node(phy_provider->children, child)
-			if (child == node)
+			if (child == node) {
+				of_node_put(child);
 				return phy_provider;
+			}
 	}
 
 	return ERR_PTR(-EPROBE_DEFER);

-- 
2.34.1


