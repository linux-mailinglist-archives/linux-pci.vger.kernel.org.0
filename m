Return-Path: <linux-pci+bounces-2426-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D818C836A7C
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 17:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 173091C24A8F
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 16:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F4E13E234;
	Mon, 22 Jan 2024 15:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5nFY1ZS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8573C13E22F;
	Mon, 22 Jan 2024 15:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936559; cv=none; b=e+0YT8ll1ur/0ZjouQDfq6/wFf88kn3MkERC3UlDoZ3HbzZ+D8LvrbMAx9kS4CjoI0s+l7C35w7NMOkOpJ63F2MGxqlHTcWVmpfxc59oM64Z4mBJoai7t/j8EIjeG8nHaSkLrGcAUvrn9n2FCU+m7cHcOYisKKqLKgjA/KxpQ3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936559; c=relaxed/simple;
	bh=msXDYHGXUUrvP5rOtftQbzOuFk8Y2ReFDcFCMxE/Si4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C58wtYwWbi2MPwW11f65rEeCah4Wm++jRZMiIS3xvFR7PJlnEth/4AFXERjImZQVolhfMAgvNZf5Or+IR/ayhGwbKmmW9GLritH+l8asTNPjCbWNWFt8mgSUiRQZPz9KwW3zbontnzx9mJqUidpiUqpVg7BSSme8UqUuNZhcOGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5nFY1ZS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E0AC43390;
	Mon, 22 Jan 2024 15:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936558;
	bh=msXDYHGXUUrvP5rOtftQbzOuFk8Y2ReFDcFCMxE/Si4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j5nFY1ZS/LdRJbyKCge1AhgKGWkzVPC7wdh02WBT/2iSLt6kvfelUJ0hKdsBZoFOI
	 SXc1vgYMpl+a3I2sT/WbKO0Pae1M1Q+YQjd50TU5slK7XkdID09sum2im0SXW9Kabp
	 T9KAB/Gz2iDketxKg7G8Yed6yODVGf3pioiWXvS4Zyfj+5fpiT1EZtdEijGdmK3CIE
	 U1zNMj5EKzFj2Y9lZ4CEn5nIwHzVDRgjtrqLm9Tt1u2cxE3vPG8VlC+rUT7uGQcwj1
	 lryfmzbmZXuov/JS1Ncpd+BFVikWBW+MRLsVP0eYvOFbw0x5Si7iN9+VkVBt9kbGgQ
	 iOJy1IMVsll9A==
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
Subject: [PATCH AUTOSEL 5.10 15/28] PCI: add INTEL_HDA_ARL to pci_ids.h
Date: Mon, 22 Jan 2024 10:14:41 -0500
Message-ID: <20240122151521.996443-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151521.996443-1-sashal@kernel.org>
References: <20240122151521.996443-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
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
index 1a41147b22e8..80744a7b5e33 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -3020,6 +3020,7 @@
 #define PCI_DEVICE_ID_INTEL_82443GX_0	0x71a0
 #define PCI_DEVICE_ID_INTEL_82443GX_2	0x71a2
 #define PCI_DEVICE_ID_INTEL_82372FB_1	0x7601
+#define PCI_DEVICE_ID_INTEL_HDA_ARL	0x7728
 #define PCI_DEVICE_ID_INTEL_SCH_LPC	0x8119
 #define PCI_DEVICE_ID_INTEL_SCH_IDE	0x811a
 #define PCI_DEVICE_ID_INTEL_E6XX_CU	0x8183
-- 
2.43.0


