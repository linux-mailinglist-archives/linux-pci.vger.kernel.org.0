Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C383327A52D
	for <lists+linux-pci@lfdr.de>; Mon, 28 Sep 2020 03:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgI1BZ4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Sep 2020 21:25:56 -0400
Received: from mga14.intel.com ([192.55.52.115]:32171 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbgI1BZ4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 27 Sep 2020 21:25:56 -0400
IronPort-SDR: x3QNEWncSG7cW7dEgr5bLyFrwLVD+wO6qcQVWc60vwp6MyMuIi0seUfP8T2PGy5ze4cvQKiv0r
 XeP/PV5yFKJQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="161157201"
X-IronPort-AV: E=Sophos;i="5.77,312,1596524400"; 
   d="scan'208";a="161157201"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2020 18:26:11 -0700
IronPort-SDR: yfkXTY7GCrcz+RWiqPv7XGs76ZwST/szo0jHRFZ3mlLKONoUkk0+xLDzcrpFzgha4Q2GkFDzu1
 ZBA4Ordx/eHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,312,1596524400"; 
   d="scan'208";a="488360770"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.116.36])
  by orsmga005.jf.intel.com with ESMTP; 27 Sep 2020 18:26:10 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <linux-pci@vger.kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
        Dave Fugate <david.fugate@intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH 0/2] VMD subdevice secondary bus resets
Date:   Sun, 27 Sep 2020 21:05:55 -0400
Message-Id: <20200928010557.5324-1-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This set adds some resets for VMD. It's very common code but doesn't
seem to fit well anywhere that can also be exported if VMD is built as a
module.

Jon Derrick (2):
  PCI: vmd: Reset the VMD subdevice domain on probe
  PCI: Add a reset quirk for VMD

 drivers/pci/controller/vmd.c | 32 ++++++++++++++++++++++++
 drivers/pci/quirks.c         | 48 ++++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)

-- 
2.18.1

