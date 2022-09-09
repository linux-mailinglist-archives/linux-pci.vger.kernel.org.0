Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83745B4064
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 22:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiIIUQ1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 16:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbiIIUQ0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 16:16:26 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B271116F5
        for <linux-pci@vger.kernel.org>; Fri,  9 Sep 2022 13:16:24 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 289KGKV7002085;
        Fri, 9 Sep 2022 15:16:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1662754580;
        bh=tFA0ATOgcSMbn1q0lgQEfJ9YWZR4cVjSev8XnXsgehk=;
        h=From:To:CC:Subject:Date;
        b=E637YVQ6bDbhDksM9ndp2AifVaTP/EN5P93NPWiJPgUGlPDkzBzZRsQmQvTG7/ULK
         F4/+V8wiW/U/SXhlQN2wWy1pKkgydONTiMhbK8y5OpKr1PddbUkHHKUw2cLn0VJjlR
         s487dvuaJ2szPeEAHvQ+OI4dECamZtPo+g2GQgUI=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 289KGKG4045625
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 9 Sep 2022 15:16:20 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 9 Sep
 2022 15:16:19 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 9 Sep 2022 15:16:19 -0500
Received: from ubuntu.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 289KGDp1071511;
        Fri, 9 Sep 2022 15:16:15 -0500
From:   Matt Ranostay <mranostay@ti.com>
To:     <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     <tjoseph@cadence.com>, <vigneshr@ti.com>, <kishon@ti.com>,
        Matt Ranostay <mranostay@ti.com>
Subject: [PATCH 0/3] PCI: add 4x lane support for pci-j721e controllers
Date:   Fri, 9 Sep 2022 13:16:04 -0700
Message-ID: <20220909201607.3835-1-mranostay@ti.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Adding of dditional support to Cadence PCIe controller (i.e. pci-j721e.c)
for up to 4x lanes, and reworking of driver to define maximum lanes per
board configuration.

Matt Ranostay (3):
  PCI: j721e: Add PCIe 4x lane selection support
  PCI: j721e: Add per platform maximum lane settings
  PCI: j721e: Add warnings on num-lanes misconfiguration

 drivers/pci/controller/cadence/pci-j721e.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

-- 
2.37.2

