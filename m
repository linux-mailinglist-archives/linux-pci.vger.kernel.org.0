Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8838792899
	for <lists+linux-pci@lfdr.de>; Tue,  5 Sep 2023 18:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343600AbjIEQX2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Sep 2023 12:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354454AbjIELsh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Sep 2023 07:48:37 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DD11AB;
        Tue,  5 Sep 2023 04:48:32 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 385BmIT4103678;
        Tue, 5 Sep 2023 06:48:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1693914498;
        bh=N68uoMAZt0elBiNOOgFrjYy/Ldpq4gljwxTQ2TN4rt8=;
        h=From:To:CC:Subject:Date;
        b=SbK+EgulnA0we6oIIjWOkmrxtDCSCJpkAZ/EbcP/3ORQQRO3y5OCHosqIzQOjeZDU
         492GjUx+W1BQZqUlNBLxiyz6lkQvTsXH+NtRW1JYb5WrATqAkVgKI21kVGC6HyMzRi
         1hTk8Btac87kOMoXeHqjgQSGRa8kpihxDhX7wyZI=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 385BmISv005244
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Sep 2023 06:48:18 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 5
 Sep 2023 06:48:17 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 5 Sep 2023 06:48:17 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 385BmHHW075458;
        Tue, 5 Sep 2023 06:48:17 -0500
From:   Achal Verma <a-verma1@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczy_ski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Achal Verma <a-verma1@ti.com>
Subject: [RFC PATCH 0/2] Enable PCIe1 on J7AHP
Date:   Tue, 5 Sep 2023 17:18:14 +0530
Message-ID: <20230905114816.2993628-1-a-verma1@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIe1 instance on J7AHP EVM EP connector has reference clock connection
from serdes unlike PCIe0 for which reference clock connection is from
on-board clock generator. To enable PCIe1 instance, ACSPCIE clock buffer
pads have to be enabled to get reference clock output available to PCIe1 EP

This enables clock source select and ACSPCIE clock buffer pads.

Achal Verma (2):
  dt-bindings: PCI: ti,j721e-pci-*: Add "ti,syscon-pcie-refclk-out"
    property
  pci: j721e: Enable reference clock output from serdes

 .../bindings/pci/ti,j721e-pci-host.yaml       | 53 ++++++++++
 .../pci/controller/cadence/pci-j721e-host.c   | 96 +++++++++++++++++++
 2 files changed, 149 insertions(+)

-- 
2.25.1

