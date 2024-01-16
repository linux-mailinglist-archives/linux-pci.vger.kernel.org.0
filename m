Return-Path: <linux-pci+bounces-2226-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5D382FB4B
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 22:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A8BA28B860
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 21:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84ECA664B0;
	Tue, 16 Jan 2024 20:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UiTlv+uy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEDE664AB;
	Tue, 16 Jan 2024 20:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435403; cv=none; b=OuJW5vLFFagIq5i4K2ov3hum+5lvT0+PKKwsdN0xjF/09jvbT3RKO+uTHVXGvCO4NLnVUXpm1kZHiDczzJkOgdlwhL8NwmuXd3pCZKR5dKQHJ8DUbq2XDjTMfEMvERZfzhqz2A+vQ4FqVfTfvLHFRHoYOjquM6VGdYQvJyDzBLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435403; c=relaxed/simple;
	bh=XjrBRZnc3cVXMYllD5hLF1ZEsvwl7OpfXi1iNQ0VQKk=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=lXE2i5YdPIAfNnDLFIT9eJ6kr2sbfvdzQ5VuD3AdhfS0fTio3fFIjs2/2FOVs6w+RVwiPlhdXfM/o41Uq9+O8+yl+lEKX6wsTIXHW1oLOiXH9xl63gW41dtijvCMqaPTrIwaIAAmupQm+EtrnCDdyOJeXbfInDAKNqUaCdhwKXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UiTlv+uy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D1B6C433F1;
	Tue, 16 Jan 2024 20:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435403;
	bh=XjrBRZnc3cVXMYllD5hLF1ZEsvwl7OpfXi1iNQ0VQKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UiTlv+uyAkwxmjx4RHhGsows2WJ4RhP3ujtOHE8bvDZxrAGrqTmnD+i6eVDZVXUtK
	 IMPtKoLF3/o5EPNIPow4IiEnBtD1SYFPk1MVmJaCsuGLnTuvRPUKXAc3R2QiQn+wcN
	 Ru8eVdWYaf1eHwqIjH3tqCBSKXVTVN9C1njOGrQJrJhTzORUNRekEp7Jib7/ixXakI
	 HsNkYHT5VHd17UPyWJgpXRBqicHNzE/Q9jJXzohYdb1VM7OAMLqYCjs+m9Z4cpuB94
	 Nle4EsdJw9WvOetLNJt08h8HpBMmFBktX2lfVdbkK+mV5DT6zr81RUDCLP1Abs7Luw
	 g7k7IDKeFsVdg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Petr Machata <petrm@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 05/31] PCI: Add no PM reset quirk for NVIDIA Spectrum devices
Date: Tue, 16 Jan 2024 15:02:14 -0500
Message-ID: <20240116200310.259340-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116200310.259340-1-sashal@kernel.org>
References: <20240116200310.259340-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.267
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
index 780223694c00..caa67252b357 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3626,6 +3626,19 @@ static void quirk_no_pm_reset(struct pci_dev *dev)
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


