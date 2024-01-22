Return-Path: <linux-pci+bounces-2423-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E51A8368A9
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 16:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D51CB29671
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 15:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EB564A87;
	Mon, 22 Jan 2024 15:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rLrQ7ajd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BFC6351E;
	Mon, 22 Jan 2024 15:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935940; cv=none; b=eW5fObM1KIwj/Kh2K31iwkUlHCygDrxgPqo6O8SxQnqPADzUDjH//AzF2hJBfvpZWKuThXW3WeVr/Uglux5prJpbcdSOeR63RuolRnkKoqGOWjzqjAXzvgwJU7YtmaVNMzjObQJPtGSNHgwKGl3HQeMMsI8KEW+DvnUjefxqHG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935940; c=relaxed/simple;
	bh=mLVvv8Y4Qn7Ze20yy8xK5iefMRIJ6KvdipG1FZupBNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XxJPiGJsQXr4vCLCG3mxDLBChe5qEbF9JywZQ4NA1jVklwHWcsyCH+yyZYQODsLzCHPzt2WoAi7YnwztGBlxvbcv/Pomp+HMDLTYmGwV1DsDH3aS/58T2NC+k+tjvOjRol4eLYtUp+le1tDiR+7NXajvlBP84eQBIzjl8dlvIFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rLrQ7ajd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5385CC43390;
	Mon, 22 Jan 2024 15:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935939;
	bh=mLVvv8Y4Qn7Ze20yy8xK5iefMRIJ6KvdipG1FZupBNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rLrQ7ajd9EDA6AIF93WbwvxvBxU6D3lJF3rJ2XUN4s3Fwouq6Th99h0M2B07rNCYK
	 5O7J14DD9tmK73s3zlBF4ko6MDXTgyhWLd04kwe+MDwcd3ceG43vaGql7wH7YNNGEn
	 /sMiQjeyaLAsv0i0tdrUzeNqGyzH18piTKqrg2jYpX1h5IqXrRGJ9VnPmT6kyKRqFA
	 PDCYOdCqhpu03SPmMlNAFL1xaNeqTzvoecfFeVmOSbn7DYTe7SxTvSQ2nPzwjAQByo
	 W8Q6ax7tnlDItDMUZ4t5uwz17/bu/WU2a+fJOvKzKdmVw1Dc1QVXDPRCIgkmP5n97w
	 HC21yCIocAHBw==
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
Subject: [PATCH AUTOSEL 6.6 23/73] PCI: add INTEL_HDA_ARL to pci_ids.h
Date: Mon, 22 Jan 2024 10:01:37 -0500
Message-ID: <20240122150432.992458-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150432.992458-1-sashal@kernel.org>
References: <20240122150432.992458-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.13
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
index fe4a3589bb3f..a6c66ea80194 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -3064,6 +3064,7 @@
 #define PCI_DEVICE_ID_INTEL_82443GX_0	0x71a0
 #define PCI_DEVICE_ID_INTEL_82443GX_2	0x71a2
 #define PCI_DEVICE_ID_INTEL_82372FB_1	0x7601
+#define PCI_DEVICE_ID_INTEL_HDA_ARL	0x7728
 #define PCI_DEVICE_ID_INTEL_HDA_RPL_S	0x7a50
 #define PCI_DEVICE_ID_INTEL_HDA_ADL_S	0x7ad0
 #define PCI_DEVICE_ID_INTEL_HDA_MTL	0x7e28
-- 
2.43.0


