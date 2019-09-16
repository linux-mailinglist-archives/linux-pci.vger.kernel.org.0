Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 828B9B416A
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2019 21:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732798AbfIPTzs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Sep 2019 15:55:48 -0400
Received: from mga01.intel.com ([192.55.52.88]:35459 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732696AbfIPTzs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Sep 2019 15:55:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 12:55:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,513,1559545200"; 
   d="scan'208";a="177152708"
Received: from unknown (HELO debian-vmd.lm.intel.com) ([10.232.112.42])
  by orsmga007.jf.intel.com with ESMTP; 16 Sep 2019 12:55:47 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] VMD fixes for v5.4
Date:   Mon, 16 Sep 2019 07:54:33 -0600
Message-Id: <20190916135435.5017-1-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo, Bjorn, Keith,

Please consider the following patches for 5.4 inclusion.

These will apply to 5.2 stable. 4.19 has a few feature deps so I will instead
follow-up with a backport.

Jon Derrick (2):
  PCI: vmd: Fix config addressing when using bus offsets
  PCI: vmd: Fix shadow offsets to reflect spec changes

 drivers/pci/controller/vmd.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

-- 
2.20.1

