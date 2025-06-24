Return-Path: <linux-pci+bounces-30497-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E760AAE63D1
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 13:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C53E91924D06
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 11:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D67229B36;
	Tue, 24 Jun 2025 11:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZufuYpbw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE4B1EBA09
	for <linux-pci@vger.kernel.org>; Tue, 24 Jun 2025 11:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750765669; cv=none; b=tHnGdRRRWkgrkYHzsZjx9/OSswYLRG/110TL1NsiA68BKxeUYTvunNWkDL2I5C+M6UCgR4xBYgxg/iXG0i9TyqSV108xGmUDZ+n35vUOanmtbSMk0a+AeUZr8V1WSatFng4ur6zMmarcoa+0q60frgeJRYMwtYDlvBL+utUK7hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750765669; c=relaxed/simple;
	bh=RLbKygwtkbUBS2akpHSKfbz4a/LEJz/V1fHALc+SWoY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nUmWotwM84R30zFWk0Z5oTwlcKbcBJ7bLZBV80M2gKC9vmI6z4pPKnU7k5K++LFQG7SkoauRefcRavoZ+bWHZFLuWhUK1/PcEfehSw3ZjtROYh5wUkOepcP7YDuLaBGPOy3iIw73egE28ynDaaKcz8gYoYVJp0hhtvwC+PIhLaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZufuYpbw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E044C4CEE3;
	Tue, 24 Jun 2025 11:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750765669;
	bh=RLbKygwtkbUBS2akpHSKfbz4a/LEJz/V1fHALc+SWoY=;
	h=From:To:Cc:Subject:Date:From;
	b=ZufuYpbwKrIGke5Qe4zpXVNv+Arh3twzQlYwraZohWrkKeMDqRSgSqa6r3AUELDTR
	 bIGQp1riRjdmdm4D8EB3u/1v3reiY9X+PjQX+3rqSlA0rbw92wQsAo0DUdDTNMFyDI
	 a1Ip3ZjmxfbLEFbHVgfOghxKkK7j/7yb9Zs+J91DTl667fYWXKrJAmRoTjZzsk2eg1
	 T5Q6NIBmfiJOpACiduV6vPMjfsdZUF3OqvP8tuclAiw2ZMVpwv+vkMvuCp0HBE0T3c
	 SmG+SXwgkkez8tmVYidMrVYtMDAmZrICINIacGKf9oa+0RMaZ1Qbt5UaT7f+767tJy
	 Shb2SbR8wZ1FA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v3 0/2] Fix EPF configfs attribute group removal
Date: Tue, 24 Jun 2025 20:45:42 +0900
Message-ID: <20250624114544.342159-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A couple of patches to fix removal of configfs attribute groups of a PCI
endpoint function driver.

Changes from v2:
 - Use list_del() instead of list_del_init() in patch 2
 - Added Niklas' review tags

Changes from v1:
 - Split out patch 1 from patch 2 as requested by Niklas.

Damien Le Moal (2):
  PCI: endpoint: Fix configfs group list head handling
  PCI: endpoint: Fix configfs group removal on driver teardown

 drivers/pci/endpoint/pci-ep-cfs.c   | 1 +
 drivers/pci/endpoint/pci-epf-core.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.49.0


