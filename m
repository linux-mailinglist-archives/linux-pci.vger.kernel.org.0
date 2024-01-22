Return-Path: <linux-pci+bounces-2427-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48427836AE5
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 17:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 003D8280DF0
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 16:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E8B148FEF;
	Mon, 22 Jan 2024 15:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVR20TPW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DE5148FEC;
	Mon, 22 Jan 2024 15:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936647; cv=none; b=kINdTvfX6uQaYsOkOx3d780zZ6YWtFcNRVL3TN0MnkdMRdA+6v7QU+0C2vPX/rTTjRtcyS73FJfdFutpU9HLlmTxJUQi16Z/3iSG6W7M1NNb6VnZLBNlfoa0NKb2U9j2m5YgbuohvoHnnitvqdDb1AbJq+lWFfsr/Bdu66KJPvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936647; c=relaxed/simple;
	bh=JJN/GoOqH5N8ePvai55B8lM1XmfhSU9g7dxUEstOPE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SqugW1XG44E30kk5qLjK316HQpMiuEyDYHviYerjgKtkv0x0srP0N4qY2Mkb+HLXZvl1jLUunI2GMtTm/TiXkb60UYSzp4iAbh04xvH+T2IiyEcp6ELqtS+AebE5GAEL9HYPCpnUv8NtG8O1cDY/bdjpifcRgFh+pgGXaSr0HNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qVR20TPW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DEFCC43394;
	Mon, 22 Jan 2024 15:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936646;
	bh=JJN/GoOqH5N8ePvai55B8lM1XmfhSU9g7dxUEstOPE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qVR20TPWKBDNihaTTbn4D1C3QWYYdU6FcunX099Od3bBYOiLJ4dfl6khf5VQXpzzI
	 cQzRAFE448CU7CQm/LuofbstUE7PLQ75F5hb5KtbsuwE3jjW87RG3yUPCtLJU9xvD9
	 zZWeKFoTBOlDBltCIrQeC9UNPo/55bkXVZ28d45du4d/5MAT3h+1cvkrte1O0hYYwV
	 z7ksR4OnZDErJFPKOYBv96D7KrBzMWVbD7j+INl3FQGCLrz+1ootHs4R1H3NWoibG0
	 w/9w/dqt3LZM+yRi12SmsbSCa5ge/xWDhGB8NvtVBFcFSH4u2JePYmA1z2tGzJDYsL
	 ptgdbamrH6azA==
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
Subject: [PATCH AUTOSEL 5.4 12/24] PCI: add INTEL_HDA_ARL to pci_ids.h
Date: Mon, 22 Jan 2024 10:16:26 -0500
Message-ID: <20240122151659.997085-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151659.997085-1-sashal@kernel.org>
References: <20240122151659.997085-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.267
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
index fcacf2334704..d8b188643a87 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -3011,6 +3011,7 @@
 #define PCI_DEVICE_ID_INTEL_82443GX_0	0x71a0
 #define PCI_DEVICE_ID_INTEL_82443GX_2	0x71a2
 #define PCI_DEVICE_ID_INTEL_82372FB_1	0x7601
+#define PCI_DEVICE_ID_INTEL_HDA_ARL	0x7728
 #define PCI_DEVICE_ID_INTEL_SCH_LPC	0x8119
 #define PCI_DEVICE_ID_INTEL_SCH_IDE	0x811a
 #define PCI_DEVICE_ID_INTEL_E6XX_CU	0x8183
-- 
2.43.0


