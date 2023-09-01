Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B919978FE2A
	for <lists+linux-pci@lfdr.de>; Fri,  1 Sep 2023 15:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349709AbjIANRa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Sep 2023 09:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjIANR3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Sep 2023 09:17:29 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9272110E0;
        Fri,  1 Sep 2023 06:17:26 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,219,1688396400"; 
   d="scan'208";a="174734870"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 01 Sep 2023 22:17:25 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id C37CC420FDB4;
        Fri,  1 Sep 2023 22:17:25 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mani@kernel.org
Cc:     marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 0/3] dt-bindings: PCI: Revise dwc and rcar-gen4-pcie
Date:   Fri,  1 Sep 2023 22:17:08 +0900
Message-Id: <20230901131711.2861283-1-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch series is based on pci.git / controller/rcar branch
to fix dt-bindings doc patches. Krzysztof mentioned that the paches
will be squashed everything later [1].

[1]
https://lore.kernel.org/linux-pci/20230831140426.GA255922@rocinante/

Yoshihiro Shimoda (3):
  dt-bindings: PCI: dwc: Update maxItems of reg and reg-names take 2
  dt-bindings: PCI: rcar-gen4-pcie: Fix minor issues
  dt-bindings: PCI: rcar-gen4-pcie-ep: Fix minor issues

 .../bindings/pci/rcar-gen4-pci-ep.yaml        | 39 ++++++++++++-------
 .../bindings/pci/rcar-gen4-pci-host.yaml      | 36 +++++++++--------
 .../bindings/pci/snps,dw-pcie-common.yaml     |  4 +-
 .../bindings/pci/snps,dw-pcie-ep.yaml         |  4 +-
 .../devicetree/bindings/pci/snps,dw-pcie.yaml |  4 +-
 5 files changed, 50 insertions(+), 37 deletions(-)

-- 
2.25.1

