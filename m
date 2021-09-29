Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E780941C10B
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 10:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244923AbhI2IzX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 04:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244938AbhI2IzM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Sep 2021 04:55:12 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7487C06161C
        for <linux-pci@vger.kernel.org>; Wed, 29 Sep 2021 01:53:31 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mVVL5-0001ik-Qf; Wed, 29 Sep 2021 10:53:19 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mVVL2-0004fp-E0; Wed, 29 Sep 2021 10:53:16 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mVVL2-0000Qi-Cp; Wed, 29 Sep 2021 10:53:16 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christoph Hellwig <hch@lst.de>, linux-pci@vger.kernel.org,
        kernel@pengutronix.de,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Russell Currey <ruscur@russell.cc>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v5 05/11] powerpc/eeh: Don't use driver member of struct pci_dev and further cleanups
Date:   Wed, 29 Sep 2021 10:53:00 +0200
Message-Id: <20210929085306.2203850-6-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210929085306.2203850-1-u.kleine-koenig@pengutronix.de>
References: <20210929085306.2203850-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=Zpj0MfNpdqb/t0RctaGob3+oRuWP4Yx6JOoywu4XRsI=; m=qLVHAb7UOiGrqQuPN/p5loiFStoGSa1I5N8zuOAmNU8=; p=0U5IO+Yv/dUfU3ayUE/9KpmDUjFv5zoIY+LRFqJ9Pw0=; g=70976583fe04d220fe4cb7c498cea58f830f1545
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFUKVMACgkQwfwUeK3K7AmJMAf/fle M7ZSgYoAd9Ai8Nl4D3rswcfDtso0iiuOBUj9/XyN9IR7lmKmEpgd/6+PMeVX62KfJMZkuufkSeOZy c9zIuozCYchsQgZtAui+QSKa56cyDQ7W5fU5hlDlmFTSWz7B9FTw0obuBNZl4bbN/+yxKDzeiHTJb PKtcKtXl9qi+EVdNUfCzRBwiSNr1y4Kie9QMIHJ/4Zt52NRSf/8WK6uu382qbSRhppW28mQegSKEn E8REnf0ykJhdAJuN9C59Cy4cBdTNAAE8YIEmZZVRE/UOsGc6aWHZtA3KKjvYLUld9053OGOUVhoi9 9vQXua1T5nTw6ObqYvrL1SLrjDl6Iww==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The driver member of struct pci_dev is to be removed as it tracks
information already present by tracking of the driver core. So replace
pdev->driver->name by dev_driver_string() for the corresponding struct
device.

Also move the function nearer to its only user and instead of the ?:
operator use a normal if which is more readable.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 arch/powerpc/include/asm/ppc-pci.h | 5 -----
 arch/powerpc/kernel/eeh.c          | 8 ++++++++
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-pci.h b/arch/powerpc/include/asm/ppc-pci.h
index 2b9edbf6e929..f6cf0159024e 100644
--- a/arch/powerpc/include/asm/ppc-pci.h
+++ b/arch/powerpc/include/asm/ppc-pci.h
@@ -55,11 +55,6 @@ void eeh_pe_dev_mode_mark(struct eeh_pe *pe, int mode);
 void eeh_sysfs_add_device(struct pci_dev *pdev);
 void eeh_sysfs_remove_device(struct pci_dev *pdev);
 
-static inline const char *eeh_driver_name(struct pci_dev *pdev)
-{
-	return (pdev && pdev->driver) ? pdev->driver->name : "<null>";
-}
-
 #endif /* CONFIG_EEH */
 
 #define PCI_BUSNO(bdfn) ((bdfn >> 8) & 0xff)
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index e9b597ed423c..4b08881c4a1e 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -399,6 +399,14 @@ static int eeh_phb_check_failure(struct eeh_pe *pe)
 	return ret;
 }
 
+static inline const char *eeh_driver_name(struct pci_dev *pdev)
+{
+	if (pdev)
+		return dev_driver_string(&pdev->dev);
+
+	return "<null>";
+}
+
 /**
  * eeh_dev_check_failure - Check if all 1's data is due to EEH slot freeze
  * @edev: eeh device
-- 
2.30.2

