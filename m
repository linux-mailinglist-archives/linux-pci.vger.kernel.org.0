Return-Path: <linux-pci+bounces-22137-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4835BA4142C
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 04:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5A171893C94
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 03:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB79208D0;
	Mon, 24 Feb 2025 03:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="heZyASBk"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445D53FBA7;
	Mon, 24 Feb 2025 03:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740368710; cv=none; b=IRu2eTeHg9YXvwoK0Clawpvu2K3CY1GXvW+qdmSPWmPocgTdhIQeKLv8g+UQlMz+SVDaxTdYSjncs1iSxJUghAGvLdahPxt3iuFxzaFniZsCbac/GmmCxskp53elvZNuVl63FOnW6/XTneZQoHNUoYhj48oQXpEYkqcpb73OSX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740368710; c=relaxed/simple;
	bh=JLsMyQSdWcTRG8EiJgarCIC0qRpuVwqXG2/B2w70LK4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eSbfCZt4fJPksaYbjdvmk2YtGYjgjERUL8Ih7NuOGkZsx3LBwxCrFEU96RQfflfcKVzp0sRDiIGRS9zgqjPBxSHdpPrIx4sYFGsOE6kmVnGaHqm4k4V8rrkUPBIWhG4fMSub3C65Th46Sh5u5pvJc7V2lO3rlB5olNXsN1WKbqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=heZyASBk; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740368702; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=dsOpm0A0/KB032ZLuWE3O79KWWGmWvjEV91Oqu2+0p0=;
	b=heZyASBkS9PW3yamUL+nq19fb+kIIstg42PaFM/DuvKDJSk399SqZtVhLdQhtxtfY3wvZSjKYYplXmCbMIas6VQ2mYobO2TJ2sRAV1B75rOqa0TN0qMbjNCU4QpuzXFe40PKokX/ek9AI42jO0z21fCJPn06v45nbanG+xq93qA=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WQ1w1CO_1740368701 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 24 Feb 2025 11:45:02 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Liguang Zhang <zhangliguang@linux.alibaba.com>,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	rafael@kernel.org
Cc: Markus Elfring <Markus.Elfring@web.de>,
	lkp@intel.com,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	ilpo.jarvinen@linux.intel.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Feng Tang <feng.tang@linux.alibaba.com>
Subject: [PATCH v3 0/4] PCIe hotplug interrupt related fixes 
Date: Mon, 24 Feb 2025 11:44:56 +0800
Message-Id: <20250224034500.23024-1-feng.tang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This patchset tries to address 2 PCIe hotplug interrupt related problems
we met recently:

1. Firmware developers reported that they received two PCIe hotplug commands
   in very short intervals on an ARM server, which doesn't comply with PCIe
   spec, and broke their state machine and work flow.
2. An irq storm bug found when testing "pci=nomsi" case, and the root
   cause is: 'nomsi' will disable MSI and let devices and root ports use
   legacy INTX interrupt, and likely make several devices/ports share one
   interrupt. In the failure case, BIOS doesn't disable the pcie hotplug
   interrupts, and actually asserts the command-complete interrupt.

More details could be found in commit log of patch 2/4 and 4/4. Basically:
    Patch 0001 moves the PCIe hotplug command waiting funtion from pciehp
               driver to PCIe port driver for code reuse.
    Patch 0002 adds the necessary wait for PCIe hotplug command
    Patch 0003 loose the condition check for interrupt disabling
    Patch 0004 for msi disabled case, disable PCIe hotplug interrupt in
               early boot phase 

Please help to review, thanks!

- Feng

Changelog:

  since v2:
    * Add patch 0001, which move the waiting logic of pcie_poll_cmd from pciehp
      driver to PCIe port driver for code reuse (Bjorn Helgaas)
    * Separate Lucas' suggestion out as patch 0003 (Bjorn and Sathyanarayanan)  
    * Avoid hotplug command waiting for HW without command-complete
      event support (Bjorn Helgaas)
    * Fix spell issue in commit log (Bjorn and Markus)
    * Add cover-letter for whole patchset (Markus Elfring)
    * Handle a set-but-unused build warning (0Day lkp bot)

  since v1:
    * Add the Originally-by for Liguang for patch 0002. The issue was found on
      a 5.10 kernel, then 6.6. I was initially given a 5.10 kernel tar ball
      without git info to debug the issue, and made the patch. Thanks to Guanghui
      who recently pointed me to tree https://gitee.com/anolis/cloud-kernel which
      show the wait logic in 5.10 was originally from Liguang, and never hit
      mainline.
    * Make the irq disabling not dependent on wthether pciehp service driver
      will be loaded (Lukas Wunner) 
    * Use read_poll_timeout() API to simply the waiting logic (Sathyanarayanan
      Kuppuswamy)
    * Fix wrong email address (Markus Elfring)
    * Add logic to skip irq disabling if it is already disabled.


Feng Tang (4):
  PCI: portdrv: pciehp: Move PCIe hotplug command waiting logic to port
    driver
  PCI/portdrv: Add necessary wait for disabling hotplug events
  PCI/portdrv: Loose the condition check for disabling hotplug
    interrupts
  PCI: Disable PCIe hotplug interrupts early when msi is disabled

 drivers/pci/hotplug/pciehp_hpc.c | 38 ++++++------------------
 drivers/pci/pci.h                |  7 +++++
 drivers/pci/pcie/portdrv.c       | 50 ++++++++++++++++++++++++++++----
 drivers/pci/probe.c              |  9 ++++++
 4 files changed, 70 insertions(+), 34 deletions(-)

-- 
2.43.5


