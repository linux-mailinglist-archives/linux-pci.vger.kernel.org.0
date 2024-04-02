Return-Path: <linux-pci+bounces-5574-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC56896063
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 01:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 163572824FC
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 23:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42555C5EE;
	Tue,  2 Apr 2024 23:48:50 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E5058ACC;
	Tue,  2 Apr 2024 23:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712101730; cv=none; b=CYvYoaq4CXJ9Hh3tLfsiqvKgITrVjyoR7NGwK8bQx+pGQGXPIX/gmGBislwZZ6MXVp/XRKzV9NuoEKW873VyVmK9qj6qsP5/ilCCNE0YIoqL0hxX+jgVxJzJAJPbihc8kIUVRwg38187NNU/SlGBRTQJJhCK6hE+sJsIWJg1Nuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712101730; c=relaxed/simple;
	bh=zjgEcDdyFbe4X+zpb5MuXUFZgieVH6PXaVfM9aAdiOw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QRE+w2WCpLY+o8btcpZehPOM3GT2i4vU/pX/IHR3K7fBCay+PKvW+zpzktG50YMWXKiascZpe6m301XFCgqn6suXOhgmssTsBJIyt4nihJm77Dq98NRJ+5QjTBL4eUvmMa4mAC3gFo7hqmXjlr1zRADlcg724clB6aS27mK3Njw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C83C433C7;
	Tue,  2 Apr 2024 23:48:50 +0000 (UTC)
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
Subject: [PATCH 0/4 v3] PCI: Add Secondary Bus Reset (SBR) support for CXL 
Date: Tue,  2 Apr 2024 16:45:28 -0700
Message-ID: <20240402234848.3287160-1-dave.jiang@intel.com>
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
Move PCI_DVSEC_VENDOR_ID_CXL to PCI_VENDOR_ID_CXL in pci_ids.h and
adjust related CXL bits.

Patch 2:
Add check to PCI bus_reset path for CXL device and return with error if "Unmask
SBR" bit is set to 0. This allows user to realize that SBR is masked for this
CXL device. However, if the user sets the "Unmask SBR" bit via a tool such as
setpci, then the bus_reset will proceed.

Patch3:
Add a new PCI reset method "cxl_bus_force" in order to allow the user an
intetional way to perform SBR. The code will set the "Unmask SBR" bit to
1 and proceed with bus_reset. The original value of the bit will be restored
after the reset operation.

Patch4:
CXL driver change that provides a ->reset_done() callback. It compares the
hardware decoder settings with the existing software configuration and emit
warning if they differ. The difference indicates that decoders were programmed
before the reset and are now cleared after reset. There may be onlined system
memory backed by CXL memory device that are now violently ripped away from
kernel mapping.

Patch series stemmed from this [1] patch. With comments [2] from Bjorn.

[1]: https://lore.kernel.org/linux-cxl/20240215232307.2793530-1-dave.jiang@intel.com/
[2]: https://lore.kernel.org/linux-cxl/20240220203956.GA1502351@bhelgaas/


