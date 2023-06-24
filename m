Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C696F73C5C1
	for <lists+linux-pci@lfdr.de>; Sat, 24 Jun 2023 03:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjFXBOo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Jun 2023 21:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjFXBOm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Jun 2023 21:14:42 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DBA26BD;
        Fri, 23 Jun 2023 18:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1687569281; x=1719105281;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gVBYtovFlShT8nOaYyDi+3MWCsKpoIGfmBUN8cnVydg=;
  b=HlwvHZOqsBs3iyDeb7LDQoYUmii5B7m/krGfIN6qhC/MjqCAnKYxYpVg
   TOvm9uE5sh1sQaBrvqO9O92qxSweEcda42z8IVLiFoeD3V8gxgY75U1IK
   UPjIra7s8Mutg1I7PT398nm6yZzL1N/rMErZuhVdBmo1WCfigTWPoZT5j
   xfrt51vweqVpj/ugBFk1a/PBGqSP4pC6cMUz0SP1K33/19cL4/PT5XawP
   EAikdCVJSCm4ixs37cicN4EiapulEkJwg890lQtlyxp0nZ9MRYH1nlCpE
   YWiJ6eVS2oRXIsGOq5XuOknB9COW2LHPlxWnq7Wj3Asisba6x/vcZXFcl
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,153,1684825200"; 
   d="scan'208";a="158380481"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jun 2023 18:14:41 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 23 Jun 2023 18:14:40 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Fri, 23 Jun 2023 18:14:40 -0700
From:   <kelvin.cao@microchip.com>
To:     <kurt.schwemmer@microsemi.com>, <logang@deltatee.com>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] PCI: switchtec: Add support for PCIe Gen5 devices
Date:   Fri, 23 Jun 2023 17:00:01 -0700
Message-ID: <20230624000003.2315364-1-kelvin.cao@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kelvin Cao <kelvin.cao@microchip.com>

Hi,

This patchset adds support for Switchtec PCIe Gen5 devices by adding
device IDs to the driver and PCI quirks. There's also minor code change
to accommodate those devices.

The patchset is based off of v6.4-rc7.

Thanks,
Kelvin

Kelvin Cao (2):
  PCI: switchtec: Use normal comment style
  PCI: switchtec: Add support for PCIe Gen5 devices

 drivers/pci/quirks.c           |  36 ++++++++
 drivers/pci/switch/switchtec.c | 158 ++++++++++++++++++++-------------
 include/linux/switchtec.h      |   1 +
 3 files changed, 134 insertions(+), 61 deletions(-)

-- 
2.25.1

