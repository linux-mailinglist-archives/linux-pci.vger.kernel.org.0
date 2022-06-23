Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E0D5570E3
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jun 2022 04:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377647AbiFWCJQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jun 2022 22:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbiFWCJQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jun 2022 22:09:16 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D07D61AF23;
        Wed, 22 Jun 2022 19:09:14 -0700 (PDT)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 23 Jun 2022 11:09:14 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 416CB2058B4F;
        Thu, 23 Jun 2022 11:09:14 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 23 Jun 2022 11:09:14 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id BD520B62E2;
        Thu, 23 Jun 2022 11:09:13 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v4 0/2] dt-bindings: PCI: uniphier: Fix endpoint descriptions
Date:   Thu, 23 Jun 2022 11:09:00 +0900
Message-Id: <1655950142-2026-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Changes since v3:
- Add Reviewed-by: and Acked-by: tags

Changes since v2:
- Move some items to minimize if/then schemas in Patch 2
- Remove Patch 3 because the warning comment is for an unmerged source

Changes since v1:
- Fix "config" in the Patch 1 commit message to "addr_space"

Kunihiko Hayashi (2):
  dt-bindings: PCI: designware-ep: Increase maxItems of reg and
    reg-names
  dt-bindings: PCI: uniphier-ep: Clean up reg, clocks, resets, and their
    names using compatible string

 .../bindings/pci/snps,dw-pcie-ep.yaml         |  4 +-
 .../pci/socionext,uniphier-pcie-ep.yaml       | 76 ++++++++++++-------
 2 files changed, 51 insertions(+), 29 deletions(-)

-- 
2.25.1

