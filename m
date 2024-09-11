Return-Path: <linux-pci+bounces-13041-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D85A975583
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 16:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8B8028B510
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 14:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853FD19F11A;
	Wed, 11 Sep 2024 14:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NDmOFM2K"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5362C191F8C;
	Wed, 11 Sep 2024 14:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726065190; cv=none; b=JSF+b7uXa64aXtPt/GZ4hx7awqnE1qfJlIq61AbtOlmnvW9TWikYlQi5rmT01CYkUU/xrHjJc844JXS9vNgMxHOLvfG0CKSdOCCkMBf7GdYq7X4y5yiU9ophsDHOOlw/aB3SNVFWHSGKVsdGdp2H0gBR59Ae82Gmj+oI32P1nsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726065190; c=relaxed/simple;
	bh=nH7uXR/mf89HIjvFTdMKPGL8LxZGyXArM3vFfrHZHHk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qAHV0LJ/Yhauqt3if+S74alpiTQleUMwteCnYh5pEZBVP90PBajtDv0iq238xXlXcrl3oyaGys4Z3u9d5BYP+uxB2omA2e4K0hTXGc5amHeR/ZVNGTWSv/Zj5o5pBSzik7VIDetyqvixodyTqHhIj4NVxk/TxpnjEIyTLOF7X38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NDmOFM2K; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=BeDJb
	itMR/rHgNLbtzCICYHaqbwBV6Q3Kpd+79Ocnh0=; b=NDmOFM2KsaKH9f366mVWW
	Sf13O3yxeAZTUlhdT1SOVEX4yX7fg5LBaWLARqMF5h1wN/Y57C520cxygDwoJRep
	+GEUdatOmFgswFdsdkZRQ1BYL7EiWb46IpdEpuwG7ZDHX43uFQM8pzzJ+iB9OIkQ
	dep6uYMrgDJ61wH1yb/iQc=
Received: from iZbp1asjb3cy8ks0srf007Z.. (unknown [120.26.85.94])
	by gzga-smtp-mta-g3-1 (Coremail) with SMTP id _____wDnT_r1qeFmmhDyCg--.6633S2;
	Wed, 11 Sep 2024 22:32:21 +0800 (CST)
From: Qianqiang Liu <qianqiang.liu@163.com>
To: ryder.lee@mediatek.com,
	jianjun.wang@mediatek.com,
	lpieralisi@kernel.org,
	matthias.bgg@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Qianqiang Liu <qianqiang.liu@163.com>
Subject: [PATCH] PCI: mediatek-gen3: Check the return value of the reset_control_bulk_deassert
Date: Wed, 11 Sep 2024 22:31:55 +0800
Message-Id: <20240911143154.59816-1-qianqiang.liu@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnT_r1qeFmmhDyCg--.6633S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKr4xJr43Gr4kAry5tr4ktFb_yoWkJFg_Xr
	Z7GFsrA3yDCry3KwnFyrWrArZxAas7Z3W0kF95tF13Aa48ur1FqrnrZrWDZF4UGF4Yqr9x
	GF1kuw4fAa4UJjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjJPEDUUUUU==
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiLwVXamVOGRDjgwACsX

"reset_control_bulk_deassert" may return error code, we should check the
return value of it.

Signed-off-by: Qianqiang Liu <qianqiang.liu@163.com>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 66ce4b5d309b..5b35dc32ad47 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -1016,7 +1016,9 @@ static int mtk_pcie_setup(struct mtk_gen3_pcie *pcie)
 	 * Deassert the line in order to avoid unbalance in deassert_count
 	 * counter since the bulk is shared.
 	 */
-	reset_control_bulk_deassert(pcie->soc->phy_resets.num_resets, pcie->phy_resets);
+	err = reset_control_bulk_deassert(pcie->soc->phy_resets.num_resets, pcie->phy_resets);
+	if (err)
+		return err;
 	/*
 	 * The controller may have been left out of reset by the bootloader
 	 * so make sure that we get a clean start by asserting resets here.
-- 
2.39.2


