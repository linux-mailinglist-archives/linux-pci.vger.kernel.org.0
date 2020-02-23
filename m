Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84B59169787
	for <lists+linux-pci@lfdr.de>; Sun, 23 Feb 2020 13:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbgBWMVn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Feb 2020 07:21:43 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:6040 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgBWMVn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 23 Feb 2020 07:21:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1582460503; x=1613996503;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nFrfdEws7Mg6zyQ4vp2uvz+5RN3YBvaRiyf1ods/ycM=;
  b=qr7So0LfAjjfoRM5yCbNbM7ZmI8J/okB/A0/dO00fRpCisTTMj/L7E7J
   BYz9Ehz7LTuUxAfbP158YM9LUR6wEvROOV4pQYg4A3h/n6W/xApWRy2Zo
   ZIof30xn2KxA6/QqOTG93Jnu1v7Qij6pbGtT2tQXsa4eJWRcWtTQ7inYK
   k=;
IronPort-SDR: bqmpiaEdSnFT+aLdoDqmhEhdjReMPlSgzPXC3sB/A+Tf7QRYOd3pEc4VN/VRkAa0HLpPJxLCgN
 KYGqsX5cogVw==
X-IronPort-AV: E=Sophos;i="5.70,476,1574121600"; 
   d="scan'208";a="26903876"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-c5104f52.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 23 Feb 2020 12:21:41 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-c5104f52.us-west-2.amazon.com (Postfix) with ESMTPS id C26E0A39EB;
        Sun, 23 Feb 2020 12:21:40 +0000 (UTC)
Received: from EX13D12EUA001.ant.amazon.com (10.43.165.48) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Sun, 23 Feb 2020 12:21:40 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D12EUA001.ant.amazon.com (10.43.165.48) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 23 Feb 2020 12:21:39 +0000
Received: from u961addbe640f56.ant.amazon.com (10.28.84.111) by
 mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Sun, 23 Feb 2020 12:21:37 +0000
From:   Stanislav Spassov <stanspas@amazon.com>
To:     <linux-pci@vger.kernel.org>
CC:     Stanislav Spassov <stanspas@amazon.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Jan=20H=20=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        Wei Wang <wawei@amazon.de>
Subject: [PATCH 0/3] Improve PCI device post-reset readiness polling
Date:   Sun, 23 Feb 2020 13:20:54 +0100
Message-ID: <20200223122057.6504-1-stanspas@amazon.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Stanislav Spassov <stanspas@amazon.de>

Enable the global maximum polling time to be configured on the kernel
command line, and make per-device overrides possible. This allows the
default timeout to be lowered while accomodating devices that require
more time to finish initialization after a reset.

When Configuration Request Retry Status Software Visibility is enabled
on the parent PCIe Root Port, it is better to poll the PCI_VENDOR_ID
register to get the special CRS behavior specified in the PCI Express
Base Specification. Polling a different register can result in system
crashes due to core timeouts when the Root Port autonomously keeps
retrying the Configuration Read without reporting back to the CPU.

Wei Wang (1):
  PCI: Make PCIE_RESET_READY_POLL_MS configurable

Stanislav Spassov (2):
  PCI: Introduce per-device reset_ready_poll override
  PCI: Add CRS handling to pci_dev_wait()

 .../admin-guide/kernel-parameters.txt         |   5 +
 drivers/pci/pci.c                             | 157 +++++++++++++++---
 drivers/pci/probe.c                           |   2 +
 include/linux/pci.h                           |   1 +
 4 files changed, 138 insertions(+), 27 deletions(-)


base-commit: bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9
-- 
2.25.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



