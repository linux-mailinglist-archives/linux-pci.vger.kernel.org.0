Return-Path: <linux-pci+bounces-4776-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C0A87A63D
	for <lists+linux-pci@lfdr.de>; Wed, 13 Mar 2024 11:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80E111F22373
	for <lists+linux-pci@lfdr.de>; Wed, 13 Mar 2024 10:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3B13D38F;
	Wed, 13 Mar 2024 10:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iE+jIP8x"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8263B798
	for <linux-pci@vger.kernel.org>; Wed, 13 Mar 2024 10:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710327507; cv=none; b=ZDZrAf165PNegMmbwM0zS6zJdS6n/Skxc0Qs0rcxJtsCNoWSNHC6R8kuwBro45wwjhEMUOF1hJyJJAoBkVzD/fFoyCkSzJaAvIT8IbsPQPXcW0JmsrOTEZNBgymwxHOpWdl6iMt4gkxU+d1+UpVv5Kt0+WjKILXBZEgHvBjOsww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710327507; c=relaxed/simple;
	bh=+5dCeZi10/u3RMlvjT4oH8IBPzU4bcYd+CsEmIgXsME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n2WoQwgRisGOEa5kUMCyQubBg5T/UMTraoDQ5Z2dtmwphxhCTYW855MLsvIM9Yc72gC4TnNX6nhLp/5PHlJ4tGMrj1IjxGHYCTeB/4vkEg5MTrqxKsW11quBQJnSHAKhgAZ7X97pAoTeZargshagUmUqxF/b8mZLT3tVDR7G7hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iE+jIP8x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD834C43394;
	Wed, 13 Mar 2024 10:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710327506;
	bh=+5dCeZi10/u3RMlvjT4oH8IBPzU4bcYd+CsEmIgXsME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iE+jIP8x5HwLMf541YDHUs/osZ5PUTPOTU7GUPYUNAU/Gyb0R2ERGcbw3xpPRFLRj
	 5PF2K+ez0/QIvXpGjpUXCHmSuTEq2Z4ywfw/qdph//Q39F3jjBP/1Hyyjb/SEY4ObO
	 ZUhDLngfoNjLgYyVY+YZCwssNuDqAKp5llpl9cWOE4lovKQcfAPefU4Rrb2PzYdLAd
	 J3W9vo8m4/DUZ9AvTOLDdoO6lIFUCJpcUZOVjRlqkJIhba/0HoJsYtsdWA3rn5Kjyp
	 2Vw3cq23FqcrKon48HC49wxGQTNJ2p97sQGFg1ZYdzJp+VIQh0f5C0p4+06aoVmzjz
	 PGqhoJKhQldYQ==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Shradha Todi <shradha.t@samsung.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH v3 2/9] PCI: endpoint: Allocate a 64-bit BAR if that is the only option
Date: Wed, 13 Mar 2024 11:57:54 +0100
Message-ID: <20240313105804.100168-3-cassel@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240313105804.100168-1-cassel@kernel.org>
References: <20240313105804.100168-1-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pci_epf_alloc_space() already sets the 64-bit flag if the BAR size is
larger than 4GB, even if the caller did not explicitly request a 64-bit
BAR.

Thus, let pci_epf_alloc_space() also set the 64-bit flag if the hardware
description says that the specific BAR can only be 64-bit.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 3 ++-
 drivers/pci/endpoint/pci-epf-core.c           | 7 ++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 01ba088849cc..8c9802b9b835 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -868,7 +868,8 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 
 		/*
 		 * pci_epf_alloc_space() might have given us a 64-bit BAR,
-		 * if we requested a size larger than 4 GB.
+		 * either because the BAR can only be a 64-bit BAR, or if
+		 * we requested a size larger than 4 GB.
 		 */
 		add = (epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64) ? 2 : 1;
 	}
diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 0a28a0b0911b..e7dbbeb1f0de 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -304,9 +304,10 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 	epf_bar[bar].addr = space;
 	epf_bar[bar].size = size;
 	epf_bar[bar].barno = bar;
-	epf_bar[bar].flags |= upper_32_bits(size) ?
-				PCI_BASE_ADDRESS_MEM_TYPE_64 :
-				PCI_BASE_ADDRESS_MEM_TYPE_32;
+	if (upper_32_bits(size) || epc_features->bar[bar].only_64bit)
+		epf_bar[bar].flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
+	else
+		epf_bar[bar].flags |= PCI_BASE_ADDRESS_MEM_TYPE_32;
 
 	return space;
 }
-- 
2.44.0


