Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1095EDA05
	for <lists+linux-pci@lfdr.de>; Wed, 28 Sep 2022 12:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiI1KYp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Sep 2022 06:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbiI1KYo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Sep 2022 06:24:44 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FA513F49;
        Wed, 28 Sep 2022 03:24:41 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 28SAOaGO099816;
        Wed, 28 Sep 2022 05:24:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1664360676;
        bh=ck6rNhKL1X9AY2+RHr/dMv1FGjWx989F3Vfr8HMWRb8=;
        h=From:To:CC:Subject:Date;
        b=ULm62cHHQnQdKyDreMU0Eh53UD3MskCCrB5M9CDEjl10xHZ9V/h8oysJh7SI/R9Vj
         kO0VkEqxS0hDk4aSf+EawRHnExE+iGmtjIn9n/6apPy/or99vTncPcrt4PZPlxH5Zt
         aURFsk9QMsE0a3s4+2VWbMlvNKJIpuE+RNagtKWI=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 28SAOa67090316
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Sep 2022 05:24:36 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Wed, 28
 Sep 2022 05:24:35 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Wed, 28 Sep 2022 05:24:35 -0500
Received: from a0393678ub.dal.design.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 28SAOWaC095050;
        Wed, 28 Sep 2022 05:24:33 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH] MAINTAINERS: Update Kishon's email address in PCI endpoint subsystem
Date:   Wed, 28 Sep 2022 15:54:31 +0530
Message-ID: <20220928102431.658-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Update Kishon's email address in PCI endpoint subsystem maintainer
entry and mark him as reviewer.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ffad3f1dfe9c..9dc9a4aa2301 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15684,9 +15684,9 @@ F:	Documentation/devicetree/bindings/pci/v3-v360epc-pci.txt
 F:	drivers/pci/controller/pci-v3-semi.c
 
 PCI ENDPOINT SUBSYSTEM
-M:	Kishon Vijay Abraham I <kishon@ti.com>
 M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
 R:	Krzysztof Wilczyński <kw@linux.com>
+R:	Kishon Vijay Abraham I <kishon@kernel.org>
 L:	linux-pci@vger.kernel.org
 S:	Supported
 Q:	https://patchwork.kernel.org/project/linux-pci/list/
-- 
2.17.1

