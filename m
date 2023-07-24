Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567DE75EDEE
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jul 2023 10:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjGXIkV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jul 2023 04:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbjGXIkF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jul 2023 04:40:05 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1383E10EF;
        Mon, 24 Jul 2023 01:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690187999; x=1721723999;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=x12lrtGBZQsSW3ujLW9h0V/KCIjM8IrYlUp2GSyhMfI=;
  b=VfFns614YrMCCoRGXSr6KX3PaxCRzFKdZPYhw/v56M6WiIwV51B/aPxO
   GbEFmIoBLAbPYnaqQzq4OHxyoTYQRGoinrwqmH0Md78nfnWG09Cvl1Mk2
   vFHEdRbzj0NsCsrO3yYfMO4vNqPnaAN9A3r2gXPUBDKZubV6r9X0MssfR
   dDN1oLBIoB+WF4nKNcbViw+a78KDu1IefriSL+CBCCqEQR1i5U7oBI0Rx
   U+A471Fq6vBIiXgAHOCKE3uQtpudHIkPhvQsbhAKGeQs3s+KStydXWKsf
   i7RdmbSNd32AYX8ZUxu8q2lT8GaEw0/JXc3NPJHbKTjVLpY1Db4D22NrR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="433627611"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="433627611"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 01:39:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="675749431"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="675749431"
Received: from unknown (HELO jiaqingz-acrn-container.sh.intel.com) ([10.239.138.235])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 01:39:55 -0700
From:   Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>,
        support@ems-wuensche.com, linux-serial@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
Subject: [PATCH v3 0/4] add support for ASIX AX99100
Date:   Mon, 24 Jul 2023 08:39:29 +0000
Message-Id: <20230724083933.3173513-1-jiaqing.zhao@linux.intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

Changes in v3:
* Keep all changes in a single patchset.
* Update commit message of patch 3.
* Get Acked-By from maintainers for patch 1 & 2.

Changes in v2:
* Split changes into 2 patchsets.
Link: https://lore.kernel.org/all/20230720102859.2985655-1-jiaqing.zhao@linux.intel.com/

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

