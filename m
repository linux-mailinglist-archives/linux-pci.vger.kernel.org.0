Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B044A7583BC
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jul 2023 19:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjGRRqO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jul 2023 13:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbjGRRqN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jul 2023 13:46:13 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964FB173A;
        Tue, 18 Jul 2023 10:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689702371; x=1721238371;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FUVD4hJBO5IxMDmFyymfYBCztnS3mXGJcBnU4SZwflA=;
  b=A1OdLG73ALT+ieC9TD5wz6zlpD79usRG4fSq5gwCJ974em3U8LpVtcYm
   yE1fsZWnxSBnprlHJkevNRMKGqfDstF1pl9A2eaGHM6n4dJvzAISOuH/G
   v2puhmtU9PuKu3J+BVguETZJKcrbOSUFLTWSFGOojyc6ZAbcALSXjwTGs
   F7jhhNmphfIoBTikcSCD8s8aI8o+o50qTx/srtIIQijS1NCfULeCPIrGx
   theaYmPu//o2EIO3W2WyfIBYTLucaCcJDWgcCchvgSZvhjWcbN1BUOeLj
   dMRQE0pIsGjap3y+DfF3nmWU5vpTPHPALt2DOcm+PVvnpBtBKkHKyUFNv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="432452364"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="432452364"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 10:46:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="727034132"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="727034132"
Received: from unknown (HELO jiaqingz-acrn-container.sh.intel.com) ([10.239.138.235])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 10:46:01 -0700
From:   Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
Subject: [PATCH 0/4] add support for ASIX AX99100
Date:   Tue, 18 Jul 2023 17:41:56 +0000
Message-Id: <20230718174200.2862849-1-jiaqing.zhao@linux.intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch adds kernel inbox driver support for the serial port and
parallel port mode controller of ASIX AX99100 PCIe to Multi I/O
Controller. This device has 4 separate PCI functions and each functions
can be configured to operate in different modes.

This patchset is tested with ASIX AX99100 in following modes:
* 4 x Serial Port
* 2 x Serial Port
* 2 x Serial Port + 1 x Parallel Port
* 1 x Parallel Port

Jiaqing Zhao (4):
  can: ems_pci: remove PCI_SUBVENDOR_ID_ASIX definition
  can: ems_pci: move ASIX AX99100 ids to pci_ids.h
  serial: 8250_pci: add support for ASIX AX99100
  parport_pc: add support for ASIX AX99100

 drivers/net/can/sja1000/ems_pci.c  |  7 +------
 drivers/parport/parport_pc.c       |  5 +++++
 drivers/tty/serial/8250/8250_pci.c | 10 ++++++++++
 include/linux/pci_ids.h            |  4 ++++
 4 files changed, 20 insertions(+), 6 deletions(-)

-- 
2.39.2

