Return-Path: <linux-pci+bounces-34048-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C102B26ADE
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 17:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30D8E1C82818
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 15:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F163221555;
	Thu, 14 Aug 2025 15:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZyl/UlJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF12A221287
	for <linux-pci@vger.kernel.org>; Thu, 14 Aug 2025 15:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755184911; cv=none; b=JyPv/YeK9AyTj7qTGx1XYd7/dt9ZZtZQsB7/yYrwiL38qEJYbpilF4z1auWEy3+Y41UtQx9WqH3ZWl0Qi7zFp7xbjgfB6dNp6ua27vjJHz4bipe34Yi/LVKjDImc1ERAbWEfV/US3Rkj+JWfjUuBmcnW1Lgwlx0fcDc4bbUE2W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755184911; c=relaxed/simple;
	bh=Al6LONgGSCTE20wCX6zqwQXCV2MCZzX0ZDbyS/3xXQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AIPD1Q0PCzgdaMYOf7YoCbxPS0KG0d78Fm/EQYYOJxwM8XIg2QbcA0QlRSpxVrHWnPxqbNFIPjHAF1i5IRonEDC37IAg2u2t9PY7j9eb4FoqHJzU5o43e08/1iqBIFWD+wXa4hEx+rM9zGZNQhjQbE5/iamEv0na+iStut0cuPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZyl/UlJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D43BDC4CEED;
	Thu, 14 Aug 2025 15:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755184910;
	bh=Al6LONgGSCTE20wCX6zqwQXCV2MCZzX0ZDbyS/3xXQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WZyl/UlJ7uh/L7X0tPBL6u3v+CyDiRbM3OVcWNJlynN58K6+xJDRTqMvOIPl4gnWT
	 Wf34Jz1tu34T9gJepsCo7mCUZ+zwdQRt213V/lvf/V35/FS7n3iCdZ3nqoeobHijhu
	 h5L5a4NX6558ihZqAE0dWpDSjgBKXhz2GgzOJc6jFmxK9hMu79zN2/yLAsV/pIy046
	 qKuHeW7pJew3CwqqYWgeutbKep2WBdsLKM0pCeyUdZ20/b8wpsPphsTPnS5qHMXTvT
	 lQdP/XT6n5sJ1YaYjnXPa99v9KR5wZ1ESbN5x/69DU2TJNVbzAtzTMJO/Z4EBQkhsR
	 6WpVxf833WqZw==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH 01/13] PCI: cadence-ep: Drop superfluous pci_epc_features initialization
Date: Thu, 14 Aug 2025 17:21:20 +0200
Message-ID: <20250814152119.1562063-16-cassel@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814152119.1562063-15-cassel@kernel.org>
References: <20250814152119.1562063-15-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1018; i=cassel@kernel.org; h=from:subject; bh=Al6LONgGSCTE20wCX6zqwQXCV2MCZzX0ZDbyS/3xXQw=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDLm/vua+OTxLpvbKpWVmX1z92uZstSvuBD6yvPzV7Vnb I9lm0+e6yhlYRDjYpAVU2Tx/eGyv7jbfcpxxTs2MHNYmUCGMHBxCsBEuoIZ/qkfCr51J1dppp2Y ZcbjDZvOHw2Kczpha/92ZvOPnP4VV68z/JW99XPuc+Nfc6WLo3/M28bxb8r0J2e/C8/5bvSJa6W kRC8TAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

struct pci_epc_features has static storage duration, so all struct members
are zero initialized implicitly. Thus, remove explicit zero initialization
of struct members.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/cadence/pcie-cadence-ep.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index 77c5a19b2ab1..f3565164f142 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -608,14 +608,12 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
 }
 
 static const struct pci_epc_features cdns_pcie_epc_vf_features = {
-	.linkup_notifier = false,
 	.msi_capable = true,
 	.msix_capable = true,
 	.align = 65536,
 };
 
 static const struct pci_epc_features cdns_pcie_epc_features = {
-	.linkup_notifier = false,
 	.msi_capable = true,
 	.msix_capable = true,
 	.align = 256,
-- 
2.50.1


