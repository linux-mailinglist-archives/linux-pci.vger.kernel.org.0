Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C85F5685E8
	for <lists+linux-pci@lfdr.de>; Wed,  6 Jul 2022 12:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbiGFKnZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Jul 2022 06:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiGFKnY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Jul 2022 06:43:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47F92E8;
        Wed,  6 Jul 2022 03:43:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6642C61E50;
        Wed,  6 Jul 2022 10:43:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DD6C341CE;
        Wed,  6 Jul 2022 10:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657104201;
        bh=00N7ksHtwGEamPjFF10EZROWjybycuFTsa4YgD+Po3E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K7qadzCUEt12Hkk2NuyJRLOe4+/ShN/ZMVSgZBzllDWUxecQFHIEmwvDbtyMrshy5
         9aX4FVnp5P0EPDlYA8GBB5IuSDPkWEl4lKC9cunRh8JV2eQrMCSLtH4Yigo/+ocAUg
         LAncEnYzO34XybOZppHLjVhwp93D8X8cHNIEDzd6ELPTFZDyPt1tCXe6GJvlV+pl2h
         ytY4G2SlsBvMGDvWbvJo4qqu62Fkq5XaZ/vE8fve4V6FLrmY8SNqTeW6qnBunC/VJo
         Nq4cPDVDNl+mfvKFW7mx5B9vmwH1cLCgvlHdmP0Kjo0Qvqr5hXBbabFdrB+UYiPW1E
         i2qbBNJZrEkJA==
Received: by pali.im (Postfix)
        id 34131821; Wed,  6 Jul 2022 12:43:19 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Nick Child <nick.child@ibm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] powerpc/pci: Make pcibios_make_OF_bus_map() static
Date:   Wed,  6 Jul 2022 12:43:05 +0200
Message-Id: <20220706104308.5390-3-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220706104308.5390-1-pali@kernel.org>
References: <20220706104308.5390-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Function pcibios_make_OF_bus_map() is used only in pci_32.c file.
So make it static and do not export out of pci_32.o unit.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/powerpc/kernel/pci_32.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index c3b91fb62a71..df981294df29 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -36,8 +36,6 @@ int pcibios_assign_bus_offset = 1;
 EXPORT_SYMBOL(isa_io_base);
 EXPORT_SYMBOL(pci_dram_offset);
 
-void __init pcibios_make_OF_bus_map(void);
-
 static void fixup_cpc710_pci64(struct pci_dev* dev);
 static u8* pci_to_OF_bus_map;
 
@@ -108,7 +106,7 @@ make_one_node_map(struct device_node* node, u8 pci_bus)
 	}
 }
 	
-void __init
+static void __init
 pcibios_make_OF_bus_map(void)
 {
 	int i;
-- 
2.20.1

