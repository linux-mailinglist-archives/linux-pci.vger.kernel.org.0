Return-Path: <linux-pci+bounces-13858-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90000990E37
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 21:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 436561F2392E
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 19:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B60D21FEC8;
	Fri,  4 Oct 2024 18:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a392iF2p"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E687321FEC4;
	Fri,  4 Oct 2024 18:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066570; cv=none; b=Le7rqEHoWK+lHQQKmvz9lfidU6RoJmVQs+6+r74gc20Ff/6FaG+rA6FgIYKij8V5GwOdgGPXs+BwnW5bAk35iKW5cjBflN+0DgseD/W0k1BPGBZi/RugOWhRKXwu0fEKA9SUm6Zac6/Y4hjjSc/a9ay6f7NL9t+dIjYHMuN090E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066570; c=relaxed/simple;
	bh=2K/1a5RGIAyA2J4ybA+WQ5RJxOMBMXzl5TD8SvSdLHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L3GHmvxZyzLyYgfoIKtQPh+1Es7bs1OR8BfEVIhWVrFoIuX4lA3yk82Cn8eHD2yS9zZU+EoF4EvhiZhRbGMxDgZW5hveuielLLUJNt1onQVSXxhmC6Ld/Vu2E4lnBaUlupuZ/oWox4NN7iDdJcvHdLttRndKN7zwL8BDkkVlKqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a392iF2p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C6D0C4CECC;
	Fri,  4 Oct 2024 18:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066569;
	bh=2K/1a5RGIAyA2J4ybA+WQ5RJxOMBMXzl5TD8SvSdLHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a392iF2pQUWmTiCB/rz0SQ+GEOnqionQf/rnOKbfsl70tZN5cyQ8Ljq4wgwikYMir
	 WCwGuZmO0ZaJRwffP960KtE6sBF+RRrSfMavMgf3RiIv9uGur/a9aglWujAS+8bein
	 BcDqw1NB0n8wd8bJS2JW+xkrAx6td28oouEWNTZ3JML8B2ENXqF6p/+79yxIBqL+rk
	 2o5rcfjEqskTLYU9TonYNMwGjrRxlowrGjkAjJFdRtjylD+S0MU8lMGkAi0/hUNDEI
	 xmJzAlNCXRUTGNv/Icc0cGP1HzfjZCe3AJrf5gGk2gFX6vrVNIcjN6HvWiDBn/bj0w
	 j0teZqoetUlNQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	zdravko delineshev <delineshev@outlook.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 19/31] PCI: Mark Creative Labs EMU20k2 INTx masking as broken
Date: Fri,  4 Oct 2024 14:28:27 -0400
Message-ID: <20241004182854.3674661-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182854.3674661-1-sashal@kernel.org>
References: <20241004182854.3674661-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.167
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
index 965e2c9406dbd..4ce4ca3df7432 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3482,6 +3482,8 @@ DECLARE_PCI_FIXUP_FINAL(0x1814, 0x0601, /* Ralink RT2800 802.11n PCI */
 			quirk_broken_intx_masking);
 DECLARE_PCI_FIXUP_FINAL(0x1b7c, 0x0004, /* Ceton InfiniTV4 */
 			quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CREATIVE, PCI_DEVICE_ID_CREATIVE_20K2,
+			quirk_broken_intx_masking);
 
 /*
  * Realtek RTL8169 PCI Gigabit Ethernet Controller (rev 10)
-- 
2.43.0


