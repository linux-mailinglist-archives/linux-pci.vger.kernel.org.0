Return-Path: <linux-pci+bounces-40034-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7033CC2820F
	for <lists+linux-pci@lfdr.de>; Sat, 01 Nov 2025 17:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7A98188453A
	for <lists+linux-pci@lfdr.de>; Sat,  1 Nov 2025 16:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF532FB609;
	Sat,  1 Nov 2025 16:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Qv4h+ZWT"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83341DF248;
	Sat,  1 Nov 2025 16:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762013170; cv=none; b=JIk/JT56rIxToqWU1Y/qIiTAn/9e9YUEFVqvLLtR5z3YgjPEUO35JLAM46AKi0u5WcDXkl2ThLXwk0hTGyNxgfuLeUFEE9Ub+i0pfYMzv44XJJkvIWwDo9K4KfY9LMbqoyBLq+V4/unxBVDIbNEBbh04Ywt+QNrJUPD0EK4UsPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762013170; c=relaxed/simple;
	bh=Qkq2J1XbXyE+1yYBv/tl1ZkDKsDlaBjvSwLxP8RDrus=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=loGovGeXYM/GPVhgEzlOqN7U1c+sk7wNtiIOrRztHaSFj7vm9gYyt3J7s2u0Vt+lRPFQOOHAcAMVxzfWM95Ocy7DHwF2i+WE+496LnqFst9V/3P9SJlEpA8kxgEcfqqjjlHglp+n5QZ9KlJBbLyuWCCnMiPq85Ug5bwekTpD2cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Qv4h+ZWT; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=wt
	UqoOB1t4ZfIMOLU4hyF3m97cGANHPWUTnEiH4MHfI=; b=Qv4h+ZWTNeHY8wZVya
	KNdLA4ekmcvy3lCgO/cU6kF1PohIvFnjLAhusLoxZUFb88ZQ2Zyj8McJNopCCurD
	avCuCgnRdForiJMec6+KgrLe3iM4GXPz3yRQBNbVt+B9C5qKo3di42o4XDlWUz0v
	wb8juJAnMqBkFkrHu5sIR5Dt4=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDXL4nTLwZp3qOtAw--.844S2;
	Sun, 02 Nov 2025 00:05:40 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	helgaas@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Hans Zhang <18255117159@163.com>
Subject: [PATCH v4 0/4] PCI: Add delay macros for better code readability and maintainability
Date: Sun,  2 Nov 2025 00:05:34 +0800
Message-Id: <20251101160538.10055-1-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXL4nTLwZp3qOtAw--.844S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFyDtw15Gw1fXw4fGr1rWFg_yoW8Ww4kpa
	y5GFsYkrs7J3yFya97ua1I9F98Aa9rAFWjqrWkG3429FW3Z3W5XFsagr4YvFy7ZrW0gw1I
	qry2kw10ka4jyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEgAw8UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOhn4o2kGKs1Z4QACsK

This series improves code readability and maintainability in the PCI
subsystem by replacing hard-coded delay values with descriptive macros.

---
Hi Bjorn,

I wonder if there is still a need to advance this series? If it's not necessary,
please drop it. Thank you very much.

Best regards
Hans


Changes for v4:
https://patchwork.kernel.org/project/linux-pci/patch/20250826170315.721551-1-18255117159@163.com/

- According to Bjorn's feedback, the benefits of using fsleep are not significant.
  drop the 0002 patch in v3. (Bjorn)
- For the controller drivers, the added macros do no good and provide no value.
  So if you ever respin this series, you can drop them. (Mani)

Changes for v3:
https://patchwork.kernel.org/project/linux-pci/cover/20250822155908.625553-1-18255117159@163.com/

- According to Bjorn's suggestion, split the first patch of v2 and add
  macro definitions to the remaining patches.

Changes for v2:
https://patchwork.kernel.org/project/linux-pci/patch/20250820160944.489061-1-18255117159@163.com/

- According to the Maintainer's suggestion, it was modified to fsleep,
  usleep_range, and macro definitions were used instead of hard code. (Bjorn)
---

Hans Zhang (4):
  PCI: Add macro for secondary bus reset delay
  PCI: Add macro for link status check delay
  PCI: pciehp: Add macros for hotplug operation delays
  PCI/DPC: Add macro for RP busy check delay

 drivers/pci/hotplug/pciehp_hpc.c |  7 +++++--
 drivers/pci/pci.c                | 11 +++++------
 drivers/pci/pci.h                |  3 +++
 drivers/pci/pcie/dpc.c           |  4 +++-
 4 files changed, 16 insertions(+), 9 deletions(-)


base-commit: ba36dd5ee6fd4643ebbf6ee6eefcecf0b07e35c7
-- 
2.34.1


