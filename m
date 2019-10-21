Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78376DF48E
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2019 19:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729945AbfJURtR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Oct 2019 13:49:17 -0400
Received: from mga05.intel.com ([192.55.52.43]:46782 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbfJURtR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Oct 2019 13:49:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2019 10:49:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,324,1566889200"; 
   d="scan'208";a="187618170"
Received: from unknown (HELO nsgsw-rhel7p6.lm.intel.com) ([10.232.116.12])
  by orsmga007.jf.intel.com with ESMTP; 21 Oct 2019 10:49:16 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        <linux-pci@vger.kernel.org>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH 0/2] PCI: vmd: Fix possible >= MAX_ORDER allocation
Date:   Mon, 21 Oct 2019 05:47:37 -0600
Message-Id: <1571658459-5668-1-git-send-email-jonathan.derrick@intel.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

This set covers a condition where, with many debug options enabled, the
allocation of the vmd irq lists can exceed the max order of the allocator.

The first patch reverts a very old optimization which is no longer valid.
The second patch adds a layer of indirection to the vmd irq lists to
significantly reduce the size per allocation.

Please consider these for v5.5

Jon Derrick (2):
  Revert "x86/PCI: VMD: Eliminate index member from IRQ list"
  PCI: vmd: Add indirection layer to vmd irq lists

 drivers/pci/controller/vmd.c | 47 ++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 23 deletions(-)

-- 
1.8.3.1

