Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8123D1A3A8A
	for <lists+linux-pci@lfdr.de>; Thu,  9 Apr 2020 21:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgDITcX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Apr 2020 15:32:23 -0400
Received: from mga03.intel.com ([134.134.136.65]:63075 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbgDITcX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Apr 2020 15:32:23 -0400
IronPort-SDR: g2ePG55Q4gudTlfh+BVzHSl45L+9CleVXQ5VTG/v6z0N9eALrJPgSyzdr4+FXlakvaltRItW3x
 5Hig9f2PtFvQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2020 12:32:22 -0700
IronPort-SDR: FcOz2aKwDMUhIQvHop9Zpt0cOYquXgeCrNF7hCJY+gyODlZuB+JF9XbErfROwv238uifDji3OB
 1QnJ132mntlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,363,1580803200"; 
   d="scan'208";a="452116450"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.116.40])
  by fmsmga005.fm.intel.com with ESMTP; 09 Apr 2020 12:32:21 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     Joerg Roedel <joro@8bytes.org>, <iommu@lists.linux-foundation.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Daniel Drake <drake@endlessm.com>, <linux@endlessm.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH 0/1] Real DMA dev DMA domain patch
Date:   Thu,  9 Apr 2020 15:17:35 -0400
Message-Id: <20200409191736.6233-1-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Sorry for the late patch here, but I hit the issue Baolu and Daniel
pointed out could occur, and requires this fix (or iommu=nopt).
Hoping to get it into an rc

Jon Derrick (1):
  iommu/vt-d: use DMA domain for real DMA devices and subdevices

 drivers/iommu/intel-iommu.c | 56 ++++++++++++++++++++++++++++---------
 1 file changed, 43 insertions(+), 13 deletions(-)

-- 
2.18.1

