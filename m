Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE514F7186
	for <lists+linux-pci@lfdr.de>; Thu,  7 Apr 2022 03:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236139AbiDGBdt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Apr 2022 21:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240671AbiDGBaM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Apr 2022 21:30:12 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E9C2E18A7A6;
        Wed,  6 Apr 2022 18:22:46 -0700 (PDT)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 07 Apr 2022 10:22:46 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 262652058B50;
        Thu,  7 Apr 2022 10:22:46 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 7 Apr 2022 10:22:46 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id A10E7B62B7;
        Thu,  7 Apr 2022 10:22:45 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2 0/3] dt-bindings: PCI: uniphier: Fix endpoint descriptions
Date:   Thu,  7 Apr 2022 10:22:30 +0900
Message-Id: <1649294553-17310-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series fixes dt-schema descriptions for PCI endpoint controller
implemented in UniPhier SoCs.

Changes since v1:
- Fix "config" in the Patch 1 commit message to "addr_space"

Kunihiko Hayashi (3):
  dt-bindings: PCI: designware-ep: Increase maxItems of reg and
    reg-names
  dt-bindings: PCI: uniphier-ep: Clean up reg, clocks, resets, and their
    names using compatible string
  ARM: dts: uniphier: Remove compatible "snps,dw-pcie-ep" from Pro5
    pcie-ep node

 .../bindings/pci/snps,dw-pcie-ep.yaml         |  4 +-
 .../pci/socionext,uniphier-pcie-ep.yaml       | 84 ++++++++++++-------
 arch/arm/boot/dts/uniphier-pro5.dtsi          |  3 +-
 3 files changed, 59 insertions(+), 32 deletions(-)

-- 
2.25.1

