Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC34F6094EF
	for <lists+linux-pci@lfdr.de>; Sun, 23 Oct 2022 19:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbiJWRCv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Oct 2022 13:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiJWRCu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 23 Oct 2022 13:02:50 -0400
Received: from mxout2.routing.net (mxout2.routing.net [IPv6:2a03:2900:1:a::b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516705597;
        Sun, 23 Oct 2022 10:02:49 -0700 (PDT)
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
        by mxout2.routing.net (Postfix) with ESMTP id 019755FC59;
        Sun, 23 Oct 2022 17:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1666544567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4IpEBqScoz0BOsedKQHVHHygIrrSlTk0S77GHPVXhEM=;
        b=tfNPDBVtY0cD9PSSZK9adXpCOkj4k5bc9hh8vqg+d+FqvW3krOa9R71ECgInxPAQ8y0AMG
        fVDyLBbOCNGac0J3r7tg7uv0JSiykr9nvywBYkSZgwQ3QEkuzPlfYsVQ4Z0pKhI5esipp4
        kCRc+nRhY5la0Qk+++QDt7Evb5pBswM=
Received: from frank-G5.. (fttx-pool-80.245.79.234.bambit.de [80.245.79.234])
        by mxbox2.masterlogin.de (Postfix) with ESMTPSA id D978B100352;
        Sun, 23 Oct 2022 17:02:45 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Sam Shih <Sam.Shih@mediatek.com>,
        Steven Liu <steven.liu@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/3] rework mtk pcie-gen3 bindings and support mt7986
Date:   Sun, 23 Oct 2022 19:02:31 +0200
Message-Id: <20221023170234.83621-1-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 0f466a79-bb1f-4f20-bc41-869e0b319303
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

This Series prepares support for mt7986 PCIe which is basicly gen3 PCIe
but with slightly differnt clock configuration.

To make differences better to read i split the exiting bindings which
has already different settings with a compatible switch and then add a
new one for mt7986.

Frank Wunderlich (3):
  dt-bindings: PCI: mediatek-gen3: add SoC based clock config
  dt-bindings: PCI: mediatek-gen3: add support for mt7986
  dt-bindings: PCI: mediatek-gen3: add mt7986 clock config

 .../bindings/pci/mediatek-pcie-gen3.yaml      | 65 +++++++++++++++----
 1 file changed, 53 insertions(+), 12 deletions(-)

-- 
2.34.1

