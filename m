Return-Path: <linux-pci+bounces-20230-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EF7A18D61
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 09:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3539C162CF3
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 08:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5DC1C3BE9;
	Wed, 22 Jan 2025 08:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MVGFI9PK"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544091C3BE5;
	Wed, 22 Jan 2025 08:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737533301; cv=none; b=hvu/7qY1rhg8aRnhkwnGOP8zB/tzcpryxZdu6MPYokIGGVoZ3C3s5+ZHXuOWPQftZANzx4g1QWqm6g5Kky1ZRLma5UfHEQs0r/KxynGaFS9gLa/YeSVD3eUoGmO5ntCiOLs9QlEVyeyAm7b+1wiIauJCrKaU2ArtHQ0z3MtBJ2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737533301; c=relaxed/simple;
	bh=kHWOsnHVgvUhlWdXMiNrIiUO+rRusH7tyqw5vWDHZfM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=oIkOeRH/bUNoI2U34Z5bePYaTW/l8RXYINwJCeSmNuBGlx1B2+i9h3A9Z2ixW8ePBJPYDf5OciuS/Cne1XoAShML9rT4gGDBK1//obor1neiRNxB3j8he1UOUdu6jx8T36wnYw4xKgaAG32SV7gBXlvuddh/yvNRDjxh9nVxck0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MVGFI9PK; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=VWnX+a7O4IFPbDKlfLQMN6Z73Dws71yaEwfBGvahvPE=;
	b=MVGFI9PKC0RFbbOF0k47UOwfxI6aon5M0ygKt9zicwg+fBWF2i3PzWeFXMKy+d
	H97pReYa8+6Q59hTVoWz4Q/hoQip1ylNd7P7PWfpwOw2Sc/cnCVQUPHr5g3SNecI
	Og8Q2TWSEqkPKn3zHVFJgCTOubSE0ix4akBijLipky+s0=
Received: from jiwei-VirtualBox.lenovo.com (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDXX9ATp5Bn1JblHg--.23736S2;
	Wed, 22 Jan 2025 16:06:44 +0800 (CST)
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
Subject: [PATCH v3 0/2] Fix the issue of failed speed limit lifting
Date: Wed, 22 Jan 2025 16:06:08 +0800
Message-Id: <20250122080610.902706-1-sjiwei@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXX9ATp5Bn1JblHg--.23736S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WrWDXrW3Jw4UXw45Zr4rGrg_yoW8Cr1fp3
	yfG3Wayr4kXa4fZFn3JF4xZFy5uan3JFWUuw1xG3yDZr15G3s5Ja1ayFWFgFyjkrW0ka12
	vr1Fg34kuw1jkrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbkuxUUUUU=
X-CM-SenderInfo: 5vml4vrl6rljoofrz/xtbBDxTcmWeQpVoxuQAAse

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

[1] https://lore.kernel.org/linux-pci/tencent_DD9CBE5B44210B43A04EF8DAF52506A08509@qq.com/
---
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


