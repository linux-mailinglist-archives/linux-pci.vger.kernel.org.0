Return-Path: <linux-pci+bounces-22191-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CF6A41CCB
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 12:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 328297AA62F
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 11:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6525B266B6C;
	Mon, 24 Feb 2025 11:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kaOmV1Te"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3CE266B67;
	Mon, 24 Feb 2025 11:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740395919; cv=none; b=hzL/GAuRb4sgpwuCPHhTvMjbZ11sDqkrotH3SxLz7e8TAZrduh5nRIe+GcM5EccMtcvZ9DKpkwU9tJfH5tKZnvElLtSKQ85xzHb0vtOf3BLkdA8v1CyhSnFtcP/xmRDWoOEQoEGDY9PAtUdYDJAgIzaHByaDLvbF/n0H/K0Znp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740395919; c=relaxed/simple;
	bh=HXGONoBrETz851kZQjDwIlLOZ/yI3qbSzzRM421/IJo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OrKjuHMqlspplnyNc/hAf90mpbofXOPCTOtjjTtjAPAjM4l4d7tvh++aqZHeAva9XYzTaVaaNwAADe9zX7e37E9HBMQzWLwD7FH0+OcjAkDlAuzg63tL96LXSxdZF1/nlMRHr7Qb99luZcepAVh4BBFuS3XwtMYYqyo/DBU9nd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kaOmV1Te; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F10C4CEE6;
	Mon, 24 Feb 2025 11:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740395919;
	bh=HXGONoBrETz851kZQjDwIlLOZ/yI3qbSzzRM421/IJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kaOmV1TedCUBkFC2QZzLKWOBiopw18alriC9lKzu00TDsaBJoeNoqK65IoRilet1g
	 NtGPqok/ynZQQCVaYhzUqqTpd5LLDu2BT/UByC7IfNXkAgxskvX/fECzxrQXv+cHPo
	 4ziR07cIjJIjSUjaHfD80LMGEOQDC0CUAggnSjJGV1WVU5jk6Ma3Q8DOUx+Dj59w8y
	 /Zi5kVWJFFzGksK8Yb5d8XK2SeXncBBNfBodfh1AULGIyWuw5pZeaYdWyqZMGHQFtO
	 IKugX1/wtGo9tZowlnRyt+dRQSIz8nujs+OyQK1wBz7ANocKeQDXmu2+VvFR7L7+X2
	 0H0T5kWU/3hKw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 13/28] PCI: pci_ids: add INTEL_HDA_PTL_H
Date: Mon, 24 Feb 2025 06:17:44 -0500
Message-Id: <20250224111759.2213772-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224111759.2213772-1-sashal@kernel.org>
References: <20250224111759.2213772-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.16
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit a1f7b7ff0e10ae574d388131596390157222f986 ]

Add Intel PTL-H audio Device ID.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/20250210081730.22916-2-peter.ujfalusi@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/pci_ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 22f6b018cff8d..c9dc15355f1ba 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -3133,6 +3133,7 @@
 #define PCI_DEVICE_ID_INTEL_HDA_LNL_P	0xa828
 #define PCI_DEVICE_ID_INTEL_S21152BB	0xb152
 #define PCI_DEVICE_ID_INTEL_HDA_BMG	0xe2f7
+#define PCI_DEVICE_ID_INTEL_HDA_PTL_H	0xe328
 #define PCI_DEVICE_ID_INTEL_HDA_PTL	0xe428
 #define PCI_DEVICE_ID_INTEL_HDA_CML_R	0xf0c8
 #define PCI_DEVICE_ID_INTEL_HDA_RKL_S	0xf1c8
-- 
2.39.5


