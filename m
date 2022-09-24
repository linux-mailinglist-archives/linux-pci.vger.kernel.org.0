Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4D55E9055
	for <lists+linux-pci@lfdr.de>; Sun, 25 Sep 2022 00:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiIXWfj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 24 Sep 2022 18:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiIXWfh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 24 Sep 2022 18:35:37 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866582BB18;
        Sat, 24 Sep 2022 15:35:30 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 28OMZLut110031;
        Sat, 24 Sep 2022 17:35:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1664058921;
        bh=YGa9njGEbYg1QGwQSVo2ytMT+Az3AQOCR+tynq9mO5g=;
        h=From:To:CC:Subject:Date;
        b=OUeZxUiWX+IAfyaVGO3tSUvjIhno/7ZxI0sjapI92dYxbLoMkjeGDPJHBiWgV1Du2
         Q+zlwrdbkbpC9Y/JjhQF1JeYC0Zl+TkHgdWOuE6NvTC23OqfnzK57DXXbxGcZA3bMe
         jAqnbyMVCDx/pMCI5Ge8DMXduK7f3Aj2guVi5xXs=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 28OMZLIB111994
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 24 Sep 2022 17:35:21 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Sat, 24
 Sep 2022 17:35:21 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Sat, 24 Sep 2022 17:35:21 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 28OMZIXY005126;
        Sat, 24 Sep 2022 17:35:20 -0500
From:   Matt Ranostay <mranostay@ti.com>
To:     <bhelgaas@google.com>, <krzk@kernel.org>, <robh+dt@kernel.org>,
        <kishon@ti.com>, <vigneshr@ti.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Matt Ranostay <mranostay@ti.com>
Subject: [PATCH v2 0/2] dt-bindings: PCI: ti,j721e-pci-*: resolve unexpected property warnings
Date:   Sat, 24 Sep 2022 15:35:15 -0700
Message-ID: <20220924223517.123343-1-mranostay@ti.com>
X-Mailer: git-send-email 2.38.0.rc0.52.gdda7228a83
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Resolve unexpected property warnings related to interrupts in both J721E PCI EP and host
yaml files.

Changes from v1:
* Fix typo in commit message
* Add missing Cc to maintainers

Matt Ranostay (2):
  dt-bindings: PCI: ti,j721e-pci-host: add interrupt controller
    definition
  dt-bindings: PCI: ti,j721e-pci-*: Add missing interrupt properties

 .../bindings/pci/ti,j721e-pci-ep.yaml         |  7 +++++++
 .../bindings/pci/ti,j721e-pci-host.yaml       | 20 +++++++++++++++++++
 2 files changed, 27 insertions(+)

-- 
2.38.0.rc0.52.gdda7228a83

