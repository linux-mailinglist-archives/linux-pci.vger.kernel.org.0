Return-Path: <linux-pci+bounces-19898-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81510A12512
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 14:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCBED18885EA
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 13:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B681324226C;
	Wed, 15 Jan 2025 13:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Pf24oP8V"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF04824A7E4;
	Wed, 15 Jan 2025 13:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736948571; cv=none; b=rZd3DcMsYlX0RYDHMlDEOUFRPe6c7Re3135KVZws1g+qXF5aWbr2ocDmkwhSWrB0guwPqK/srxG3vpX9dnKxtzAS2n8K1NQn574AbKWRVFI1ytAFAL54FN4F6FkFfkLuisb2H6xc00ogckraki/7n2vJ6GX6GqE1QtpQI5IJcVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736948571; c=relaxed/simple;
	bh=2Hph0zj3rVGlA0O406s0z8SA/dHRuzQTuX8s7DmTXTg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=m6ziBgqXq4n+qNcQAelt46pSktOhgbNGxsdZmQ0gJicD58AfOeflMgmPbt3Hs3iJBa9/7hZRVKXTdjkBeIEfkSFFC62Xz+lidR1nSL5lH8nWpUpZOx5zJuablRSoJw1Kyp/4UYb0TdjHOmJtB6Mt8ypl9HDeuCa4LE1mXRlnOKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Pf24oP8V; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=eNWYvqZLKMQR1VLwrvBJcFbkXUvUEfzlqkN50e+tY9E=;
	b=Pf24oP8VJq6rl7aZwW9wy3o0XKOTLhk6BTojVVjQVzUMCroh0zholwXHi+dD1k
	/BWwCVYZdW7XPt2J1P2RDD/hfCTP0MEhNuSlR8ShJm7pRo+93MuDgkBdaL+WaVEH
	NtZNzC63o60ifYjmwQsct+NoGzmweIherKdydkAtieHnU=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDnFHcku4dnv58iGA--.58526S2;
	Wed, 15 Jan 2025 21:41:57 +0800 (CST)
From: Jiwei Sun <sjiwei@163.com>
To: macro@orcam.me.uk,
	ilpo.jarvinen@linux.intel.com,
	bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	helgaas@kernel.org,
	lukas@wunner.de,
	ahuang12@lenovo.com,
	sunjw10@lenovo.com,
	jiwei.sun.bj@qq.com,
	sunjw10@outlook.com
Subject: [PATCH v2 0/2] PCI: Fix the wrong reading of register fields
Date: Wed, 15 Jan 2025 21:41:52 +0800
Message-Id: <20250115134154.9220-1-sjiwei@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnFHcku4dnv58iGA--.58526S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WrWDXrW3Jw4UXw45Zr4rGrg_yoW8Aw48p3
	yfC3W3tF4kX34rZFs3X3WxZFyUuan3AFW8uw18G34DZr13C34Fka1avF4FgFyjyrW0ka1Y
	qF1Sq3409w1UArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjPfdUUUUU=
X-CM-SenderInfo: 5vml4vrl6rljoofrz/1tbiDwjVmWeHtuJNVAAAsm

From: Jiwei Sun <sunjw10@lenovo.com>

Since commit de9a6c8d5dbf ("PCI/bwctrl: Add pcie_set_target_speed() to set
PCIe Link Speed"), there are two potential issues in the function
pcie_failed_link_retrain().

(1) The macro PCIE_LNKCTL2_TLS2SPEED() and PCIE_LNKCAP_SLS2SPEED() just
uses the link speed field of the registers. However, there are many other
different function fields in the Link Control 2 Register or the Link
Capabilities Register. If the register value is directly used by the two
macros, it may cause getting an error link speed value (PCI_SPEED_UNKNOWN).

(2) In the pcie_failed_link_retrain(), the local variable lnkctl2 is not
changed after reading from PCI_EXP_LNKCTL2. It might cause that the
removing 2.5GT/s downstream link speed restriction codes are not executed.

In order to avoid the above-mentioned potential issues, only keep link
speed field of the two registers before using and reread the Link Control 2
Register before using.

This series focuses on the first patch of the original series [1]. The
second one of the original series will submitted via the other single
patch.

Fixes: de9a6c8d5dbf ("PCI/bwctrl: Add pcie_set_target_speed() to set PCIe Link Speed")

[1] https://lore.kernel.org/linux-pci/tencent_DD9CBE5B44210B43A04EF8DAF52506A08509@qq.com/
---
v2 changes:
 https://lore.kernel.org/linux-pci/tencent_753C9F9DFEC140A750F2778E6879E1049406@qq.com/
 - divide the two issues into different patches
 - get fixed inside the macros
---

Jiwei Sun (2):
  PCI: Fix the wrong reading of register fields
  PCI: reread the Link Control 2 Register before using

 drivers/pci/pci.h    | 30 +++++++++++++++++-------------
 drivers/pci/quirks.c |  1 +
 2 files changed, 18 insertions(+), 13 deletions(-)

-- 
2.34.1


