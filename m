Return-Path: <linux-pci+bounces-2424-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AF683697E
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 17:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 507791F22330
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 16:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66131823BC;
	Mon, 22 Jan 2024 15:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XzGxj7WR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E344823B8;
	Mon, 22 Jan 2024 15:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936246; cv=none; b=X2x6l/TGwvIw+N00uPAZX9R9FWaTobXRQ2EB/q0441just0DhLXK8X3EGNmz0BaPIffPSuiT+ZJBX5OdELMGq2Xa6lh2WTgSv+pT4aU1x3kVtogyM4mkfuCJAeopFs78rOAPhIdFPu0Slp9QOHBlbAjmmb+rmDx8v9nvlNMURnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936246; c=relaxed/simple;
	bh=JskSdRkoo0zPlNHzPVsJK+zaOzyDnAdrRS/w8B/YknM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QQtuHDDQBuerBSq6Ue8v8aj6VhpaEsPD46ELTA6ikYqHs75bic5Ib4emcJbSmZ+qDFEqZ2YCkfYrrLjPqOVNMbSoR78ru/8oP+kSIIfiYbs8fPuESma/BM+gkxaqh4J/U3ipylCTo9GxBlmZHQcCFW8yFXnCiZQYCvVEUdNFgQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XzGxj7WR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A4FCC43399;
	Mon, 22 Jan 2024 15:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936245;
	bh=JskSdRkoo0zPlNHzPVsJK+zaOzyDnAdrRS/w8B/YknM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XzGxj7WRqPosDBG5jVPgebCcvUaBJ32tPAkOw2i2w4mLf14BeZVJ2JQoV6rg2Kx0f
	 JFlnAKwyckKMljQaOJEqScTtt5vcwrcE246DBWBS/XuiUkn2E46JAYwycOKPA+NswG
	 hnEddimskZ4qgQGbNVmbzDatHVw2sm/5DCDYVf8oTfgGBpp3CtjGmGQ/8TYT0xUNqT
	 nmx7B9SdYi740yHAEKezmQRIRoUL4AEc0fiY+N6sThzrgQ3WV/zKYm7Jpl1Eu72Jnz
	 PFkJ7AnRvR+xpWqYluU6VNadSZOUzH7LW4oJil3Cmj4EuR6+zVFKqt0dLEXj0MfZlx
	 JsJht4g+ULkjg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 21/53] PCI: add INTEL_HDA_ARL to pci_ids.h
Date: Mon, 22 Jan 2024 10:08:22 -0500
Message-ID: <20240122150949.994249-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150949.994249-1-sashal@kernel.org>
References: <20240122150949.994249-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.74
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit 5ec42bf04d72fd6d0a6855810cc779e0ee31dfd7 ]

The PCI ID insertion follows the increasing order in the table, but
this hardware follows MTL (MeteorLake).

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Acked-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/20231204212710.185976-2-pierre-louis.bossart@linux.intel.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/pci_ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index b76ff0850618..73cc1e7dd15a 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -3000,6 +3000,7 @@
 #define PCI_DEVICE_ID_INTEL_82443GX_0	0x71a0
 #define PCI_DEVICE_ID_INTEL_82443GX_2	0x71a2
 #define PCI_DEVICE_ID_INTEL_82372FB_1	0x7601
+#define PCI_DEVICE_ID_INTEL_HDA_ARL	0x7728
 #define PCI_DEVICE_ID_INTEL_SCH_LPC	0x8119
 #define PCI_DEVICE_ID_INTEL_SCH_IDE	0x811a
 #define PCI_DEVICE_ID_INTEL_E6XX_CU	0x8183
-- 
2.43.0


