Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67C27CCAE6
	for <lists+linux-pci@lfdr.de>; Tue, 17 Oct 2023 20:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbjJQSmK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Oct 2023 14:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbjJQSmJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Oct 2023 14:42:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0019790;
        Tue, 17 Oct 2023 11:42:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D623CC433C7;
        Tue, 17 Oct 2023 18:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697568127;
        bh=lGFXEWFnum9tD8Qq7965lPiDiK5TjJr0YSfkEVSWvV4=;
        h=From:Date:Subject:To:Cc:From;
        b=E0OMPh1bZEzpKFMSF2r+o5Do6gdJ2zoZV3pv8cqFm9FPDHMy5+6PEb7kknuVvURHY
         iet7AjRkxuZ/2As/yWkKgNljaOLrClxg4dNFjcPRCh74G0dMyG5eiG/5Zq8pvV3MUe
         uMczM3Vmjtq06rYJNwFg6cSKm6wTg+CMOWKDpppMdH8EBBgxgiboUFSBJ0QjxzJNlz
         wRjLxiU6/Q09rkPL0l8N5YPzr/BYwPAAOVgEUZljoKGJkcAig/bAwmO4FPw/fON8h+
         A3Jj69s1IHpuXNGFUOM1802tSnsixRp6UQAq78YIBB9S37D0LkLfKE7kXykpPENVyO
         Ajt8MLBbg7xBA==
From:   Nathan Chancellor <nathan@kernel.org>
Date:   Tue, 17 Oct 2023 11:41:58 -0700
Subject: [PATCH] PCI: rcar-gen4: Fix type of type parameter in
 rcar_gen4_pcie_ep_raise_irq()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231017-pcie-rcar-wifpts-v1-1-ab1f42bf9386@kernel.org>
X-B4-Tracking: v=1; b=H4sIAHXVLmUC/x3MQQ5AMBBA0avIrE3SEiWuIhZMp8yGZipIxN01l
 m/x/wOJVThBXzygfEqSfcuwZQG0TtvCKD4bKlPV1tgWIwmj0qR4SYhHQkeu8cGFjroZchaVg9z
 /chjf9wNTBEnZYgAAAA==
To:     marek.vasut+renesas@gmail.com, yoshihiro.shimoda.uh@renesas.com,
        lpieralisi@kernel.org, kw@linux.com
Cc:     robh@kernel.org, bhelgaas@google.com, ndesaulniers@google.com,
        trix@redhat.com, fancer.lancer@gmail.com, mani@kernel.org,
        linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2708; i=nathan@kernel.org;
 h=from:subject:message-id; bh=lGFXEWFnum9tD8Qq7965lPiDiK5TjJr0YSfkEVSWvV4=;
 b=owGbwMvMwCEmm602sfCA1DTG02pJDKl6V+tMfm849+t5ybYrynFuydfNOJ4pf/9out3wjJB40
 TxhI8nYjlIWBjEOBlkxRZbqx6rHDQ3nnGW8cWoSzBxWJpAhDFycAjCRxJcM/xPLP0veNtjB8pOz
 Js9px7+UVKNoHo//3WvvRew5NvtbvyPD/4hFW/6v7pAJCQqym/o5JWDKoZV/nW7eOFKUl+2lYrH
 /ORsA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

With clang's kernel control flow integrity (kCFI, CONFIG_CFI_CLANG),
indirect call targets are validated against the expected function
pointer prototype to make sure the call target is valid to help mitigate
ROP attacks. If they are not identical, there is a failure at run time,
which manifests as either a kernel panic or thread getting killed. A
warning in clang aims to catch these at compile time, which reveals:

  drivers/pci/controller/dwc/pcie-rcar-gen4.c:403:15: error: incompatible function pointer types initializing 'int (*)(struct dw_pcie_ep *, u8, enum pci_epc_irq_type, u16)' (aka 'int (*)(struct dw_pcie_ep *, unsigned char, enum pci_epc_irq_type, unsigned sort)') with an expression of type 'int (struct dw_pcie_ep *, u8, unsigned int, u16)' (aka 'int (struct dw_pcie_ep *, unsigned char, unsigned int, unsigned short)') [-Werror,-Wincompatible-function-pointer-types-strict]
    403 |         .raise_irq = rcar_gen4_pcie_ep_raise_irq,
        |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
  1 error generated.

'->raise_irq()' in 'struct dw_pcie_ep_ops' expects a type parameter of
type 'enum pci_epc_irq_type', not 'unsigned int'. Adjust the type to
match and use the proper enum values in the switch. The underlying value
of both the enum and the macro is the same, so there is no functional
change while clearing up the warning and avoiding a CFI failure at run
time.

Fixes: 32b83c68d634 ("PCI: rcar-gen4: Add endpoint mode support")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 619262d32f4e..0c0f5c257b14 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -353,14 +353,15 @@ static void rcar_gen4_pcie_ep_deinit(struct dw_pcie_ep *ep)
 }
 
 static int rcar_gen4_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
-				       unsigned int type, u16 interrupt_num)
+				       enum pci_epc_irq_type type,
+				       u16 interrupt_num)
 {
 	struct dw_pcie *dw = to_dw_pcie_from_ep(ep);
 
 	switch (type) {
-	case PCI_IRQ_LEGACY:
+	case PCI_EPC_IRQ_LEGACY:
 		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
-	case PCI_IRQ_MSI:
+	case PCI_EPC_IRQ_MSI:
 		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
 	default:
 		dev_err(dw->dev, "Unknown IRQ type\n");

---
base-commit: de45624e69e14ccd6b4b2886155578bb218925de
change-id: 20231017-pcie-rcar-wifpts-6c65df6f8c8b

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>

