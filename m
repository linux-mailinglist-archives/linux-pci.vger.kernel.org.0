Return-Path: <linux-pci+bounces-30224-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3459AAE1170
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 04:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9730F7ADBAF
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 02:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521221D7E41;
	Fri, 20 Jun 2025 02:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/2JbYqp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E5F19CCFA;
	Fri, 20 Jun 2025 02:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750388140; cv=none; b=qwWAFFlG0ULT17kDEix0D8s5GL0tGzqsliJIGpP7i1MpSBRtigMc63a/ApgL7Q4SfqxqnpwRcHtikE/pTmLD3WD8S3RPmvzRtEWx9uJokrMz+Pn5vJHH+mo7Ltzv57jdddqnGzMRkoH21yLr5WTiIdxQ1vWxm148IbH+UBIc1DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750388140; c=relaxed/simple;
	bh=jPA1olMTWa2BHo+uYQO/iSse65JiJVx+iRIUnTVzmXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aw9BwImhx0AGBGIVQodFk8zOSsyW2qrHM0qWC6kdjQw4OQmsjzbZd0KkDWj10Q/xNLwVP2XFBhOI9T7r6p4UW6wjz7/cPddJqrbMHhNIWa2fI0V541/t366WWx8Mn9l6J4FVbfrGZu8T2FngWvDFomQnDTIiloEJAI0AyqPMgf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/2JbYqp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3395CC4CEF1;
	Fri, 20 Jun 2025 02:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750388139;
	bh=jPA1olMTWa2BHo+uYQO/iSse65JiJVx+iRIUnTVzmXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g/2JbYqpITLCH8No1hTY0nXGIVliJRB4bNMa4k4jOBHA2r70pyqDMJhRYwMpWqbie
	 Ni+6KhrhRcILuA80FzO5mpoSb3ERQ2DoriceQkXTvH7pXahAR3X45HncTHKWrk7DkC
	 nK1xclewQx5cmd02d20k/QqvOrkSlU6v1kTkhxugZQdJ/tUOp9ZI+QOOG/5QH5JKQ9
	 A+DwaIPynAbgIrT/5JI9WSsWP3AEAXqvCHfdnOS3O0IwFEAhTIFd7PYJecaWLAyBXT
	 Ouf0FUXKFn81oARarYLkiuExripDb2oV5LoPW8tbSh+y7PHE+VHIqKhsEE8N1FTepD
	 4SjQKQzsRQxMQ==
From: Mario Limonciello <superm1@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM)
Cc: linux-pm@vger.kernel.org,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 2/2] PCI: Fix runtime PM usage count underflow on device unplug
Date: Thu, 19 Jun 2025 21:55:35 -0500
Message-ID: <20250620025535.3425049-3-superm1@kernel.org>
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
devices.

pci_stop_bus_device() will call device_release_driver(). As part of device
release sequence pm_runtime_put_sync() is called for the device which will
decrement the runtime counter to 0. After this, the device remove callback
(pci_device_remove()) will be called which again calls pm_runtime_put_sync()
but as the counter is already 0 will cause an underflow.

This behavior was introduced in commit 967577b062417 ("PCI/PM: Keep runtime
PM enabled for unbound PCI devices") to prevent asymmetrical get/put from
probe/remove, but this misses out on the point that when releasing a driver
the usage count is decremented from the device core.

Drop the extra call from pci_device_remove().

Fixes: 967577b062417 ("PCI/PM: Keep runtime PM enabled for unbound PCI devices")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v3:
 * git archeaology
 * Drop call alltogether, not just for the device disconnected case
v2:
 * Use pci_dev_is_disconnected()
v1: https://lore.kernel.org/linux-usb/20250609020223.269407-1-superm1@kernel.org/T/#mf95c947990d016fbfccfd11afe60b8ae08aafa0b
---
 drivers/pci/pci-driver.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index b78b98133e7df..63f1cb11906ad 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -478,9 +478,6 @@ static void pci_device_remove(struct device *dev)
 	pci_dev->driver = NULL;
 	pci_iov_remove(pci_dev);
 
-	/* Undo the runtime PM settings in local_pci_probe() */
-	pm_runtime_put_sync(dev);
-
 	/*
 	 * If the device is still on, set the power state as "unknown",
 	 * since it might change by the next time we load the driver.
-- 
2.43.0


