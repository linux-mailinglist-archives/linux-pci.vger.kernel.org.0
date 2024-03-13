Return-Path: <linux-pci+bounces-4775-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20ECD87A63E
	for <lists+linux-pci@lfdr.de>; Wed, 13 Mar 2024 11:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF8A6B2181A
	for <lists+linux-pci@lfdr.de>; Wed, 13 Mar 2024 10:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862EB3D968;
	Wed, 13 Mar 2024 10:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYwnLDIB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628833B798
	for <linux-pci@vger.kernel.org>; Wed, 13 Mar 2024 10:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710327505; cv=none; b=UrtmcWXUNEE2XEU6wr9hegEUjvP+BCF4pp5CkB+a6A1ltSu9N3MEmQP82GbE417kaGtL0WjEF8YEIjU6yQ6TnZKKWYjrfEKd9pN1zUuihaqdACJfYcoeelCC81WD+idNfn4KvoLzI8S445NawJaIPIMYnnW2jv+yGoFlHEX3TRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710327505; c=relaxed/simple;
	bh=FRR3ONvC1dTDtzKK4rr212hrCcCfCZS60W/bKB4hdjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JzAGIkV4cD1ueNE+MvfnLzB6+dRvIZLre891Ql+zl5g1vrp3mJhAmdb/H6/L0J1xO8tvfxsW8jKyhN5DA4cj/ONlxrQ3g8SVz9VJwlIcsRQ2O1rokOw3QCUZJl86/myfeBDvyLXEKcSbHCZjcYKRUYKKmPlRzdlQRk5MxRbAX+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYwnLDIB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED64FC433C7;
	Wed, 13 Mar 2024 10:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710327504;
	bh=FRR3ONvC1dTDtzKK4rr212hrCcCfCZS60W/bKB4hdjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WYwnLDIBY9JOV1/TfeZ9YlL4LjzvjgZQsxrjZu/zroz6lKlmpfmqfVFTR/3vcdFWD
	 ySpmuaVfg3YRLzgAtuUNQ9hDONsnLFQZzVdv8dw7LU/86O/OlK8NFukbShbt+tPzX4
	 Ac1OGaV0lVx1KukI2SXnZOn8S6y/KepaHwNpb0RHH3uCJ0sm0sd4e+RdWqwtSf8A8O
	 ICFscIDCG0IX3NXuKQGW8ZDUa98f7vbVGuL3N4X9/+WcUl4h99TT70ocjJ1JhtWQN9
	 TsjxuEgze7XG8D1tJFWqrqEvb0cEEBzQ5GYcvRO50AIVggixXPexYSiAhQIW/lWVW6
	 Suts2kUgntjBw==
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
Subject: [PATCH v3 1/9] PCI: endpoint: pci-epf-test: Fix incorrect loop increment
Date: Wed, 13 Mar 2024 11:57:53 +0100
Message-ID: <20240313105804.100168-2-cassel@kernel.org>
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


