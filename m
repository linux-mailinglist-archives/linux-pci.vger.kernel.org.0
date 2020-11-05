Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB4922A7A54
	for <lists+linux-pci@lfdr.de>; Thu,  5 Nov 2020 10:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgKEJUP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Nov 2020 04:20:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:56580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbgKEJUP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Nov 2020 04:20:15 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 026F62071A;
        Thu,  5 Nov 2020 09:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604568014;
        bh=vG/q08mrtLO2gtgc71xNwaKrcP0h6Ke4lfzwwZebEmc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AizFHPUT+/8spelBt47bhLEK1RpLhRh3Y3KY85KCZsd6XlHvcO2B+F+Xgq2AHCNXQ
         d9JrAkYC9bizE/R9I8f//2h+bd4nRuTJgJvrYyAEc4YFcevr5fVM3Y/OFNmcjq7Yfy
         NjC1lvcaPJCGy9UEvGVNsPxGnscV95Ysew59zPP8=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kabRD-007mhX-Pc; Thu, 05 Nov 2020 09:20:11 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 05 Nov 2020 09:20:11 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Frank Wunderlich <linux@fw-web.de>,
        linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: Aw: Re:  Re: [PATCH] pci: mediatek: fix warning in msi.h
In-Reply-To: <87h7q4lnoz.fsf@nanos.tec.linutronix.de>
References: <20201031140330.83768-1-linux@fw-web.de>
 <878sbm9icl.fsf@nanos.tec.linutronix.de>
 <EC02022C-64CF-4F4B-A0A2-215A0A49E826@public-files.de>
 <87lfflti8q.wl-maz@kernel.org> <1604253261.22363.0.camel@mtkswgap22>
 <trinity-9eb2a213-f877-4af3-87df-f76a9c093073-1604255233122@3c-app-gmx-bap08>
 <87k0v4u4uq.wl-maz@kernel.org> <87pn4w90hm.fsf@nanos.tec.linutronix.de>
 <df5565a2f1e821041c7c531ad52a3344@kernel.org>
 <87h7q791j8.fsf@nanos.tec.linutronix.de>
 <877dr38kt8.fsf@nanos.tec.linutronix.de>
 <901c5eb8bbaa3fe53ddc8f65917e48ef@kernel.org>
 <87o8ke7njb.fsf@nanos.tec.linutronix.de>
 <trinity-1d7f8900-10db-40c0-a0aa-47bb99ed84cd-1604508571909@3c-app-gmx-bs02>
 <87h7q4lnoz.fsf@nanos.tec.linutronix.de>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <074d057910c3e834f4bd58821e8583b1@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: tglx@linutronix.de, frank-w@public-files.de, ryder.lee@mediatek.com, linux-mediatek@lists.infradead.org, linux@fw-web.de, linux-kernel@vger.kernel.org, matthias.bgg@gmail.com, linux-pci@vger.kernel.org, bhelgaas@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020-11-04 23:14, Thomas Gleixner wrote:

[...]

> TBH, that's butt ugly. So after staring long enough into the PCI code I
> came up with a way to transport that information to the probe code.
> 
> That allows a particular device to say 'I can't do MSI' and at the same
> time keeps the warning machinery intact which tells us that a 
> particular
> host controller driver is broken.
> 
> Uncompiled and untested as usual :)
> 
> Thanks,
> 
>         tglx
> ---
>  drivers/pci/controller/pcie-mediatek.c |    4 ++++
>  drivers/pci/probe.c                    |    3 +++
>  include/linux/pci.h                    |    1 +
>  3 files changed, 8 insertions(+)
> 
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -143,6 +143,7 @@ struct mtk_pcie_port;
>   * struct mtk_pcie_soc - differentiate between host generations
>   * @need_fix_class_id: whether this host's class ID needed to be fixed 
> or not
>   * @need_fix_device_id: whether this host's device ID needed to be 
> fixed or not
> + * @no_msi: Bridge has no MSI support
>   * @device_id: device ID which this host need to be fixed
>   * @ops: pointer to configuration access functions
>   * @startup: pointer to controller setting functions
> @@ -151,6 +152,7 @@ struct mtk_pcie_port;
>  struct mtk_pcie_soc {
>  	bool need_fix_class_id;
>  	bool need_fix_device_id;
> +	bool no_msi;
>  	unsigned int device_id;
>  	struct pci_ops *ops;
>  	int (*startup)(struct mtk_pcie_port *port);
> @@ -1084,6 +1086,7 @@ static int mtk_pcie_probe(struct platfor
> 
>  	host->ops = pcie->soc->ops;
>  	host->sysdata = pcie;
> +	host->no_msi = pcie->soc->no_msi;
> 
>  	err = pci_host_probe(host);
>  	if (err)
> @@ -1173,6 +1176,7 @@ static const struct dev_pm_ops mtk_pcie_
>  };
> 
>  static const struct mtk_pcie_soc mtk_pcie_soc_v1 = {
> +	.no_msi = true,
>  	.ops = &mtk_pcie_ops,
>  	.startup = mtk_pcie_startup_port,
>  };
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -889,6 +889,9 @@ static int pci_register_host_bridge(stru
>  	if (!bus)
>  		return -ENOMEM;
> 
> +	if (bridge->no_msi)
> +		bus->bus_flags |= PCI_BUS_FLAGS_NO_MSI;
> +
>  	bridge->bus = bus;
> 
>  	/* Temporarily move resources off the list */
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -545,6 +545,7 @@ struct pci_host_bridge {
>  	unsigned int	native_dpc:1;		/* OS may use PCIe DPC */
>  	unsigned int	preserve_config:1;	/* Preserve FW resource setup */
>  	unsigned int	size_windows:1;		/* Enable root bus sizing */
> +	unsigned int	no_msi:1;		/* Bridge has no MSI support */
> 
>  	/* Resource alignment requirements */
>  	resource_size_t (*align_resource)(struct pci_dev *dev,

If that's the direction of travel, we also need something like this
for configuration where the host bridge relies on an external MSI block
that uses MSI domains (boot-tested in a GICv3 guest).

         M.

diff --git a/drivers/pci/controller/pci-host-common.c 
b/drivers/pci/controller/pci-host-common.c
index 6ce34a1deecb..603f6fbbe68a 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -77,6 +77,7 @@ int pci_host_common_probe(struct platform_device 
*pdev)

  	bridge->sysdata = cfg;
  	bridge->ops = (struct pci_ops *)&ops->pci_ops;
+	bridge->msi_domain = true;

  	platform_set_drvdata(pdev, bridge);

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 16fb150fbb8d..f421b2869bca 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -889,9 +889,6 @@ static int pci_register_host_bridge(struct 
pci_host_bridge *bridge)
  	if (!bus)
  		return -ENOMEM;

-	if (bridge->no_msi)
-		bus->bus_flags |= PCI_BUS_FLAGS_NO_MSI;
-
  	bridge->bus = bus;

  	/* Temporarily move resources off the list */
@@ -928,6 +925,9 @@ static int pci_register_host_bridge(struct 
pci_host_bridge *bridge)
  	device_enable_async_suspend(bus->bridge);
  	pci_set_bus_of_node(bus);
  	pci_set_bus_msi_domain(bus);
+	if (bridge->no_msi ||
+	    (bridge->msi_domain && !bus->dev.msi_domain))
+		bus->bus_flags |= PCI_BUS_FLAGS_NO_MSI;

  	if (!parent)
  		set_dev_node(bus->bridge, pcibus_to_node(bus));
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c2a0c1d471d6..81f72fd46e06 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -546,6 +546,7 @@ struct pci_host_bridge {
  	unsigned int	preserve_config:1;	/* Preserve FW resource setup */
  	unsigned int	size_windows:1;		/* Enable root bus sizing */
  	unsigned int	no_msi:1;		/* Bridge has no MSI support */
+	unsigned int	msi_domain:1;		/* Bridge wants MSI domain */

  	/* Resource alignment requirements */
  	resource_size_t (*align_resource)(struct pci_dev *dev,

-- 
Jazz is not dead. It just smells funny...
