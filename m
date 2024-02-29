Return-Path: <linux-pci+bounces-4240-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD8986C748
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 11:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9E60B21063
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 10:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C0A65194;
	Thu, 29 Feb 2024 10:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="upJ5fMwu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D19657AF
	for <linux-pci@vger.kernel.org>; Thu, 29 Feb 2024 10:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709203767; cv=none; b=YvdndIvXjMjJVxeRnOtFsdDEZpMSKoLL2aAJOZYPwyULbd+mkvYbOPnyIZpky9KSsJl3wg5AYguFhPyS3JmyOGNdLICExMesFc76Hj9P99jWPb/uk4EswlUgnE5bwDWwEw7ysVH8o8IVe2GBGRqkQosqitK/12yt7LuGLGVqxb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709203767; c=relaxed/simple;
	bh=q7/juh58Ish9tN+cyfUjNXSuZK6Dq95jqNb6zEzMQTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L8eFZE/LZ1mYA7rVX1y1WwMWEqp1S1PimyeIQg2p9b8KMJdQW/tjRbK+xHHyombwluyeP4ajvKZHFzFOnpwf48cwMefYpO+5+aZzKKVyOMZoPrJEuaAW7LJTnYbidziysiXCXlnOQNM1+/EpoEoEn4Pb+NfA7pnwXK81exNYU2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=upJ5fMwu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37EB1C433F1;
	Thu, 29 Feb 2024 10:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709203767;
	bh=q7/juh58Ish9tN+cyfUjNXSuZK6Dq95jqNb6zEzMQTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=upJ5fMwuG6zs2FPP5/fbjSh370+MA0TJ+d8Gz3vzkIgyb6MQ1aZhgXjEN3pr1lnbH
	 Sgn6J9ZJ2735smWUUlyJ8EuODqE9RS1krQksxse6w+Tbkh3Ne3kvcmXgJyRwF4D/H7
	 KylJa5n58rS+DUHbn9tlyR8emR+ifq3L03dB3j+1pS8LzRGeW7N6CL9YqgcNyoZjhC
	 0XIxBRXaQ1Y1jSb9k1E+kcZ/VU8Nk7RwF3Tx/W00L0b2sspQk4wv6RrzNKj4FzHd8K
	 hwnj+UUmN+6/uUzFullhjF/1goa2jZGlDdmet1HbYgthzbjmiwTI3vygfaIKczTePL
	 WbBIMJOinAtFg==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Shradha Todi <shradha.t@samsung.com>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH 2/2] PCI: endpoint: Set prefetch when allocating memory for 64-bit BARs
Date: Thu, 29 Feb 2024 11:48:59 +0100
Message-ID: <20240229104900.894695-3-cassel@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240229104900.894695-1-cassel@kernel.org>
References: <20240229104900.894695-1-cassel@kernel.org>
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
 drivers/pci/endpoint/pci-epf-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index e7dbbeb1f0de..10264d662abf 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -305,7 +305,8 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 	epf_bar[bar].size = size;
 	epf_bar[bar].barno = bar;
 	if (upper_32_bits(size) || epc_features->bar[bar].only_64bit)
-		epf_bar[bar].flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
+		epf_bar[bar].flags |= PCI_BASE_ADDRESS_MEM_TYPE_64 |
+				      PCI_BASE_ADDRESS_MEM_PREFETCH;
 	else
 		epf_bar[bar].flags |= PCI_BASE_ADDRESS_MEM_TYPE_32;
 
-- 
2.44.0


