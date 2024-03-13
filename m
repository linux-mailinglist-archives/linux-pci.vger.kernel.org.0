Return-Path: <linux-pci+bounces-4783-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1F087A64F
	for <lists+linux-pci@lfdr.de>; Wed, 13 Mar 2024 11:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9165282E70
	for <lists+linux-pci@lfdr.de>; Wed, 13 Mar 2024 10:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED90F3D552;
	Wed, 13 Mar 2024 10:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uq7wGPoy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D5B39867
	for <linux-pci@vger.kernel.org>; Wed, 13 Mar 2024 10:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710327526; cv=none; b=QGBmUemWQhPteXhX1roiDSo3bK38TpEDRD/8hmZlCFKLj+lQQyfa+0imMi/pGUbDtAMVo4sUB1btrcAs9ybopvOiyEdW5dtfEkVPBn9GF5Zec9zXNTTNvXIw+7DROJmRB1m6g+wcuikBVQW6uUlNpU7U993Fg8B529nN0XK0dNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710327526; c=relaxed/simple;
	bh=zBUxZx9SQIn/bGrmtUc2kf8i/Kt0fwEJho9Hy745O9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BbZ3QrXJcB9wHzIRqHClYxFZMuXmZuBF4OZqQtlvi3j+YQUBUdGzlUtMjwlkzc34NXvbg5AZyYtYUHLNbwh0CTIEIHVl4b8j87vdp8C+PKiCcf80tGZXt5KVoJ+QvTh6oxBiZBidYwWFAGgV6S1MpU0lFqP/Vg8+emQ5QfgskiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uq7wGPoy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C8BC433F1;
	Wed, 13 Mar 2024 10:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710327526;
	bh=zBUxZx9SQIn/bGrmtUc2kf8i/Kt0fwEJho9Hy745O9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uq7wGPoyCC0E7ZIE3jK6p1Ly+SlPr4602efaen77BKkKCQfPV6SkSS9WKT/nMqnqq
	 /sTQ7No/NgWe5pn1Ez5pQCe8oT+GokRFHekxMQQQTMqPHcn8rXlfH1+Ibi+jYiZiQf
	 KRdaL73nRBb21fY8/17MrxO9BWNtJAAnp8hxUup75bn/dT8FbKEmf0ob5L46S8ihVV
	 zdgqMrI4XjawlDh4m/CTZBwHMD+EbRXs68OfnO4lpTgzlBsOmWHsrkk0VDcSktmPN4
	 X8odhfp6680P5Za6tDhuen3z21phsuWGGhx8e0bHpwSG0hlvgM36xBqLAcvOWHtKFw
	 +DK9+3MTjuDBw==
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
Subject: [PATCH v3 9/9] PCI: endpoint: Set prefetch when allocating memory for 64-bit BARs
Date: Wed, 13 Mar 2024 11:58:01 +0100
Message-ID: <20240313105804.100168-10-cassel@kernel.org>
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

From the PCIe 6.0 base spec:
"Generally only 64-bit BARs are good candidates, since only Legacy
Endpoints are permitted to set the Prefetchable bit in 32-bit BARs,
and most scalable platforms map all 32-bit Memory BARs into
non-prefetchable Memory Space regardless of the Prefetchable bit value."

"For a PCI Express Endpoint, 64-bit addressing must be supported for all
BARs that have the Prefetchable bit Set. 32-bit addressing is permitted
for all BARs that do not have the Prefetchable bit Set."

"Any device that has a range that behaves like normal memory should mark
the range as prefetchable. A linear frame buffer in a graphics device is
an example of a range that should be marked prefetchable."

The PCIe spec tells us that we should have the prefetchable bit set for
64-bit BARs backed by "normal memory". The backing memory that we allocate
for a 64-bit BAR using pci_epf_alloc_space() (which calls
dma_alloc_coherent()) is obviously "normal memory".

Thus, set the prefetchable bit when allocating backing memory for a 64-bit
BAR.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/endpoint/pci-epf-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index e7dbbeb1f0de..20d2bde0747c 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -309,6 +309,9 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 	else
 		epf_bar[bar].flags |= PCI_BASE_ADDRESS_MEM_TYPE_32;
 
+	if (epf_bar[bar].flags & PCI_BASE_ADDRESS_MEM_TYPE_64)
+		epf_bar[bar].flags |= PCI_BASE_ADDRESS_MEM_PREFETCH;
+
 	return space;
 }
 EXPORT_SYMBOL_GPL(pci_epf_alloc_space);
-- 
2.44.0


