Return-Path: <linux-pci+bounces-33012-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6633CB13674
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 10:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C2F6179709
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 08:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956A225B30E;
	Mon, 28 Jul 2025 08:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHcUc9RN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C114234963;
	Mon, 28 Jul 2025 08:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753691096; cv=none; b=hOiHewC97BLOZvNNKp2CCOvSyeROpJ1UlmBMIWrnOUSR19xXp+fiNXOudcH0AyUXCW0uQOOFytp7wzr6FxjZa8c1UxS1fiQwyo6r9q/gD3hsMVYwl1QHPiSe0o5f1JFHxEobjweli0YXrBSPBsNEmanInXI4KW/RsOELZ9YJoqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753691096; c=relaxed/simple;
	bh=l4iu4ChzVc1nL+CJ6QgQYIFZyBLZHTAfyN3HW/ZgUxE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a57bVUk4nKPzU9UYPBUHwte5rOHc5AEGxL/2yQn9AV5LGvjbtzohzoueKLf8cpTUBmlHTs8jAOTORgnNVHfsdlbpjh1BafRgCIZyUY31PDGB6b/oqF7tRsXk56P+lDJLMiVmDoNRx0EqCRdfUQ05w9YtogZ4Bn+p8u5Glcfigl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHcUc9RN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0386C4CEF7;
	Mon, 28 Jul 2025 08:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753691095;
	bh=l4iu4ChzVc1nL+CJ6QgQYIFZyBLZHTAfyN3HW/ZgUxE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RHcUc9RNmIM7SGOQ09D5XqF5Fk1blrKHwZ5aXGJeFz1mpQJF/ExVQFrTrwC6clY04
	 /ZwpzEr/QF4poEkRKLUjqJ2Fz6IP2IaFVI3OpRUtoYpWU1EWoIVWGNHXxYNvsM1kVq
	 l8REnH0LWg5hCpVkJtOPr6i1CzvrC2OSW/YVO4JywD7eJNC33vj0EHIgRBa4EidKuu
	 8dqnZL9GQRvO1OhwD+GacyW3SdVifvxO4MWQJUMi6M4bk9rBnl4CuK2rG0xtSJVRtV
	 kT7s1dCSL3R242G+EC1SlMVfhbzgveNpUJFYW22iOKPsBSyjRUgw6KSOl03CJlYppS
	 g7ABIiMAuboxA==
From: chrisl@kernel.org
Date: Mon, 28 Jul 2025 01:24:42 -0700
Subject: [PATCH RFC 12/25] PCI/LUO: Save struct pci_dev info during prepare
 phase
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-luo-pci-v1-12-955b078dd653@kernel.org>
References: <20250728-luo-pci-v1-0-955b078dd653@kernel.org>
In-Reply-To: <20250728-luo-pci-v1-0-955b078dd653@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-acpi@vger.kernel.org, David Matlack <dmatlack@google.com>, 
 Pasha Tatashin <tatashin@google.com>, Jason Miu <jasonmiu@google.com>, 
 Vipin Sharma <vipinsh@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
 Adithya Jayachandran <ajayachandra@nvidia.com>, 
 Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, 
 Mike Rapoport <rppt@kernel.org>, Chris Li <chrisl@kernel.org>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
X-Mailer: b4 0.14.2

From: Jason Miu <jasonmiu@google.com>

Some fields in the struct pci_dev are mutable during kernel execution,
and the runtime values cannot be re-construct from reading the PCI
config space registers again. Therefore, for the next kernel, we need
to save those fields for liveupdate during the prepare phase. Those
values are expected to be restored in the boot up time of the next
kernel.

The struct pci_dev_ser is packed for making sure the field offsets are
consistent across the kernel images before and after liveupdate.

We would like to save one more field for PCI resources, which has type
struct resource. It contains pointers so needs extra handlings in the
coming patches.

Signed-off-by: Chris Li <chrisl@kernel.org>
---
 drivers/pci/liveupdate.c | 22 ++++++++++++++--------
 drivers/pci/pci.h        | 22 ++++++++++++++++++++++
 2 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index f84c0a455f7055b9b64051b125368fb0f9e6144f..6b1c14d70fd16b0919ca22faae788069f3743708 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -18,14 +18,6 @@
 static LIST_HEAD(preserved_devices);
 static LIST_HEAD(probe_devices);
 
-struct pci_dev_ser {
-	u32	path;		/* domain + bus + slot + fn */
-	u8	requested;
-	u16	num_vfs;
-	char	driver_name[63];
-	u64	driver_data;	/* driver data */
-};
-
 struct pci_ser {
 	u32 count;
 	struct pci_dev_ser devs[];
@@ -156,6 +148,20 @@ static int pci_save_device_state(struct device *dev, struct pci_dev_ser *s)
 	s->requested = dev->lu.requested;
 	if (pdev->sriov && pdev->is_physfn)
 		s->num_vfs = pdev->sriov->num_VFs;
+
+	s->devfn = pdev->devfn;
+	s->current_state = pdev->current_state;
+	s->pm_cap = pdev->pm_cap;
+	s->broken_intx_masking = pdev->broken_intx_masking;
+	s->pme_poll = pdev->pme_poll;
+	s->no_d3cold = pdev->no_d3cold;
+	s->wakeup_prepared = pdev->wakeup_prepared;
+	s->skip_bus_pm = pdev->skip_bus_pm;
+	s->ignore_hotplug = pdev->ignore_hotplug;
+	s->hotplug_user_indicators = pdev->hotplug_user_indicators;
+	s->pref_window = pdev->pref_window;
+	s->pref_64_window = pdev->pref_64_window;
+
 	return 0;
 }
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index b79a18c5e948980fe2ef3f0a10e0d795b1eee6d7..2ef12745ee05960878d8d3fe0cdf136f69c8d408 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -489,6 +489,28 @@ struct pci_sriov {
 	bool		drivers_autoprobe; /* Auto probing of VFs by driver */
 };
 
+struct pci_dev_ser {
+	u32	path;		/* domain + bus + slot + fn */
+	u8	requested;
+	u16	num_vfs;
+	char	driver_name[63];
+	u64	driver_data;	/* driver data */
+
+	/* Saved fields from struct pci_dev */
+	u32	devfn;
+	u32	current_state;
+	u8	pm_cap;
+	u32	broken_intx_masking:1;
+	u32	pme_poll:1;
+	u32	no_d3cold:1;
+	u32	wakeup_prepared:1;
+	u32	skip_bus_pm:1;
+	u32	ignore_hotplug:1;
+	u32	hotplug_user_indicators:1;
+	u32	pref_window:1;
+	u32	pref_64_window:1;
+} __packed;
+
 #ifdef CONFIG_PCI_DOE
 void pci_doe_init(struct pci_dev *pdev);
 void pci_doe_destroy(struct pci_dev *pdev);

-- 
2.50.1.487.gc89ff58d15-goog


