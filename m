Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 097AE2A2C35
	for <lists+linux-pci@lfdr.de>; Mon,  2 Nov 2020 14:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725798AbgKBN6t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Nov 2020 08:58:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:51336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725960AbgKBN6Q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Nov 2020 08:58:16 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D96092227F;
        Mon,  2 Nov 2020 13:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604325495;
        bh=4vBetSmkaAnipo22H++gE1vnC0urlGdr/4l9rZltXFE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=b+8i5rz2fNvGL/J6h4wEUkI4ox8rsUkM8bbbQBOG71JqSsWi1gVwTT0Mo82faN1td
         /KMhiFuGwK7cRt0J4BfT9L7nWYKypu8/fdn/U0HtQBjKJFeAB9BDprMjxJv47a4iue
         6vtU7qZPCSdHWVnb29WtdnR5uM/nDL8Xv0AplhW0=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kZaLc-006g2w-Bj; Mon, 02 Nov 2020 13:58:12 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 02 Nov 2020 13:58:12 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Frank Wunderlich <linux@fw-web.de>,
        linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: Aw: Re:  Re: [PATCH] pci: mediatek: fix warning in msi.h
In-Reply-To: <trinity-4313623b-1adf-4cc3-8b50-2d0593669995-1604318207058@3c-app-gmx-bap57>
References: <20201031140330.83768-1-linux@fw-web.de>
 <878sbm9icl.fsf@nanos.tec.linutronix.de>
 <EC02022C-64CF-4F4B-A0A2-215A0A49E826@public-files.de>
 <87lfflti8q.wl-maz@kernel.org> <1604253261.22363.0.camel@mtkswgap22>
 <trinity-9eb2a213-f877-4af3-87df-f76a9c093073-1604255233122@3c-app-gmx-bap08>
 <87k0v4u4uq.wl-maz@kernel.org> <87pn4w90hm.fsf@nanos.tec.linutronix.de>
 <df5565a2f1e821041c7c531ad52a3344@kernel.org>
 <trinity-4313623b-1adf-4cc3-8b50-2d0593669995-1604318207058@3c-app-gmx-bap57>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <336d6588567949029c52ecfbb87660c1@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: frank-w@public-files.de, tglx@linutronix.de, ryder.lee@mediatek.com, linux-mediatek@lists.infradead.org, linux@fw-web.de, linux-kernel@vger.kernel.org, matthias.bgg@gmail.com, linux-pci@vger.kernel.org, bhelgaas@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020-11-02 11:56, Frank Wunderlich wrote:
> looks good on bananapi-r2, no warning, pcie-card and hdd recognized

Thanks for giving it a shot. Still needs a bit of tweaking, as I expect
it to break configurations that select CONFIG_PCI_MSI_ARCH_FALLBACKS
(we have to assume that MSIs can be handled until we hit the 
arch-specific
stuff).

There is also a small nit in the way we allow userspace to mess with
this flag via sysfs, and similar restrictions should probably apply.

Updated patch below.

         M.

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index d15c881e2e7e..5bb1306162c7 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -387,10 +387,20 @@ static ssize_t msi_bus_store(struct device *dev, 
struct device_attribute *attr,
  		return count;
  	}

-	if (val)
+	if (val) {
+		/*
+		 * If there is no possibility for this bus to deal with
+		 * MSIs, then allowing them to be requested would lead to
+		 * the kernel complaining loudly. In this situation, don't
+		 * let userspace mess things up.
+		 */
+		if (!pci_bus_is_msi_capable(subordinate))
+			return -EINVAL;
+
  		subordinate->bus_flags &= ~PCI_BUS_FLAGS_NO_MSI;
-	else
+	} else {
  		subordinate->bus_flags |= PCI_BUS_FLAGS_NO_MSI;
+	}

  	dev_info(&subordinate->dev, "MSI/MSI-X %s for future drivers of 
devices on this bus\n",
  		 val ? "allowed" : "disallowed");
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 4289030b0fff..28861cc6435a 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -871,6 +871,8 @@ static void pci_set_bus_msi_domain(struct pci_bus 
*bus)
  		d = pci_host_bridge_msi_domain(b);

  	dev_set_msi_domain(&bus->dev, d);
+	if (!pci_bus_is_msi_capable(bus))
+		bus->bus_flags |= PCI_BUS_FLAGS_NO_MSI;
  }

  static int pci_register_host_bridge(struct pci_host_bridge *bridge)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 22207a79762c..6aadb863dff4 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2333,6 +2333,12 @@ pci_host_bridge_acpi_msi_domain(struct pci_bus 
*bus) { return NULL; }
  static inline bool pci_pr3_present(struct pci_dev *pdev) { return 
false; }
  #endif

+static inline bool pci_bus_is_msi_capable(struct pci_bus *bus)
+{
+	return (IS_ENABLED(CONFIG_PCI_MSI_ARCH_FALLBACKS) ||
+		dev_get_msi_domain(&bus->dev));
+}
+
  #ifdef CONFIG_EEH
  static inline struct eeh_dev *pci_dev_to_eeh_dev(struct pci_dev *pdev)
  {

-- 
Jazz is not dead. It just smells funny...
