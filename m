Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 222EC1A8CC3
	for <lists+linux-pci@lfdr.de>; Tue, 14 Apr 2020 22:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633344AbgDNUpF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Apr 2020 16:45:05 -0400
Received: from mga17.intel.com ([192.55.52.151]:48103 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2633341AbgDNUpE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Apr 2020 16:45:04 -0400
IronPort-SDR: kujtMVIFQLHOCdhCODiESeCkJ4MH4p7zaRRw7d3yDTj3iWbNrZvLzec++zoiwIm/wdSiP8KLKr
 92mfKxiKwVSQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 13:45:03 -0700
IronPort-SDR: 3ZmR5Yrg763KwRkjQQ8aCzdC4BJkBzmDEJ2gR694c8D1HHi12SlW0slp/GRjRvTXhnAm4LZkHy
 QhxsUKV7tkHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,384,1580803200"; 
   d="scan'208";a="288336363"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.116.40])
  by fmsmga002.fm.intel.com with ESMTP; 14 Apr 2020 13:45:02 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <linux-pci@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH 0/5] PCI Bridge Emulation changes for v5.8
Date:   Tue, 14 Apr 2020 16:30:00 -0400
Message-Id: <20200414203005.5166-1-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

These are the changes for pci-bridge-emul as applies to your origin/next.

The first two patches are fixes for existing issues.
The third patch is the conversion to GENMASK() and BIT() for clarity.
The fourth adds the missing bit definitions from PCIe 4.0 and PCIe 5.0.
The fifth patch optimizes away the unnecessary reserved member.

Jon Derrick (5):
  PCI: pci-bridge-emul: Fix PCIe bit conflicts
  PCI: pci-bridge-emul: Fix Root Cap/Status comment
  PCI: pci-bridge-emul: Convert to GENMASK and BIT
  PCI: pci-bridge-emul: Update for PCIe 5.0 r1.0
  PCI: pci-bridge-emul: Eliminate the 'reserved' member

 drivers/pci/pci-bridge-emul.c | 78 +++++++++++++++++------------------
 1 file changed, 37 insertions(+), 41 deletions(-)

-- 
2.18.1

