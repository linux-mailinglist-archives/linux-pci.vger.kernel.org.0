Return-Path: <linux-pci+bounces-30223-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D05EEAE116B
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 04:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A921168656
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 02:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965641CBEAA;
	Fri, 20 Jun 2025 02:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPCj0Ek7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD941BEF77;
	Fri, 20 Jun 2025 02:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750388139; cv=none; b=AOSL2O8beRfxOhvdmAHW2eFOIk1GjEOasE9z/oAQ8IcSYuYQs0FnEm45T8+x0Q2K5ZUwlaCcPJYcblQB1qCqFcjOODWodDvjO9gblay/HOhQzdEoXxm6RGwkSQM72hggQ0keQyy4438nekWRODsdDfHr32ISRWKujX8Adp40nBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750388139; c=relaxed/simple;
	bh=Y/CjH2xMz/xYNwUFX6ujhfmpzcysXs2YH/NnBhHupYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qXOfctr1Sq6KkRX+H9aTFmEd9k8Pf+sEIUjIGalx4QtdI5EhUM4FPiSOXCn/8c3Swh8bG/3NXSbPxGmSsuTGEc8PcCkx/EWV9gfR5oGiFuDGjnljuRNvsamqfHz/dMz3HC3jJ3on87q6IovMjUyQ0+xPoxFf2L1c9tAriDBMAYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPCj0Ek7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51938C4CEED;
	Fri, 20 Jun 2025 02:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750388139;
	bh=Y/CjH2xMz/xYNwUFX6ujhfmpzcysXs2YH/NnBhHupYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mPCj0Ek7gYrnpqvMULoNVMPkz8dmfAFb5DfUE+jFzRJhcCVMDTFizpXIesJYYTcom
	 ntF25kYoczfVDF3D0seBpRMZ7ra8Z1pjRlMJLekjytYyfpCvZ4LX6bt9R5TOd268t/
	 9QHtpCBTzKV1/b65viEbTOuH+FydQTFn76+ZC7LHJfM4lNv0Vif5seikxKjZ05FD8o
	 8dWUm1HM7sgpifpa0owqyOJLdgH3XNuk8UG41pCeY4RrXySHN38Fm8Mfav1eQ+I/Ti
	 1+5pEpe7hNByjv7GQgW6iB6vDxHyn66M5pEe5ovDYzA8N+RBNvlD8pBlbkUf77vUnt
	 1aMsQPYAi5j9A==
From: Mario Limonciello <superm1@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM)
Cc: linux-pm@vger.kernel.org,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: [PATCH v3 1/2] PCI/PM: Skip resuming to D0 if disconnected
Date: Thu, 19 Jun 2025 21:55:34 -0500
Message-ID: <20250620025535.3425049-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250620025535.3425049-1-superm1@kernel.org>
References: <20250620025535.3425049-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

When a USB4 dock is unplugged the PCIe bridge it's connected to will
remove issue a "Link Down" and "Card not detected event". The PCI core
will treat this as a surprise hotplug event and unconfigure all downstream
devices. This involves setting the device error state to
`pci_channel_io_perm_failure` which pci_dev_is_disconnected() will check.

It doesn't make sense to runtime resume disconnected devices to D0 and
report the (expected) error to do so.  It is still useful information
that a device is disconnected though, so add an info message for that
purpose.

Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v3:
 * Adjust text and subject
 * Add an info message instead
v2:
 * Use pci_dev_is_disconnected()
v1: https://lore.kernel.org/linux-usb/20250609020223.269407-1-superm1@kernel.org/T/#mf95c947990d016fbfccfd11afe60b8ae08aafa0b
---
 drivers/pci/pci.c | 5 +++++
 drivers/pci/pci.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 9e42090fb1089..160a9a482c732 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1374,6 +1374,11 @@ int pci_power_up(struct pci_dev *dev)
 		return -EIO;
 	}
 
+	if (pci_dev_is_disconnected(dev)) {
+		dev->current_state = PCI_D3cold;
+		return -EIO;
+	}
+
 	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
 	if (PCI_POSSIBLE_ERROR(pmcsr)) {
 		pci_err(dev, "Unable to change power state from %s to D0, device inaccessible\n",
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 12215ee72afb6..57aaf9c63e2e8 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -550,6 +550,7 @@ static inline bool pci_dev_set_io_state(struct pci_dev *dev,
 
 static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
 {
+	pci_info(dev, "Device disconnected\n");
 	pci_dev_set_io_state(dev, pci_channel_io_perm_failure);
 	pci_doe_disconnected(dev);
 
-- 
2.43.0


