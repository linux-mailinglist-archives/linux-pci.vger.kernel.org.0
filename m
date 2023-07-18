Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57554758631
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jul 2023 22:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjGRUmg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jul 2023 16:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjGRUmf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jul 2023 16:42:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DACEC;
        Tue, 18 Jul 2023 13:42:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B20160DF8;
        Tue, 18 Jul 2023 20:42:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4566CC433C7;
        Tue, 18 Jul 2023 20:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689712953;
        bh=en8EzJKtI23l4/PfyM8svRxM6g+Yw2OFtEPsiEJdaOY=;
        h=From:To:Cc:Subject:Date:From;
        b=T0JMk2He5mTbNMRWXrEHeWiPJnhMdvvdMlIIz5N6KObFe3nkCG6z7b09ZknToPO6a
         SsFUzZUzMxLRM4fnu1T0jImJVHHyUKoTBlmk5MCUNuFZzYsgtllM1/IBlcMDYHWsnM
         kkkKeskO2q1mGR2XZmAEEZTZF7+lNJTCpa5+iD53MMOhqBXC8dAjpXEj9LqqfyZUVI
         dbNu+rPh5EgGgj2GzjdmzSSoz0CShp7t1eM9TzuY81tLnpIGMfb2H+rf5tkjUhI8QP
         Oc6MFzfHMtxZ6zefFKOfwK1iRDVIkTbKMbQaMCropv/UzZ7qLu0O+UOEtTFMI59YWU
         dxGLFGuHwJDDA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] m68k/pci: Drop useless pcibios_setup()
Date:   Tue, 18 Jul 2023 15:42:29 -0500
Message-Id: <20230718204229.493669-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

From: Bjorn Helgaas <bhelgaas@google.com>

The PCI core supplies a weak pcibios_setup() implementation that is
identical to the m68k implementation.  Remove the m68k version since it is
unnecessary.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/m68k/kernel/pcibios.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/m68k/kernel/pcibios.c b/arch/m68k/kernel/pcibios.c
index b0e110d3d2e6..9504eb19d73a 100644
--- a/arch/m68k/kernel/pcibios.c
+++ b/arch/m68k/kernel/pcibios.c
@@ -92,9 +92,3 @@ void pcibios_fixup_bus(struct pci_bus *bus)
 		pci_write_config_byte(dev, PCI_LATENCY_TIMER, 32);
 	}
 }
-
-char *pcibios_setup(char *str)
-{
-	return str;
-}
-
-- 
2.34.1

