Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B911F9913
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2019 19:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfKLStn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Nov 2019 13:49:43 -0500
Received: from mga03.intel.com ([134.134.136.65]:15388 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726957AbfKLStn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Nov 2019 13:49:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Nov 2019 10:49:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,297,1569308400"; 
   d="scan'208";a="198183587"
Received: from unknown (HELO nsgsw-rhel7p6.lm.intel.com) ([10.232.117.44])
  by orsmga008.jf.intel.com with ESMTP; 12 Nov 2019 10:49:42 -0800
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH v2 0/2] VMD support for 8086:9A0B
Date:   Tue, 12 Nov 2019 05:47:51 -0700
Message-Id: <1573562873-96828-1-git-send-email-jonathan.derrick@intel.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This set adds VMD support for device 8086:9A0B. The first patch adds
another bus range restriction and the second patch adds the device id.

v1->v2:
Reworded ambiguous commit message to match code comment
Coding style fixes

Jon Derrick (2):
  PCI: vmd: Add bus 224-255 restriction decode
  PCI: vmd: Add device id for VMD device 8086:9A0B

 drivers/pci/controller/vmd.c | 32 ++++++++++++++++++++++++--------
 include/linux/pci_ids.h      |  1 +
 2 files changed, 25 insertions(+), 8 deletions(-)

-- 
1.8.3.1

