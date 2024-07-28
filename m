Return-Path: <linux-pci+bounces-10885-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D964393E7A2
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2024 18:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1680C1C213E5
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2024 16:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598F812C530;
	Sun, 28 Jul 2024 16:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sNWV48gs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE8C12C49C;
	Sun, 28 Jul 2024 16:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722182768; cv=none; b=Nn49ljA8CH7NzDVivvQSNqOzR645e4iEdVTw2JWI+fNqEVF1Gw2uYQfLVm0Lo/doUMZU9epozMdikyaa9NzmPKFOC5wC9qM6WfDELrCmJiFYZ1S6wF+3DxX3YZvL5kXby0Ug7tIU9sQAPGK/KEHkMTFOSYEtGgdj+4Cn8TpKe9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722182768; c=relaxed/simple;
	bh=1RX0+wkHNMYF5YtyKwKNieuYJZb9r7TXdNS+f4Gv3ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WhoK/hvoucyGYUHH18o9GOMqJuK+Mvn/mSc5axpF782TszX8DoWnx2r41LpSPg9863TSzruHVmsiOvDOi5IoG2JgwbOz9o5TIpwjulzEz8iSGXpqIDpgInEAeE/X47WCZTpoHzPCZlcYXCzUWUcUigo5Yr0JJlBKRBf+USKmqeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sNWV48gs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA0B2C4AF0A;
	Sun, 28 Jul 2024 16:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722182768;
	bh=1RX0+wkHNMYF5YtyKwKNieuYJZb9r7TXdNS+f4Gv3ek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sNWV48gsHUIVuqkFdnOouh60NgCtNfbsOxGPQbbJGmjcVvugY3m6YwVy3QHxmrU4b
	 zBwlHMybwLvtFk0WwCjkv/IbNOaVwg+7fIoZHqLx4XfAKL5q1PbL0cZLwM/3rwrJEr
	 Stfzwz8NxqhKxpCtDbrvk8sRiWwDr8syeI1inXcJKVXG/x1POZj07tdTJ6hBPfge/h
	 kgA03rxDzx/4v1qCDKVVOEX2+RVoz+i8UkliFcoq0I7FG5YAT4b/kThsoZ/Lp+UxeU
	 OZxtNddQOAwwr0Lbqq56yP715w33kYfndbkIsOixigyz3brD1At5LIjSd2v0dGivcI
	 r1r7NTEzfyW+w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 11/23] PCI: Add INTEL_HDA_PTL to pci_ids.h
Date: Sun, 28 Jul 2024 12:04:52 -0400
Message-ID: <20240728160538.2051879-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728160538.2051879-1-sashal@kernel.org>
References: <20240728160538.2051879-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit 163f10b2935362f0e8ef8d7fadd0b5aa33e9130f ]

More PCI ids for Intel audio.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20240612064709.51141-2-pierre-louis.bossart@linux.intel.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/pci_ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 942a587bb97e3..0168c6a60148f 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -3112,6 +3112,7 @@
 #define PCI_DEVICE_ID_INTEL_HDA_LNL_P	0xa828
 #define PCI_DEVICE_ID_INTEL_S21152BB	0xb152
 #define PCI_DEVICE_ID_INTEL_HDA_BMG	0xe2f7
+#define PCI_DEVICE_ID_INTEL_HDA_PTL	0xe428
 #define PCI_DEVICE_ID_INTEL_HDA_CML_R	0xf0c8
 #define PCI_DEVICE_ID_INTEL_HDA_RKL_S	0xf1c8
 
-- 
2.43.0


