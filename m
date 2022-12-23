Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0DA5654CB4
	for <lists+linux-pci@lfdr.de>; Fri, 23 Dec 2022 08:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiLWHIa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Dec 2022 02:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiLWHI3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Dec 2022 02:08:29 -0500
X-Greylist: delayed 66 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 22 Dec 2022 23:08:28 PST
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2FDFA186F8
        for <linux-pci@vger.kernel.org>; Thu, 22 Dec 2022 23:08:27 -0800 (PST)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 23 Dec 2022 16:07:20 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 397272058B4F;
        Fri, 23 Dec 2022 16:07:20 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 23 Dec 2022 16:07:20 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 9127EA6B7B;
        Fri, 23 Dec 2022 16:07:19 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v4 0/1] dt-bindings: PCI: uniphier: Fix endpoint descriptions
Date:   Fri, 23 Dec 2022 16:07:12 +0900
Message-Id: <20221223070713.20549-1-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series fixes dt-schema descriptions for PCI endpoint controller
implemented in UniPhier SoCs.

Drop the patch in this series,
"dt-bindings: PCI: designware-ep: Increase maxItems of reg and reg-names",
because this was done by the commit 4cc13eedb892
("dt-bindings: PCI: dwc: Add reg/reg-names common properties").

Changes since v3:
- Drop Patch 1
  "dt-bindings: PCI: designware-ep: Increase maxItems of reg and reg-names".

Changes since v2:
- Move some items to minimize if/then schemas in Patch 2
- Remove Patch 3 because the warning comment is for an unmerged source

Changes since v1:
- Fix "config" in the Patch 1 commit message to "addr_space"

Kunihiko Hayashi (1):
  dt-bindings: PCI: uniphier-ep: Clean up reg, clocks, resets, and their
    names using compatible string

 .../pci/socionext,uniphier-pcie-ep.yaml       | 76 ++++++++++++-------
 1 file changed, 49 insertions(+), 27 deletions(-)

-- 
2.25.1

