Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6944BC206F
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2019 14:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfI3MQY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Sep 2019 08:16:24 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:48827 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfI3MQY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Sep 2019 08:16:24 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MZCX1-1iaW5x1SCX-00V7fF; Mon, 30 Sep 2019 14:16:00 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Antoine Tenart <antoine.tenart@bootlin.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Pascal van Leeuwen <pvanleeuwen@verimatrix.com>,
        Pascal van Leeuwen <pascalvanl@gmail.com>,
        Kelsey Skunberg <skunberg.kelsey@gmail.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH 3/3] crypto: inside-secure - Remove #ifdef checks
Date:   Mon, 30 Sep 2019 14:14:35 +0200
Message-Id: <20190930121520.1388317-3-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190930121520.1388317-1-arnd@arndb.de>
References: <20190930121520.1388317-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:DhNMaznTViuOF1AalsUIbiZreKsHiyUrkj8fjXw2kpt+XaZVRMO
 J8YhptUq0zNreRZAe1ciQQ9P+7PwLZ4bVXmZ2zDxUx16GeaoE+uLbSBgsq4VqI/bllMTpUm
 IuOxnA/ocfiWg7kY8BpiqjzDbShczJ0gkj3X45qj6ROtPYNI1xWVIe84GaxjDxbJJT/Kxf4
 GCMm4UdcKSxI/O67jRoeA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:iwpPAhAApkg=:vp6ThXb05tXvclIdlpOKKK
 9xeCeSq9XRyUpW/bqAqmJKKLGkk0Dmni/pOgc+KWFb/bUqE5jDBE6agHOI3v6VlhEO1iQ7CLV
 gR4/7DWERudbPYl09MEziUp/oWYSm4xo+QgUD68FnLuodMS1fbyderRJLzO1BcIZN9wuQML2a
 mz684aYB+X5HJQ2GJrw012PxdMfTu2myUmH7usdIcW/UDg5j1Eacg1YLo5eRtYeX7pYTorqLS
 8vdOfsIsU8Xfs7E+d3gXKiSRlVncPB3mjJOtKzh7mmJnSCXbwtpMkwYEVAHjMqVvTaY4/cXC1
 aDJCggWuHj2cimOinhDTJ88N6x/hQSQY4q5j/F6AsviI/kS6UjqM+lvl1HKXexaK7thGZI5wI
 L9WFx8+JfUpFIPj9B2dOCwHOSmdn2YeCvoBM9aQ+sStypc1brRCggst6Af1THOj2tWV8qPGF8
 3lfwmx2ejW1KKJCqEiWM9mZCo0fwtTmRYxZIpbJDqGSwPBXjtX2lV43tf5wgd+IvKXXosuiPg
 hkCZYTPNx109UA+M/erLPaX6c+FsKrrkbL/xETUsrW3AXHPXPnc/uolW8A1fo+cz9eVYqJ5jc
 buENIliHdYaUzgxniz0DavEs/1qAuRJ/br3MXKoYUbnKH7yvrcLso51UfRorcAiLmn+9KeHBC
 ktYJlTiDUSJqBP9eWE6v2pfR4S2uYCyLMHP8O6/AWmwnGKO/Av3dGrUABq339Es85ycXV9cYd
 jTK1Loj8PKsbklF1gEbzdEb4MijosQ+QGi//ne7NtoRQiYyyXDU5DHT+OG1UCthO/M3+XADuC
 u65TN7AgkL4g98Ypd9xTpptk550otgnsWlvWZ16J47yizTnz2fsyiVcxNyk2pLGHZbpcccy+T
 64ls0o7jlMI1K1K5AYnA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When both PCI and OF are disabled, no drivers are registered, and
we get some unused-function warnings:

drivers/crypto/inside-secure/safexcel.c:1221:13: error: unused function 'safexcel_unregister_algorithms' [-Werror,-Wunused-function]
static void safexcel_unregister_algorithms(struct safexcel_crypto_priv *priv)
drivers/crypto/inside-secure/safexcel.c:1307:12: error: unused function 'safexcel_probe_generic' [-Werror,-Wunused-function]
static int safexcel_probe_generic(void *pdev,
drivers/crypto/inside-secure/safexcel.c:1531:13: error: unused function 'safexcel_hw_reset_rings' [-Werror,-Wunused-function]
static void safexcel_hw_reset_rings(struct safexcel_crypto_priv *priv)

It's better to make the compiler see what is going on and remove
such ifdef checks completely. In case of PCI, this is trivial since
pci_register_driver() is defined to an empty function that makes the
compiler subsequently drop all unused code silently.

The global pcireg_rc/ofreg_rc variables are not actually needed here
since the driver registration does not fail in ways that would make
it helpful.

For CONFIG_OF, an IS_ENABLED() check is still required, since platform
drivers can exist both with and without it.

A little change to linux/pci.h is needed to ensure that
pcim_enable_device() is visible to the driver. Moving the declaration
outside of ifdef would be sufficient here, but for consistency with the
rest of the file, adding an inline helper is probably best.

Fixes: 212ef6f29e5b ("crypto: inside-secure - Fix unused variable warning when CONFIG_PCI=n")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/crypto/inside-secure/safexcel.c | 49 ++++++-------------------
 include/linux/pci.h                     |  1 +
 2 files changed, 13 insertions(+), 37 deletions(-)

diff --git a/drivers/crypto/inside-secure/safexcel.c b/drivers/crypto/inside-secure/safexcel.c
index 311bf60df39f..c4e8fd27314c 100644
--- a/drivers/crypto/inside-secure/safexcel.c
+++ b/drivers/crypto/inside-secure/safexcel.c
@@ -1547,7 +1547,6 @@ static void safexcel_hw_reset_rings(struct safexcel_crypto_priv *priv)
 	}
 }
 
-#if IS_ENABLED(CONFIG_OF)
 /* for Device Tree platform driver */
 
 static int safexcel_probe(struct platform_device *pdev)
@@ -1666,9 +1665,7 @@ static struct platform_driver  crypto_safexcel = {
 		.of_match_table = safexcel_of_match_table,
 	},
 };
-#endif
 
-#if IS_ENABLED(CONFIG_PCI)
 /* PCIE devices - i.e. Inside Secure development boards */
 
 static int safexcel_pci_probe(struct pci_dev *pdev,
@@ -1789,54 +1786,32 @@ static struct pci_driver safexcel_pci_driver = {
 	.probe         = safexcel_pci_probe,
 	.remove        = safexcel_pci_remove,
 };
-#endif
-
-/* Unfortunately, we have to resort to global variables here */
-#if IS_ENABLED(CONFIG_PCI)
-int pcireg_rc = -EINVAL; /* Default safe value */
-#endif
-#if IS_ENABLED(CONFIG_OF)
-int ofreg_rc = -EINVAL; /* Default safe value */
-#endif
 
 static int __init safexcel_init(void)
 {
-#if IS_ENABLED(CONFIG_PCI)
+	int ret;
+
 	/* Register PCI driver */
-	pcireg_rc = pci_register_driver(&safexcel_pci_driver);
-#endif
+	ret = pci_register_driver(&safexcel_pci_driver);
 
-#if IS_ENABLED(CONFIG_OF)
 	/* Register platform driver */
-	ofreg_rc = platform_driver_register(&crypto_safexcel);
- #if IS_ENABLED(CONFIG_PCI)
-	/* Return success if either PCI or OF registered OK */
-	return pcireg_rc ? ofreg_rc : 0;
- #else
-	return ofreg_rc;
- #endif
-#else
- #if IS_ENABLED(CONFIG_PCI)
-	return pcireg_rc;
- #else
-	return -EINVAL;
- #endif
-#endif
+	if (IS_ENABLED(CONFIG_OF) && !ret) {
+		ret = platform_driver_register(&crypto_safexcel);
+		if (ret)
+			pci_unregister_driver(&safexcel_pci_driver);
+	}
+
+	return ret;
 }
 
 static void __exit safexcel_exit(void)
 {
-#if IS_ENABLED(CONFIG_OF)
 	/* Unregister platform driver */
-	if (!ofreg_rc)
+	if (IS_ENABLED(CONFIG_OF))
 		platform_driver_unregister(&crypto_safexcel);
-#endif
 
-#if IS_ENABLED(CONFIG_PCI)
 	/* Unregister PCI driver if successfully registered before */
-	if (!pcireg_rc)
-		pci_unregister_driver(&safexcel_pci_driver);
-#endif
+	pci_unregister_driver(&safexcel_pci_driver);
 }
 
 module_init(safexcel_init);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index f9088c89a534..1a6cf19eac2d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1686,6 +1686,7 @@ static inline struct pci_dev *pci_get_class(unsigned int class,
 static inline void pci_set_master(struct pci_dev *dev) { }
 static inline int pci_enable_device(struct pci_dev *dev) { return -EIO; }
 static inline void pci_disable_device(struct pci_dev *dev) { }
+static inline int pcim_enable_device(struct pci_dev *pdev) { return -EIO; }
 static inline int pci_assign_resource(struct pci_dev *dev, int i)
 { return -EBUSY; }
 static inline int __pci_register_driver(struct pci_driver *drv,
-- 
2.20.0

