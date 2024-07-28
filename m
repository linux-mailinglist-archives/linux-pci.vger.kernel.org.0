Return-Path: <linux-pci+bounces-10892-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CE493E7CA
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2024 18:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBA341C21410
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2024 16:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8000014388F;
	Sun, 28 Jul 2024 16:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghYj+7ju"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B9641C64;
	Sun, 28 Jul 2024 16:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722182832; cv=none; b=JBP0lZ6J35QYPpyXUn9B8a6E+49N9tSYmvPhxdnKwOJa7OzzGSQEFCtfmUhI6Flggrli6LHDT6lBuc8Tgfp5bqmKVF41RwkYiNHW2AFpJNRpaOrDIFTJlg492fGnj7oPHr8j95v3J8u0gQ8pKWGZ1LDKz/G1MUepNd0H+wDcMGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722182832; c=relaxed/simple;
	bh=cvZjx4tKvqb5Bi6SKxJps2POuHJes3dAJC2Sde15U1s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dI8TCt77pZ8zxo4q3Phlv1d1L7LVU5z47GxgxWsR1WoKni1AW/cYq9obDphlN+xXyW3cVbsa/8f9/DjWtnSCeSi54q1+kRDcW8LFRsot5K1dU+QrqxEnfq0LstIYWYQfO9MWYotmJsIcbJ4beFDGPh8SdeZTEnKInzy5xIr/pow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghYj+7ju; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26202C116B1;
	Sun, 28 Jul 2024 16:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722182832;
	bh=cvZjx4tKvqb5Bi6SKxJps2POuHJes3dAJC2Sde15U1s=;
	h=From:To:Cc:Subject:Date:From;
	b=ghYj+7ju4IkM7hnH5N+52PhvcgVQ9QWZStuU9jdebHJaK4kb6MiVRhM+Yy2tRrmTL
	 9N2wg6OJTZNlDHUNYQTEBb6OPgzeyHSe3drNblZkZ+fhiQuA3wAsg9BiBz3cV6m18v
	 oaXPX7KMuiFSjidNPArfuoDds1psK7I2pBVhpAucDKQ7nAHqYrtVe3rlN9YjMi2t4M
	 TAjg8ItOw1lq+5GbgRrGpWRtPlvhC2NF05ljIJW8jukPwFrwKKe7NhFC2FuKceg8k+
	 QyKYrT/IIF6BVpYV6EOuYrUchPnzOIIsxjEzeC0V3C4IBUVCEb6Wqb1/Hh+/LHBJSl
	 IF81zjCkHwoyw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ajit Khaparde <ajit.khaparde@broadcom.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Andy Gospodarek <gospo@broadcom.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 01/17] PCI: Add ACS quirk for Broadcom BCM5760X NIC
Date: Sun, 28 Jul 2024 12:06:37 -0400
Message-ID: <20240728160709.2052627-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
Content-Transfer-Encoding: 8bit

From: Ajit Khaparde <ajit.khaparde@broadcom.com>

[ Upstream commit 524e057b2d66b61f9b63b6db30467ab7b0bb4796 ]

The Broadcom BCM5760X NIC may be a multi-function device.

While it does not advertise an ACS capability, peer-to-peer transactions
are not possible between the individual functions. So it is ok to treat
them as fully isolated.

Add an ACS quirk for this device so the functions can be in independent
IOMMU groups and attached individually to userspace applications using
VFIO.

[kwilczynski: commit log]
Link: https://lore.kernel.org/linux-pci/20240510204228.73435-1-ajit.khaparde@broadcom.com
Signed-off-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/quirks.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index ec4277d7835b2..1bf1a83dabb93 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5092,6 +5092,10 @@ static const struct pci_dev_acs_enabled {
 	{ PCI_VENDOR_ID_BROADCOM, 0x1750, pci_quirk_mf_endpoint_acs },
 	{ PCI_VENDOR_ID_BROADCOM, 0x1751, pci_quirk_mf_endpoint_acs },
 	{ PCI_VENDOR_ID_BROADCOM, 0x1752, pci_quirk_mf_endpoint_acs },
+	{ PCI_VENDOR_ID_BROADCOM, 0x1760, pci_quirk_mf_endpoint_acs },
+	{ PCI_VENDOR_ID_BROADCOM, 0x1761, pci_quirk_mf_endpoint_acs },
+	{ PCI_VENDOR_ID_BROADCOM, 0x1762, pci_quirk_mf_endpoint_acs },
+	{ PCI_VENDOR_ID_BROADCOM, 0x1763, pci_quirk_mf_endpoint_acs },
 	{ PCI_VENDOR_ID_BROADCOM, 0xD714, pci_quirk_brcm_acs },
 	/* Amazon Annapurna Labs */
 	{ PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS, 0x0031, pci_quirk_al_acs },
-- 
2.43.0


