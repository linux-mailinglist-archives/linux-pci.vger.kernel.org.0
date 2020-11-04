Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 467302A7107
	for <lists+linux-pci@lfdr.de>; Thu,  5 Nov 2020 00:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732566AbgKDXOa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Nov 2020 18:14:30 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52522 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732553AbgKDXOZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Nov 2020 18:14:25 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604531661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S1uT/ory2tJYYKprq7tpAtg+6JYjWTDzAvdKLuSxFsE=;
        b=zxQWjZ8/AB2Lwf78tMX7LeYKasG61OYcb90cptjPXIebDsJSwRhcNkMrSTvCJZ1yGDbEyR
        NXEA+Vo57Iybw8eFxlOuM68KL7Mi0R/iV8SC3tl2QcbA2cBdwTwHuTmLnaLY46yIjK0jcH
        WaJZ2/ttNxTf6dWOU4hw1IngCDCEAkqQpPqpP2a+7GQo7YMxgEDijLuI1udRtf9YcEv8JO
        0NfuyhdFKs83wvb7TEl8omLUTe51wXqvi9Qihu6s8PkMBSwCejhj1c12Z6bu1RuWADWH29
        15zj/t5AAwE3kJaF4wJ1SZWXdESIff94YI3z7nMPCgOHNZDBM5bKymokk/CZmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604531661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S1uT/ory2tJYYKprq7tpAtg+6JYjWTDzAvdKLuSxFsE=;
        b=dOfXSMPz5OxVxeZ5HDfZvfWqs8tGpBO9c7pDG6DteaqHiILOmLTr2FhW29AGAczpj5iDdb
        PrIdVoFXFH/Z+1AQ==
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Marc Zyngier <maz@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Frank Wunderlich <linux@fw-web.de>,
        linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: Aw: Re:  Re: [PATCH] pci: mediatek: fix warning in msi.h
In-Reply-To: <trinity-1d7f8900-10db-40c0-a0aa-47bb99ed84cd-1604508571909@3c-app-gmx-bs02>
References: <20201031140330.83768-1-linux@fw-web.de> <878sbm9icl.fsf@nanos.tec.linutronix.de> <EC02022C-64CF-4F4B-A0A2-215A0A49E826@public-files.de> <87lfflti8q.wl-maz@kernel.org> <1604253261.22363.0.camel@mtkswgap22> <trinity-9eb2a213-f877-4af3-87df-f76a9c093073-1604255233122@3c-app-gmx-bap08> <87k0v4u4uq.wl-maz@kernel.org> <87pn4w90hm.fsf@nanos.tec.linutronix.de> <df5565a2f1e821041c7c531ad52a3344@kernel.org> <87h7q791j8.fsf@nanos.tec.linutronix.de> <877dr38kt8.fsf@nanos.tec.linutronix.de> <901c5eb8bbaa3fe53ddc8f65917e48ef@kernel.org> <87o8ke7njb.fsf@nanos.tec.linutronix.de> <trinity-1d7f8900-10db-40c0-a0aa-47bb99ed84cd-1604508571909@3c-app-gmx-bs02>
Date:   Thu, 05 Nov 2020 00:14:20 +0100
Message-ID: <87h7q4lnoz.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Frank,

On Wed, Nov 04 2020 at 17:49, Frank Wunderlich wrote:
>> Von: "Thomas Gleixner" <tglx@linutronix.de>
>> Any architecture which selects PCI_MSI_ARCH_FALLBACKS and does not have
>> irqdomain support runs into:
>>
>> 	if (!d)
>> 		bus->bus_flags |= PCI_BUS_FLAGS_NO_MSI;
>>
>> which in turn makes pci_msi_supported() return 0 and consequently makes
>> pci_enable_msi[x]() fail.
>
> i'm not that deep into this, but just my thoughts...you are the experts :)
>
> checking for PCI_MSI_ARCH_FALLBACKS here does not help?
>
> something like this:
>
> #ifndef PCI_MSI_ARCH_FALLBACKS
> 	if (!d)
> 		bus->bus_flags |= PCI_BUS_FLAGS_NO_MSI;
> #endif

TBH, that's butt ugly. So after staring long enough into the PCI code I
came up with a way to transport that information to the probe code.

That allows a particular device to say 'I can't do MSI' and at the same
time keeps the warning machinery intact which tells us that a particular
host controller driver is broken.

Uncompiled and untested as usual :)

Thanks,

        tglx
---
 drivers/pci/controller/pcie-mediatek.c |    4 ++++
 drivers/pci/probe.c                    |    3 +++
 include/linux/pci.h                    |    1 +
 3 files changed, 8 insertions(+)

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
@@ -1084,6 +1086,7 @@ static int mtk_pcie_probe(struct platfor
 
 	host->ops = pcie->soc->ops;
 	host->sysdata = pcie;
+	host->no_msi = pcie->soc->no_msi;
 
 	err = pci_host_probe(host);
 	if (err)
@@ -1173,6 +1176,7 @@ static const struct dev_pm_ops mtk_pcie_
 };
 
 static const struct mtk_pcie_soc mtk_pcie_soc_v1 = {
+	.no_msi = true,
 	.ops = &mtk_pcie_ops,
 	.startup = mtk_pcie_startup_port,
 };
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -889,6 +889,9 @@ static int pci_register_host_bridge(stru
 	if (!bus)
 		return -ENOMEM;
 
+	if (bridge->no_msi)
+		bus->bus_flags |= PCI_BUS_FLAGS_NO_MSI;
+
 	bridge->bus = bus;
 
 	/* Temporarily move resources off the list */
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -545,6 +545,7 @@ struct pci_host_bridge {
 	unsigned int	native_dpc:1;		/* OS may use PCIe DPC */
 	unsigned int	preserve_config:1;	/* Preserve FW resource setup */
 	unsigned int	size_windows:1;		/* Enable root bus sizing */
+	unsigned int	no_msi:1;		/* Bridge has no MSI support */
 
 	/* Resource alignment requirements */
 	resource_size_t (*align_resource)(struct pci_dev *dev,
