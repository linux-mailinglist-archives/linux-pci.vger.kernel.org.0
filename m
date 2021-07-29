Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1EB43DADC2
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jul 2021 22:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbhG2Uhw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jul 2021 16:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbhG2Uhv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jul 2021 16:37:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0ADC0613CF
        for <linux-pci@vger.kernel.org>; Thu, 29 Jul 2021 13:37:48 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m9Cmn-0000FB-6B; Thu, 29 Jul 2021 22:37:45 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m9Cmm-0003dF-AP; Thu, 29 Jul 2021 22:37:44 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m9Cmm-0004JF-9Y; Thu, 29 Jul 2021 22:37:44 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>, kernel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org
Subject: [PATCH v1 3/5] PCI: Provide wrapper to access a pci_dev's bound driver
Date:   Thu, 29 Jul 2021 22:37:38 +0200
Message-Id: <20210729203740.1377045-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210729203740.1377045-1-u.kleine-koenig@pengutronix.de>
References: <20210729203740.1377045-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=7QyPcwdZ4NY+Kamu1yuALIDREdHsFlSri/yk8rxG5RU=; m=efVkvKukHsBB4PwEUkp1fcCPAc6GyqodQBQ/wT0SBJU=; p=/gl5i/UU1Dx09yWOtLon+pQ4jNTmCE0Y+RzjPzQvvpA=; g=9669558ff758fb0bb7e9379b94e233c729d3a4b8
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmEDEX0ACgkQwfwUeK3K7AnJsgf+L9m dAAepAffg0DqO4mEHBAN9xlbrzVV8hdC2FjXjhHxBegmBNVxCVLGPWHux8syNntEBqqFa8fwK1LPz h0iHqvyxo7l8S616n3XiCF/b36uyo4JvQOPNWtl/lcD/lZ28rySJQ7+rHHdLw1QiGhBQ2lmbi4BCO CLXpDxdlzgIxdTovICB8bp4HODbs/HxBgbuFUtKM6zrqHFXeJ3HMoARKaaMfiaS7uzU93bnPJwG4H 0y9hK//gCNxG5LoTORRm4LgA5liJ9Ri2GoL1DwchxVsGKbp3dmero4Y0GkUIkX9wCn56UYmbS4hy3 +RtuKKky6gkOPtiBWbGflWK5BQVH5tQ==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Which driver a device is bound to is available twice: In struct
pci_dev::dev->driver and in struct pci_dev::driver. To get rid of the
duplication introduce a wrapper to access struct pci_dev's driver
member. Once all users are converted the wrapper can be changed to
calculate the driver using pci_dev::dev->driver.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 include/linux/pci.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 540b377ca8f6..778f3b5e6f23 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -887,6 +887,7 @@ struct pci_driver {
 };
 
 #define	to_pci_driver(drv) container_of(drv, struct pci_driver, driver)
+#define pci_driver_of_dev(pdev) ((pdev)->driver)
 
 /**
  * PCI_DEVICE - macro used to describe a specific PCI device
-- 
2.30.2

