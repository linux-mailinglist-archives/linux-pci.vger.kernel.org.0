Return-Path: <linux-pci+bounces-34049-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 499EDB26ADA
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 17:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 452CC9E5694
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 15:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024F021ABA4;
	Thu, 14 Aug 2025 15:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1fosMzD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD58420B803;
	Thu, 14 Aug 2025 15:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755184913; cv=none; b=ZLmMpwcUg5QqeziWWEVO4HIEphJ94SuIlMuA2FlGkcOektfZzNQE2/tfXllB2yjdNeDUIOFoQGG0J9/Zr9LYM9oO4ir/FSG8im3yNR7PKea6XKbE3GU9RYb5ly/as9aCU8nzpG5Da04ZmzTJ9E4p6ugqqHVWJkYnK/wLK5NE33U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755184913; c=relaxed/simple;
	bh=cOPUDHAum6ClxWVzuME4qsm8OMqT3raM1UE0YZXV+FM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t/2YlH0XALQCj4ZDbhlftwhg4raf4nxNSLkR0zsCUkcm14tJV9ySd6hWP3OOnqHHS3OpdkiX+ENNSltuWmsHvFS+F6IOIxzik7yWXt2fyZipV0DW48BhEjdlebc8PhbGIQAqZpSZ01aPOE3Rs36JNnikreC02K1tAzuViHkXbmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1fosMzD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A03CC4CEED;
	Thu, 14 Aug 2025 15:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755184913;
	bh=cOPUDHAum6ClxWVzuME4qsm8OMqT3raM1UE0YZXV+FM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n1fosMzDOHFAm7Tro5nrlCvwMq/Fc3dF+IljdQSjWpOefnq0XHQ4UdpB1kl2YlnCS
	 TnIUj42xXPnYLUxE+ebIj2+EJmnGwxU05Fal+5E+tjE/6NwVX0xHsOsSzoWv+DXsSR
	 1X/iqnvqitJWW2E/4mJs07ZhWsDSUZf25l+j+4ry6ZWhFri7YbTUW6gJa+WtiwY7U+
	 IXmE3QXpAVLdJAn8HlC5HmFC5q9N842X0ENJjnV2uepV9+YsNp1/eIztJVCyP0ILKZ
	 kJRrrm1n+j8OYzlsCw1g4cOzeY9cYa4rBif40JKgOyfWafBtY5aglk44K2soNDT/2o
	 wMTepbW8H5V4A==
From: Niklas Cassel <cassel@kernel.org>
To: Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH 02/13] PCI: rcar-ep: Drop superfluous pci_epc_features initialization
Date: Thu, 14 Aug 2025 17:21:21 +0200
Message-ID: <20250814152119.1562063-17-cassel@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814152119.1562063-15-cassel@kernel.org>
References: <20250814152119.1562063-15-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=912; i=cassel@kernel.org; h=from:subject; bh=cOPUDHAum6ClxWVzuME4qsm8OMqT3raM1UE0YZXV+FM=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDLm/vu638ZCTqntmLRPdC7fgUUq838+/u671DPtq5Wvy FKmIxYLOkpZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjAR6wyGf/oTTgRVHEu9UON9 03D6RWb1r8eLbCXZb5lXe65h6P6b+IORobXvzSw+/QkXVdRE6r+FmzktOh7Dy/gpqSe/03WiX9J 7XgA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

struct pci_epc_features has static storage duration, so all struct members
are zero initialized implicitly. Thus, remove explicit zero initialization
of struct members.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/pcie-rcar-ep.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar-ep.c b/drivers/pci/controller/pcie-rcar-ep.c
index a8a966844cf3..657875ef4657 100644
--- a/drivers/pci/controller/pcie-rcar-ep.c
+++ b/drivers/pci/controller/pcie-rcar-ep.c
@@ -436,9 +436,7 @@ static void rcar_pcie_ep_stop(struct pci_epc *epc)
 }
 
 static const struct pci_epc_features rcar_pcie_epc_features = {
-	.linkup_notifier = false,
 	.msi_capable = true,
-	.msix_capable = false,
 	/* use 64-bit BARs so mark BAR[1,3,5] as reserved */
 	.bar[BAR_0] = { .type = BAR_FIXED, .fixed_size = 128,
 			.only_64bit = true, },
-- 
2.50.1


