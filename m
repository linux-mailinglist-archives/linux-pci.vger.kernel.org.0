Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB84726CE05
	for <lists+linux-pci@lfdr.de>; Wed, 16 Sep 2020 23:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgIPVIC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Sep 2020 17:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgIPQDk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Sep 2020 12:03:40 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27908C0D942B
        for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2020 07:57:27 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id j7so3328000plk.11
        for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2020 07:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1MZwtpdbpR82U6Gt5FPzGRx8447icke/57YKQin/C1w=;
        b=SnFiideW4v1h1GfuLr0YBWu2m48RxJpZzGlNwB1zlyIT23pDJs4jM3UpJ3BjlCo3Ln
         4AchZFaZESPBSmajWtg5TX/E8D0adUngXBLnB2hy8JFX+PS/xC8KI0i66fWhMyjbVRoA
         drnFWt+5AVxOoeMbV94rHALapPtenW82hv1n4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1MZwtpdbpR82U6Gt5FPzGRx8447icke/57YKQin/C1w=;
        b=HDF8hZqiPGmqt6HQ+wSpb7vYjs5EnJnZUfl8YNmWpsJWGiF1OWHPcZot6UwJpxav0z
         fNoIQ7HItpGr/RzCaBjxrQz+u1G4d19dQRZPRoXHyou4X7qgBCrkvab/BvP9au1NVj8Q
         TUz9YMXvkj46qjEjhIMP8hGtu8IZQvyM2IbKTnhnLEXZygbDsxKJ3AteMPefZpSNfZpo
         SccUnCptiy+TZ3b3nITKj10KnLUBFd9pC3Nm1LYD5Mcfzt6JHLhm6YQhKc8XMa3z6gJ5
         VEWS0ETyNi4NYTrxStk/oxwqs6/IkoB7iIEysnmCHLT4TD1PV8+kyBvdab8KltwOFy4K
         BbQg==
X-Gm-Message-State: AOAM532IVtDjiZqiFf9qBtflpswJKeq4s9a8QoFpHGAndXswskyUNar0
        l9uytS120hGUFHb8jdJRgSFisKFWHvdTw0SrixH5WAuB58HgoeHqa7okPF09t8cFKwEJy7u68aS
        bdUODgZ3h4xmgJfwge0X4R+8VcqJxoXSTVQMxIujkaHkZluA8vziuqWl/dqa6N8k7yMjPyKTbfI
        r+Txeg
X-Google-Smtp-Source: ABdhPJxPdcFIJf7Y7r7V+T6n57+3CMecgJqMly75nRv6uxltu3DUIVK67DoStHARIsYQ7H1Y9yQx+g==
X-Received: by 2002:a17:902:7844:b029:d0:cbe1:e704 with SMTP id e4-20020a1709027844b02900d0cbe1e704mr24389033pln.18.1600268246713;
        Wed, 16 Sep 2020 07:57:26 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id 82sm15070257pgd.6.2020.09.16.07.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 07:57:26 -0700 (PDT)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        james.quinlan@broadcom.com
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/1] PCI: pcie_bus_config can be set at build time
Date:   Wed, 16 Sep 2020 10:57:06 -0400
Message-Id: <20200916145707.33313-2-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200916145707.33313-1-james.quinlan@broadcom.com>
References: <20200916145707.33313-1-james.quinlan@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000006dd7e405af6f7cd2"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--0000000000006dd7e405af6f7cd2

The Kconfig is modified so that the pcie_bus_config setting can be done at
build time in the same manner as the CONFIG_PCIEASPM_XXXX choice.  The
pci_bus_config setting may still be overridden by the bootline param.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/Kconfig | 56 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.c   | 12 ++++++++++
 2 files changed, 68 insertions(+)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 4bef5c2bae9f..15ce948858fb 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -187,6 +187,62 @@ config PCI_HYPERV
 	  The PCI device frontend driver allows the kernel to import arbitrary
 	  PCI devices from a PCI backend to support PCI driver domains.
 
+choice
+	prompt "PCIE default bus config setting"
+	default PCIE_BUS_DEFAULT
+	depends on PCI
+	help
+	  One of the following choices will set the pci_bus_config at
+	  compile time.  The choices offered are the same as those offered
+	  for the bootline parameter 'pci'; i.e. 'pci=pcie_bus_tune_off',
+	  'pci=pcie_bus_safe', 'pci=pcie_bus_perf', and 'pci=pcie_bus_peer2peer'.
+	  This is a compile-time setting and is still be overridden by the
+	  above bootline parameters, if present.  If unsure, chose PCIE_BUS_DEFAULT.
+
+config PCIE_BUS_TUNE_OFF
+	bool "Tune Off"
+	depends on PCI
+	help
+	  Use the BIOS defaults; doesn't touch MPS at all.  This is the same
+	  as booting with 'pci=pcie_bus_tune_off'.
+
+config PCIE_BUS_DEFAULT
+	bool "Default"
+	depends on PCI
+	help
+	  Default choice; ensures that the MPS matches upstream bridge.
+
+config PCIE_BUS_SAFE
+	bool "Safe"
+	depends on PCI
+	help
+	  Use largest MPS that boot-time devices support.  If you have a
+	  closed system with no possibility of adding new devices,
+	  this will use the largest MPS that's supported by all devices.
+	  This is the same as booting with 'pci=pcie_bus_safe'.
+
+config PCIE_BUS_PERFORMANCE
+	bool "Performance"
+	depends on PCI
+	help
+	  Use MPS and MRRS for best performance.  This setting ensures
+	  that a given device's MPS is no larger than its parent MPS,
+	  which allows us to keep all switches/bridges to the max MPS supported
+	  by their parent and eventually the PHB.  This is the same as
+	  booting with 'pci=pcie_bus_perf'.
+
+config PCIE_BUS_PEER2PEER
+	bool "Peer2peer"
+	depends on PCI
+	help
+	  Set MPS = 128 for all devices.  MPS configuration effected by
+	  the other options could cause the MPS on one root port to be
+	  different than that of the MPS on another.  Simply making the system
+	  wide MPS be set to the smallest possible value (128B) solves
+	  this issue.  This is the same as booting with 'pci=pcie_bus_peer2peer'.
+
+endchoice
+
 source "drivers/pci/hotplug/Kconfig"
 source "drivers/pci/controller/Kconfig"
 source "drivers/pci/endpoint/Kconfig"
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e39c5499770f..dfb52ed4a931 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -101,7 +101,19 @@ unsigned long pci_hotplug_mmio_pref_size = DEFAULT_HOTPLUG_MMIO_PREF_SIZE;
 #define DEFAULT_HOTPLUG_BUS_SIZE	1
 unsigned long pci_hotplug_bus_size = DEFAULT_HOTPLUG_BUS_SIZE;
 
+
+/* PCIE bus config, can be overridden by bootline param */
+#ifdef CONFIG_PCIE_BUS_TUNE_OFF
+enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_TUNE_OFF;
+#elif defined CONFIG_PCIE_BUS_SAFE
+enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_SAFE;
+#elif defined CONFIG_PCIE_BUS_PERFORMANCE
+enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_PERFORMANCE;
+#elif defined CONFIG_PCIE_BUS_PEER2PEER
+enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_PEER2PEER;
+#else
 enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_DEFAULT;
+#endif
 
 /*
  * The default CLS is used if arch didn't set CLS explicitly and not
-- 
2.17.1


--0000000000006dd7e405af6f7cd2
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
mOxPm7sNHsn0TVdPryi9+T2d8fVC/kUmuEdTYP/Hdu4W4b4T9BcW57fInYrmaJ+uotS6X59rAgMB
AAGjggHRMIIBzTAOBgNVHQ8BAf8EBAMCBaAwgZ4GCCsGAQUFBwEBBIGRMIGOME0GCCsGAQUFBzAC
hkFodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc3BlcnNvbmFsc2lnbjJzaGEy
ZzNvY3NwLmNydDA9BggrBgEFBQcwAYYxaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL2dzcGVy
c29uYWxzaWduMnNoYTJnMzBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYm
aHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBEBgNVHR8E
PTA7MDmgN6A1hjNodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzcGVyc29uYWxzaWduMnNoYTJn
My5jcmwwJQYDVR0RBB4wHIEaamFtZXMucXVpbmxhbkBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYI
KwYBBQUHAwQwHwYDVR0jBBgwFoAUaXKCYjFnlUSFd5GAxAQ2SZ17C2EwHQYDVR0OBBYEFNYm4GDl
4WOt3laB3gNKFfYyaM8bMA0GCSqGSIb3DQEBCwUAA4IBAQBD+XYEgpG/OqeRgXAgDF8sa+lQ/00T
wCP/3nBzwZPblTyThtDE/iaL/YZ5rdwqXwdCnSFh9cMhd/bnA+Eqw89clgTixvz9MdL9Vuo8LACI
VpHO+sxZ2Cu3bO5lpK+UVCyr21y1zumOICsOuu4MJA5mtkpzBXQiA7b/ogjGxG+5iNjt9FAMX4JP
V6GuAMmRknrzeTlxPy40UhUcRKk6Nm8mxl3Jh4KB68z7NFVpIx8G5w5I7S5ar1mLGNRjtFZ0RE4O
lcCwKVGUXRaZMgQGrIhxGVelVgrcBh2vjpndlv733VI2VKE/TvV5MxMGU18RnogYSm66AEFA/Zb+
5ztz1AtIMYICbzCCAmsCAQEwbTBdMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBu
di1zYTEzMDEGA1UEAxMqR2xvYmFsU2lnbiBQZXJzb25hbFNpZ24gMiBDQSAtIFNIQTI1NiAtIEcz
AgwTv2xmtR4KOmK4QvMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIFveeto9zs+u
nCMsgI6cw/k3ns3WNFQ4huev144CfGRxMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIwMDkxNjE0NTcyN1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBqIcrT50QMlW895RGfSiKe0hGqsJSE
kzdLqRCMNXuyH5SNvbkj5PGCvEx43JwxcgHk2FfOjqmd0XG9lKLGB/D8s8RambMXASlKzo2gmUKb
9KKHsE0NmAcLkL8MAZy3mMaLiuQgNaXi1oniPdW6kz1TZC1W6QMtYhjjHQGeOgD+DcyOUqrmjbW4
i+fVqtFZGCxL02qyGaWS7ZhlI1D4XJGIGbAYktyWVC849Z3gY0735PVF7a4ZX3AShfn6jDATdcG+
QeawHo/D2CWVJadahrFqQ53OFchynK/wqhbxbrEo4Z58v2exQmKOQk0SoEfB2ywpF0aHf8JQRb5w
jQ475Jv/
--0000000000006dd7e405af6f7cd2--
