Return-Path: <linux-pci+bounces-20608-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D92A242A4
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2025 19:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8061418895F2
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2025 18:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500801F1920;
	Fri, 31 Jan 2025 18:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H96lAUHr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B5D4315A
	for <linux-pci@vger.kernel.org>; Fri, 31 Jan 2025 18:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738348237; cv=none; b=DoihIUAwQEFZM7fc5N2LPrV/fMdcYqXIEaX2rC9kegxR4eGLXzV2xp8GgQmPGmWCEzzkUsMM0CIeWW3vxPRgFzj+FbCbg1x7s2zfqMVM0Y3eh/2z6cMSubJ7euLtPgtANAb5Y+lAwH3uKk9XhvZPnW4jhnL9AnLWWVjrinVZzPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738348237; c=relaxed/simple;
	bh=Dgj5VNoE5kVgWc76NDWLLdMQe5eoOJ8Xt5A76OaSvQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c0HrKgE5irgrKTJ30C+nqODTfZN6fZ82xk83nQZNLyWe+GGxLKzbqv4km+womt0KaO7avHALpjUhhVS8tKqj8Yio4V2SoN6IWiE24jeqGZ/dQj7UFiphdex/6BNqtRpCJVv4CwBl3+9zGvj0aB/yeE9B7b/lqH57CZ78DzUVsJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H96lAUHr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1BAFC4CED3;
	Fri, 31 Jan 2025 18:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738348236;
	bh=Dgj5VNoE5kVgWc76NDWLLdMQe5eoOJ8Xt5A76OaSvQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H96lAUHrcl0zDCcAiMi4BEDOCUJosQOK7GMWh16PB14yPPEqX/5Lawm95d3dH+Ral
	 NeUeedwbltFM1WoOz+m2uZJjFA7ghbeXdFXyjJMTQDkvl+2X6MryMUF3cbbY9UJwij
	 9/6x01CXlzO8jZ/zPHGjdzzzILofEgx2NrptPvUtsEBCIxAxCU1rj4YzfY5x9o58E1
	 Chg7TZyhMXRxHjBLuuB2uZjzkVL0I1UkwhJ2z0QfvpTVU/9gE9M0ZnTLJgxTuyXDKN
	 vV5K89CmsxH9DqHIEMkG6hKghpGTU12mhjvOuQqrQPJrQuqnT2KGwjZuOJIcM1AS0b
	 dUZHNUKPwBFuA==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Udit Kumar <u-kumar1@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Niklas Cassel <cassel@kernel.org>,
	stable+noautosel@kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v4 6/7] PCI: keystone: Specify correct alignment requirement
Date: Fri, 31 Jan 2025 19:29:55 +0100
Message-ID: <20250131182949.465530-15-cassel@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250131182949.465530-9-cassel@kernel.org>
References: <20250131182949.465530-9-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1769; i=cassel@kernel.org; h=from:subject; bh=Dgj5VNoE5kVgWc76NDWLLdMQe5eoOJ8Xt5A76OaSvQs=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNLniq22c3ixsjnb+p6sz8HJ56pE9O71mvb1Skup7rSxi mz/8XV2RykLgxgXg6yYIovvD5f9xd3uU44r3rGBmcPKBDKEgYtTACZy9h0jw8zump2GK+69mx8o bTHb+W7OQcUC5nPbg6SvhC+5sMnLYwojw7Fvortvd0g1PDy0cq1k9bkJr5lmxxV92dWgNOPg5Jd TdzEDAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

The support for a specific iATU alignment was added in
commit 2a9a801620ef ("PCI: endpoint: Add support to specify alignment for
buffers allocated to BARs").

This commit specifically mentions both that the alignment by each DWC
based EP driver should match CX_ATU_MIN_REGION_SIZE, and that AM65x
specifically has a 64 KB alignment.

This also matches the CX_ATU_MIN_REGION_SIZE value specified by
"12.2.2.4.7 PCIe Subsystem Address Translation" in the AM65x TRM:
https://www.ti.com/lit/ug/spruid7e/spruid7e.pdf

This higher value, 1 MB, was obviously an ugly hack used to be able to
handle Resizable BARs which have a minimum size of 1 MB.

Now when we actually have support for Resizable BARs, let's configure the
iATU alignment requirement to the actual requirement.
(BARs described as Resizable will still get aligned to 1 MB.)

Cc: stable+noautosel@kernel.org # Depends on PCI endpoint Resizable BARs series
Fixes: 23284ad677a9 ("PCI: keystone: Add support for PCIe EP in AM654x Platforms")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pci-keystone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index fdc610ec7e5e..76a37368ae4f 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -970,7 +970,7 @@ static const struct pci_epc_features ks_pcie_am654_epc_features = {
 	.bar[BAR_3] = { .type = BAR_FIXED, .fixed_size = SZ_64K, },
 	.bar[BAR_4] = { .type = BAR_FIXED, .fixed_size = 256, },
 	.bar[BAR_5] = { .type = BAR_RESIZABLE, },
-	.align = SZ_1M,
+	.align = SZ_64K,
 };
 
 static const struct pci_epc_features*
-- 
2.48.1


