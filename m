Return-Path: <linux-pci+bounces-2422-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A77CA836730
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 16:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EE001F22D72
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 15:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E2E4F895;
	Mon, 22 Jan 2024 14:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPULy5oB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A965D4F891;
	Mon, 22 Jan 2024 14:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935486; cv=none; b=TT2TuLG3c6pc4RfVvKzj+oBTI4pICiVZvFsg060uLr6/LHKac1CE5ducYrkCwnsKzJql36PLSu0W77YiCqaxgWXv2G9FqD9n/ibELyn72UFIMo+H+RStrIeX5CboaBucC4PZGI28Uv7Z8YCC+Vz5UTwnCM/rwaX5ja3secNUSYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935486; c=relaxed/simple;
	bh=Na4YO0JjGFwKvNknEcCzXZmeYejhdT7chmhMjnYgpEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pPmsKNPATUL532JO+lP9TLa8D21Qoui4AHopHsPy1PMIwGp5cWqVfpc2G+MTuJ8olWWCBKFIwIUIEOyxGydoWkqdxVxj/vfTLiC8KW1b3lOVcAnxfAiM+6Qd3+m53WGbxphdthrChAx6Aa7jBecdo3IYPoJtdNybohXqr1wpby0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPULy5oB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE5EC43399;
	Mon, 22 Jan 2024 14:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935486;
	bh=Na4YO0JjGFwKvNknEcCzXZmeYejhdT7chmhMjnYgpEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JPULy5oBi4eIuLiTT4A3kAREWT/XPI8PrzpitWyLR2JsU23XN82HAKFDkiiM6ECMt
	 UGz+1jIWbbVU/mOGkynHm0FIH947bheiy3GhMuOZCJZ0Bk3vmLWQLjDVb74vyWaPru
	 Row/UxBCuVrTN0YGZSPlGA2YGQ5SIYf8Ph5IcgYel1wIRt4TTqyEk04BIze2OHgeyu
	 o4rTPCGRYg8fbyO5mhRbzyBBKtZ5xy6qNF7AwR9n8FzDNPFqearcNHWbq/DCUqMHKk
	 GwTjHU/MeyypnHdAPJPt/U7VdzJqjftDCk5HyhXEoNfuDC0AgxQYPKSG9oK5ba+xGY
	 2xJA9E+uu7Xgg==
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
Subject: [PATCH AUTOSEL 6.7 29/88] PCI: add INTEL_HDA_ARL to pci_ids.h
Date: Mon, 22 Jan 2024 09:51:02 -0500
Message-ID: <20240122145608.990137-29-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122145608.990137-1-sashal@kernel.org>
References: <20240122145608.990137-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.1
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
index 275799b5f535..97cc0baad0f4 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -3065,6 +3065,7 @@
 #define PCI_DEVICE_ID_INTEL_82443GX_0	0x71a0
 #define PCI_DEVICE_ID_INTEL_82443GX_2	0x71a2
 #define PCI_DEVICE_ID_INTEL_82372FB_1	0x7601
+#define PCI_DEVICE_ID_INTEL_HDA_ARL	0x7728
 #define PCI_DEVICE_ID_INTEL_HDA_RPL_S	0x7a50
 #define PCI_DEVICE_ID_INTEL_HDA_ADL_S	0x7ad0
 #define PCI_DEVICE_ID_INTEL_HDA_MTL	0x7e28
-- 
2.43.0


