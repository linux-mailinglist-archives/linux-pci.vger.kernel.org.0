Return-Path: <linux-pci+bounces-8320-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2DB8FCBF2
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 14:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52A0A283EAD
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 12:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0C01AF6CD;
	Wed,  5 Jun 2024 11:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nsseMGOC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963A71AF6C9;
	Wed,  5 Jun 2024 11:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588396; cv=none; b=ZeuyufSHykiVErYLG4O2MhfKVl3et2HUZASY9rCmKRF7FwLs2vjEgqLV+f+kKKuwQ+ZUpOR5hD0cLfDJSJZwL/aPamndMZTC/pMEBjKcGovWxeTD0ysaWU6/Werle1hvHfx7UhgkATjWDeCb0oggzQAuNU8+5+T/h1eoUNARrtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588396; c=relaxed/simple;
	bh=KnKHWBqMNsixSFYLmeVcY+L/MoRxXzbFNwqyHThKhU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AK6zQ52cZAnEPJZ2FAZT/EsXAg0I7RJeNPrmAN4/9bp5gOyaEB857zGU6UVNk7Iq0HxgkxQoHDwaCvKkM+OXA0bS9Evn2LZ5NL0sDvc1kMrLGZIEEt6M2vvAfnwIbkVlKuuHYlHYelAmi3iXW5xOCpGw3kLbx/mTn4SsX+IvJQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nsseMGOC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54225C3277B;
	Wed,  5 Jun 2024 11:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588396;
	bh=KnKHWBqMNsixSFYLmeVcY+L/MoRxXzbFNwqyHThKhU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nsseMGOCRMWDxmVQ6WkTdNHS+TuzYM/9bgjj6BaAY0mEC6aUiXv9G91/p5Oc1GsYT
	 VbpdQacsWdMoi2i0UrY3M2rs4NI68POn+pzKEJ1p4JTofmCBvERNWBOU5yNcBCDYwY
	 PygW/SpCMX2tm6b66tO2WtidlKJExsQwz7jsdCSvbiA2RqfesGO4QC+UXZ8GRo23lb
	 z1t/B5cS6CP2qKSFnXGafycYl+K1MOYgom4z2a8WQF5EUUiT6bn/w+VixfFAiBVIlg
	 WFHln9nWOP42JGFSi1Ste90mVIZTibC5gfYuY1rS1b6ep3Z7IctRYCGC6zI2sO0iN3
	 YfAe8VCFJLcZA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 20/20] PCI: Do not wait for disconnected devices when resuming
Date: Wed,  5 Jun 2024 07:52:03 -0400
Message-ID: <20240605115225.2963242-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605115225.2963242-1-sashal@kernel.org>
References: <20240605115225.2963242-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.32
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
index 26c9d16cb60c3..bb5a1d8bdfbd8 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1190,6 +1190,11 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
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
index ee89a69817aaf..512cb40150dfe 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2484,7 +2484,12 @@ static inline struct pci_dev *pcie_find_root_port(struct pci_dev *dev)
 
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


