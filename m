Return-Path: <linux-pci+bounces-23308-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16508A59254
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 12:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 540EC16B44F
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 11:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416C2227567;
	Mon, 10 Mar 2025 11:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIbcXKTu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB64226CF3
	for <linux-pci@vger.kernel.org>; Mon, 10 Mar 2025 11:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741605059; cv=none; b=Cgx9SsOnPWW24msLD91KvHMnaIlyaZ2zhSKK8Hu0ANl4RDDficRnSvxH1VikJZFXMzDpXEpd1RLIoEzfsbkVliJ3P2SFrYJwuWeVucBSmOh6mN3LngTa80P/6SJDFlo4dQStGfdRIbxzy3Kw9PD4SBO0BNnDsFbu3AHtH7wSSW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741605059; c=relaxed/simple;
	bh=QqHlb9amokoslycep2GrTaleec2IM9DCX/kxSCszE8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QP+T1Gh7Xsqksy2iD9tvk/CExrkOgCFK9LEJX1bzEOlLokRvIpIR9pxxTppvALdOfJnO+fF7FztvTgkHcib2S1YHW1bNExTg+4ueMBwu2QnL6lxxQcJ/9ihyMZgqJVJPlEu8qyvxeLi5fEmmiVn0yDp6MCH/UfweoEEKQU5Ioq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIbcXKTu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49107C4CEEF;
	Mon, 10 Mar 2025 11:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741605059;
	bh=QqHlb9amokoslycep2GrTaleec2IM9DCX/kxSCszE8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EIbcXKTuyd8QdqDegRa7wXBLn7NJy8n/ZZe4XlNO16m90E22X6rbg9hLRoFn+6Z4F
	 XYag2qXQyVFRdmjTzkQkTGRQ7KWF+ougoXexfqSHy4Y/9+O3AAXW3mzDUcwEEwV3bA
	 Uc8qxvTminmgSBbIKvA1yhnhz/4p+uDiGwdllIM+vSYqqBf4VuK0K80zr/rx0quGFJ
	 n4G3uid/XCbWwjrLBWO89q+E9zYbH25t6wrj761h1wj9xPFvAJ61sxyFOvQ1jT+2Ww
	 OhyoPra2q7wPl9UV9rlByq0GhAbEx5A+Rt2ADV0zC7GRJw9rTNSpA1QyVcMtIbGryw
	 35McLDTt38qIw==
From: Niklas Cassel <cassel@kernel.org>
To: bhelgaas@google.com,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org
Cc: linux-pci@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 4/7] PCI: endpoint: Add intx_capable to epc_features
Date: Mon, 10 Mar 2025 12:10:21 +0100
Message-ID: <20250310111016.859445-13-cassel@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310111016.859445-9-cassel@kernel.org>
References: <20250310111016.859445-9-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=957; i=cassel@kernel.org; h=from:subject; bh=QqHlb9amokoslycep2GrTaleec2IM9DCX/kxSCszE8M=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNLPnZg3Y33jp4K9bX3WnvopvqsSzi/snLH8G//SWM+I6 293nao72VHKwiDGxSArpsji+8Nlf3G3+5TjindsYOawMoEMYeDiFICJCFYyMkxisdI6fn/XEiuF 84m1N0z/GXEanuZuVfw7ZYrpvT1SJVwM/8yiXOabz1NRvpj75smf3rfJy6b1FEpvv/S5efr+G74 ia5gB
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

In struct pci_epc_features, an EPC driver can already specify if they
support MSI (by setting msi_capable) and MSI-X (by setting msix_capable).

Thus, for consistency, allow an EPC driver to specify if it supports
INTx interrupts as well (by setting intx_capable).

Since this struct is zero initialized, EPC drivers that want to claim
INTx support will need to set intx_capable to true.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 include/linux/pci-epc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 9970ae73c8df..5872652291cc 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -232,6 +232,7 @@ struct pci_epc_features {
 	unsigned int	linkup_notifier : 1;
 	unsigned int	msi_capable : 1;
 	unsigned int	msix_capable : 1;
+	unsigned int	intx_capable : 1;
 	struct	pci_epc_bar_desc bar[PCI_STD_NUM_BARS];
 	size_t	align;
 };
-- 
2.48.1


