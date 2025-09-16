Return-Path: <linux-pci+bounces-36228-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E61EB58F81
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 09:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68083525964
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 07:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871232ECD0E;
	Tue, 16 Sep 2025 07:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IS9MKNvf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B41C2E7162;
	Tue, 16 Sep 2025 07:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758008719; cv=none; b=Ae3unLTPxietE//G1AZ0hbGa5WH5lyNFy/L+1S978bKzR/h87SepkfLHbpunLqJaPQxJE3+OaahSVcXNTxL0uG9pdxlWd1LOT0tuy6PUovWwGqDuF2xJVg0KzYGMKICJ5kJLPP1Q0gcbSz19XAFSeQr98L3MQ8IFVyKQ2h4FWRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758008719; c=relaxed/simple;
	bh=atC+NDqa0LfxetrMUXV/684PEhjI9J/4qvzS5Tca4rs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d8g2Yy7ePfHcv60S8J5+Ni3C0Itk/vjunyWD6mZcPPQgvjRjfMwcPwOUzTdETa9dR7n4ayGEVF0WSV41j0Zy2wpDtLUVAPiYvQTbfGbXCEbFccYzIRgoDAMgVYlegu1SA3onDkCU5RkT8/tCX49pHsf4frLjnxdbPYl3T0M5/Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IS9MKNvf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48640C4CEF9;
	Tue, 16 Sep 2025 07:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758008719;
	bh=atC+NDqa0LfxetrMUXV/684PEhjI9J/4qvzS5Tca4rs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IS9MKNvfFLZU41niOvXE3SkO9rfzHIaY/zKX+XP+Gc1gWTyHpXzP9g3XPj6oYYWB8
	 KSOsc03KLVc7m3vZaGq+uqILXJh/PYBWLb3kQS1TmveEbv7wQIRBOPhaGOjk9juxU5
	 3eIAyjLx3dmquiqWOxAjzXIGxqpkWpAfsog0iWqIi9v9LIxV+6W0KH3+OfFa6HhbQw
	 dhBfdf82t+Sll0efDNNSkHlzIr2sbmD6IWXEO0MMJytB76wfxJ0gktwcxi3qbNuE2v
	 i1VQnoAA7J/HUH3oUF1qQh5PiDb7izn/ahhnBktvPsyA2uH8aU4fR0ocHswt+47sjJ
	 o/M7pSyX0EK8A==
From: Chris Li <chrisl@kernel.org>
Date: Tue, 16 Sep 2025 00:45:13 -0700
Subject: [PATCH v2 05/10] PCI/LUO: Forward finish callbacks to drivers
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-luo-pci-v2-5-c494053c3c08@kernel.org>
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
In-Reply-To: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Len Brown <lenb@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-acpi@vger.kernel.org, David Matlack <dmatlack@google.com>, 
 Pasha Tatashin <tatashin@google.com>, Jason Miu <jasonmiu@google.com>, 
 Vipin Sharma <vipinsh@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
 Adithya Jayachandran <ajayachandra@nvidia.com>, 
 Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, 
 Mike Rapoport <rppt@kernel.org>, Chris Li <chrisl@kernel.org>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
X-Mailer: b4 0.14.2

When PCI receives the LUO finish callback. The PCI subsystem forwards the
finish callback to the driver with restored dev->lu.dev_state->data.

Tested: In qemu, request a virtio net device as requested.
	Perform luo prepare then kexec. Verify the new kernel boot up
	dmesg shows the requested device has per device live update state
	restored. Perform liveupdate finish and see the device finish
	callback gets invoked.

Signed-off-by: Chris Li <chrisl@kernel.org>
---
 drivers/pci/liveupdate.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 305c5e85aba6bac9d02f97c83e7b3250298d2eff..41606df346f751c78f6c69caa275b4a76be72510 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -264,6 +264,29 @@ static int pci_call_freeze(struct pci_ser *pci_state, struct list_head *devlist)
 	return 0;
 }
 
+static void pci_call_finish(struct list_head *devlist)
+{
+	struct device *dev;
+
+	pci_lock_rescan_remove();
+	down_write(&pci_bus_sem);
+
+	list_for_each_entry(dev, devlist, lu.lu_next) {
+		struct pci_dev_ser *s = dev->lu.dev_state;
+
+		if (!dev->driver)
+			panic("PCI luo finish: dev %s does not have driver", dev_name(dev));
+		if (!dev->driver->lu)
+			panic("PCI luo finish: dev %s does not support liveupdate",
+			      dev_name(dev));
+		if (!dev->driver->lu->finish)
+			continue;
+		dev->driver->lu->finish(dev, s->driver_data);
+	}
+	up_write(&pci_bus_sem);
+	pci_unlock_rescan_remove();
+}
+
 static int pci_liveupdate_freeze(void *arg, u64 *data)
 {
 	struct pci_ser *pci_state = phys_to_virt(*data);
@@ -297,7 +320,12 @@ static void pci_liveupdate_cancel(void *arg, u64 data)
 
 static void pci_liveupdate_finish(void *arg, u64 data)
 {
+	struct pci_ser *pci_state = phys_to_virt(data);
+
 	pr_info("finish data[%llx]\n", data);
+	pci_call_finish(&probe_devices);
+	cleanup_liveupdate_devices(&probe_devices);
+	cleanup_liveupdate_state(pci_state);
 }
 
 struct liveupdate_subsystem pci_liveupdate_ops = {

-- 
2.51.0.384.g4c02a37b29-goog


