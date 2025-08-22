Return-Path: <linux-pci+bounces-34601-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E3CB3202E
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 18:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 154CF605856
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 16:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02672EBDC8;
	Fri, 22 Aug 2025 16:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WkAsXT6K"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D592E54D2;
	Fri, 22 Aug 2025 16:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755878588; cv=none; b=Q/sAx8M91h0XfnTHHEj9yfT1QUlWS+SeyizB3VWMpTG7znD/ZvzUCn/X6vMzc76bVwuNUImOB5qDps0KzlotMO2O4d+pmBlrp06kkIvH7d7nEc0XLzuD0qtXqziySu+BilewGOsbBsn+Is54Z2UxR4ZsJDRyauqU3nvLKxUTdzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755878588; c=relaxed/simple;
	bh=SFx+xEXCps/MEjk6e6nCLSHOmv+Tx0NtwGUdwnZG4Ww=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lETXTeIRvdHGvB6pLmL5RKLKTepbwk+/Vp6gn/Xvd/ABjT00TTyoh2cHIxTXYKP6juH9A5n+bnDZDCLq9tbz1DrmJR3RseUcxcoZPkWgaVb3z3E5mnKQ4y26XFncSoVbDEixsJI6qMtIKZPGAmHfgFPzGn5Thb88mPMetZFMN/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WkAsXT6K; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Z4
	lofPLCVpT9yH9KN2N7Nz+nTKVn7B8LeP9A7V7D8Gg=; b=WkAsXT6K8HUPo0RHJd
	cnaXt0d/uhHQMna4r1hmRCwT0b+4bPevy9FnnhERoS1RMoVuXIKmiC7n/IJe62Ry
	EkX86UW55Lx1Fr9hsT+kocFPRsvaqCE18IZl3q3urq1aQlo2DwSXYgX5QziAKUEK
	mGyLOL05SJReBik/+hn0rpdiU=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgBnxDaplKho3jnHAA--.18200S2;
	Sat, 23 Aug 2025 00:02:50 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	helgaas@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Hans Zhang <18255117159@163.com>
Subject: [PATCH v2 0/7] PCI: Replace short msleep() calls with more precise delay functions
Date: Fri, 22 Aug 2025 23:59:01 +0800
Message-Id: <20250822155908.625553-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgBnxDaplKho3jnHAA--.18200S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFW7AFyruryUWFWDGFW3Jrb_yoW8ur47pa
	98GFs0yF1xJFZ8ua17Za1IvFn09Fn7AFWj9F9xWasrXas8Aw1UGF4ftF1rWr12qrW0qw1U
	Xa45Ja1rGay8AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pixhliUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWwWxo2iokSpKrwAAsS

This series replaces short msleep() calls (less than 20ms) with more
precise delay functions (fsleep() and usleep_range()) throughout the
PCI subsystem.

The msleep() function with small values can sleep longer than intended
due to timer granularity, which can cause unnecessary delays in PCI
operations such as link status checking, reset handling, and hotplug
operations.

These changes:
- Use fsleep() for delays that require precise timing (1-2ms).
- Use usleep_range() for delays that can benefit from a small range.
- Add #defines for all delay values with references to PCIe specifications.
- Update comments to reference the latest PCIe r7.0 specification.

This improves the responsiveness of PCI operations while maintaining
compliance with PCIe specifications.

---
Changes for v2:
https://patchwork.kernel.org/project/linux-pci/patch/20250820160944.489061-1-18255117159@163.com/

- According to the Maintainer's suggestion, it was modified to fsleep,
  usleep_range, and macro definitions were used instead of hard code. (Bjorn)
---

Hans Zhang (7):
  PCI: Replace msleep(2) with fsleep() for precise delay
  PCI: Replace msleep(1) with fsleep() for precise link status checking
  PCI: rcar-host: Replace msleep(1) with fsleep() for precise speed
    change monitoring
  PCI: brcmstb: Replace msleep(5) with usleep_range() for precise link
    up checking
  PCI: rcar: Replace msleep(5) with usleep_range() for precise PHY ready
    checking
  PCI: pciehp: Replace msleep(10) with usleep_range() for precise delays
  PCI/DPC: Replace msleep(10) with usleep_range() for precise RP busy
    checking

 drivers/pci/controller/pcie-brcmstb.c   | 5 ++++-
 drivers/pci/controller/pcie-rcar-host.c | 4 +++-
 drivers/pci/controller/pcie-rcar.c      | 4 +++-
 drivers/pci/hotplug/pciehp_hpc.c        | 6 +++++-
 drivers/pci/pci.c                       | 9 +++------
 drivers/pci/pci.h                       | 7 +++++++
 drivers/pci/pcie/dpc.c                  | 5 ++++-
 7 files changed, 29 insertions(+), 11 deletions(-)


base-commit: b19a97d57c15643494ac8bfaaa35e3ee472d41da
-- 
2.25.1


