Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9B6010C8FD
	for <lists+linux-pci@lfdr.de>; Thu, 28 Nov 2019 13:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfK1M4y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Nov 2019 07:56:54 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:42669 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbfK1M4x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Nov 2019 07:56:53 -0500
Received: from orion.localdomain ([95.117.37.214]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MUY9w-1iRTe00XvE-00QSQQ; Thu, 28 Nov 2019 13:54:36 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     tim@buttersideup.com, james.morse@arm.com, rrichter@marvell.com,
        jdelvare@suse.com, linux@roeck-us.net, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, linux-crypto@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-pci@vger.kernel.org
Subject: [PATCH 5/6] char: hw_random: intel-rng: use pci_get_device_by_id()
Date:   Thu, 28 Nov 2019 13:54:05 +0100
Message-Id: <20191128125406.10417-5-info@metux.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191128125406.10417-1-info@metux.net>
References: <20191128125406.10417-1-info@metux.net>
X-Provags-ID: V03:K1:EbWrMi3cKVLJ5grbOjx3/hSD38kPrYADX4wYa3I2tB+lljpckSy
 15HWVYCgNQbjb4Jw3Jq5wDzRihvWg1A40U38MsKdMEXp34A3CDPgBn18wQGaajyXKEeu5ay
 NsIDm3ieOx2cqQOzjrtF3v4KCOsDSDg4nKPQBitqKPLXkyvJNky+o2SHLXJPJQ6Nw06jjRO
 p/cWYppeb0dvhCnWHwmrw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:b3/pDDdW3UM=:HOt218E1TJBg5l8PwQMbn5
 w/I+vFLUvPQdEAp5cDPDg8n2h4ya8JtA1HanhyNAmcyh4vGsMgeYRXlZpmvZupMH+axBIuqxu
 pVFcwt4Sp1TMawpRn0F8Dv4vvffgxawkECTS8zzNlz8idaOZtBZbVNa8LAmWjXwgSKrkpSodl
 GnNhy4Pq+UMaqA5ikRxkqWeg9y/u5VllU0cKvl8g+g/brdHyCsqj1pXtL2K/n5bHFOTqC+rzu
 kI9M8bVpPIUPwYxM0aRhWZ6s8bTo4/CCiIDqsN2HAGB/iyPXUNnPROFJV7w+Z4IMLFcxMm2e2
 uNX+S+c0Mr2Q9jCug6/ntRuVhcBUpFChhRw1nCf3jlJi6Rrl7NU16lumMoqUoBmNSdO5ZBiua
 JDI+G2P254oeJieUNKspfKPMjXMZ+mVbeVUGIBV2EHkADJvn4zHbRZA8npJo2h4urY8LcjVCi
 F0McB4lBnIjPPbL/XyEZKdx53XUn8OTfNAdQWnk40u1SQ8cjqYLCjbdqw5YHP99HwciWY6qYw
 YFmBo7tZmLZuXvwd+B8O+8CiJ/K6lSUuZXn3RqDz18foPro7g1/IKzz3/623ktdU3AChdOCud
 BBaIsqme1ehxmVRejswtrs6qTMwX7saoU0f+2BbMnEWjKA+zrpvwppooxFiT9K/3JcsI4CRRQ
 C1lU8pQ5UCuTW1INIXckNLWG+HTBP7lmhcLKzmassUponhmRCYGY8LUwg+tC1U2V1s4NBM3DV
 M376+7mY/UZ2s/l0w27Lqhmv+C7hfea+YTSGQrNnOnNXBS4mFSGa/gsGiJXGg9qt+bXgnF4vx
 Wf6zkZEV35085jbvkNP9VGozwPbfIZsVTOE+NFgOcG+0J5BFDm3tdRJ5FqwaSS7iQU3gN9iQH
 yI5kHlzVQgjPoyZ/zF2Q==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use the new pci_get_device_by_id() helper in order to reduce
a bit of boilerplate.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/char/hw_random/intel-rng.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/char/hw_random/intel-rng.c b/drivers/char/hw_random/intel-rng.c
index 290c880266bf..6b8d37a81166 100644
--- a/drivers/char/hw_random/intel-rng.c
+++ b/drivers/char/hw_random/intel-rng.c
@@ -335,8 +335,7 @@ static int __init mod_init(void)
 	struct intel_rng_hw *intel_rng_hw;
 
 	for (i = 0; !dev && pci_tbl[i].vendor; ++i)
-		dev = pci_get_device(pci_tbl[i].vendor, pci_tbl[i].device,
-				     NULL);
+		dev = pci_get_device_by_id(&pci_tbl[i]);
 
 	if (!dev)
 		goto out; /* Device not found. */
-- 
2.11.0

