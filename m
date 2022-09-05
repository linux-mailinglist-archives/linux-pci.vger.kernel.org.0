Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1FB75AD986
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 21:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbiIETZT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 15:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiIETZR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 15:25:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818E51D315;
        Mon,  5 Sep 2022 12:25:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D7B26106D;
        Mon,  5 Sep 2022 19:25:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC51C43141;
        Mon,  5 Sep 2022 19:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662405915;
        bh=J12A2PV0eS7uwJxlm8tx2YP5rzJkWJMh3zeWWeeD28Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vHN32U7bYxKKnGx53sqeQBaqN8SpGNibaA8IBaIv28M5sbdeg4/gjnaCaVwWoh4cI
         P/2WVU8QBfDYRIVxy/H2byFX9EtMakaSN53v0Atcx4zTVP6vEX8lJqy4QsUqXGsFT5
         hekgXwzyoB47pqYpcMBMQLTgjvkx7oGVJohphFgOVV9dkc4U0NiXVDLJakIxuie+l/
         OIsPXK7YPm7BAieB0nHP+yaACWcjNQGD8t6I7voVJozWyi5OoRAeLGYG7NiiV6l8WO
         pP/bL+03R39kffVs9z7RvD4wqKSNZ4Z6kCqria4jgwEKJdTgPPUV9XevgQwRO/AcFC
         u3JHPovUrSTSQ==
Received: by pali.im (Postfix)
        id 165C77D7; Mon,  5 Sep 2022 21:25:15 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Mauri Sandberg <maukka@ext.kapsi.fi>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 4/7] PCI: mvebu: Remove unused busn member
Date:   Mon,  5 Sep 2022 21:23:07 +0200
Message-Id: <20220905192310.22786-5-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220905192310.22786-1-pali@kernel.org>
References: <20220718202843.6766-1-maukka@ext.kapsi.fi>
 <20220905192310.22786-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Signed-off-by: Pali Rohár <pali@kernel.org>
---
Changes in v3:
* New patch
---
 drivers/pci/controller/pci-mvebu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 6ef8c1ee4cbb..d9e46bd7a4ec 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -96,7 +96,6 @@ struct mvebu_pcie {
 	struct resource io;
 	struct resource realio;
 	struct resource mem;
-	struct resource busn;
 	int nports;
 };
 
-- 
2.20.1

