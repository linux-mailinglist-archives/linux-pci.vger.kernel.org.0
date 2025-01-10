Return-Path: <linux-pci+bounces-19623-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD27EA091D7
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2025 14:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E25C33A729F
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2025 13:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF97220DD68;
	Fri, 10 Jan 2025 13:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="X3QMvEeq"
X-Original-To: linux-pci@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710CF20B80D;
	Fri, 10 Jan 2025 13:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736515524; cv=none; b=hr5IzWRnKvv6y/Mw/u+BRrxG1GQUVMLy8w+i9zkMK7zRDBwqlmLbjtJbJPplepTTvUCdVwUpawVGU0HF6FCNM3NNsUPyx+yZopMXfbdv4cv8YFXYf/Me24hYqUjfQd3o7CzGjNwHFwdYS6/gSNueboYfH0zBAg4nMz1ohB3f90A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736515524; c=relaxed/simple;
	bh=L1R2/2TNpjJyLVgCMWQ8uw7m8h8+4HRcAAljh4SEe3k=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=A2qJkVxuTvdUw55D3VFEuVC0ajyiJrwXLfX0yQ/UIxzraxW/c1ckzkunVd/mwZLsBIr0HP998T6H/RZiJG4/rwAGtsfq3NBEgZZ+dlORTSbG6CGQWpmI3YKHYxwqw+o/nQBXeIXlVN3ZtfajIMROcn8pmmL2Buw6jrE9JsVqtqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=X3QMvEeq; arc=none smtp.client-ip=43.163.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1736515507; bh=mptHu4g9IUyvhR2U1UoZgt0nySKY4QynTmjkqWx4Ytg=;
	h=From:To:Cc:Subject:Date;
	b=X3QMvEeqgHz8ACyCcMu+pOzwLehOsEIma71RzUTvnbptjeYNpmc9HJWVtH45V1vyn
	 E0YGuf9lq1J6UhdR9W0IUW6z6LuA6RCmWZLfXR8co91i4Zfrc28cV8y8ehImwxQALk
	 5KU40Rm/nBHdusXJYwH4wPu0bPgmUk9cIwKfVtsk=
Received: from jiwei-VirtualBox.lenovo.com ([120.244.62.107])
	by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
	id 59F0B279; Fri, 10 Jan 2025 21:22:31 +0800
X-QQ-mid: xmsmtpt1736515351tmufw2cfz
Message-ID: <tencent_DD9CBE5B44210B43A04EF8DAF52506A08509@qq.com>
X-QQ-XMAILINFO: Mrv6PNPZjcp6a91DUZs8PePgthbjV6CVvu4Xi8jKhsYMfbz7dAHy7L2fU3ncD6
	 tagbGB5GC/zqh/4GcDLExlG4SAdz8bnFAlkb5F2JqOOANSTAV7of3j194+AP9DBh6TVAR8FQCiAI
	 u2HppvnIyBIjYIiB20vxSSUQXEaZJCXRlQK5DMyvnsIQCcligxGrxxMECqR4tPg5FzRYWnL8Wwe9
	 dn7AwKWt/GcXFzAQm8ReyFXvcj9fHqVZskLMRmGRLUu34o2md0xFVJZdxmSDU0olpmkohH5lThuq
	 Pxt1yjLh7JoaG6D1ythSIw+4GN9+mgZnJNtf+SS5zucq5bfF5OJ+HVWSaKzYTyHTR5YByA28cNNp
	 /YCsv1VPWtXJV9c15+mW7hbCJRpd+4ZLhpyuwss9L//O+5I5ZmmAmuOwdNMB8+ucLlVjtBqqqMkV
	 3apxD3i8lXwGNrrAaWaVtcqUiXbAwN61+aA4J66vbzUwGE84AXkFDGMK4t+FEzbFrNbrA0PQq3DI
	 bf8yLxi4klBSWQ1mleM8JTfBiLM/iLO2dmOCzsNL0tAbLr2qe0aISzkhSOI8kKiZyhoQs5v9itOU
	 lDJSpK2F+18M5KQdLx1uxlXOD/ZKPglT3l2hKhGKf/miK2O57xaat5d0VMxcKSPXBLoXZFanyKUA
	 sxTrPs9TVhk9BKrwrkkFLdTK9po3/lP9qFa0mRgeeqweJK+cwNQ5R2mLwZno+9ogrEdAy0nBPOfd
	 Kq9RfiJuNjrt9Az1dtz7MJEibK0o0VQNy+WJvhsEfORhSEdVbZIJjU6qe5lPeJf990r5vyyC3Vdi
	 I9dGF2GaRQ3ny6KQXTOnR2sVIydu2y8bSvImpbvUw8dZ388svSV7yw37Y4jY6WySwwrWiRGmw3hv
	 m+I8RtAQ3beV6Jk92QGbjpQwl27pONKrbgrLOfY95s9bG6QEMG8K5QFrl870NYSMzadMC1xjabxU
	 9iXh25pc4CBRgcDYHWpy4+U6jSjV6MIG8RJU3nWKvTvFu2FAdvO1IabkzGwMrQ
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Jiwei Sun <jiwei.sun.bj@qq.com>
To: macro@orcam.me.uk,
	ilpo.jarvinen@linux.intel.com,
	bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	guojinhui.liam@bytedance.com,
	helgaas@kernel.org,
	lukas@wunner.de,
	ahuang12@lenovo.com,
	sunjw10@lenovo.com,
	jiwei.sun.bj@qq.com
Subject: [PATCH 0/2] PCI: Fix the PCIe bridge decreasing to Gen 1 during
Date: Fri, 10 Jan 2025 21:21:52 +0800
X-OQ-MSGID: <20250110132154.28732-1-jiwei.sun.bj@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiwei Sun <sunjw10@lenovo.com>

When we do the quick hot-add/hot-remove test with a PCIE Gen 5 NVMe disk,
there is a possibility that the PCIe bridge will decrease to 2.5GT/s from
32GT/s.

The issue is caused by commit a89c82249c37 ("PCI: Work around PCIe link
training failures"). Although the commit 712e49c96706 ("PCI: Correct error
reporting with PCIe failed link retraining") and the commit f68dea13405c
("PCI: Revert to the original speed after PCIe failed link retraining")
have tried to fix the similar issue. However, there is still a window for
triggering the issue within 1-second hot-add/hot-remove test.

Besides, the commit de9a6c8d5dbf ("PCI/bwctrl: Add pcie_set_target_speed()
introduces two potential issues might cause that the removing 2.5GT/s
downstream link speed restriction works fail.

Jiwei Sun (2):
  PCI: Fix the wrong reading of register fields
  PCI: Fix the PCIe bridge decreasing to Gen 1 during hotplug testing

 drivers/pci/quirks.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

-- 
2.34.1


