Return-Path: <linux-pci+bounces-2428-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E31836B4E
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 17:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5643B1F21F12
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 16:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F7C151466;
	Mon, 22 Jan 2024 15:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdQ7Lw+8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27B3151460;
	Mon, 22 Jan 2024 15:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936727; cv=none; b=cbX4UpJlcK/r0j9dk1z6g67qz9xtZc4NIEt3171WMvcJ+c0a1QE1XND+yeT6T7YoKb2M/I8LR6ILctUbIYZL2G/5tjdonCWboZ+hFAIUPOgb3y2rsnM+13+ZJd4byq22UxjTYa8rOlH11Vrd1Nkho33iaVURVwr+5WeA+VjbiZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936727; c=relaxed/simple;
	bh=xNLPbC33qbiFNlEQQCES7BLoTBUKClHXHSMgmyaOfxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EimIFMv//dYa/fItIJW3cSfVU888VGKW81OHqWPnyxdLoNM5EplTo2W49E2k2oqG6HDihsYWT3VM2vWRGbuBO00/oW43Lxz1owWz4o2X8no4sEG38NvoPbAZCyH+hGr3RCBVStZEfVXOIBLRLuAKkVElJdfD9Y/a2J3qBMjzc3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdQ7Lw+8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C03C43390;
	Mon, 22 Jan 2024 15:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936726;
	bh=xNLPbC33qbiFNlEQQCES7BLoTBUKClHXHSMgmyaOfxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EdQ7Lw+8UzZA8ZgHso4YJnKTGA6vwoBSL58v4LhI4PGLRDzxL5Dwqf2cVBnKXbrZ/
	 kwoSla4mfiIwhcOKc70ZfOzlHGdt+u7sasfhaisHMqNZZdy0C0jaL8+IiAak+o8Q+c
	 xilcvEAvoGAcjL3myBRK0LJT1ui4TAgJ7/53PKBqKOtwf3AOVWvtTwC+BC2HDJay8+
	 eB4DqVAnIcdEZdAGucZd4B2CdQHGRmRubp1swT5zXLstHHyICTFJzpZvjqCyHjuWrq
	 6LgzIZ1d6ems9GyO0ZrtpI4oHKr9nV2nAT7NG6gRvnsQ/iVKWKVl1hsaIa9+x6eYBh
	 XMVeNhRQ7830w==
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
Subject: [PATCH AUTOSEL 4.19 11/23] PCI: add INTEL_HDA_ARL to pci_ids.h
Date: Mon, 22 Jan 2024 10:17:51 -0500
Message-ID: <20240122151823.997644-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151823.997644-1-sashal@kernel.org>
References: <20240122151823.997644-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.305
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
index 76d5490231a7..3ac7b92b35b9 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -3004,6 +3004,7 @@
 #define PCI_DEVICE_ID_INTEL_82443GX_0	0x71a0
 #define PCI_DEVICE_ID_INTEL_82443GX_2	0x71a2
 #define PCI_DEVICE_ID_INTEL_82372FB_1	0x7601
+#define PCI_DEVICE_ID_INTEL_HDA_ARL	0x7728
 #define PCI_DEVICE_ID_INTEL_SCH_LPC	0x8119
 #define PCI_DEVICE_ID_INTEL_SCH_IDE	0x811a
 #define PCI_DEVICE_ID_INTEL_E6XX_CU	0x8183
-- 
2.43.0


