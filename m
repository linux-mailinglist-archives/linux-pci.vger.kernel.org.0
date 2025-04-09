Return-Path: <linux-pci+bounces-25523-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DFFA81BA1
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 05:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D2458A3D10
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 03:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C331BC073;
	Wed,  9 Apr 2025 03:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UGbn5MQZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338EC6F073;
	Wed,  9 Apr 2025 03:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744170151; cv=none; b=IYr4HsAaj63PQP8YeVnIXH5M16bRzHfgpsvsVJMib86SBD9MQYAotMSO6ApNGQTxkDKWMXrv9kKaZrobGsauW4k6IId1NFnmJ0Dh0Izaqv8MxcygR1KuYmU5GCN820I2dPCNM+o/nWOIQge7l7EfIuWBRru5vHoay3+IGNWfr+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744170151; c=relaxed/simple;
	bh=dxz58imorngaLXiFlNXGntg9NzC3l+1/qxF6Cn/d7Mo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MMXSzLRuY3BHWkF6C/dC9rTswhd5/fEbNMLja6fWy6xajCPW2W32qXmwaqt3+B4j1C4QzMLl4WBzaHNK6iQT+BnmWvxcAVuuzxJUjJ0Z+Ld4xepfM/bJtMlg7odwpY25d36x+fKk9NzwtQGV3uZaAcCs3r1x4OGZwtTcVt7Q8UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UGbn5MQZ; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=GkGyx
	7DPt/EgcE0T4RHJCvE68IU2uPkdWm1gFMOum7I=; b=UGbn5MQZtAv0VWZFSsKdn
	6XdWJLKdEgzPmLBhTsIDaMMOBPVitoA/lly9XC2BvsWc6+wjcInkON98dbSpuyQJ
	SIw7mEXv0i3L+412zTY+5d0DHb/ZtS4eq/zw9qE7uWH7Ocypn36v1XAlBoM1Anje
	8oKhfXujYlkFWSg9oXHbgk=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDHD3GH7PVnbwQBFQ--.4446S2;
	Wed, 09 Apr 2025 11:42:02 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	bhelgaas@google.com
Cc: kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	ilpo.jarvinen@linux.intel.com,
	robh@kernel.org,
	jingoohan1@gmail.com,
	thomas.richard@bootlin.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v9 0/6] Refactor capability search into common macros
Date: Wed,  9 Apr 2025 11:41:50 +0800
Message-Id: <20250409034156.92686-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHD3GH7PVnbwQBFQ--.4446S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr4rZF13tw1rtFWxWF43GFg_yoW8tr17pF
	yfJ3Z3Cr4rJFWa9an3Aa12kay3Xan7Ja4xJ3yfKw1fXF17uFy5trs7Kr1rAFZrA397Xwnx
	ZF45Jr95KFn0y3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p_YL9UUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWx0qo2f11ShHpgABsA

1. Introduce generic bus config read helper function.
2. Clean up __pci_find_next_cap_ttl() readability.
3. Refactor capability search into common macros.
4. DWC/CDNS use common PCI host bridge macros for finding the
   capabilities.
5. Use cdns_pcie_find_*capability to avoid hardcode.

Changes since v8:
- Split patch.
- The patch commit message were modified.
- Other patches(4/6, 5/6, 6/6) are unchanged.

Changes since v7:
- Patch 2/5 and 3/5 compilation error resolved.
- Other patches are unchanged.

Changes since v6:
- Refactor capability search into common macros.
- Delete pci-host-helpers.c and MAINTAINERS.

Changes since v5:
- If you put the helpers in drivers/pci/pci.c, they unnecessarily enlarge
  the kernel's .text section even if it's known already at compile time
  that they're never going to be used (e.g. on x86).
- Move the API for find capabilitys to a new file called
  pci-host-helpers.c.
- Add new patch for MAINTAINERS.

Changes since v4:
- Resolved [v4 1/4] compilation warning.
- The patch subject and commit message were modified.

Changes since v3:
- Resolved [v3 1/4] compilation error.
- Other patches are not modified.

Changes since v2:
- Add and split into a series of patches.

Hans Zhang (6):
  PCI: Introduce generic bus config read helper function
  PCI: Clean up __pci_find_next_cap_ttl() readability
  PCI: Refactor capability search into common macros
  PCI: dwc: Use common PCI host bridge APIs for finding the capabilities
  PCI: cadence: Use common PCI host bridge APIs for finding the
    capabilities
  PCI: cadence: Use cdns_pcie_find_*capability to avoid hardcode.

 drivers/pci/access.c                          | 17 ++++
 .../pci/controller/cadence/pcie-cadence-ep.c  | 40 +++++----
 drivers/pci/controller/cadence/pcie-cadence.c | 28 ++++++
 drivers/pci/controller/cadence/pcie-cadence.h | 18 ++--
 drivers/pci/controller/dwc/pcie-designware.c  | 72 ++-------------
 drivers/pci/pci.c                             | 68 ++------------
 drivers/pci/pci.h                             | 88 +++++++++++++++++++
 include/uapi/linux/pci_regs.h                 |  2 +
 8 files changed, 187 insertions(+), 146 deletions(-)


base-commit: a24588245776dafc227243a01bfbeb8a59bafba9
-- 
2.25.1


