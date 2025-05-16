Return-Path: <linux-pci+bounces-27882-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF79AABA168
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 18:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C8E9521042
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 16:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AD6242D8C;
	Fri, 16 May 2025 16:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="a/G4I8ha"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26622417C3;
	Fri, 16 May 2025 16:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747414582; cv=none; b=NnH8ZlAnnXPnWkUeMI4LVefLWUtQdoOh24Y2pJr9HxH2qzsBefwDRObpPL6vuqsUX4IVxMDFp5ekA6i9DeTQ4nA5bLTdOIUNgjuJa2VcM6wAYta6QRQLwxkf0trSfnt39/rrP9Gx6biksRv5KVJKSvApq5OBTeNSF965OLnY4mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747414582; c=relaxed/simple;
	bh=khofMY+tQKRgt4Zd2hx1ukVRxjpmBs++tuBbX8jH09I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MtDoeURKU4iO7FY+T5dgvb6JipTnTDo3BLsUHK3xAU+S7z77TWo0CT8JKb1wcv6mSJSbPnM3ysMU1K2UXUr23mbDLQqyxKEuFhqwPtAvXxb/64q5sSjbsbFWLiDNobMMXVWA23W5pcGL4GHtw0WXnaJGXfj9iuFYBpadQMh8ENw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=a/G4I8ha; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=vQ
	p5KgHSKW4HOO20NVV22SdGkoXvOWWW2pqTNEBzMz4=; b=a/G4I8haOIBbu5bErr
	ytWKeslCzg1XBtmlCDeCdQApTp8/o1owb5PyXTB22syPUtD590ZCq6xX+BS+YauY
	5rWnBKx7FMsVqr7L1rZj/hacpmg3kvLb0BhzIuCoX6rAaTnO+R7ieCt+Xnwjz4vl
	FavdEP3hHECs5wRHEfcPTc7KY=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wB3lOX6bSdoVElgBw--.64634S2;
	Sat, 17 May 2025 00:55:22 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	tglx@linutronix.de,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	mahesh@linux.ibm.com
Cc: oohall@gmail.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH 0/4] pci: implement "pci=aer_panic"
Date: Sat, 17 May 2025 00:55:14 +0800
Message-Id: <20250516165518.125495-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3lOX6bSdoVElgBw--.64634S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXFWUuF4kGF1xuF48ur1UAwb_yoW5ZF1DpF
	WrKws0krn5GFySyFn3CayxWryYy3Z3J345GFykWw18X3ZxKFyUJ34SyFW5tFZIgrW09w45
	Xr4vqrWUWw4DGFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRvoGdUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWx1Po2gnaWRvYwAAsk

The following series introduces a new kernel command-line option aer_panic
to enhance error handling for PCIe Advanced Error Reporting (AER) in
mission-critical environments. This feature ensures deterministic recover
from fatal PCIe errors by triggering a controlled kernel panic when device
recovery fails, avoiding indefinite system hangs.

Problem Statement
In systems where unresolved PCIe errors (e.g., bus hangs) occur,
traditional error recovery mechanisms may leave the system unresponsive
indefinitely. This is unacceptable for high-availability environment
requiring prompt recovery via reboot.

Solution
The aer_panic option forces a kernel panic on unrecoverable AER errors.
This bypasses prolonged recovery attempts and ensures immediate reboot.

Patch Summary:
Documentation Update: Adds aer_panic to kernel-parameters.txt, explaining
its purpose and usage.

Command-Line Handling: Implements pci=aer_panic parsing and state
management in PCI core.

State Exposure: Introduces pci_aer_panic_enabled() to check if the panic
mode is active.

Panic Trigger: Modifies recovery logic to panic the system when recovery
fails and aer_panic is enabled.

Impact
Controlled Recovery: Reduces downtime by replacing hangs with immediate
reboots.

Optional: Enabled via pci=aer_panic; no default behavior change.

Dependency: Requires CONFIG_PCIEAER.

For example, in mobile phones and tablets, when there is a problem with
the PCIe link and it cannot be restored, it is expected to provide an
alternative method to make the system panic without waiting for the
battery power to be completely exhausted before restarting the system.

---
For example, the sm8250 and sm8350 of qcom will panic and restart the
system when they are linked down.

https://github.com/DOITfit/xiaomi_kernel_sm8250/blob/d42aa408e8cef14f4ec006554fac67ef80b86d0d/drivers/pci/controller/pci-msm.c#L5440

https://github.com/OnePlusOSS/android_kernel_oneplus_sm8350/blob/13ca08fdf0979fdd61d5e8991661874bb2d19150/drivers/net/wireless/cnss2/pci.c#L950


Since the design schemes of each SOC manufacturer are different, the AXI
and other buses connected by PCIe do not have a design to prevent hanging.
Once a FATAL error occurs in the PCIe link and cannot be restored, the
system needs to be restarted.


Dear Mani,

I wonder if you know how other SoCs of qcom handle FATAL errors that occur
in PCIe link.
---

Hans Zhang (4):
  pci: implement "pci=aer_panic"
  PCI/AER: Introduce aer_panic kernel command-line option
  PCI/AER: Expose AER panic state via pci_aer_panic_enabled()
  PCI/AER: Trigger kernel panic on recovery failure if aer_panic is set

 .../admin-guide/kernel-parameters.txt          |  7 +++++++
 drivers/pci/pci.c                              |  2 ++
 drivers/pci/pci.h                              |  4 ++++
 drivers/pci/pcie/aer.c                         | 18 ++++++++++++++++++
 drivers/pci/pcie/err.c                         |  8 ++++++--
 5 files changed, 37 insertions(+), 2 deletions(-)


base-commit: fee3e843b309444f48157e2188efa6818bae85cf
prerequisite-patch-id: 299f33d3618e246cd7c04de10e591ace2d0116e6
prerequisite-patch-id: 482ad0609459a7654a4100cdc9f9aa4b671be50b
-- 
2.25.1


