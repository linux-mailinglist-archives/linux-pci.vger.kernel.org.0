Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75E663A04D
	for <lists+linux-pci@lfdr.de>; Mon, 28 Nov 2022 05:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiK1EDw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Nov 2022 23:03:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiK1EDn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Nov 2022 23:03:43 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A59A13D2B;
        Sun, 27 Nov 2022 20:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669608222; x=1701144222;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7a1NGqIRR9f6Jqr5n73oWfmtS1WBJi/dkBMFlHgFXps=;
  b=Sk/PJ2oDiPsjBVlwZ9ucVnFM5JNO+v3bz95L4W6X2QYxfGf+bWA7z79R
   4DmYK/7bQmb98Fn9oCfvFC7lq9qYyiioa7SZ7AEuRovK0xqMuJLn6mH4k
   js1wsuKpn2kLxwkynQhA3J7c7zTlxIGYkP6ZqKGEo2625TAz0AUpbIO2s
   mq0Nx/dSMiQ+4ohUyt22gclIMdW5J77ZLDhOFxyArAIe4+d1HhTC5+uLM
   pYkvL2IyBaEu5mf+Zr+F/+3EXSSJF2lk6hRiUwz1516CTKzv0NH5IUqv/
   fClOde6GtXus0JxJiqqoL+7rLUZLdiR5zZR0TLqMMTa0A7yBoEssj3KK6
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="295127112"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="295127112"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2022 20:03:41 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="593733577"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="593733577"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.2.33])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2022 20:03:41 -0800
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
Subject: [PATCH V3 0/2] PCI/DOE: Remove asynchronous task support
Date:   Sun, 27 Nov 2022 20:03:36 -0800
Message-Id: <20221128040338.1936529-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Changes from V2
	From Jonathan
		Add comment about change in PCI_DOE_POLL_INTERVAL value
		Remove additional code

Changes from V1
	Address comments around locking
	Add patch to remove unneeded pci_doe_flush_mb() call

The asynchronous task support in the PCI DOE mailboxes has become a
maintenance burden.

Remove the code associated with that support.

Ira Weiny (2):
  PCI/DOE: Remove the pci_doe_flush_mb() call
  PCI/DOE: Remove asynchronous task support

 drivers/cxl/core/pci.c  |  16 +----
 drivers/pci/doe.c       | 135 ++++++++++------------------------------
 include/linux/pci-doe.h |  11 +---
 3 files changed, 36 insertions(+), 126 deletions(-)


base-commit: b6e7fdfd6f6a8bf88fcdb4a45da52c42ba238c25
-- 
2.37.2

