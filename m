Return-Path: <linux-pci+bounces-5134-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C08D88B5AE
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 00:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54CAF1C37C74
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 23:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14E384D2D;
	Mon, 25 Mar 2024 23:59:16 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B205084D2A;
	Mon, 25 Mar 2024 23:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711411156; cv=none; b=pVcHTNSqb3VBrf8t6E0NQgreIMKYcUndtea/W3Yy3qY7nhCeXDoSXpBWlfHlEe3MK41h91Y42gOraDsz2FZCkEhSvmmWPddXbybnl1FmESHe1qoSTdNJOd1MYLBJ8H1MmgoyEE/d5QU092tNlTHJWKLeYxuWz0zxYBkavUZpM8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711411156; c=relaxed/simple;
	bh=H+Z6duRuHTRQuL6SK2IWat0yxvpiuUkeq3z5doKshAA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VpxKk7VlvaH98hp1oto9mQGjfM3a3KC6lpbR3TmFPxcl68CPJIfDxWFfFhk44U4Kzvby6armvz/NVQ+onDijJU2H+YsxljYDcVTjRoAnRKkHZPugxm42lo0kmWJL5dvYKZmJO8TJRCQDGlb5AohK8llzFMcVyML1RYICXK3t6pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C535C433F1;
	Mon, 25 Mar 2024 23:59:16 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net,
	bhelgaas@google.com,
	lukas@wunner.de
Subject: [PATCH 0/3 v2] PCI: Add Secondary Bus Reset (SBR) support for CXL 
Date: Mon, 25 Mar 2024 16:58:00 -0700
Message-ID: <20240325235914.1897647-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Bjorn,
Please consider this series for kernel 6.10. The series attempt to
add secondary bus reset (SBR) support to CXL. By default, SBR for CXL is
masked. Per CXL specification r3.1 8.1.5.2, the Port Control Extensions
register bit 0 (Unmask SBR) in the host bridge controls the masking of CXL SBR.
"When 0, SBR bit in Bridge Control register of this Port has no effect. When 1,
the Port shall generate hot reset when SBR in Bridge Control gets set to 1.
Default value of this bit is 0. When the Port is operating in PCIe mode or RCD
mode, this field has no effect on SBR functionality and Port shall follow PCIe
Base Specification."

v2:
- Use pci_upstream_bridge() instead of dev->bus->self. (Lukas)
- Rename is_cxl_device() to pci_is_cxl(). (Lukas)
- Return -ENOTTY on error. (Lukas)

Patch 1:
Add check to PCI bus_reset path for CXL device and return with error if "Unmask
SBR" bit is set to 0. This allows user to realize that SBR is masked for this
CXL device. However, if the user sets the "Unmask SBR" bit via a tool such as
setpci, then the bus_reset will proceed.

Patch2:
Add a new PCI reset method "cxl_bus_force" in order to allow the user an
intetional way to perform SBR. The code will set the "Unmask SBR" bit to
1 and proceed with bus_reset. The original value of the bit will be restored
after the reset operation.

Patch3:
CXL driver change that provides a ->reset_done() callback. It compares the
hardware decoder settings with the existing software configuration and emit
warning if they differ. The difference indicates that decoders were programmed
before the reset and are now cleared after reset. There may be onlined system
memory backed by CXL memory device that are now violently ripped away from
kernel mapping.

Patch series stemmed from this [1] patch. With comments [2] from Bjorn.

[1]: https://lore.kernel.org/linux-cxl/20240215232307.2793530-1-dave.jiang@intel.com/
[2]: https://lore.kernel.org/linux-cxl/20240220203956.GA1502351@bhelgaas/

