Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25226F6A12
	for <lists+linux-pci@lfdr.de>; Thu,  4 May 2023 13:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjEDLfT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 May 2023 07:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEDLfS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 May 2023 07:35:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B12448F;
        Thu,  4 May 2023 04:35:17 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A117F66031D7;
        Thu,  4 May 2023 12:35:15 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683200116;
        bh=1NMvcGiXphJ8FhyetkrltYkSY2U0NjU1T6zPshhG/DI=;
        h=From:To:Cc:Subject:Date:From;
        b=Cyu4RsQ5vbnTn1GOCVrF9dpVrpJ2iP4P5L2sHjYetT6uTK9OohIFOkKk+5TaAmTSw
         WKYfxpcLiZBqlOcuHG59K4ltBDH3yR/QrzROBvAyqIHOIYpZ5hDwbrBYjuBEWeioSx
         yAHlYQdbIuxFMBX/yt/HeaMWPfoYUOx94OEb24SVWCk26MhHnswfqzLeD6pVROYac8
         65zOPsnSK1g6ZNo7YWEaUpXvfJ5VLvI+JdOkgg1fu+6YP6Pshss1/Z70R3MQX+TrBr
         7p5GsAkgwckBnC51XzIRGXxA38Z2iZw7X/EKq0xM2XhSG3ubc5UDtGJ68q4t2QP9Zb
         tsQPqnPBY8VeA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     ryder.lee@mediatek.com
Cc:     jianjun.wang@mediatek.com, lpieralisi@kernel.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, p.zabel@pengutronix.de,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/2] MediaTek PCIe Gen3: Suspend fixes
Date:   Thu,  4 May 2023 13:35:07 +0200
Message-Id: <20230504113509.184633-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series fixes PM suspend/resume for MediaTek PCIe Gen3, seen on
the MT8195 Tomato Chromebook, which would deadlock at resume.

Tested on a MT8195 Tomato Chromebook.

AngeloGioacchino Del Regno (2):
  PCI: mediatek-gen3: Stop acquiring spinlocks in {suspend,resume}_noirq
  PCI: mediatek-gen3: Assert MAC reset only if PHY reset also present

 drivers/pci/controller/pcie-mediatek-gen3.c | 33 +++++++++++----------
 1 file changed, 17 insertions(+), 16 deletions(-)

-- 
2.40.1

