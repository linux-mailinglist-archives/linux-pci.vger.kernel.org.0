Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B507577A2B5
	for <lists+linux-pci@lfdr.de>; Sat, 12 Aug 2023 22:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjHLUpO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 12 Aug 2023 16:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjHLUpN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 12 Aug 2023 16:45:13 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AE9171F;
        Sat, 12 Aug 2023 13:45:16 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37CKiwF4020192;
        Sat, 12 Aug 2023 15:44:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691873098;
        bh=mmTcvOmzvh1G2Zt3WeekOlPqyTFdfYlojqbxNI4oq5U=;
        h=From:To:CC:Subject:Date;
        b=CzlDSXwgexJz7dMJeUorj33WNDFdUZpajxLO/v+AifXaX1lN85lwj4NTnIoR+oSXb
         no2LcnwC+3jL67J4LLb/X9lj6TZG2TrFDHwmjFMYFnq7XicnfCffRX5V7QbZcf5hJl
         feHy9/jSL+BfxoW7sfa96O78FyA1ntLIDWvxzWDA=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37CKiwLa030536
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 12 Aug 2023 15:44:58 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 12
 Aug 2023 15:44:57 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 12 Aug 2023 15:44:56 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37CKiupT081100;
        Sat, 12 Aug 2023 15:44:56 -0500
From:   Achal Verma <a-verma1@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczy_ski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Achal Verma <a-verma1@ti.com>
Subject: [PATCH 0/2] Advertise ARI related capabilities.
Date:   Sun, 13 Aug 2023 02:14:53 +0530
Message-ID: <20230812204455.479510-1-a-verma1@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series addresses the limitation and flaw which are occurring due to
ARI capability related bits not set correctly.

First patch addresses the issue of PCI_EXP_DEVCAP2_ARI being not set even
when J7 PCIe controller in RC mode supports ARI Forwarding.

Second patch related to the issue when PCIe controller is put in end point
mode, Next function field in ARI capability for last function stores
current_function+1 value, which is supposed to be zero to signal that
current function is the last one.


Achal Verma (1):
  PCI: cadence: Advertise ARI Forwarding Supported

Jasko-EXT Wojciech (1):
  PCI: cadence: Clear the ARI Capability Next Function Number of the
    last function

 drivers/pci/controller/cadence/pci-j721e.c     |  4 ++++
 .../pci/controller/cadence/pcie-cadence-ep.c   | 14 +++++++++++++-
 .../pci/controller/cadence/pcie-cadence-host.c |  7 +++++++
 drivers/pci/controller/cadence/pcie-cadence.h  | 18 ++++++++++++++++++
 4 files changed, 42 insertions(+), 1 deletion(-)

-- 
2.25.1

