Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED3F6B37FE
	for <lists+linux-pci@lfdr.de>; Fri, 10 Mar 2023 09:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjCJIFr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Mar 2023 03:05:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjCJIFp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Mar 2023 03:05:45 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB69B1B38;
        Fri, 10 Mar 2023 00:05:44 -0800 (PST)
Received: from cryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net [82.11.51.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: tanureal)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E55AB6603064;
        Fri, 10 Mar 2023 08:05:42 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678435543;
        bh=aXDW9FM3v6N1gp/G6svdu0Iv9rfB/0Z8Inu2S3xCf4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fh+3hbrZX63tbEgCu8QMhiNdvHIvJ5tdpSdE3dTMSQQ1IHv3G/OkOYp587KeXjw0H
         Wte5VVGJez2NsEGK//ZaFmtSdyvqpRqlNGd7BxI2OxdywTkzTBcj2qWXu9Zc8hBS1t
         FyczdNcZcgqYA4btHApUzWydm858U28q8YtAtjFDOVpP+MyWBBJRQ2i0NqHit/qcBX
         VSzsvPi0sDRbrE9J3wtfLgV23V7UUqmjgl/pv5JkKll+vXESPsWGCTLuVCjr9ieAfb
         VC2gm6t8YHh6OfxNeo0Ldu2Q55JyQ43MM23j7Cjmc0ZF8JdZLn183AXvtbY8sI+t2/
         /QBgzL9dAMtFg==
From:   Lucas Tanure <lucas.tanure@collabora.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Qu Wenruo <wqu@suse.com>,
        Piotr Oniszczuk <piotr.oniszczuk@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Lucas Tanure <lucas.tanure@collabora.com>, kernel@collabora.com
Subject: [PATCH 2/7] PCI: rockchip-dwc: Add rk3588 compatible line
Date:   Fri, 10 Mar 2023 08:05:13 +0000
Message-Id: <20230310080518.78054-3-lucas.tanure@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230310080518.78054-1-lucas.tanure@collabora.com>
References: <20230310080518.78054-1-lucas.tanure@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RK3588 can use the same PCIe driver as rk3568

Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index c1e7653e508e..435b717e5bc6 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -354,6 +354,7 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 
 static const struct of_device_id rockchip_pcie_of_match[] = {
 	{ .compatible = "rockchip,rk3568-pcie", },
+	{ .compatible = "rockchip,rk3588-pcie", },
 	{},
 };
 
-- 
2.39.2

