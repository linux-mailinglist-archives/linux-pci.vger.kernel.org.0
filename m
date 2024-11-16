Return-Path: <linux-pci+bounces-16983-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEEF9CFFE1
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 17:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE803283B0D
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 16:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C4218130D;
	Sat, 16 Nov 2024 16:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9C9kodz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF5E29415
	for <linux-pci@vger.kernel.org>; Sat, 16 Nov 2024 16:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731774984; cv=none; b=Qpu51LyR/whD4UZ7uwE9EgZw6zXv17/k1ag+dxDanfBR9NXfpOQl9Nd3ecuIyDxh+GMNW6WcpjOGaJa2A+lZmZhIewJyhYTMC8Mlh9hR5yuNC/qNH+R0KB0lv/6a6P8bs0UoIE6ryOEBA7sH3UELu35s7u+IzGb6e6ZQlqJMFng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731774984; c=relaxed/simple;
	bh=KoLmHPN+69iBXOvoxCUQ4B4ux9IP5nIy91a83eyfrN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fZvEssNjmorE5UfQVg4Es4xGGj4PnxMImG0sVB7T+lPZWFGYdmAdkEb9CKNVKd6zEsReZy05aHaFBLjRd5Wre8otU3UFF4O9mV1tI59T65Vt/TfN1+D1lRweSKwsnWY7gQER6TFM5P8mZ8OBeLF7Dcej65vGFL7p5t3cP4917b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9C9kodz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E86C6C4CEC3;
	Sat, 16 Nov 2024 16:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731774983;
	bh=KoLmHPN+69iBXOvoxCUQ4B4ux9IP5nIy91a83eyfrN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n9C9kodz+qYDI4pvTFMYH+gZUkecjtPM7j79yJdS5V9JS5N+FNHb8fALZjd4Irmh7
	 PGJHKDlD+QH5eVlPgsD393mg/d06RzA/wQ/7xunL6ZpiFkbVCdDszzUCyQjgVzDbzJ
	 UsNET+37+yRRV+W3B/1s5do21fr0waJnj+Sql57e8Sl/E/n1i/O3LprWehHh1fW4Xd
	 rjoe4q90i/m2K3Nj9JkkpbHiAC4MjF+LYpGhtYhHlbJFwERArVYepu3MQiKeKGnmGj
	 1r2kH0mbspITR1ZtS8KRKX5kPRM0CtJV4cofM83vAwki8ShWY5LR6NsGIl/xvc/z0G
	 vWLc5wAfHO8xg==
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
Subject: [PATCH v3 3/4] PCI: endpoint: Verify that requested BAR size is a power of two
Date: Sat, 16 Nov 2024 17:36:02 +0100
Message-ID: <20241116163558.2606874-9-cassel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241116163558.2606874-6-cassel@kernel.org>
References: <20241116163558.2606874-6-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1136; i=cassel@kernel.org; h=from:subject; bh=KoLmHPN+69iBXOvoxCUQ4B4ux9IP5nIy91a83eyfrN4=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNItTn4xjPt82CNnJ3vdVekXZ9m3Nf8/+zzq7vol77gig 7dN4Vru11HKwiDGxSArpsji+8Nlf3G3+5TjindsYOawMoEMYeDiFICJfH3H8L8oJZFZKVPtVYgO c3xcz/UvFR+/ZjC/zI8N6TrXwph/YhfD/7y+nTOOiTj9/HbxYHtG1eq3TkyNN422dn2+/FhReld hPT8A
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

When allocating a BAR using pci_epf_alloc_space(), there are checks that
round up the size to a power of two.

However, there is no check in pci_epc_set_bar() which verifies that the
requested BAR size is a power of two.

Add a power of two check in pci_epc_set_bar(), so that we don't need to
add such a check in each and every PCI endpoint controller driver.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/endpoint/pci-epc-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index c69c133701c92..6062677e9ffec 100644
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
2.47.0


