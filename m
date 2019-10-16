Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0913DA1EA
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2019 01:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390104AbfJPXGY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Oct 2019 19:06:24 -0400
Received: from mga02.intel.com ([134.134.136.20]:4571 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731616AbfJPXGY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Oct 2019 19:06:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2019 16:06:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,305,1566889200"; 
   d="scan'208";a="189833609"
Received: from unknown (HELO nsgsw-rhel7p6.lm.intel.com) ([10.232.116.93])
  by orsmga008.jf.intel.com with ESMTP; 16 Oct 2019 16:06:23 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        Pawel Baldysiak <pawel.baldysiak@intel.com>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Dave Fugate <david.fugate@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH 0/3] Expose VMD BIOS domain info
Date:   Wed, 16 Oct 2019 11:04:45 -0600
Message-Id: <1571245488-3549-1-git-send-email-jonathan.derrick@intel.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In order to provide better VMD userspace management support, VMD needs to know
its instance number in the platform. VMDs can be enabled or disabled, so a
simple enumeration can't explicitly determine the instance number of the VMD.

To assist userspace with management tasks, VMD BIOS writes the VMD instance
number and socket number into the first enabled root port's IO Base/Limit
registers prior to OS handoff. VMD driver can capture this information and
expose it to userspace.

This set exposes hardware-specific details of the VMD configuration as written
by the VMD-enabled BIOS. This data is restored to the same location on reset or
module unload. This set reuses the serialized child device configuration
accessors for proper ordering and write flushing.

Jon Derrick (3):
  PCI: vmd: Add helpers to access device config space
  PCI: vmd: Expose VMD details from BIOS
  PCI: vmd: Restore domain info during resets/unloads

 drivers/pci/controller/vmd.c | 147 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 133 insertions(+), 14 deletions(-)

-- 
1.8.3.1

