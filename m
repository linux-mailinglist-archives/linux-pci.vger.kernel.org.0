Return-Path: <linux-pci+bounces-20263-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF9BA19E3C
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 06:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C5EA188B3CA
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 05:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DAA1ADC8A;
	Thu, 23 Jan 2025 05:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Wlai763R"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB2B136E3B;
	Thu, 23 Jan 2025 05:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737611568; cv=none; b=dvKtY2e2rRtT0xlLWPjcZ/q5ijg0pODEu2cfVXRo/wzsvDbErfqjRT+n/YkEyuHm/qxO9JtkO0YCqXOIyFgH36NvyDUj4uZmmr8axsSzVFZYUC93iTQDEFqZkZTwsZSpLG5SWu+qqThghQA8mLT26Myd0lHG7iiI6mN+VVwdLjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737611568; c=relaxed/simple;
	bh=6jzhOeaxOia8RYTSOe+nbDlCKjzyrlGJ2yIAnwG1dBo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=NW5TD7NTFYnzWESpOeucVITkdTVUUgTH+u4dS/si0Bqy1J+l/vW2UOUuahNXG/0xLEFc6bgOenMzMdyiHYVIw3nANM+s3ZU/bI/D5lFsPevgSneb78Te562+AExjFX+DhhxCKYF9636Fr6hBLKIJDJSOKROWFWDaVIWC9YJNtwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Wlai763R; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=2YW1FZ+hTW73m/bMzH2iIib4JfkDZYbytR5zU0F5dzE=;
	b=Wlai763RUljlOpvhyxfP2ETI6gdzzC0dxnJ6fCQBUg5H11KIIXXZSQKz0tioRD
	ZdsQ/Lynamzy3QxHesCdpoxaOVbYRiab/rBT3zw2bpqZwiQxw8Fl3yzTN5JdmWuM
	it8k6bn4ZfPmcU/KTvR8qrhvrTaXOmz88aXZk12IhiYJo=
Received: from jiwei-VirtualBox.lenovo.com (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDXxy392JFnt3jOHw--.51666S2;
	Thu, 23 Jan 2025 13:51:58 +0800 (CST)
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
Subject: [PATCH v4 0/2] PCI: Fix the issue of failed speed limit lifting
Date: Thu, 23 Jan 2025 13:51:53 +0800
Message-Id: <20250123055155.22648-1-sjiwei@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXxy392JFnt3jOHw--.51666S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WrWDXrW3Jw4UXw45Zr4rGrg_yoW8CF1Dp3
	yfG3Wayr4kJa4fJFn3JF47ZFy5uan3JFWDuw1xG3yUZF15G3s5Ja1SyFWFgFyjkrW0ya12
	vr1Yqrykuw1jkrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbkuxUUUUU=
X-CM-SenderInfo: 5vml4vrl6rljoofrz/1tbiDwzdmWeRzSK77AAAsJ

From: Jiwei Sun <sunjw10@lenovo.com>

Since commit de9a6c8d5dbf ("PCI/bwctrl: Add pcie_set_target_speed() to set
PCIe Link Speed"), there are two potential issues in the function
pcie_failed_link_retrain().

(1) The macro PCIE_LNKCTL2_TLS2SPEED() and PCIE_LNKCAP_SLS2SPEED() just
use the link speed field of the registers. However, there are many other
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

[1] https://lore.kernel.org/linux-pci/tencent_DD9CBE5B44210B43A04EF8DAF52506A08509@qq.com/
---
v4 changes:
 - rename the variable name in the macro

v3 changes:
 - add fix tag in the commit messages of first patch
 - add an empty line after the local variable definition in the macro
 - adjust the position of reading the Link Control 2 register in the code

v2 changes:
 - divide the two issues into different patches
 - get fixed inside the macros

Jiwei Sun (2):
  PCI: Fix the wrong reading of register fields
  PCI: Adjust the position of reading the Link Control 2 register

 drivers/pci/pci.h    | 32 +++++++++++++++++++-------------
 drivers/pci/quirks.c |  6 ++++--
 2 files changed, 23 insertions(+), 15 deletions(-)

-- 
2.34.1


