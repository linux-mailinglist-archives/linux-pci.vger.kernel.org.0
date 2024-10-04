Return-Path: <linux-pci+bounces-13865-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F0B990EE4
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 21:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9670E1C21E5A
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 19:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2454D1E32A1;
	Fri,  4 Oct 2024 18:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICW+R78W"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8831E0DB2;
	Fri,  4 Oct 2024 18:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066690; cv=none; b=L3AB5x98uktI5QiWgzrQpzqzC+8bfyNIdYNv3zpAqrSZVonV3nzYywQtD0LM/SAR8BUFWZx/sV/Y90C0bjfVSsps2mtfHsB8XwGBPEZ+bDi7yJ6twWYfd0M/xGdxhFDGOVULgtt8ibmTEZrxDX+kdrcM7a7SmfCAEqYPDFRphbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066690; c=relaxed/simple;
	bh=4WUDydnIDbvuuK8gMPJhvD8Aya+zx/g+TATOtPjyIYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G+gffgTBtaivsQoA1/1uUzyHv1mDIVX2DlRCeQ4VqAVUkYEb7enM+ePD2QJpaxl9l0YLWIWZbkBhdCV6irPoJQ9sxx+F4Wr7BwW3Qx1/D/aU3JmK3U0bivsdld/6zlL9kPwPglsCmNEpRU/AvSaP+dWuk5W3C5tLpg3Vct3G71o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICW+R78W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D12AC4CEC6;
	Fri,  4 Oct 2024 18:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066689;
	bh=4WUDydnIDbvuuK8gMPJhvD8Aya+zx/g+TATOtPjyIYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ICW+R78W3fIxkBxMTaPvzvhGtuJIfLUrbv88BTWXw57XGvKzLUaWf6Vt2DVqy3kHm
	 mCIvjnpw5zWEAj6HK72T6pziUTOhM05hFwhinCoM9doyEwdOdfrX5XTWIxKbt03fkN
	 5BVxH44iIe6tNBbx+pieOKS8PXlYDGSih13yXPljR6foflJBIW4fZcIEfj3Jrie9Ql
	 EV/KeFiFmIqIOJGUlGcYFANhp8EXL+PUHm5P25CXo9SlGcE1EuQC1W0ZOx2Y+6iMLP
	 2JCuuwER82WwYvvEyNbnmciJim+2moE7YDOQhmTnhmOqZ5OZMychLMqJBWHOw/iolc
	 f7nGWHui2k5Dw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	zdravko delineshev <delineshev@outlook.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 13/21] PCI: Mark Creative Labs EMU20k2 INTx masking as broken
Date: Fri,  4 Oct 2024 14:30:48 -0400
Message-ID: <20241004183105.3675901-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004183105.3675901-1-sashal@kernel.org>
References: <20241004183105.3675901-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.284
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
index 1e846b62feba5..805200feaec82 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3441,6 +3441,8 @@ DECLARE_PCI_FIXUP_FINAL(0x1814, 0x0601, /* Ralink RT2800 802.11n PCI */
 			quirk_broken_intx_masking);
 DECLARE_PCI_FIXUP_FINAL(0x1b7c, 0x0004, /* Ceton InfiniTV4 */
 			quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CREATIVE, PCI_DEVICE_ID_CREATIVE_20K2,
+			quirk_broken_intx_masking);
 
 /*
  * Realtek RTL8169 PCI Gigabit Ethernet Controller (rev 10)
-- 
2.43.0


