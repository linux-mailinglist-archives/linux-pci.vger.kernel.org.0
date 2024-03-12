Return-Path: <linux-pci+bounces-4752-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 599AD879278
	for <lists+linux-pci@lfdr.de>; Tue, 12 Mar 2024 11:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1FA2B23D21
	for <lists+linux-pci@lfdr.de>; Tue, 12 Mar 2024 10:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3597A78662;
	Tue, 12 Mar 2024 10:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMmjwdiu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE1A78292
	for <linux-pci@vger.kernel.org>; Tue, 12 Mar 2024 10:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710240752; cv=none; b=CdnbJF7cYC3MchXfHNZRWPG870MkQESAAdSRqSiX43ujs6XTtE2AwhdReOVAXTsBYUIPyA7NIRM8SCLLjIdOv4BfobvP5gDI5UBm46mGTkwsNE7h3+aGQrTiDu3pr1x3a8cvBY4MKSTBdmGlGWtstz96zHMKxD2d7miGSMcfmjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710240752; c=relaxed/simple;
	bh=+5dCeZi10/u3RMlvjT4oH8IBPzU4bcYd+CsEmIgXsME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fFucZTxEnAewTHZxoCj0CkUgCuMKZaGmNf2c+0QWgjE1+VlWOZCVL4CNwgKmoiUzI6CVMYgCZibdZLjAMTWfxf1rvaW9LBt3r6oGH7aVHxa+00Nyt7h7OwioV37OJdhxz28vWyclXGI506TyTYcUhBi9f8elxPILF1WRc4tT+Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMmjwdiu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69E7C43390;
	Tue, 12 Mar 2024 10:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710240751;
	bh=+5dCeZi10/u3RMlvjT4oH8IBPzU4bcYd+CsEmIgXsME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oMmjwdiulXfNKuGy87L81k+OLhk5IxuypqfMJaHpqa1voG1Rvtus+BMgyR+Y4G5ij
	 fFYmrAswW0873Z7cZXVyHkalLjzN9AKzWAqukDNNnppsvXzzkdmHvTbY4cF+v/1xA1
	 l6s4kVYjsggZV7FqtOI3mN3ERx8Ze/14x5jOas0rjLFamMHYk1cJV5bjd27QqjycFF
	 bfsFBoOKV5ds7WNUhtqevkNsZISAARITiZD445j4eVVmD6SXsxJXtbNwGJGEQKI7GZ
	 GUHbf65C826U7m8fsN4y2R4ku0fwNkcI3RekIFqyOfUNUXWHBU6UKwbspchyoDYYUl
	 vCP+V5DXS77Ww==
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
Subject: [PATCH v2 2/9] PCI: endpoint: Allocate a 64-bit BAR if that is the only option
Date: Tue, 12 Mar 2024 11:51:42 +0100
Message-ID: <20240312105152.3457899-3-cassel@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240312105152.3457899-1-cassel@kernel.org>
References: <20240312105152.3457899-1-cassel@kernel.org>
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


