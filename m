Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3312F1BB2ED
	for <lists+linux-pci@lfdr.de>; Tue, 28 Apr 2020 02:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgD1Acv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Apr 2020 20:32:51 -0400
Received: from mga03.intel.com ([134.134.136.65]:53455 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbgD1Acv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Apr 2020 20:32:51 -0400
IronPort-SDR: 5KNYLR3I1xhGKJi7l7vIQiOSnasLct7HltAiYDg6fmwVh+4+feyGshyO433Ja8xOxbTukETJZC
 tJB0J0JCO9qQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 17:32:49 -0700
IronPort-SDR: lBQl9HB+Bjlc4ebtztBGRLJrNoDj+JSiAJk5fsXKUOGRNmgqvn0zEzFk1Tu7dEYA7LmXv6D9mr
 GHn4do8gGo+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,325,1583222400"; 
   d="scan'208";a="404503975"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 27 Apr 2020 17:32:49 -0700
Received: from debox1-hc.jf.intel.com (debox1-hc.jf.intel.com [10.54.75.159])
        by linux.intel.com (Postfix) with ESMTP id B16885807CA;
        Mon, 27 Apr 2020 17:32:49 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     rjw@rjwysocki.net, lenb@kernel.org, bhelgaas@google.com,
        kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Add support for StorageD3Enable _DSD property
Date:   Mon, 27 Apr 2020 17:32:12 -0700
Message-Id: <20200428003214.3764-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

NVMe storage power management during suspend-to-idle, particularly on
laptops, has been inconsistent with some devices working with D3 while
others must rely on NVMe APST in order for power savings to be realized.
Currently the default is to use APST unless quirked to do otherwise.
However newer platforms, like Intel Comet Lake systems, may require NVMe
drives to use D3 in order for the PCIe ports to be properly power managed.
To make it easier for drivers to choose, these platforms may supply a
special "StorageD3Enable" _DSD property under the root port that the device
is attached to. If supplied, the driver must use D3 in order for the
platform to realize the deepest power savings in suspend-to-idle.
    
The first patch adds the new _DSD GUID and fowards the property through the
pci/acpi layer to the pci device.

The second patch adds support for the property to the nvme driver.

David E. Box (2):
  pci: Add ACPI StorageD3Enable _DSD support
  drivers/nvme: Add support for ACPI StorageD3Enable property

 drivers/acpi/property.c |  3 +++
 drivers/nvme/host/pci.c |  7 ++++++
 drivers/pci/pci-acpi.c  | 47 +++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.c       |  6 ++++++
 drivers/pci/pci.h       |  4 ++++
 include/linux/pci.h     |  1 +
 6 files changed, 68 insertions(+)

-- 
2.20.1

