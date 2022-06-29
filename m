Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87299560BCF
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 23:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbiF2VgS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 17:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbiF2VgL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 17:36:11 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4EE3FD9B
        for <linux-pci@vger.kernel.org>; Wed, 29 Jun 2022 14:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656538566; x=1688074566;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jn2NH1285pk9HbMOykQfBMgT4zyBr5bMTRzqIXvYfZE=;
  b=AWBdhAgE5J+jtTcxEdHzrfY4KWatV46Af2kJJvjTXoWN2SyiNAz+b92u
   YFgqPLTrzFzZ6JTNwPxq4rcm5UVn0SFKzbZIUsnS1CowNIKNXlIKx53J6
   Fsai2j2tSe9P2kqDsBLmR+yJFILCEIwKfqG/m8WHkl+vjgzqDmtqodKNI
   hBLjq0tji/Kldb8JpTlO146CqEHxeF4mA1Nx0GiD8FWRaM7tY0oR91u1K
   DM7EK351poIIjM8Qv5XH7viSKa8b23yAX7hv91akzO15s78Ai03VoVwBg
   foSXZA8GHJnuRfAmuSDe9T34EzWdagCIYkLeALyMhd1tU1aCI/rtlgsRb
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="270932677"
X-IronPort-AV: E=Sophos;i="5.92,232,1650956400"; 
   d="scan'208";a="270932677"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 14:36:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,232,1650956400"; 
   d="scan'208";a="917772543"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 29 Jun 2022 14:36:02 -0700
Received: from MeteorLakePO1.jf.intel.com (MeteorLakePO1.jf.intel.com [10.234.180.58])
        by linux.intel.com (Postfix) with ESMTP id 64ABB580B55;
        Wed, 29 Jun 2022 14:35:57 -0700 (PDT)
From:   Gayatri Kammela <gayatri.kammela@linux.intel.com>
To:     linux-pci@vger.kernel.org
Cc:     rafael@kernel.org, david.e.box@linux.intel.com,
        Gayatri Kammela <gayatri.kammela@linux.intel.com>
Subject: [RFC] PCIe error handling support
Date:   Wed, 29 Jun 2022 14:36:28 -0700
Message-Id: <20220629213628.433924-1-gayatri.kammela@linux.intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi all,

We have a PCIe device with several functions, 0, 1, and 2. However only function
1 has and needs a driver. We've added PCIe error handler support to this driver,
but it doesn't work by itself to recover the device because the other two
functions do not have drivers bound to them. This condition is covered by the
following code block in drivers/pci/pcie/err.c:

	if (!pci_dev_set_io_state(dev, state) || !pdrv ||
	    !pdrv->err_handler || !pdrv->err_handler->error_detected) {
		/*
		 * If any device in the subtree does not have an error_detected
		 * callback, PCI_ERS_RESULT_NO_AER_DRIVER prevents subsequent
		 * error callbacks of "any" device in the subtree, and will
		 * exit in the disconnected error state.
		 */
		if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE) {
			vote = PCI_ERS_RESULT_NO_AER_DRIVER;
			pci_info(dev, "can't recover (no error_detected callback)\n");
		}

The current solution is to bind dummy drivers to these functions with error
handler support. However, these are custom drivers and we're looking for a
solution that would work upstream without having to provide these drivers.
Starting by looking at this code, is a particular reason to require a driver in
order to recover a PCIe device? Would it be feasible to remove this requirement,
at least allowing other existing function drivers to recover themselves and
allowing recovery of the slot? Thanks.

-- 
2.32.0
