Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD54963409A
	for <lists+linux-pci@lfdr.de>; Tue, 22 Nov 2022 16:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbiKVPx3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Nov 2022 10:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbiKVPx2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Nov 2022 10:53:28 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB673FBBA;
        Tue, 22 Nov 2022 07:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669132407; x=1700668407;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZieeqBSO9ZKAHPTInxT0PCQuGM6JN6mzwwhY7KzUGXg=;
  b=TSbASHHFZU58eeP7Q10BxDBEfxjxVb9DFqSvH1qgyRH1JkWdbF/gCRik
   4m9eiUMs7ApGmEN9IviThU36qHanLysg02fz09x5Hw1o0/PrQnoKaAMEw
   /ZKPagiKbffzshiCy4+XalD1zQfLSzMGDV+bRbrqZ6SKqB5oc4Qc7nU57
   udr4Zg7Ip7u3dWfXR+lFyRK8AbyQw85DGjq/FWz0zOwCoFkA6r+osnayq
   WT7E1xZcVJ9wOVGyDhBTSr1ydMCdZroT9JVvPSmjRZIUYZj5VCUFQsqfn
   su90Vi3z1HUFCgrGQYRQR7xnLC1eNOZv37Ne6buBzytJYS1w8OQZkrbNH
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="313877728"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="313877728"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 07:53:27 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="816142047"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="816142047"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.209.130.75])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 07:53:26 -0800
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Lukas Wunner <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gregory Price <gregory.price@memverge.com>,
        "Li, Ming" <ming4.li@intel.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: [PATCH V2 0/2] PCI/DOE: Remove asynchronous task support
Date:   Tue, 22 Nov 2022 07:53:22 -0800
Message-Id: <20221122155324.1878416-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Changes from V1
	Address comments around locking
	Add patch to remove unneeded pci_doe_flush_mb() call

The asynchronous task support in the PCI DOE mailboxes has become a
maintenance burden.

Remove the code associated with that support.

Ira Weiny (2):
  PCI/DOE: Remove the pci_doe_flush_mb() call
  PCI/DOE: Remove asynchronous task support

 drivers/cxl/core/pci.c  |  16 +-----
 drivers/pci/doe.c       | 123 +++++++++-------------------------------
 include/linux/pci-doe.h |  10 +---
 3 files changed, 32 insertions(+), 117 deletions(-)


base-commit: b6e7fdfd6f6a8bf88fcdb4a45da52c42ba238c25
-- 
2.37.2

