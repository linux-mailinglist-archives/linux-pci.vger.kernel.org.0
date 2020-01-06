Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3E3C131B8C
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2020 23:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgAFWhX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jan 2020 17:37:23 -0500
Received: from mga01.intel.com ([192.55.52.88]:28167 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbgAFWhX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Jan 2020 17:37:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jan 2020 14:37:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,403,1571727600"; 
   d="scan'208";a="210925883"
Received: from unknown (HELO skalakox.lm.intel.com) ([10.232.116.60])
  by orsmga007.jf.intel.com with ESMTP; 06 Jan 2020 14:37:22 -0800
From:   Sushma Kalakota <sushmax.kalakota@intel.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Jonathan Derrick <jonathan.derrick@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Sushma Kalakota <sushmax.kalakota@intel.com>
Subject: [PATCH 0/2] New VMD Device ids
Date:   Mon,  6 Jan 2020 15:41:20 -0700
Message-Id: <20200106224122.3231-1-sushmax.kalakota@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This set adds new VMD device ids

Sushma Kalakota (2):
  PCI: vmd: Add device id for VMD device 8086:4C3D
  PCI: vmd: Add device id for VMD device 8086:467F

 drivers/pci/controller/vmd.c | 4 ++++
 include/linux/pci_ids.h      | 2 ++
 2 files changed, 6 insertions(+)

-- 
2.17.1

