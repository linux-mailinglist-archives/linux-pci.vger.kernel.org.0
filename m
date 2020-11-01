Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDE42A222D
	for <lists+linux-pci@lfdr.de>; Sun,  1 Nov 2020 23:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbgKAW1V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 1 Nov 2020 17:27:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbgKAW1V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 1 Nov 2020 17:27:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D38C0617A6;
        Sun,  1 Nov 2020 14:27:21 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604269638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ptxTsFp2L6efDZ+NSsWwAuqOWnuRT3+qbc/ppVuKKyc=;
        b=zrhVLZVBFb+q3hwt5X/nvPFMdsf4VVl0ZxIm6E9eDxZYf3tEfrB4GMorHj70CBSscXfA5q
        7tO17wbxtYzyEztnPNpp6pQuRYCAeWfhc7Il6oGoD1aiHBTVutRnmhuHxyiWTlq68VnE58
        w27URJOE8zqC0GDeT+YmTP5UZSmKvsdovTCAcCrGw2yE4gMtVEv+1ZBI/nIQsjtImf17A9
        Z8Ov/wMPndW4hznqwyyx8pNQ/R/xQ/YDb/BcA+2d6aeBZoGbhd5JGWBYCzq/dgNYGItFzD
        kCo8gVDp9I4LV4+AEt6/OCNhbW9bTtWPNdhpo7NJShn3Hlhb+E+zrRbzN8RcLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604269638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ptxTsFp2L6efDZ+NSsWwAuqOWnuRT3+qbc/ppVuKKyc=;
        b=91YBEhR4RkDtGn4ekE0bM4GfC1r7cgSSnIrSGBCPZonjdRxEx8D8WPiVKEkZJtgtNmQJ3J
        9Lpp8U5BuAPEbmAw==
To:     Marc Zyngier <maz@kernel.org>,
        Frank Wunderlich <frank-w@public-files.de>
Cc:     Ryder Lee <ryder.lee@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Frank Wunderlich <linux@fw-web.de>,
        linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: Aw: Re: [PATCH] pci: mediatek: fix warning in msi.h
In-Reply-To: <87k0v4u4uq.wl-maz@kernel.org>
References: <20201031140330.83768-1-linux@fw-web.de> <878sbm9icl.fsf@nanos.tec.linutronix.de> <EC02022C-64CF-4F4B-A0A2-215A0A49E826@public-files.de> <87lfflti8q.wl-maz@kernel.org> <1604253261.22363.0.camel@mtkswgap22> <trinity-9eb2a213-f877-4af3-87df-f76a9c093073-1604255233122@3c-app-gmx-bap08> <87k0v4u4uq.wl-maz@kernel.org>
Date:   Sun, 01 Nov 2020 23:27:17 +0100
Message-ID: <87pn4w90hm.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Nov 01 2020 at 21:47, Marc Zyngier wrote:
> On Sun, 01 Nov 2020 18:27:13 +0000,
> Frank Wunderlich <frank-w@public-files.de> wrote:
> Thinking of it a bit more, I think this is the wrong solution.
>
> PCI MSIs are optional, and not a requirement. I can trivially spin a
> VM with PCI devices and yet no MSI capability (yes, it is more
> difficult with real HW), and this results in a bunch of warning, none
> of which are actually indicative of anything being wrong.

Well. No. 

The problem is that the device enumerates MSI capability, but the host
bridge is not proving support for MSI. 

The host bridge fails to mark the bus with PCI_BUS_FLAGS_NO_MSI. That's
the reason why this runs into this issue.

Something like the uncompiled hack below. I haven't found a way to hand
that down to the probe function.

Thanks,

        tglx
---
diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index cf4c18f0c25a..d91bdfea7329 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -143,6 +143,7 @@ struct mtk_pcie_port;
  * struct mtk_pcie_soc - differentiate between host generations
  * @need_fix_class_id: whether this host's class ID needed to be fixed or not
  * @need_fix_device_id: whether this host's device ID needed to be fixed or not
+ * @no_msi: Bridge has no MSI support
  * @device_id: device ID which this host need to be fixed
  * @ops: pointer to configuration access functions
  * @startup: pointer to controller setting functions
@@ -151,6 +152,7 @@ struct mtk_pcie_port;
 struct mtk_pcie_soc {
 	bool need_fix_class_id;
 	bool need_fix_device_id;
+	bool no_msi;
 	unsigned int device_id;
 	struct pci_ops *ops;
 	int (*startup)(struct mtk_pcie_port *port);
@@ -1089,6 +1091,9 @@ static int mtk_pcie_probe(struct platform_device *pdev)
 	if (err)
 		goto put_resources;
 
+	if (!pcie->soc->no_msi)
+		host->bus->bus_flags |= PCI_BUS_FLAGS_NO_MSI;
+
 	return 0;
 
 put_resources:
@@ -1173,6 +1178,7 @@ static const struct dev_pm_ops mtk_pcie_pm_ops = {
 };
 
 static const struct mtk_pcie_soc mtk_pcie_soc_v1 = {
+	.no_msi = true,
 	.ops = &mtk_pcie_ops,
 	.startup = mtk_pcie_startup_port,
 };



