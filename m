Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA5862BB970
	for <lists+linux-pci@lfdr.de>; Fri, 20 Nov 2020 23:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbgKTWvx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Nov 2020 17:51:53 -0500
Received: from mga04.intel.com ([192.55.52.120]:15001 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728905AbgKTWvw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Nov 2020 17:51:52 -0500
IronPort-SDR: O4H6Dpsqjc0Ud7oUSb/LsJ2hQi19pGIBmsD21K/Z3yN4SiwHYFXL7l/f+C09dmWuGxD5A9vbEE
 L/lDFxTR98Lg==
X-IronPort-AV: E=McAfee;i="6000,8403,9811"; a="168985721"
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="168985721"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 14:51:52 -0800
IronPort-SDR: 7y8T8eA5IJdQ/X6fdwMO4Qj1W9BmIt6xg8/zadBIFEe77f3kuJ7ycPwBF8spdejYULlLYYrB1s
 /eUiqiuST1GQ==
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="357852053"
Received: from sabakhle-mobl1.amr.corp.intel.com (HELO jderrick-mobl.amr.corp.intel.com) ([10.213.165.80])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 14:51:51 -0800
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        Nirmal Patel <nirmal.patel@intel.com>,
        Sushma Kalakota <sushmax.kalakota@intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH 0/5] Legacy direct-assign mode
Date:   Fri, 20 Nov 2020 15:51:39 -0700
Message-Id: <20201120225144.15138-1-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This set adds a legacy direct-assign mode. Newer enterprise hardware has
physical addressing hints to assist device passthrough to guests that needs to
correctly program bridge windows with physical addresses. Some customers are
using a legacy method that relies on the VMD subdevice domain's root port
windows to be written with the physical addresses. This method also allows
other hypervisors besides QEMU/KVM to perform guest passthrough.

This patchset adds a host and guest mode to write the physical address
information to the root port registers in the host and read them in the guest,
and restore them in both cases on module unload.

This patchset also folds in the VMD subdevice domain secondary bus reset
patchset [1] to clear the domain prior to guest passthrough.

[1] https://patchwork.kernel.org/project/linux-pci/cover/20200928010557.5324-1-jonathan.derrick@intel.com/

Jon Derrick (5):
  PCI: vmd: Reset the VMD subdevice domain on probe
  PCI: Add a reset quirk for VMD
  PCI: vmd: Add offset translation helper
  PCI: vmd: Pass features to vmd_get_phys_offsets()
  PCI: vmd: Add legacy guest passthrough mode

 drivers/pci/controller/vmd.c | 200 ++++++++++++++++++++++++++++++++++++++-----
 drivers/pci/quirks.c         |  48 +++++++++++
 2 files changed, 227 insertions(+), 21 deletions(-)

-- 
1.8.3.1

