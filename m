Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F7D60C643
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 10:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbiJYIUE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 04:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbiJYITw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 04:19:52 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB9E186CF
        for <linux-pci@vger.kernel.org>; Tue, 25 Oct 2022 01:19:33 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29P8JOPj109079;
        Tue, 25 Oct 2022 03:19:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666685964;
        bh=Lo8LG8uU7d9jDxCZ1OnsR0Fud9O1Wp11S4jYZdQwtgw=;
        h=From:To:CC:Subject:Date;
        b=sBKu3uy2MiFbYwFi0k5R9FLbZTBJ6eDJOPxiyKlrTd7YaLaxIA1KYqVDsDxQCbo1u
         s54iwEtwfBEro/kTlDY8DOeN1fBpNSHvUavpck9+xLWirIWJPvPSltWxbrx78iZXH5
         2+p42+U3dmjPveP3/N/76eQlQjHtGhvgOp0ysbtE=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29P8JOO2016610
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Oct 2022 03:19:24 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 25
 Oct 2022 03:19:23 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 25 Oct 2022 03:19:23 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29P8JJfl025443;
        Tue, 25 Oct 2022 03:19:21 -0500
From:   Matt Ranostay <mranostay@ti.com>
To:     <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Matt Ranostay <mranostay@ti.com>
Subject: [PATCH RESEND v2 0/2] dt-bindings: PCI: ti,j721e-pci-*: resolve unexpected property warnings
Date:   Tue, 25 Oct 2022 01:19:07 -0700
Message-ID: <20221025081909.404107-1-mranostay@ti.com>
X-Mailer: git-send-email 2.38.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
2.38.GIT

