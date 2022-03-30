Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556E54EBA1E
	for <lists+linux-pci@lfdr.de>; Wed, 30 Mar 2022 07:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbiC3FZ2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Mar 2022 01:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbiC3FZ1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Mar 2022 01:25:27 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB9AB15B076;
        Tue, 29 Mar 2022 22:23:36 -0700 (PDT)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 30 Mar 2022 14:23:36 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 6DF352058443;
        Wed, 30 Mar 2022 14:23:36 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 30 Mar 2022 14:23:36 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id E6DB4B62B7;
        Wed, 30 Mar 2022 14:23:35 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2 0/2] dt-bindings: PCI: uniphier: Convert bindings and fix devicetree warning issue
Date:   Wed, 30 Mar 2022 14:23:32 +0900
Message-Id: <1648617814-9217-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Convert dt-bindings description for UniPhier PCI controller into a JSON
description, and remove unused compatible from devicetree to fix dtbs_check
warnings after convertion.

Changes since v1:
- Remove a redundant item list of reg-names and add minItems
- Add patch 2 to fix warnings

Kunihiko Hayashi (2):
  dt-bindings: PCI: uniphier: Convert uniphier-pcie.txt to json-schema
  arm64: dts: uniphier: Remove compatible "snps,dw-pcie" from pcie node

 .../bindings/pci/socionext,uniphier-pcie.yaml | 96 +++++++++++++++++++
 .../devicetree/bindings/pci/uniphier-pcie.txt | 82 ----------------
 MAINTAINERS                                   |  2 +-
 .../boot/dts/socionext/uniphier-ld20.dtsi     |  2 +-
 .../boot/dts/socionext/uniphier-pxs3.dtsi     |  2 +-
 5 files changed, 99 insertions(+), 85 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/socionext,uniphier-pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/uniphier-pcie.txt

-- 
2.25.1

