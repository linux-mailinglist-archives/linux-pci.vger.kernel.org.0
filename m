Return-Path: <linux-pci+bounces-5502-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8F48947A3
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 01:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A293A283758
	for <lists+linux-pci@lfdr.de>; Mon,  1 Apr 2024 23:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C7956B87;
	Mon,  1 Apr 2024 23:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ON5za/ue"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5678443AD1;
	Mon,  1 Apr 2024 23:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712013812; cv=none; b=hPtnLHkd5tu7IqXaBKWtlbbpgsZPe/Fh6/DNWX+jY1+QZKqiUmx19fKEKFBkr3SpHjlfI8sv//3rMfHwARKdG1wT7qSepfqLAisjd83Uh2Zt6NONKz/SlcAcQzCUw3tey+EyZwc/uWRWJZSmFWS8G1XpCqASWkPI6mFvlzOYSWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712013812; c=relaxed/simple;
	bh=6frmr/LZ+mZh4g2pAfuFIDxm7g5Oks6iY49oaBgnE/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TEHQyfo7CEDw3Tz/QLZxCiz4jccP04Y1UFp0CtU4RVzn0VXWyhJx8JW3VYyaSZPaHoLrZDRq7c4R9RnwrJSZ/f7SYroNHRe0m1Jw+zkFd4qbxDnljMy7yAX/qvy19Z5j4tf6WuMebc8V84OdGEUII/U2RX1elblF0aOFv+6naf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ON5za/ue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0EDC433C7;
	Mon,  1 Apr 2024 23:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712013811;
	bh=6frmr/LZ+mZh4g2pAfuFIDxm7g5Oks6iY49oaBgnE/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ON5za/ueHWisfy+dWgCFHgdDRiRz0O0nJOt/IJZigFwf7B0bxzM+G+YcjTEerMEjd
	 I/OhD4AC76VTZNeQmmxB+qVsrjE4AjDcxeQr8K2BoPsA5Igyk3r9Vub3KXn2QRqIZ0
	 hCeNZumsThUi5LLXWHDz21M/bjLq9FR5ByCynOSHE5UcPhvVGN6QqVokM+Y0egV2e7
	 Icbj+B+vBKYGV4sgaaep6YxyUw8tbnASSgYIoGSVkExBytTVXSDE3DeVV79r+0Gchs
	 fMM6wtWK9TAcuZo6jogKPDQjOw/Du2I0R24+v+e5MX1SvA0mkYNnMQkmeNf/5ubhZE
	 f8IJhyw+pps1A==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Kevin Tian <kevin.tian@intel.com>,
	Marc Zyngier <maz@kernel.org>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Megha Dey <megha.dey@intel.com>,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/3] PCI/MSI: Remove IMS (Interrupt Message Store) support for now
Date: Mon,  1 Apr 2024 18:23:23 -0500
Message-Id: <20240401232326.1794707-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <e5bacec0-28ca-4cd9-9ffe-92feaf5fbfef@kernel.org>
References: <e5bacec0-28ca-4cd9-9ffe-92feaf5fbfef@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

IMS (Interrupt Message Store) support appeared in v6.2, but there are no
users yet.

Remove it for now.  We can add it back when a user comes along.

Bjorn Helgaas (3):
  Revert "PCI/MSI: Provide stubs for IMS functions"
  Revert "PCI/MSI: Provide pci_ims_alloc/free_irq()"
  Revert "PCI/MSI: Provide IMS (Interrupt Message Store) support"

 drivers/pci/msi/api.c       | 50 -------------------------------
 drivers/pci/msi/irqdomain.c | 59 -------------------------------------
 include/linux/pci.h         | 26 ----------------
 3 files changed, 135 deletions(-)

-- 
2.34.1


