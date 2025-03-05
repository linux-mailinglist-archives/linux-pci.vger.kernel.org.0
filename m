Return-Path: <linux-pci+bounces-22955-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CAAA4F851
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 08:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0FE63A6BAD
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 07:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5CF1F153A;
	Wed,  5 Mar 2025 07:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGT1bbZP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355591EC00B;
	Wed,  5 Mar 2025 07:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741161252; cv=none; b=bEIicvs+bUMdnpWBtFWFFzl6t+yaCfn355NQquDmDRYgurbzj0D11rNGIKWHdQVanGQHEg+EKJMySjBZYn4PEKwz8sx1Kh4F4ePWzml2BCzVo5kdTd0YSYYUUR+0jtQLQIw8cz3nxqSCjYAkKe/ZsRBDNW/k22A2brhAdVwilrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741161252; c=relaxed/simple;
	bh=W8jDnO3VInSEaJW68j1TJXMhPIXhOgkbyfJZWVPYzRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AUaN3qa8nlLOL6Mtv44+vhwNe5/2UtjOK+ML/jxHgszkOKdR4jSRARGPONT88pj9FbSqEs8WTmff6SvsqQl9RjdVQFyKVdg1EdZh3QmjGwkmbzkl/roL6IViwXYaK/+rZUqau04rVCBICUfNvwyAOI/3kE1ioiDLke3ly/TH2Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGT1bbZP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B7BEC4CEE2;
	Wed,  5 Mar 2025 07:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741161251;
	bh=W8jDnO3VInSEaJW68j1TJXMhPIXhOgkbyfJZWVPYzRQ=;
	h=From:To:Cc:Subject:Date:From;
	b=TGT1bbZPCOE6/L8mIjhYWh+l3lZEiXqBuy4dgW3gV6zhATo5JR8PnWWchLQrpYRze
	 tH0oIH4onCgnW0Sr235a4bktbHeXrGIIrcYzUfMWzxYwsEC1JKFjSQwstbLdjQ2SZz
	 0+B1Nop/bNNMG+sgtzYb2r1apeiWBOtQVKkNEE/U9S4VcHXC7ifwIs2cUJqm9y6FL7
	 BoHj3gbNfkDKIDfDdJfXtSgH/kwvaAjYkSdUFT0vPbMeVeUX3D9C6CEJdZQ9xa0LEv
	 jfC0Ex04KIBxGiV9Q51YhZhtccdbHFFEtRTQHilVlesFUd3iUMXK839Id+dbtIGDOM
	 TD1e8qH2vaezg==
From: Philipp Stanner <phasta@kernel.org>
To: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <phasta@kernel.org>
Subject: [PATCH] PCI: Follow-up fix for BAR hardening
Date: Wed,  5 Mar 2025 08:53:55 +0100
Message-ID: <20250305075354.118331-2-phasta@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes a bug where variables were used before being initialized.

To be squashed into commit "PCI: Check BAR index for validity"

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
Fix for this already applied patch:
https://lore.kernel.org/all/20250304143112.104190-2-phasta@kernel.org/
---
 drivers/pci/iomap.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/iomap.c b/drivers/pci/iomap.c
index 0cab82cbcc99..fe706ed946df 100644
--- a/drivers/pci/iomap.c
+++ b/drivers/pci/iomap.c
@@ -40,13 +40,14 @@ void __iomem *pci_iomap_range(struct pci_dev *dev,
 
 	if (!pci_bar_index_is_valid(bar))
 		return NULL;
-	if (len <= offset || !start)
-		return NULL;
 
 	start = pci_resource_start(dev, bar);
 	len = pci_resource_len(dev, bar);
 	flags = pci_resource_flags(dev, bar);
 
+	if (len <= offset || !start)
+		return NULL;
+
 	len -= offset;
 	start += offset;
 	if (maxlen && len > maxlen)
@@ -90,13 +91,13 @@ void __iomem *pci_iomap_wc_range(struct pci_dev *dev,
 
 	if (!pci_bar_index_is_valid(bar))
 		return NULL;
-	if (len <= offset || !start)
-		return NULL;
 
 	start = pci_resource_start(dev, bar);
 	len = pci_resource_len(dev, bar);
 	flags = pci_resource_flags(dev, bar);
 
+	if (len <= offset || !start)
+		return NULL;
 	if (flags & IORESOURCE_IO)
 		return NULL;
 
-- 
2.48.1


