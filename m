Return-Path: <linux-pci+bounces-2222-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F42D82F7E7
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 21:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08AA21F26100
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 20:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B14129A97;
	Tue, 16 Jan 2024 19:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGzcp8hN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7C1129A8F;
	Tue, 16 Jan 2024 19:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434599; cv=none; b=MEvZyarjEuJMjlLOrQRQsSQIv8FYnT+weuqzUkgQJDJu007s+kAvu7doIo+RpFhTEZJepK32k5OOHqshlgtlih4bK1lIVqA7Fj/qWf3UCAeVyPQmMg4Y4u65GRFeeG9dD1GLA99hF2Xq+4ifN/0EA1CsSRfecHI3QOtkJLdwZn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434599; c=relaxed/simple;
	bh=Wkmj4B3uejP3WGH0oYV3/MqVkPdtTU7Bqr3eiSburUE=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=sCpqQSxL9bvNfIk2O2UnrgTND8bgwLj32DzzWy8nsfFAYC5qxjQz0VBwSd+NFtWzdRF91743tO4EoHJ+k4rwJJR3yWm0elLn3fQ5g5Jq825dHaAnJUyugPKzo/c/3VMu+TOM9FrUE53SPMWWKVEkd6q++TPsvBK4IJbjUmRvBxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uGzcp8hN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 494AEC43390;
	Tue, 16 Jan 2024 19:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434599;
	bh=Wkmj4B3uejP3WGH0oYV3/MqVkPdtTU7Bqr3eiSburUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uGzcp8hNzv1gn6zksCUYGN6R1ZxmHIRKJZY6kyIym7QPbLwuivZUC8LdWVIjKfoIb
	 jLTOtyJ4hkgesOhCRPPNtNXf5I5kODZU7rU4muQSeTy82kfLJUg2C9R7YO+b/0fLhg
	 oIcnpv9Zm2tVW7NHFACRgSKsq1zia48Nt3TU52d3llQ8Fk8cS+Qht8ynC2Sv1NK+58
	 tbG52pwtZDJK2iRqfN3I6Wv2WFI8Qv85NfPeuuDv+8JaZsag351uc6h5lcXXb3y6Gn
	 BvYDX6XKWzYpFPI89O/Q6Fdx1aOkAEQ9Y2ZeXZCAU8X2XL4xK4q7Qoatkb27nONFbA
	 vqE+RaRVp3M1Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Petr Machata <petrm@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 020/104] PCI: Add no PM reset quirk for NVIDIA Spectrum devices
Date: Tue, 16 Jan 2024 14:45:46 -0500
Message-ID: <20240116194908.253437-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194908.253437-1-sashal@kernel.org>
References: <20240116194908.253437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
Content-Transfer-Encoding: 8bit

From: Ido Schimmel <idosch@nvidia.com>

[ Upstream commit 3ed48c80b28d8dcd584d6ddaf00c75b7673e1a05 ]

Spectrum-{1,2,3,4} devices report that a D3hot->D0 transition causes a
reset (i.e., they advertise NoSoftRst-). However, this transition does
not have any effect on the device: It continues to be operational and
network ports remain up. Advertising this support makes it seem as if a
PM reset is viable for these devices. Mark it as unavailable to skip it
when testing reset methods.

Before:

 # cat /sys/bus/pci/devices/0000\:03\:00.0/reset_method
 pm bus

After:

 # cat /sys/bus/pci/devices/0000\:03\:00.0/reset_method
 bus

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/quirks.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index ae95d0950772..d46faf186f55 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3786,6 +3786,19 @@ static void quirk_no_pm_reset(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_ATI, PCI_ANY_ID,
 			       PCI_CLASS_DISPLAY_VGA, 8, quirk_no_pm_reset);
 
+/*
+ * Spectrum-{1,2,3,4} devices report that a D3hot->D0 transition causes a reset
+ * (i.e., they advertise NoSoftRst-). However, this transition does not have
+ * any effect on the device: It continues to be operational and network ports
+ * remain up. Advertising this support makes it seem as if a PM reset is viable
+ * for these devices. Mark it as unavailable to skip it when testing reset
+ * methods.
+ */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, 0xcb84, quirk_no_pm_reset);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, 0xcf6c, quirk_no_pm_reset);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, 0xcf70, quirk_no_pm_reset);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, 0xcf80, quirk_no_pm_reset);
+
 /*
  * Thunderbolt controllers with broken MSI hotplug signaling:
  * Entire 1st generation (Light Ridge, Eagle Ridge, Light Peak) and part
-- 
2.43.0


