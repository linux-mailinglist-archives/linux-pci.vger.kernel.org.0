Return-Path: <linux-pci+bounces-18383-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E35609F0F34
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 15:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A44752823F4
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 14:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796991E0DB5;
	Fri, 13 Dec 2024 14:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tpvL2rh5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391881E0E08
	for <linux-pci@vger.kernel.org>; Fri, 13 Dec 2024 14:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734100425; cv=none; b=Zf8AlrbXXZZVx6L8w3g8n1zfSBmml0TMbjuClQgUN+MayGFEwZ915R+bgCNFSQVQBAZAzDhVH8Yt/+sgUxz58VbFQfgQJE7Ds6aOGg1mYX79i7Yn516Y/hQaVIWqCUutVY6tLkbiofUQuvWIFJw+q2iZTA785t74yhazs8xp/bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734100425; c=relaxed/simple;
	bh=TogfjNWvw13U7UTT/BFwsTkPYIc7m/zcJdIlaNZz+ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ThPI0o++ow9uUN38B+kYmBkl/vWikH+QhSBRxRCjUzx3iirqOZp4tGOnZLytotTHr8nMhLPOuglOIzNrhB/7GNGSyTazGUVX1s3siIE392oiBTLUhlVWGk6uZwizlOGp2IveeSEjhngA64TGlvjKab6DUMtomjIkjxhu2Hj6k7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tpvL2rh5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4DBAC4CED7;
	Fri, 13 Dec 2024 14:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734100424;
	bh=TogfjNWvw13U7UTT/BFwsTkPYIc7m/zcJdIlaNZz+ek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tpvL2rh5PmMxm506U0ZFrbTmMc2RH/r9+LB0CYavcLOJ/+aOmN59Ec4v13UHJT7pS
	 rQD93Y4wuBkXNYm6bI89PskA2K+UOC9No6DtSmmJNh0CZWkvXDcexGtxmiSmWuxSMI
	 2P+GLFljgOnwoZPnzJ0xN8TUSehRzyol73DSQx9schss5pNwJWjxliOc0B+o9XzNFx
	 vn4/K1Kd9U4fCRV1IGwSab9tfLbhckcVdPWxISLptYdMCHEdBShL/mutRll1PRqPoL
	 3d1gcMeaeh9aOMyUe9znmk+uAjV2kr/2y2gWjJhmOjw6RPFpMO/8HoxzU33QB0gvvY
	 D8ZY5HSgTk+5Q==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH v6 6/6] PCI: endpoint: Verify that requested BAR size is a power of two
Date: Fri, 13 Dec 2024 15:33:07 +0100
Message-ID: <20241213143301.4158431-14-cassel@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241213143301.4158431-8-cassel@kernel.org>
References: <20241213143301.4158431-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1205; i=cassel@kernel.org; h=from:subject; bh=TogfjNWvw13U7UTT/BFwsTkPYIc7m/zcJdIlaNZz+ek=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNJjXJf8y7DcfO/4cyeOZYV2xyInxS5d934T9+yzB/etU BYQDk1b1VHKwiDGxSArpsji+8Nlf3G3+5TjindsYOawMoEMYeDiFICJTE9hZHhbZbP87CqZZZOc 3ZS3mmcGZa48oDt/fkJJRgbHj0PXNixi+O98znjehClHrbvmPZyqpm1olzN3z+5ZJSZPtJ1iugo 3PmQGAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

When allocating a BAR using pci_epf_alloc_space(), there are checks that
round up the size to a power of two.

However, there is no check in pci_epc_set_bar() which verifies that the
requested BAR size is a power of two.

Add a power of two check in pci_epc_set_bar(), so that we don't need to
add such a check in each and every PCI endpoint controller driver.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/endpoint/pci-epc-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index c69c133701c9..6062677e9ffe 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -622,6 +622,9 @@ int pci_epc_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	    (epc_features->bar[bar].fixed_size != epf_bar->size))
 		return -EINVAL;
 
+	if (!is_power_of_2(epf_bar->size))
+		return -EINVAL;
+
 	if ((epf_bar->barno == BAR_5 && flags & PCI_BASE_ADDRESS_MEM_TYPE_64) ||
 	    (flags & PCI_BASE_ADDRESS_SPACE_IO &&
 	     flags & PCI_BASE_ADDRESS_IO_MASK) ||
-- 
2.47.1


