Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED8973E30E
	for <lists+linux-pci@lfdr.de>; Mon, 26 Jun 2023 17:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjFZPTQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Jun 2023 11:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjFZPTN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Jun 2023 11:19:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5365010CC
        for <linux-pci@vger.kernel.org>; Mon, 26 Jun 2023 08:19:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6721760EC3
        for <linux-pci@vger.kernel.org>; Mon, 26 Jun 2023 15:19:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13260C433C8;
        Mon, 26 Jun 2023 15:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687792749;
        bh=BKUM4J3ZY8mGqA+pyg6yhHdDh1WtlwJDH1EQYQe1YA4=;
        h=From:To:Cc:Subject:Date:From;
        b=Pg8Tz27LzqYyS3IjW0z5ES1ffydXR90Mrb5ZAalRT1+a2u+UcZF3LUKl2MP2zaZXM
         jRtGyNdaydLMZd+qL5UPw2RHyRa8D+GXkUqTzwoCuAeF3GiSkyIbIo+1f+HpVWYvdY
         ebN6J/vcdEQ9pRtUysQlpADa/vnJTEbY4C150odJbYXWrOOnD/ASh/U4D79S/ia5wL
         DgsTHea0w7+PV/pHlE9mM6g/j6t4iIUlCwus6MTWk4Y+J+DgPvLXN8DZvpMlBnEeX+
         /Xlgcy8WcSQzDR+TxSNn65b4YFq43nrwdRiXAgOQR7Pt4wR7gH3I1XVtSTeALPXuZj
         OweBKQj9vlqNQ==
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add Manivannan Sadhasivam as DesignWare PCIe driver maintainer
Date:   Mon, 26 Jun 2023 15:19:07 +0000
Message-ID: <20230626151907.495702-1-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Manivannan has been actively reviewing patches and testing changes
related to the DesignWare core driver and other DWC-based PCIe drivers
for a while now.

Thus, let's add Manivannan as a maintainer for the Synopsys DesignWare
driver to make his role and contributions official.

Thank you Manivannan! For all the help with DWC!

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7e0b87d5aa2e..61a64744e31b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16167,6 +16167,7 @@ F:	drivers/pci/controller/dwc/pci-exynos.c
 PCI DRIVER FOR SYNOPSYS DESIGNWARE
 M:	Jingoo Han <jingoohan1@gmail.com>
 M:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
+M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
-- 
2.41.0

