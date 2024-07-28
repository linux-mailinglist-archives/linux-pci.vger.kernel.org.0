Return-Path: <linux-pci+bounces-10915-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B11C93E875
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2024 18:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 347251F21C3A
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2024 16:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03C87A702;
	Sun, 28 Jul 2024 16:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nl86C6vU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947F17A724;
	Sun, 28 Jul 2024 16:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722183036; cv=none; b=XSvuz9HN0cmPWUioV1oCzHCV8Ut4krCq1kOLSUAEoqNQdqX+kFq96c56A0m5CAUjYieY3HtzFuDlGpjKuPulk+AaYeGYY2JZR4AiYuiYZOnxj3c5iEdrNbacQm+uqxhJTNESNUQ2SGw5qdv8/GgVLE3i0e5z6ZsvRGjFoVNdMxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722183036; c=relaxed/simple;
	bh=dfZD/ufH60U9HmSEBX5+cjPLbiTlR4MKOHc+tbMdF4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pEWyXytO5CYlTMdzCwecGt4yVsQgxHdZVq+NuIrTvb6KTo2VfmNTeRXHURSWwwZAc9dqD3kzR/GDvYYHSc7quQww+C697uKdZw9OFOq2xja0H6LieaWtgAuzA8wIkGyaGGoUHG/hfo6DvtI3OlG9j4+ckxKe2fcXQkHO0zOnPmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nl86C6vU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B4EC32782;
	Sun, 28 Jul 2024 16:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722183036;
	bh=dfZD/ufH60U9HmSEBX5+cjPLbiTlR4MKOHc+tbMdF4o=;
	h=From:To:Cc:Subject:Date:From;
	b=nl86C6vUbnRCIQtzgELyGGGewLuIlvIKsvZ4c7vlEl6m1xKvMuMcbQFEzNcvNq7a+
	 XXm+lcTkSFH4eI6wFk5lfLpYcjjBAcm8m60amk1suL9kRJwp5x0FVDN92AcuwyeDj9
	 TkI/kr74Pr7x6etJ3HBX8QvL/PAZcn8LVpqHGFDyu6XRuA00n+PeJiMEVwxkzStWb0
	 bwxwf09SwBX2DU5EnPFPO6nhb4eVLZ+GIOVzHxtaMJg0c1mUqIeztXhIdmM+rKZE50
	 ESyumHefiT6hPYnNAmS/ufbUdSL9qDtCE0R04+8t7aO3aA7uDSM4Wu9eo6reqt3OgE
	 ZyTaUL4T7kSxA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ajit Khaparde <ajit.khaparde@broadcom.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Andy Gospodarek <gospo@broadcom.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 1/7] PCI: Add ACS quirk for Broadcom BCM5760X NIC
Date: Sun, 28 Jul 2024 12:10:21 -0400
Message-ID: <20240728161033.2054341-1-sashal@kernel.org>
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
X-stable-base: Linux 5.4.281
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
index 3bc7058404156..aef73bc36ee98 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4986,6 +4986,10 @@ static const struct pci_dev_acs_enabled {
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


