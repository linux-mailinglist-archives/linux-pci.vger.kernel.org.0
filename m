Return-Path: <linux-pci+bounces-2425-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FDA836A15
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 17:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D2D71C24A27
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 16:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81725133405;
	Mon, 22 Jan 2024 15:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1Ud4kuu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA30133400;
	Mon, 22 Jan 2024 15:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936420; cv=none; b=phdvDsrsm1dmDa+MMhZZHBJ8nut/ljmtEb+irKOE+r+zp7F3ObVavD2Q/Um7jhBGkE1XEsOshHmyjT9sqgx6eOFtQu4XY0K8AHs0oZd7xmL+gz8Ta4z3jZ+FddseCOoeThh4Z8NgGMhFk5hDHh3uH89tUOdOy+XVh/+YtPHfLHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936420; c=relaxed/simple;
	bh=lQOSQ28UkDSE40o9G5OVcuJT0caczPt1IrfMwV8sRq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j9GWD7FbUYwSkMMPPolP9Y1xu3bqRgq2m82wbz/zuybmLsexD5UPYf7slz0m0dQg98/u2bwhu6k+XsCkh8tNQbbsqPGyOl6MT5v8DwWY36Dttu9tiHXQG5ae0SVJKUWzTozIb5FeGt4/KN9x87M7uF9XxaEAyjzuuqzvkWWroks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1Ud4kuu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDDD7C433F1;
	Mon, 22 Jan 2024 15:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936420;
	bh=lQOSQ28UkDSE40o9G5OVcuJT0caczPt1IrfMwV8sRq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u1Ud4kuunyQGrWHr9wvRGwVL/tsIJ+/MMWkjAPITbUMYUyWnebIZlI0KlF7QAVXHy
	 35k9Q+h2MEH1Jn673gIyb26guWQn5EFu7CJKSdMOhxaMQg4NScQmqydLQR3BIBHqMU
	 m5bPEpPP6kjRflmP/MD+3oGjeKQjsBzcgemgJgOs0xnB4+S2H0Vih9QK2RA9Y5vgNq
	 ZX2h7l4eoAamCh5lALtp0wHd/Myc+Es9X2pH/0oBsgh1ofo06oq7hyTBM82lshopiA
	 zsAJLH+n1+BQgnHYZYM8E1yyx9m03zjLMuiADXEngy+ZrIOdu1vGr+o4ZKZzMkwOL8
	 9Bt7fnqkzvCNA==
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
Subject: [PATCH AUTOSEL 5.15 15/35] PCI: add INTEL_HDA_ARL to pci_ids.h
Date: Mon, 22 Jan 2024 10:12:12 -0500
Message-ID: <20240122151302.995456-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151302.995456-1-sashal@kernel.org>
References: <20240122151302.995456-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
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
index d2d5e854c692..2590ccda29ab 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2999,6 +2999,7 @@
 #define PCI_DEVICE_ID_INTEL_82443GX_0	0x71a0
 #define PCI_DEVICE_ID_INTEL_82443GX_2	0x71a2
 #define PCI_DEVICE_ID_INTEL_82372FB_1	0x7601
+#define PCI_DEVICE_ID_INTEL_HDA_ARL	0x7728
 #define PCI_DEVICE_ID_INTEL_SCH_LPC	0x8119
 #define PCI_DEVICE_ID_INTEL_SCH_IDE	0x811a
 #define PCI_DEVICE_ID_INTEL_E6XX_CU	0x8183
-- 
2.43.0


