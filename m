Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15985291678
	for <lists+linux-pci@lfdr.de>; Sun, 18 Oct 2020 10:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgJRImR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 18 Oct 2020 04:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgJRImR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 18 Oct 2020 04:42:17 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B67DC0613CE
        for <linux-pci@vger.kernel.org>; Sun, 18 Oct 2020 01:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2kEJ0J4WBMFkQkm34v9mJqN6+2JSTlpQpRr9UNGAsp0=; b=EEvHgWjyd/ByUtH7K6Wgy2DFlJ
        A+/7HenPWRgKLyqOe2MNPxUVfIbDFK2sUO5xaJnh71tQOy3eYjCjXZu8PDanbEooeD12U6S9QTGTU
        H9g8gygww3Oj66GbcNO0H4fPtAJE7qx0IzhKeEfUMUD78wnVJrnbnDjx8zMlNQ1axjmt7KFqDsCMm
        ZpgqNdwZxrjFsjts6I4Yu+gpiSXQJUBcOENK61ktwJ3PVAfLPIBuKptHMrDAqEnQ9NaiCTuxAHc6z
        hCN0ki8u4gf/3fBlXNmKbeVKuoLpEeH3I1VyYqmIFOgOrC5HSUjTRwH3UVLjJBTSdJrc74us2q1nm
        0cImeBLg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:34818 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1kU4GY-00047i-5d; Sun, 18 Oct 2020 09:42:10 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1kU4GX-0006lL-U0; Sun, 18 Oct 2020 09:42:10 +0100
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: footbridge: fix dc21285 PCI configuration accessors
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1kU4GX-0006lL-U0@rmk-PC.armlinux.org.uk>
Sender: "Russell King,,," <rmk@armlinux.org.uk>
Date:   Sun, 18 Oct 2020 09:42:09 +0100
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Building with gcc 4.9.2 reveals a latent bug in the PCI accessors
for Footbridge platforms, which causes a fatal alignment fault
while accessing IO memory. Fix this by making the assembly volatile.

Cc: stable@vger.kernel.org
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-footbridge/dc21285.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-footbridge/dc21285.c b/arch/arm/mach-footbridge/dc21285.c
index 416462e3f5d6..f9713dc561cf 100644
--- a/arch/arm/mach-footbridge/dc21285.c
+++ b/arch/arm/mach-footbridge/dc21285.c
@@ -65,15 +65,15 @@ dc21285_read_config(struct pci_bus *bus, unsigned int devfn, int where,
 	if (addr)
 		switch (size) {
 		case 1:
-			asm("ldrb	%0, [%1, %2]"
+			asm volatile("ldrb	%0, [%1, %2]"
 				: "=r" (v) : "r" (addr), "r" (where) : "cc");
 			break;
 		case 2:
-			asm("ldrh	%0, [%1, %2]"
+			asm volatile("ldrh	%0, [%1, %2]"
 				: "=r" (v) : "r" (addr), "r" (where) : "cc");
 			break;
 		case 4:
-			asm("ldr	%0, [%1, %2]"
+			asm volatile("ldr	%0, [%1, %2]"
 				: "=r" (v) : "r" (addr), "r" (where) : "cc");
 			break;
 		}
@@ -99,17 +99,17 @@ dc21285_write_config(struct pci_bus *bus, unsigned int devfn, int where,
 	if (addr)
 		switch (size) {
 		case 1:
-			asm("strb	%0, [%1, %2]"
+			asm volatile("strb	%0, [%1, %2]"
 				: : "r" (value), "r" (addr), "r" (where)
 				: "cc");
 			break;
 		case 2:
-			asm("strh	%0, [%1, %2]"
+			asm volatile("strh	%0, [%1, %2]"
 				: : "r" (value), "r" (addr), "r" (where)
 				: "cc");
 			break;
 		case 4:
-			asm("str	%0, [%1, %2]"
+			asm volatile("str	%0, [%1, %2]"
 				: : "r" (value), "r" (addr), "r" (where)
 				: "cc");
 			break;
-- 
2.20.1

