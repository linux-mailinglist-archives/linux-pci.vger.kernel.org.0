Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9CFB7B6978
	for <lists+linux-pci@lfdr.de>; Tue,  3 Oct 2023 14:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjJCMxU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Oct 2023 08:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjJCMxU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Oct 2023 08:53:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0B393;
        Tue,  3 Oct 2023 05:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696337597; x=1727873597;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=702HqFQNmxV7YgGeTBn23DHTxJX9WZ3IGA7eOFHSmOU=;
  b=e0Yh7WBJccq8BOxpZEoWmfK1Vss/q3LeWjmDTWkOqdafmJZgbRQ+5q7U
   JzKhvc2hTeXyy1OC7icU4LUn8S7ufr7kAA5OLeOLeBn7oWzXi50qxscYO
   h7azswMnSdiB/sqsa+maVH1Ju29VjtjaCAxTVQ7KMewZr+QJggHeSVqp8
   zmtQTuk6gCtrgLRHIWmDEFzTIqkomgCS6tYReC6KYU+jZ05Gqx+uqdhNx
   GfpHrkONq3QwLfkQcybIGzWwMorUDygSGwY1Bv6Z7aNR755VC49aZ+aCU
   MAEYOSnga0oUJ1a5sVJBl0olDaBKAIVx8GSXWNu6jr/l/sOGGuZWTrIo6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="447022284"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="447022284"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 05:53:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="998005890"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="998005890"
Received: from bmihaile-mobl1.ger.corp.intel.com (HELO localhost) ([10.251.222.64])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 05:53:08 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        bcm-kernel-feedback-list@broadcom.com, jonathan.derrick@linux.dev,
        kw@linux.com, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-renesas-soc@vger.kernel.org,
        lpieralisi@kernel.org, marek.vasut+renesas@gmail.com,
        minghuan.Lian@nxp.com, mingkai.hu@nxp.com,
        m.karthikeyan@mobiveil.co.in, nirmal.patel@linux.intel.com,
        rjui@broadcom.com, robh@kernel.org, roy.zang@nxp.com,
        sbranden@broadcom.com, yoshihiro.shimoda.uh@renesas.com,
        Zhiqiang.Hou@nxp.com
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 0/3] PCI: PCI_HEADER_TYPE bugfix & cleanups
Date:   Tue,  3 Oct 2023 15:52:57 +0300
Message-Id: <20231003125300.5541-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

One bugfix and cleanups for PCI_HEADER_TYPE_* literals.

This series only covers what's within drivers/pci/. I'd have patches
for other subsystems too but I decided to wait with them until
PCI_HEADER_TYPE_MFD is in Linus' tree (to keep the series receipient
count reasonable, the rest can IMO go through the subsystem specific
trees once the define is there).

Ilpo Järvinen (3):
  PCI: vmd: Correct PCI Header Type Register's MFD bit check
  PCI: Add PCI_HEADER_TYPE_MFD pci_regs.h
  PCI: Use PCI_HEADER_TYPE_* instead of literals

 drivers/pci/controller/dwc/pci-layerscape.c   |  2 +-
 .../controller/mobiveil/pcie-mobiveil-host.c  |  2 +-
 drivers/pci/controller/pcie-iproc.c           |  2 +-
 drivers/pci/controller/pcie-rcar-ep.c         |  2 +-
 drivers/pci/controller/pcie-rcar-host.c       |  2 +-
 drivers/pci/controller/vmd.c                  |  5 ++---
 drivers/pci/hotplug/cpqphp_ctrl.c             |  6 ++---
 drivers/pci/hotplug/cpqphp_pci.c              | 22 +++++++++----------
 drivers/pci/hotplug/ibmphp.h                  |  5 +++--
 drivers/pci/hotplug/ibmphp_pci.c              |  2 +-
 drivers/pci/pci.c                             |  2 +-
 drivers/pci/quirks.c                          |  6 ++---
 include/uapi/linux/pci_regs.h                 |  1 +
 13 files changed, 30 insertions(+), 29 deletions(-)

-- 
2.30.2

