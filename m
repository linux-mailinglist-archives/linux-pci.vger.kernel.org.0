Return-Path: <linux-pci+bounces-22190-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAC5A41C73
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 12:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1AD03B9ABF
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 11:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F256260A2E;
	Mon, 24 Feb 2025 11:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBX19GAP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F83260A2B;
	Mon, 24 Feb 2025 11:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740395841; cv=none; b=Rzm6mJefOLqbr13eHOFXnve7fYSx1Ozc3LqaRSXCvyPRQPm2Dri0WmfDuk+hQJo/kU9YR2e+AWsWswPItygyAmTuWLqD9xbYmrhtSlVTbnm5o8/O0TJAeotb0hkRa5UnyVGIuY/JSUqwYhRxtDxKnjXhK31fplo/wpx0c2TTNao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740395841; c=relaxed/simple;
	bh=gvXOKDHTJ21i4zONuRdj8+AXWrD2W12VvECtWD2rCCI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rslS2eO9U1F8upmaRcgIwG446ov71/bCe8PJ1bKZRDnsPRlH4VTUV1GLpDVlvoHRUAA10YDEYY50ac4fAGJPHi36lpWxB7DY3L1K4Q9P5jC7bMnKZdre0ZaW8kSL1rERSN65mfXoW8sE47FtYtgeETX/w9Sq/Wfz4DEDgUw4nik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rBX19GAP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D201C4CEE8;
	Mon, 24 Feb 2025 11:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740395840;
	bh=gvXOKDHTJ21i4zONuRdj8+AXWrD2W12VvECtWD2rCCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rBX19GAPDpDLcZZ0H/xFa7gSX30A+fP1+5REsDeo9VCoIOaJ3pOPingcWuh6MFz5I
	 XmZTjVsiTKi+dqfynhGHB7CW3/XtZlltwNTWLJ/E48eLEcP60aGVOcG2OUnpODayNI
	 WonTtZbGZ0VabN8AnammbTyYDA4vyQmoPiQFJbHWE0/k+6TFZYIQ5Y5qMHA+Jgz7az
	 /aEabtNCSruvOVJpbsbWWVMf3zJwNO//1jurtzHnu51uZbiFvWKAcf8ZdW11QFktgz
	 wLO9Fo50pU/FgDDYFnsQQw7QnLbymM/56qUJLrLtim8SeP05N1ZHtt6G5QpSoKcQY0
	 aNytGpzrnw0lw==
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
Subject: [PATCH AUTOSEL 6.13 15/32] PCI: pci_ids: add INTEL_HDA_PTL_H
Date: Mon, 24 Feb 2025 06:16:21 -0500
Message-Id: <20250224111638.2212832-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224111638.2212832-1-sashal@kernel.org>
References: <20250224111638.2212832-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.4
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
index de5deb1a0118f..1a2594a38199f 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -3134,6 +3134,7 @@
 #define PCI_DEVICE_ID_INTEL_HDA_LNL_P	0xa828
 #define PCI_DEVICE_ID_INTEL_S21152BB	0xb152
 #define PCI_DEVICE_ID_INTEL_HDA_BMG	0xe2f7
+#define PCI_DEVICE_ID_INTEL_HDA_PTL_H	0xe328
 #define PCI_DEVICE_ID_INTEL_HDA_PTL	0xe428
 #define PCI_DEVICE_ID_INTEL_HDA_CML_R	0xf0c8
 #define PCI_DEVICE_ID_INTEL_HDA_RKL_S	0xf1c8
-- 
2.39.5


