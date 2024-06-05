Return-Path: <linux-pci+bounces-8318-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 871328FCB9E
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 14:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8066F1C235E2
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 12:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A85F1A2FDF;
	Wed,  5 Jun 2024 11:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b0YsRj8r"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3266F1A2FD9;
	Wed,  5 Jun 2024 11:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588320; cv=none; b=BA0G6tV8cF8LeWeP1ZhkQ9OpOIDKW3IwQzd1YIY4J2ggJQq1bZskDQjYkHvYZDr2gacm53d7ONijBDdpAWJ7wpgBLY7AItMKu7Frlu4S9D/PsGlUZ+auuZiV/W3PI7FxN22d97v2raFEPKgLnIfHt7RGY/ZVp/DY2c8BWLkpxV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588320; c=relaxed/simple;
	bh=GfBw9xyioKxp7porRMxoMZgGzTbaY0W78q0oLcabsmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pydIgGPVPv7/lRjTzROoiAp2jCTxp586kT2yxsZuGX9s8yTSTzeJcxnEGa0h1EqeCtx1l6NpNqozZpz+UvBdVGDHB4gnineTAhO+p3gI8U9i//fzcEvC96pWSyiF1Tr66bYG8BN1gvqimz6v+Z1eBTzAr7r8RcvbHezw4sVZxF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b0YsRj8r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD55C4AF07;
	Wed,  5 Jun 2024 11:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588320;
	bh=GfBw9xyioKxp7porRMxoMZgGzTbaY0W78q0oLcabsmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b0YsRj8rNcF1thB1dN4pWXtyPtV6iYd2ql6C1GdSqY6pRt8+Lk/amzNrogsPtType
	 5SgzqUN6Aa+RCl5nP+J0rkR9Ij0yds9cO7xq1LuW8mDHFLzp/xln40SqtuyY6PR8S+
	 gTGHiRjKLdgqSZZWxrheuirrlyUfRqJhPQDNNZ985MGr6CmoR76HVuCN5lm3Q6/869
	 7600Q7H1lSTNTIuiE7GTzVjk/fBjyG+Jzz3fY7gtf21yaVAL/1LYyUyW/oSD6C5D4j
	 lW237AIX4x0CSSrwZaIqbmtP/Hyg6xkxmHbEf3enzKgX1no3/asoSug7d2fW9SO9C9
	 360GFzbmbhlSw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 23/24] PCI: Do not wait for disconnected devices when resuming
Date: Wed,  5 Jun 2024 07:50:33 -0400
Message-ID: <20240605115101.2962372-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605115101.2962372-1-sashal@kernel.org>
References: <20240605115101.2962372-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.12
Content-Transfer-Encoding: 8bit

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit 6613443ffc49d03e27f0404978f685c4eac43fba ]

On runtime resume, pci_dev_wait() is called:

  pci_pm_runtime_resume()
    pci_pm_bridge_power_up_actions()
      pci_bridge_wait_for_secondary_bus()
        pci_dev_wait()

While a device is runtime suspended along with its PCI hierarchy, the
device could get disconnected. In such case, the link will not come up no
matter how long pci_dev_wait() waits for it.

Besides the above mentioned case, there could be other ways to get the
device disconnected while pci_dev_wait() is waiting for the link to come
up.

Make pci_dev_wait() exit if the device is already disconnected to avoid
unnecessary delay.

The use cases of pci_dev_wait() boil down to two:

  1. Waiting for the device after reset
  2. pci_bridge_wait_for_secondary_bus()

The callers in both cases seem to benefit from propagating the
disconnection as error even if device disconnection would be more
analoguous to the case where there is no device in the first place which
return 0 from pci_dev_wait(). In the case 2, it results in unnecessary
marking of the devices disconnected again but that is just harmless extra
work.

Also make sure compiler does not become too clever with dev->error_state
and use READ_ONCE() to force a fetch for the up-to-date value.

Link: https://lore.kernel.org/r/20240208132322.4811-1-ilpo.jarvinen@linux.intel.com
Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pci.c   | 5 +++++
 include/linux/pci.h | 7 ++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 9d5d08a420f1a..0658b374d988c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1250,6 +1250,11 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
 	for (;;) {
 		u32 id;
 
+		if (pci_dev_is_disconnected(dev)) {
+			pci_dbg(dev, "disconnected; not waiting\n");
+			return -ENOTTY;
+		}
+
 		pci_read_config_dword(dev, PCI_COMMAND, &id);
 		if (!PCI_POSSIBLE_ERROR(id))
 			break;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 213109d3c601d..b692472616efb 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2519,7 +2519,12 @@ static inline struct pci_dev *pcie_find_root_port(struct pci_dev *dev)
 
 static inline bool pci_dev_is_disconnected(const struct pci_dev *dev)
 {
-	return dev->error_state == pci_channel_io_perm_failure;
+	/*
+	 * error_state is set in pci_dev_set_io_state() using xchg/cmpxchg()
+	 * and read w/o common lock. READ_ONCE() ensures compiler cannot cache
+	 * the value (e.g. inside the loop in pci_dev_wait()).
+	 */
+	return READ_ONCE(dev->error_state) == pci_channel_io_perm_failure;
 }
 
 void pci_request_acs(void);
-- 
2.43.0


