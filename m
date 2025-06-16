Return-Path: <linux-pci+bounces-29892-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A042AADB98E
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 21:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D472C3B6F43
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 19:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FEC289E14;
	Mon, 16 Jun 2025 19:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3QcwloQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0A42E40E
	for <linux-pci@vger.kernel.org>; Mon, 16 Jun 2025 19:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750102103; cv=none; b=s/+sLNwFergBLwH4lu+wYgQqdFqUBYd/fYAVAG6zk0cUVFT7QL011aj2Wp74jmw7aZ0SN/vCzcsqs91bfNVRegFe1JPepQJTyv/mmF+Kaa2qVrjtOQmbUAY5bQH0N66rqxE9bfF6Rx5Bh0yAVexAF+qljy6YzbJy3hMJcDTGQzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750102103; c=relaxed/simple;
	bh=IuUSHuICNT6VDr2kGhY7r9UdTJKfGEQciUGw8PV9XY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r+sAEtymx3e3bl7v5KfyeS/gOUzRoXuI1h2j/jLJFgdYZL6z/RE3HJdWgUuEIMhC9LNGae+jkEvi6cTeRcTZ87k0+HcB99ksrMJh8JsSeKW4A+SSJXv1pTkeiU/d8JqVEAkHts4mB0FRgivlthd+RKZknuVdXzmMWQU1eiUkBUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3QcwloQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52371C4CEF1;
	Mon, 16 Jun 2025 19:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750102102;
	bh=IuUSHuICNT6VDr2kGhY7r9UdTJKfGEQciUGw8PV9XY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F3QcwloQZwiNAMT8Hrbd5/sEV9uOFjIAksR7RsYNEFh1deRVcoQDe6fTsmonpmJsj
	 peH/bm2vlimB6aguTYPjC/aMuDqgTGyzxfQF0XNSrNHa9nxHjJa+vsmMN9gfzDzyH6
	 psQ4V5ANPJvaQA69AF/cWLEnuMRGER9MJCqqrP1StjLXwqBwMX4xxm3doG5tXparoC
	 Ypz+2HbhYhDu6h5DBmzJ+vUSPxresjiYxxGtk416dTzMbzaGwxYMlDvMbAiuq6eOyO
	 yaOdG2DeJ3DmEHd4qHgRVoUj388xdfTLCqq2R9iYskM8vnYkPwZ/kMFB9xMTweCu02
	 p5ZnR2KCo3lVg==
From: Mario Limonciello <superm1@kernel.org>
To: mario.limonciello@amd.com,
	bhelgaas@google.com
Cc: linux-pci@vger.kernel.org
Subject: [PATCH v2 2/2] PCI: Fix runtime PM usage count underflow
Date: Mon, 16 Jun 2025 14:26:57 -0500
Message-ID: <20250616192813.3829124-3-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250616192813.3829124-1-superm1@kernel.org>
References: <20250616192813.3829124-1-superm1@kernel.org>
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

When PCI core gets to the point that the device is removed using
pci_device_remove() the runtime count has already been decremented and
so calling pm_runtime_put_sync() will cause an underflow.

Detect the device ishas been disconnected and skip the call for this
cleanup path.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * Use pci_dev_is_disconnected()
v1: https://lore.kernel.org/linux-usb/20250609020223.269407-1-superm1@kernel.org/T/#mf95c947990d016fbfccfd11afe60b8ae08aafa0b
---
 drivers/pci/pci-driver.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 67db34fd10ee7..0d4c67829958b 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -479,7 +479,8 @@ static void pci_device_remove(struct device *dev)
 	pci_iov_remove(pci_dev);
 
 	/* Undo the runtime PM settings in local_pci_probe() */
-	pm_runtime_put_sync(dev);
+	if (!pci_dev_is_disconnected(pci_dev))
+		pm_runtime_put_sync(dev);
 
 	/*
 	 * If the device is still on, set the power state as "unknown",
-- 
2.43.0


