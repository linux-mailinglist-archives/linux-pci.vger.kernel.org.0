Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15DC9EC9C8
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2019 21:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfKAUqP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Nov 2019 16:46:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:54950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbfKAUqO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Nov 2019 16:46:14 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC0A2217D9;
        Fri,  1 Nov 2019 20:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572641174;
        bh=F0N4am3tvuIABgzPZ9GWSjWx45Dug7D8vk5AaQAP3Ns=;
        h=From:To:Cc:Subject:Date:From;
        b=IKiwWi3aVxH1kpP0lBFOKoRM7EVYDoG/yasPcl7BQEF59deTol6utTgyESIG4dAGE
         fnoRmQxUdcNo0NQ4icSiFNYZQBJKThpB9Nrp9wRZZoeoBraDfX8hQww5Pb7tiW4QbJ
         +L8xFng+PxAAADAaKkhNJ1573F2V8Aj8i0Wqz8pQ=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/6] PCI/PM: Minor fix and cleanups
Date:   Fri,  1 Nov 2019 15:45:52 -0500
Message-Id: <20191101204558.210235-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

First, fix our D2 delay (which I think was just a bug -- we delayed in
microseconds instead of milliseconds, but I'm not sure we really even use
D2).

The rest are just cleanups that should not change any behavior.  These are
based on my current pci/pm branch (0d1685046e61) and I pushed them to
pci/pm-2 for now.

Bjorn Helgaas (6):
  PCI/PM: Apply D2 delay as milliseconds, not microseconds
  PCI/PM: Expand PM reset messages to mention D3hot (not just D3)
  PCI/PM: Simplify pci_set_power_state()
  xen-platform: Convert to generic power management
  PCI/PM: Remove unused pci_driver.resume_early() hook
  PCI/PM: Remove unused pci_driver.suspend_late() hook

 Documentation/power/pci.rst | 10 ++++-----
 drivers/pci/pci-driver.c    | 43 ++++++-------------------------------
 drivers/pci/pci.c           |  8 +++----
 drivers/xen/platform-pci.c  | 10 ++++++---
 include/linux/pci.h         |  4 ----
 5 files changed, 22 insertions(+), 53 deletions(-)

-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

