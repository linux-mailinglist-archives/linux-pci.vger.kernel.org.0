Return-Path: <linux-pci+bounces-4730-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10ADF87899A
	for <lists+linux-pci@lfdr.de>; Mon, 11 Mar 2024 21:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDF9B281BCF
	for <lists+linux-pci@lfdr.de>; Mon, 11 Mar 2024 20:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9E73C482;
	Mon, 11 Mar 2024 20:41:41 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4056659B4D;
	Mon, 11 Mar 2024 20:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710189701; cv=none; b=kVdNZKGfLqI7DxLTYbsmVMuvUh8yFahhLtmS/SqUI5Bmp9odzmmaFtwcwUvnc6/t8Frv4WzPpdEvFnQUhmEHHP0z2HnVxxoCYZ7ofzSXiak3gqszCofkBJ5PsClH/B9k3yCdVLrUW8v7/3JwJ9tGUcTuWkEA27u2q2DYMJtRQos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710189701; c=relaxed/simple;
	bh=SPlKXranJZSMCPDj5WiyxpKxGTNl5V4ftUBlRh/Id+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SJQSUdwGJdoQ2ZtUgE2u4VF9T4gvpSOGe5CCqQPebQch/gDu4tjR2clx9RebHbdHTf5S++4aNT8sl7pvqh+tduH2kFSFdt6qIoU4IKKE+Z3Tc1ze1uPpifAPOGqHT5ZW4H1TdrvFJjUU1dneKylO5NTz0/B5aweGev9Bg5Zgl1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4D5BC433F1;
	Mon, 11 Mar 2024 20:41:39 +0000 (UTC)
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
Subject: [PATCH 0/3] PCI: Add Secondary Bus Reset (SBR) support for CXL
Date: Mon, 11 Mar 2024 13:39:52 -0700
Message-ID: <20240311204132.62757-1-dave.jiang@intel.com>
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


