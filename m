Return-Path: <linux-pci+bounces-4751-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1533F879276
	for <lists+linux-pci@lfdr.de>; Tue, 12 Mar 2024 11:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4652B1C22104
	for <lists+linux-pci@lfdr.de>; Tue, 12 Mar 2024 10:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20EB78662;
	Tue, 12 Mar 2024 10:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="heMEk8x+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCDD69D19
	for <linux-pci@vger.kernel.org>; Tue, 12 Mar 2024 10:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710240749; cv=none; b=PLiEXSyNHAUd8Bn62ZxZI+5RwYghFcN72DtpGXrLnZ2m4wIrKM0tieg15LIxS7xkRfAcoPCjeVjmLwZm2XMPgIsy+8rVUoyuKx9r5LzZDtfRf92vnclSf7wyxzprhOh2nT/8bGL4JQzHhZu0XIsHEPcvnKye1yyEOhn6koFZpWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710240749; c=relaxed/simple;
	bh=FRR3ONvC1dTDtzKK4rr212hrCcCfCZS60W/bKB4hdjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EG5agNgtYJ6mcOava+Hu4+ipnWpMTu+4T0IX4IcZSnLeGE9nIyX73ITvtzqFZoZpfz70637RjakHTFuYQyuv0HLl/sO0lpO35vmyk6+5Plc3dSJwJ3GqzVL6h/FyCPHDadVoYbuLHNE4PBzapbtd6y3cFO7npst4/YSZStlEjto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=heMEk8x+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14CEFC43394;
	Tue, 12 Mar 2024 10:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710240749;
	bh=FRR3ONvC1dTDtzKK4rr212hrCcCfCZS60W/bKB4hdjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=heMEk8x+GdHa1asvZzZAGoBX9mvUQUkazS5POCefykPY7Fu3JDAZQQg62EZAJCcCO
	 JsMerhgGhKocH53CbLLCn/tBVUUhgPECNtr1rrs98bSkJeHWcTqX49JUWYLLeZ8RzB
	 uC8DfNNKf59dr+2q5xuSxdo4j18Vfccx/5PBc9YFTMoOkdOa/ytTgbcUwxqOhTN/G2
	 txU0RoAKqI5VEsY4230BWvZCO80QconzfYPxQI3IDZ+UcCCv8CTrRp3XdwfcsuVAm4
	 yRnzwgsAO6+Sfb9IYtq792arP9ANHQvSFnyOJI7HBG/3uXmrBej7tKp51hD1aqqb9W
	 bPQlyVRM3LANQ==
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
Subject: [PATCH v2 1/9] PCI: endpoint: pci-epf-test: Fix incorrect loop increment
Date: Tue, 12 Mar 2024 11:51:41 +0100
Message-ID: <20240312105152.3457899-2-cassel@kernel.org>
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

pci_epf_test_alloc_space() currently skips the BAR succeeding a 64-bit BAR
if the 64-bit flag is set, before calling pci_epf_alloc_space().

However, pci_epf_alloc_space() will set the 64-bit flag if we request an
allocation of 4 GB or larger, even if it wasn't set before the allocation.

Thus, we need to check the flag also after pci_epf_alloc_space().

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index cd4ffb39dcdc..01ba088849cc 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -865,6 +865,12 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 			dev_err(dev, "Failed to allocate space for BAR%d\n",
 				bar);
 		epf_test->reg[bar] = base;
+
+		/*
+		 * pci_epf_alloc_space() might have given us a 64-bit BAR,
+		 * if we requested a size larger than 4 GB.
+		 */
+		add = (epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64) ? 2 : 1;
 	}
 
 	return 0;
-- 
2.44.0


