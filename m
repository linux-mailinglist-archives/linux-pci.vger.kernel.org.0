Return-Path: <linux-pci+bounces-13850-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 429C8990D28
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 21:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7ADB1F229D7
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 19:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2C620563D;
	Fri,  4 Oct 2024 18:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpRQUPFz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C12205636;
	Fri,  4 Oct 2024 18:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066350; cv=none; b=GItzabk9GakaNrr0S0itnBs90v1IonF8OrwaF6GqNsaZMHRro/Q/Fw01S6+Wof1o66cl8erUtK6ajmLMRmL9fZjuU9ylRmNlObmQ4DKmZBi7LNHumDUjtJ88uf/m96jb/ACz818I0d8sisTVA0IDJXeoH8lzktcih3ga4k/7Lkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066350; c=relaxed/simple;
	bh=XzJvyazZ2b8fN2LRI5JRLxuHf8JsBuGArGamVTpOvrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mr4y3ExYdBbg6sIQMW+2xUwoqo38N+mYiZHHOwJ/uVrSUNIIQbouwWLup53QU+tQg/gJeBo/iWJ3ZdTVt8IdovHpRDOEmK/GCD33xqCOx1BH1Et9ZdoWphBrprL2/eM6pvvRpvtlaSpkT4nDT2vvSpMYY9QmFaPUB67J/nfSDIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OpRQUPFz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BB03C4CEC6;
	Fri,  4 Oct 2024 18:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066350;
	bh=XzJvyazZ2b8fN2LRI5JRLxuHf8JsBuGArGamVTpOvrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OpRQUPFz59UXyL1midwWPOFhLdkGTH5VI4t3cjrMI/rO3FwLUjvNIC028aSSBkd9P
	 59qfnqlUNE++zLLQaUL0/EJUjvxSj9a6A6LZ5pCCGkonEFOzgjniWAOmdxxs4P9ueS
	 aIH3tKy7Q78ZiLHlRFRvXtzD9Qpxr/5lUBi3X/zqKj/QQSU1BfN8Ssxv9V9EadMelR
	 MB+E/q/n7zwHE55u2tZBcJyr70EWTmezorORgfz+XRDDH+WaBJI75nuPXCmnXxtOQs
	 NbOwylh+CGlSx/XEatelF0U6j1TnKk3Bx1DT/KMmFwd1Q/ITjZBrHF0+xCTFCTi9n8
	 bUoHgd0Tg6Klg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	zdravko delineshev <delineshev@outlook.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 26/58] PCI: Mark Creative Labs EMU20k2 INTx masking as broken
Date: Fri,  4 Oct 2024 14:23:59 -0400
Message-ID: <20241004182503.3672477-26-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182503.3672477-1-sashal@kernel.org>
References: <20241004182503.3672477-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.54
Content-Transfer-Encoding: 8bit

From: Alex Williamson <alex.williamson@redhat.com>

[ Upstream commit 2910306655a7072640021563ec9501bfa67f0cb1 ]

Per user reports, the Creative Labs EMU20k2 (Sound Blaster X-Fi
Titanium Series) generates spurious interrupts when used with
vfio-pci unless DisINTx masking support is disabled.

Thus, quirk the device to mark INTx masking as broken.

Closes: https://lore.kernel.org/all/VI1PR10MB8207C507DB5420AB4C7281E0DB9A2@VI1PR10MB8207.EURPRD10.PROD.OUTLOOK.COM
Link: https://lore.kernel.org/linux-pci/20240912215331.839220-1-alex.williamson@redhat.com
Reported-by: zdravko delineshev <delineshev@outlook.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
[kwilczynski: commit log]
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b70126953fc42..e740636e99796 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3601,6 +3601,8 @@ DECLARE_PCI_FIXUP_FINAL(0x1814, 0x0601, /* Ralink RT2800 802.11n PCI */
 			quirk_broken_intx_masking);
 DECLARE_PCI_FIXUP_FINAL(0x1b7c, 0x0004, /* Ceton InfiniTV4 */
 			quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CREATIVE, PCI_DEVICE_ID_CREATIVE_20K2,
+			quirk_broken_intx_masking);
 
 /*
  * Realtek RTL8169 PCI Gigabit Ethernet Controller (rev 10)
-- 
2.43.0


