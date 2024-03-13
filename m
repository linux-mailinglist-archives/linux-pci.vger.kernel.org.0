Return-Path: <linux-pci+bounces-4777-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 036A387A640
	for <lists+linux-pci@lfdr.de>; Wed, 13 Mar 2024 11:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 883BCB21512
	for <lists+linux-pci@lfdr.de>; Wed, 13 Mar 2024 10:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2B43D548;
	Wed, 13 Mar 2024 10:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fu3+czTo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA633B798
	for <linux-pci@vger.kernel.org>; Wed, 13 Mar 2024 10:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710327510; cv=none; b=qrmcXv/clc1q6RX6FWhvuXpIkDUHJOYXV0sB0CZF9ek2X+WYcE/VYpovoJJJ093kWYHHSUm63Vxshvjl70PnAYckjgCa6fWP0HwsbnbLDWqeRgXef/bOhov1d7leorexQbAde6Sz/wVPy1X/J1SM/kxrhoxxmqn28JOd/jn71xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710327510; c=relaxed/simple;
	bh=e/qH9cmUPYUotD/eAIW0sRrL9XefNgAmZxzo/zRfOXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HQpsJLkGoscOZ9YU8O9pZhPASq/sHqSShLX+T9513BJ5lDX8pZ+TgMPNvU7t8Fzcaiqn7gvoBVOkrUB20k0l033Ir61nB1sPh7KaAC2vUIxYzv5Qj1HkhKWeHrO9f/gxPNh+ef4n4r7LTAS0S6pKq5zBiSdRX16CzvrZGg7o4ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fu3+czTo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BBB4C433F1;
	Wed, 13 Mar 2024 10:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710327509;
	bh=e/qH9cmUPYUotD/eAIW0sRrL9XefNgAmZxzo/zRfOXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fu3+czTooeb804z147E3W506+97krqEewiftTgCtigByMb8eJnlXMVO3g0lkansuK
	 nax4DLoZPK/iCD38iiUiXlE2oDrZptg4vth7yg2yi02I6frm1bPPuRsk6vh3Py+p1o
	 mCfQYyvu/fJgz4RwPhMGS8WCLF+i8CaiEi8+yqNKwXgJIcTtaBM/AeQz1TL/5uL4IT
	 9ZQRRquh216LaqiOt1o/2lyf+1Lw841uc0Kv2bx0NsY95iCusWLrIfswnW2z/NlCpx
	 H9ScHXUrW45/CSKiv6JTDoWj7BRZxJb9W8GFXuRLCyT+1x0Lo64KpAu818Nr0ANwAV
	 OUXMqCb63o/cg==
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
Subject: [PATCH v3 3/9] PCI: endpoint: pci-epf-test: Remove superfluous code
Date: Wed, 13 Mar 2024 11:57:55 +0100
Message-ID: <20240313105804.100168-4-cassel@kernel.org>
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

The pci-epf-test does no special configuration at all, it simply requests
a 64-bit BAR if the hardware requires it. However, this flag is now
automatically set when allocating a BAR that can only be a 64-bit BAR,
so we can drop pci_epf_configure_bar() completely.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 8c9802b9b835..7dc9704128dc 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -877,19 +877,6 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 	return 0;
 }
 
-static void pci_epf_configure_bar(struct pci_epf *epf,
-				  const struct pci_epc_features *epc_features)
-{
-	struct pci_epf_bar *epf_bar;
-	int i;
-
-	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
-		epf_bar = &epf->bar[i];
-		if (epc_features->bar[i].only_64bit)
-			epf_bar->flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
-	}
-}
-
 static int pci_epf_test_bind(struct pci_epf *epf)
 {
 	int ret;
@@ -914,7 +901,6 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 	test_reg_bar = pci_epc_get_first_free_bar(epc_features);
 	if (test_reg_bar < 0)
 		return -EINVAL;
-	pci_epf_configure_bar(epf, epc_features);
 
 	epf_test->test_reg_bar = test_reg_bar;
 	epf_test->epc_features = epc_features;
-- 
2.44.0


