Return-Path: <linux-pci+bounces-13837-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A360990B81
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 20:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65DE0B24DEF
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 18:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF0E2225B8;
	Fri,  4 Oct 2024 18:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kllo3iBh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F22E2225B2;
	Fri,  4 Oct 2024 18:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065960; cv=none; b=EhIDSnveZD/SWP6FX9/SlI9HVe80eYg3dnFmWJI4PNhTHeU/GnrAHMdJ1hRHmJMh6ZmlAkSwvS6rpeRy7G9kuom8F+HQjR9Ei+Kat6DJNTqtOS2rlF1lpILzxRqu11JiMHAYHxDP3CU4MYVEbv3LPZ5GJUfjLC0yaCSpx1vXyYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065960; c=relaxed/simple;
	bh=Ivkni5jqlMfHjej3+rJuHYXnOG8zI/fZCzqWPx1iPtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qQQKKhfsS9KYlAhYdWUj/j+gLp/Hgw+egTni6P1EwhUVwMQFGmq4cJ8iJWyXYHm4l18jejoR8EfmCH64Nh7/GZ2VAZI0RDGhSk/EjPCSUh3eTZsylSjxMbVRZZjGdGd/1NYxfeXmQV+9SplzcElYHxHc1DCYGQXXK3sF9HLVX/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kllo3iBh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A69EC4CED4;
	Fri,  4 Oct 2024 18:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728065960;
	bh=Ivkni5jqlMfHjej3+rJuHYXnOG8zI/fZCzqWPx1iPtI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kllo3iBhTrFmEkibwgD8DWHGwFyRXkRoVVL0H1fkPh1XY3mQo/bUerr+X/LVaRBnC
	 Xn67C2VWmR0a5mUeDKKjn6lqKtcKsQ6W0C7zEmi3FuvuTPEp0WP5pLt3mtkyeKP3PD
	 3UmikS0/gaTp0Xs/Dc+dy5OIMeohZMuy8amAkEctakulu0amu8cMAlhIauoK/Bw204
	 32/1oa2HPxZWy4cJMK3pegjBEXJp9qQpp8I/H26dypnPZH2KFLDWG2pxmW6th2xDW3
	 YtKwCHIf5EFCco3lSU0OKZttJeyGL73C/6iQ63kLABsvqwqIbrLjIr4V6yVcdEdjn2
	 dJ3eeRvldOWrw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	zdravko delineshev <delineshev@outlook.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 29/76] PCI: Mark Creative Labs EMU20k2 INTx masking as broken
Date: Fri,  4 Oct 2024 14:16:46 -0400
Message-ID: <20241004181828.3669209-29-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004181828.3669209-1-sashal@kernel.org>
References: <20241004181828.3669209-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.2
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
index 8502f8a27f239..9e4f8d06e2778 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3608,6 +3608,8 @@ DECLARE_PCI_FIXUP_FINAL(0x1814, 0x0601, /* Ralink RT2800 802.11n PCI */
 			quirk_broken_intx_masking);
 DECLARE_PCI_FIXUP_FINAL(0x1b7c, 0x0004, /* Ceton InfiniTV4 */
 			quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CREATIVE, PCI_DEVICE_ID_CREATIVE_20K2,
+			quirk_broken_intx_masking);
 
 /*
  * Realtek RTL8169 PCI Gigabit Ethernet Controller (rev 10)
-- 
2.43.0


