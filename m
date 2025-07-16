Return-Path: <linux-pci+bounces-32267-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 403C5B0766C
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 14:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B97E1AA74F4
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 12:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD13A2F5484;
	Wed, 16 Jul 2025 12:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zjwn+piG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2872F531C;
	Wed, 16 Jul 2025 12:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752670585; cv=none; b=TacyoWtWlVKbxuZHzVpvqqoCJqYRR2HHsUw+m+Z3X+mJ7z3eqHOJNz4ZVs9QaPO2rx6WRzchcKNQM3XQ0K/mKhWi0IUFP36z4xSFQh+B+rdpw5VtWqoCPxom/uHE56tzZMrpM1reWLX0GJWo6+TOQQJq0clToIDoBZFKpXGtK54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752670585; c=relaxed/simple;
	bh=d5ezahiJEgmQKnKdHKwl1RCHamaJ0esu7vRT109SEbQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=itWBktj8bx7k6yY/qZ2C34AeuDTDnems10QmJmsVsOTkjw1Tp1h0BKxtfjN/88mDp0IK3y+tU4BKiVHl+h2vHABshAs9US+93yATV17jjorDavjBAhw4GYCriAzParKHYbvK/S3nMaL0re+ELjRv1PKKD7VxEalqJlIZ7bUCa0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zjwn+piG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08C0CC19421;
	Wed, 16 Jul 2025 12:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752670585;
	bh=d5ezahiJEgmQKnKdHKwl1RCHamaJ0esu7vRT109SEbQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Zjwn+piGRW4ptJ/z0z/uECdIuQMEStd2Q07dBMlSQJ3syeuKkk9W1IysDQ/1idTk2
	 pFcHTVlwQYQZqe9s1pj1axXyV2JP97Z1EhuEjol2fdSniYLHSf0u/SSYcMlOt5Saed
	 n0DYy4c8/qPHEw3eUlDF3qzUMYs9dvaDVGec6vtO/ZGk0AktP3oZTUIx42nMtvJ/XM
	 T7SSbSL6HzDVGF53Ni9x2NILo5T0w1LRoyPaAX9el7x3uEvrWh1S28tl3SG0PYUUUv
	 Q3ibcCFPXXQnjxZ/ak+N2438aCO6wUrwqg4eKFha89W/tBOzEaj5r4S7Xp6jVAGDPH
	 2nYUVc1/IOK+Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1AB0C83F22;
	Wed, 16 Jul 2025 12:56:24 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Wed, 16 Jul 2025 18:26:25 +0530
Subject: [PATCH 6/6] wifi: ath10k: Use pci_{enable/disable}_link_state()
 APIs to enable/disable ASPM states
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-ath-aspm-fix-v1-6-dd3e62c1b692@oss.qualcomm.com>
References: <20250716-ath-aspm-fix-v1-0-dd3e62c1b692@oss.qualcomm.com>
In-Reply-To: <20250716-ath-aspm-fix-v1-0-dd3e62c1b692@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Nirmal Patel <nirmal.patel@linux.intel.com>, 
 Jonathan Derrick <jonathan.derrick@linux.dev>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 ath12k@lists.infradead.org, ath11k@lists.infradead.org, 
 ath10k@lists.infradead.org, Bjorn Helgaas <helgaas@kernel.org>, 
 ilpo.jarvinen@linux.intel.com, linux-arm-msm@vger.kernel.org, 
 linux-pci@vger.kernel.org, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1518;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=Fx4ej/EicH41+mIOpWKF1WcnMWq9PYq0rbjy+/KSq0Q=;
 b=kA0DAAoBVZ8R5v6RzvUByyZiAGh3oXbIxqk80Tgh+RxdditU6/SfcGzUbtEKyagt0528i4qmg
 okBMwQAAQoAHRYhBGelQyqBSMvYpFgnl1WfEeb+kc71BQJod6F2AAoJEFWfEeb+kc71+zwH/j9g
 77XQ+TyQtXbct+iV57W9c8g3ZQmgOtKIHRMLu+mcrcqHfSxz/V/4OcFnyjatqAbs33eteSiCZ55
 LoVeVbo3qOjovyINbJXFwgSGgb7MrPELoEBPbwyZvr7H6mp2v1GP3XUzZsi6NwIHjh1J7BQUqHV
 aDnAaoWlbmAChlKp0tbmRkWVN2LpMwTe6EfcYqrCmz7nBm1x0QLTpGPJkNYzV/HgleNa8aMEQFV
 eQP3tLVUolrRr8ZS4IJHlOEVQus5Ub4hqfKpnW3BFAvywjtvLCovpSp6Diwn0zkfZ0WLLS5Xk0R
 6jeK1WBsuL8Emy0OHC085U9qIOq5psdkZ9ca4Pc=
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

It is not recommended to enable/disable the ASPM states on the back of the
PCI core directly using the LNKCTL register. It will break the PCI core's
knowledge about the device ASPM states. So use the APIs exposed by the PCI
core to enable/disable ASPM states.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath10k/pci.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/pci.c b/drivers/net/wireless/ath/ath10k/pci.c
index 1e6d43285138ece619b9d7dc49f113a439e2085d..b20ab535a850ef1f5fe606bd7e7a230ebcd894c8 100644
--- a/drivers/net/wireless/ath/ath10k/pci.c
+++ b/drivers/net/wireless/ath/ath10k/pci.c
@@ -1965,9 +1965,7 @@ static int ath10k_pci_hif_start(struct ath10k *ar)
 	ath10k_pci_irq_enable(ar);
 	ath10k_pci_rx_post(ar);
 
-	pcie_capability_clear_and_set_word(ar_pci->pdev, PCI_EXP_LNKCTL,
-					   PCI_EXP_LNKCTL_ASPMC,
-					   ar_pci->link_ctl & PCI_EXP_LNKCTL_ASPMC);
+	pci_enable_link_state(ar_pci->pdev, ath_pci_aspm_state(ar_pci->link_ctl));
 
 	return 0;
 }
@@ -2824,8 +2822,7 @@ static int ath10k_pci_hif_power_up(struct ath10k *ar,
 
 	pcie_capability_read_word(ar_pci->pdev, PCI_EXP_LNKCTL,
 				  &ar_pci->link_ctl);
-	pcie_capability_clear_word(ar_pci->pdev, PCI_EXP_LNKCTL,
-				   PCI_EXP_LNKCTL_ASPMC);
+	pci_disable_link_state(ar_pci->pdev, PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1);
 
 	/*
 	 * Bring the target up cleanly.

-- 
2.45.2



