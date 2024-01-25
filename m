Return-Path: <linux-pci+bounces-2533-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C9283B786
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jan 2024 04:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5088D1F25424
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jan 2024 03:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44581FAD;
	Thu, 25 Jan 2024 03:06:41 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6460D79E2;
	Thu, 25 Jan 2024 03:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706152001; cv=none; b=aaREJBaKn8viLN1h8kM9zZo/v9EVd0DQzc6eWXTAGhL16a+uiFOKLWHlt+fRuOWeIt7lF0xY2pQcwFaK4Qoof2Y/ex8IG7QVLftS3vFWAGlvKuFURK94Z+UijHyMiTtsaTOv9rPRtcgPhPsioDHBP1JWNDuDVZyU0vCKHWgKG2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706152001; c=relaxed/simple;
	bh=ow7IMVspmCcE3TE1IhnzZv0vHhmCk8Hrv8HbR587cVk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Faqum17Wa9EqPsmtIOoI/unqhC7+yAGxqbOnAxHYUJS+c/YDZnB6o8V9rLK3iHf385u/xXZ52mQPMktUvXFLgpEc0TY01C7xQ/S5EZjk+ovz5/dVORQZ3Ix5TsUzFG9OaYoxiVOSbSJvTouofVGBebGhqKJUJLVt0naIVz5oVdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 99479cd41a2149baa6630577220df5a3-20240125
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:b5f2e5c8-8590-4e7f-b06c-b09c9f7db4fa,IP:20,
	URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:-3,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-3
X-CID-INFO: VERSION:1.1.35,REQID:b5f2e5c8-8590-4e7f-b06c-b09c9f7db4fa,IP:20,UR
	L:0,TC:0,Content:-20,EDM:0,RT:0,SF:-3,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-3
X-CID-META: VersionHash:5d391d7,CLOUDID:35c43a83-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:240125110630WOUVYAVM,BulkQuantity:0,Recheck:0,SF:19|44|101|66|38|24|
	100|17|102,TC:nil,Content:1,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BE
	C:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 99479cd41a2149baa6630577220df5a3-20240125
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 599201392; Thu, 25 Jan 2024 11:06:29 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id C92E2E000EB9;
	Thu, 25 Jan 2024 11:06:28 +0800 (CST)
X-ns-mid: postfix-65B1D034-617628425
Received: from kernel.. (unknown [172.20.15.234])
	by mail.kylinos.cn (NSMail) with ESMTPA id DD215E000EB9;
	Thu, 25 Jan 2024 11:06:24 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: bhelgaas@google.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] x86: Code cleanup for ehci_hdr
Date: Thu, 25 Jan 2024 11:06:23 +0800
Message-Id: <20240125030623.513902-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This part was commented from commit 3ef0e1f8cad0
("x86: olpc: add One Laptop Per Child architecture support")
in about 16 years before.

If there are no plans to enable this part code in the future,
we can remove this dead code.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 arch/x86/pci/olpc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/pci/olpc.c b/arch/x86/pci/olpc.c
index f3aab76e357a..4b18c6404363 100644
--- a/arch/x86/pci/olpc.c
+++ b/arch/x86/pci/olpc.c
@@ -154,9 +154,6 @@ static const uint32_t ehci_hdr[] =3D {  /* dev f func=
tion 4 - devfn =3D 7d */
 	0x0,	0x40,	0x0,	0x40a,			/* CapPtr INT-D, IRQA */
 	0xc8020001, 0x0, 0x0,	0x0,	/* Capabilities - 40 is R/O, 44 is
 					   mask 8103 (power control) */
-#if 0
-	0x1,	0x40080000, 0x0, 0x0,	/* EECP - see EHCI spec section 2.1.7 */
-#endif
 	0x01000001, 0x0, 0x0,	0x0,	/* EECP - see EHCI spec section 2.1.7 */
 	0x2020,	0x0,	0x0,	0x0,	/* (EHCI page 8) 60 SBRN (R/O),
 					   61 FLADJ (R/W), PORTWAKECAP  */
--=20
2.39.2


