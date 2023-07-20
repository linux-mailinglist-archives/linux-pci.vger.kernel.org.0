Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23FC75ABEA
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jul 2023 12:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjGTK31 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jul 2023 06:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjGTK30 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jul 2023 06:29:26 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E15910F1;
        Thu, 20 Jul 2023 03:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689848965; x=1721384965;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8BRj9DV9hZENUSR739fKaMViZ/7IEPkjjSo5RbBuyWM=;
  b=aHKFKUbLdKqfnfVkN/EUab8J+L+6EORVe0ZGkUB2XelLajVMnK1Ql/y1
   6wcUsBgsHia+3FX23HWwPXhBpyBIx4Uz5DyfEQUnxsiax07ib8yt22x4k
   GQBiqnKPOQiHAHa4gc3kYvWNFGNd6hdxtjUGO5viGYVfpj7chr1ANk0AJ
   SYUlffd7OkhsagUW1gJw7a6NpZJxYSyYygm98ORYXMo+3CXovZQB8rKYo
   1hVc4lHAY9LPYoe5OTyEzwtAWuYWx6axrARWsKh05H8fqzVPbQrALthE2
   qJZRwX61VZIY77WlBCbv85SpUyQtoaYWiZg29+ag1jDHNlrW4FNWtvdkD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="370261353"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="370261353"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 03:29:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="727636701"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="727636701"
Received: from unknown (HELO jiaqingz-acrn-container.sh.intel.com) ([10.239.138.235])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 03:29:22 -0700
From:   Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>,
        support@ems-wuensche.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-can@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
Subject: [PATCH v2 0/2] can: ems_pci: refine PCI IDs for ASIX AX99100
Date:   Thu, 20 Jul 2023 10:28:57 +0000
Message-Id: <20230720102859.2985655-1-jiaqing.zhao@linux.intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Moves ASIX AX99100 ids to pci_ids.h for serial and parallel driver
support in upcoming patchset. Also removes PCI_SUBVENDOR_ID_ASIX as
0xa000 is not the PCI-SIG assigned vendor id of ASIX.

Link: https://lore.kernel.org/all/20230718174200.2862849-1-jiaqing.zhao@linux.intel.com/

Changes in v2:
* Split changes into 2 patchsets

Jiaqing Zhao (2):
  can: ems_pci: remove PCI_SUBVENDOR_ID_ASIX definition
  can: ems_pci: move ASIX AX99100 ids to pci_ids.h

 drivers/net/can/sja1000/ems_pci.c | 7 +------
 include/linux/pci_ids.h           | 4 ++++
 2 files changed, 5 insertions(+), 6 deletions(-)

-- 
2.39.2

