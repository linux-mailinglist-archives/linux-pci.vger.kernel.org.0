Return-Path: <linux-pci+bounces-35759-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F88B5064D
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 21:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B02F7B3A11
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 19:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0003352FFD;
	Tue,  9 Sep 2025 19:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GA4tSOpb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB053168FC;
	Tue,  9 Sep 2025 19:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757445414; cv=none; b=TPQblyQQFmcqj0wAX5DarZUyuxw8PR1qbNCSQZW1ZPi3mE26yBGjA44Fxphs+aSO9NsMoYf0RsFpnEnmoKqvxCjFyNqvYsKpCe1FCnJO0A8KOSl0KtNxINH05cyHFX1TZcJHffB1WdBo2h5hUWxFQXMDCuc1zgBTCfUpapisfG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757445414; c=relaxed/simple;
	bh=z+OfJFIWEfQUM5YlYoNwYn3+vku/zqAn4a1cIBqKGxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nda0oIYsJtp3w3MzVhrMjf8MvzS1H47a8vcWX7ZWOHDJN/YNuQzzeHxt1uhiF2StSWmkf4z5OI79Fd/XJa36w3sSNblNH07HA2mF6SFYHaZezRRYd9pDmpWaCMW7Yv6ldTSnTvovjEBNvwmFwprV+5FTjOZjVRvKXPdU+Ea4VE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GA4tSOpb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA9EC4CEFB;
	Tue,  9 Sep 2025 19:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757445414;
	bh=z+OfJFIWEfQUM5YlYoNwYn3+vku/zqAn4a1cIBqKGxQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GA4tSOpbNgfmkStgdR4bN5bELokzvq2GovFrIFKKDdb7yZaoxZFxRJOGc9y/PvIA2
	 bhfOO/P0ZMz/6mnB+JCZR1w2Hl0ir7MopSKDUhyLnfYoAIQ9xG48cP/sBdAotBUCiJ
	 8jVNFzRJqUCwNbXTaoXJM4zCpbZIA3LC175Gg0rRP/O2spxMO4zAho7mumhZy5lEjz
	 WfhGyVCODirY51vbt4k9k7cCkhpzOvdsBbUdh2oKlpqy597v78BfjKoJ7oaXIxDaiM
	 tbmqaEsCBj1Y0/Z9HIToJXFcBWI0Fl4ZA/kFGFR2Tf1NXnkzRAREY2/WECsBx83XAG
	 FpcLAmFjeRlTw==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Pavel Machek <pavel@kernel.org>,
	Len Brown <lenb@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-pm@vger.kernel.org (open list:HIBERNATION (aka Software Suspend, aka swsusp)),
	amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
	linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
	linux-scsi@vger.kernel.org (open list:SCSI SUBSYSTEM),
	linux-usb@vger.kernel.org (open list:USB SUBSYSTEM),
	linux-trace-kernel@vger.kernel.org (open list:TRACING),
	AceLan Kao <acelan.kao@canonical.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	=?UTF-8?q?Merthan=20Karaka=C5=9F?= <m3rthn.k@gmail.com>,
	Eric Naim <dnaim@cachyos.org>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v7 08/12] PCI/PM: Use pci_power_manageable() in pci_pm_poweroff_noirq()
Date: Tue,  9 Sep 2025 14:16:15 -0500
Message-ID: <20250909191619.2580169-9-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250909191619.2580169-1-superm1@kernel.org>
References: <20250909191619.2580169-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Devices with no subordinate should be put into D3 during hibernate, but
devices that have bridge_d3 set should also be put to sleep during
hibernate. Adjust the check in pci_pm_poweroff_noirq() to use
pci_power_manageable() to cover those as well.

Tested-by: Eric Naim <dnaim@cachyos.org>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
v7:
 * Reword title
v5:
 * Split out patch
---
 drivers/pci/pci-driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index fb6f1f60b2f1f..c563fd6af979d 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1227,7 +1227,7 @@ static int pci_pm_poweroff_noirq(struct device *dev)
 			return error;
 	}
 
-	if (!pci_dev->state_saved && !pci_has_subordinate(pci_dev))
+	if (!pci_dev->state_saved && pci_power_manageable(pci_dev))
 		pci_prepare_to_sleep(pci_dev);
 
 	/*
-- 
2.43.0


