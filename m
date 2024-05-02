Return-Path: <linux-pci+bounces-7014-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D761C8B9F15
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 18:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDA3E1C221A7
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 16:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DAF16D9A4;
	Thu,  2 May 2024 16:58:54 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161F716D31F;
	Thu,  2 May 2024 16:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714669134; cv=none; b=LkmXplo1nOtbuJ6V8cQe+T6K+kgf/axxwyAOc649ytf2qWiaThG38mqscYXcqQhfXD8uHGBIOs/ElSAulNGqUQQ+iLUO8O0HSYQzEXS7ACTWx3XAdRffUBZxRTr7ecYfNaz1U1w9zkmxq7ZuLc3oG2VHmPWmB0G5nFjtdSOXirY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714669134; c=relaxed/simple;
	bh=aan8jUHUZG0AZyG14ZHCvyNvwV04hUeBYqy7xLK46L0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cXI4poWPVNdefZfG2G13KVRFNU6Fd30fj5eexPvWxaB36CvDwGEj95MpF7QVPVgtcUxYXDyIiTt/YEF4BSrQEfyTUJd2Kh4YlqzNiMv2WWuAFi+HAwa3hy0GsZHQY5Kl1dMyPHllazivbrsiXHmGx8QbiqO5FaDvaE4INQbeqCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BCABC113CC;
	Thu,  2 May 2024 16:58:53 +0000 (UTC)
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
Subject: [PATCH v6 0/5] PCI: Add Secondary Bus Reset (SBR) support for CXL
Date: Thu,  2 May 2024 09:57:29 -0700
Message-ID: <20240502165851.1948523-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Bjorn,
Please consider this series for the next appropriate kernel merge window.
The CXL part has review tags from Dan and Jonathan. It can go through your tree.
The series attempt to add secondary bus reset (SBR) support to CXL. By default,
SBR for CXL is masked. Per CXL specification r3.1 8.1.5.2, the Port Control
Extensions register bit 0 (Unmask SBR) in the host bridge controls the masking
of CXL SBR.  "When 0, SBR bit in Bridge Control register of this Port has no
effect. When 1, the Port shall generate hot reset when SBR in Bridge Control
gets set to 1.  Default value of this bit is 0. When the Port is operating in
PCIe mode or RCD mode, this field has no effect on SBR functionality and Port
shall follow PCIe Base Specification."

v6:
- Split out locking of upstream bridge to a separate patch and add lockdep
  support. (Dan)
- Added Dan's review tags for last 2 patches.

v5:
- Move bridge locking to pci_reset_function(). (Dan)
- Simplify retrieval of cxld. (Dan)
- Add lock to device to prevent racing of disabled cxlmd. (Dan)
- Promote dev_warn() to dev_crit() (Dan)
- Remove LOCKDEP_NOT_UNRELIABLE flag. (Dan)

v4:
- Return u16 for cxl_port_dvsec(). (Lukas)
- Use pci_dev_lock guard() on bridge. (Lukas)
- Clarify commit subject on 4/4. (Jonathan)

v3:
- Move PCI_DVSEC_VENDOR_ID_CXL to PCI_VENDOR_ID_CXL in pci_ids.h (Bjorn)
- Remove of CXL device checking. (Bjorn)
- Rename defines to PCI_DVSEC_CXL_PORT_*. (Bjorn)
- Fix SBR define in commit log. (Bjorn)
- Update comment on dvsec not found. (Dan)
- Check return of dvsec value read for error. (Dan)
- Move cxl_port_dvsec() to an earlier patch. (Dan)
- Add pci_cfg_access_lock() for bridge access. (Dan)
- Change cxl_bus_force method to cxl_bus. (Dan)
- Rename decoder_hw_mismatch() to __cxl_endpoint_decoder_reset_detected(). (Dan)
- Move CXL register access function to core/pci.c. (Dan)
- Add kernel taint to decoder reset warning. (Dan)

v2:
- Use pci_upstream_bridge() instead of dev->bus->self. (Lukas)
- Rename is_cxl_device() to pci_is_cxl(). (Lukas)
- Return -ENOTTY on error. (Lukas)

Patch 1:
Move PCI_DVSEC_VENDOR_ID_CXL to PCI_VENDOR_ID_CXL in pci_ids.h and adjust related
CXL bits.

Patch 2:
Add locking of the upstream bridge to keep configuration of the bridge consistent.

Patch 3:
Add check to PCI bus_reset path for CXL device and return with error if "Unmask
SBR" bit is set to 0. This allows user to realize that SBR is masked for this
CXL device. However, if the user sets the "Unmask SBR" bit via a tool such as
setpci, then the bus_reset will proceed.

Patch4:
Add a new PCI reset method "cxl_bus" in order to allow the user an
intetional way to perform SBR. The code will set the "Unmask SBR" bit to
1 and proceed with bus_reset. The original value of the bit will be restored
after the reset operation.

Patch5:
CXL driver change that provides a ->reset_done() callback. It compares the
hardware decoder settings with the existing software configuration and emit
warning if they differ. The difference indicates that decoders were programmed
before the reset and are now cleared after reset. There may be onlined system
memory backed by CXL memory device that are now violently ripped away from
kernel mapping.

Patch series stemmed from this [1] patch. With comments [2] from Bjorn.

[1]: https://lore.kernel.org/linux-cxl/20240215232307.2793530-1-dave.jiang@intel.com/
[2]: https://lore.kernel.org/linux-cxl/20240220203956.GA1502351@bhelgaas/


