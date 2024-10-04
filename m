Return-Path: <linux-pci+bounces-13862-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 330BE990E99
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 21:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4EE7281271
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 19:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5131DFDB9;
	Fri,  4 Oct 2024 18:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNDmsL8N"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778991DFDB0;
	Fri,  4 Oct 2024 18:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066636; cv=none; b=TSr3JI4FDZ5tgW4eGxXsKv4bNXdiIA56PuA9C0McLQq2RXG2JoMEZ2n25gz4JM/9GsKjZu3wy2kYQS8D93adkTEh5BqonELFC506uuw1p2kG5xCS64An6OQUTdFeP2vhDqw4ttAIwx0+sZEHv163pc8SPfJgSWCD/mQiYUWKhb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066636; c=relaxed/simple;
	bh=pGhMBklSLX6a/duMcuD848w0q/EuxxDj32RH6xll+Y8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OtIGRET9RDCrhmvNllMyO13HzbrDgly12PipDNxQApadpZ39u4JVFRVvwpa4HHLK25JqOd8ZOoTDjCAR9feu9efSRcgm4K5ejdVLZiklYxazE140xRJsbYUMU6UOrc4EMWz7WyKeMuYLZmdSjHl5sVlkNizhotXuC+FQF2xEWFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNDmsL8N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CC61C4CEC6;
	Fri,  4 Oct 2024 18:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066636;
	bh=pGhMBklSLX6a/duMcuD848w0q/EuxxDj32RH6xll+Y8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WNDmsL8NzvJiKMQ9HPZsnlpXHqJoaAaVamCHi5PcxnaefrCmoz/r1PHGoddn+EF+H
	 FJLJ4HhdDlclpwndKTbTh2YKmPUg419qh3jtyu3hwjK5+oMDdDWVUk8PVNGWABfv9X
	 dQrvB+c6supsPjyrlCs9DKiydfT7nt4JJ2at0agGcOJu0uPkS9pEOw/rRouAuOfnLS
	 wHsvHO1YFE3O28yiLJ8+VV3KDRyeiZrMR5iufwKPb0sAt5jmDqOP8VNPJTIhVY4Ao0
	 Iw1TR6NmRGdRbek1w6UK7Cpe8bE5Kugj3alGxw1QrdZxI7RYtVLDw7lq1HmTGoq88C
	 vcyjW+Ep5uWHQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	zdravko delineshev <delineshev@outlook.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 16/26] PCI: Mark Creative Labs EMU20k2 INTx masking as broken
Date: Fri,  4 Oct 2024 14:29:42 -0400
Message-ID: <20241004183005.3675332-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004183005.3675332-1-sashal@kernel.org>
References: <20241004183005.3675332-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.226
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
index f0bbdc72255ed..86b91f8da1caa 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3454,6 +3454,8 @@ DECLARE_PCI_FIXUP_FINAL(0x1814, 0x0601, /* Ralink RT2800 802.11n PCI */
 			quirk_broken_intx_masking);
 DECLARE_PCI_FIXUP_FINAL(0x1b7c, 0x0004, /* Ceton InfiniTV4 */
 			quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CREATIVE, PCI_DEVICE_ID_CREATIVE_20K2,
+			quirk_broken_intx_masking);
 
 /*
  * Realtek RTL8169 PCI Gigabit Ethernet Controller (rev 10)
-- 
2.43.0


