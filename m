Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6C6C315C
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2019 12:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730314AbfJAK3K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Oct 2019 06:29:10 -0400
Received: from mga18.intel.com ([134.134.136.126]:12065 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbfJAK3K (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Oct 2019 06:29:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 03:29:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,570,1559545200"; 
   d="scan'208";a="191418906"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 01 Oct 2019 03:29:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 0219D1AD; Tue,  1 Oct 2019 13:29:05 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Brad Campbell <lists2009@fnarfbargle.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        linux-pci@vger.kernel.org
Subject: [PATCH 0/3] thunderbolt: Fixes for few reported issues
Date:   Tue,  1 Oct 2019 13:29:02 +0300
Message-Id: <20191001102905.21680-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi all,

This series includes fixes for a couple of issues people have reported:

  - Discovering DP path fails on Light Ridge based iMac with two devices
    (monitors) connected.

  - There is a lockdep splat on Dominik's system when plugging in Thunderbolt
    dock.

  - Nicholas spotted that we do unnecessary PCI config space read when
    issuing LC mailbox command on ICL.

Mika Westerberg (3):
  thunderbolt: Read DP IN adapter first two dwords in one go
  thunderbolt: Fix lockdep circular locking depedency warning
  thunderbolt: Drop unnecessary read when writing LC command in Ice Lake

 drivers/thunderbolt/nhi_ops.c |  1 -
 drivers/thunderbolt/switch.c  | 28 +++++++++++-----------------
 2 files changed, 11 insertions(+), 18 deletions(-)

-- 
2.23.0

