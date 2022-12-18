Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E919464FEE2
	for <lists+linux-pci@lfdr.de>; Sun, 18 Dec 2022 13:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiLRMau (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 18 Dec 2022 07:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbiLRMas (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 18 Dec 2022 07:30:48 -0500
X-Greylist: delayed 543 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 18 Dec 2022 04:30:45 PST
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD214F2A
        for <linux-pci@vger.kernel.org>; Sun, 18 Dec 2022 04:30:45 -0800 (PST)
Received: by air.basealt.ru (Postfix, from userid 490)
        id 05F692F2022A; Sun, 18 Dec 2022 12:21:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
Received: from localhost (broadband-188-32-10-232.ip.moscow.rt.ru [188.32.10.232])
        by air.basealt.ru (Postfix) with ESMTPSA id 45D7B2F20227;
        Sun, 18 Dec 2022 12:21:39 +0000 (UTC)
Date:   Sun, 18 Dec 2022 15:21:39 +0300
From:   "Alexey V. Vissarionov" <gremlin@altlinux.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     "Alexey V. Vissarionov" <gremlin@altlinux.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jesse Barnes <jbarnes@virtuousgeek.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yu Zhao <yu.zhao@intel.com>, linux-pci@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH] PCI/IOV: "virtfn4294967295\0" requires 17 bytes
Message-ID: <20221218122139.GA1182@altlinux.org>
References: <20221218033347.23743-1-gremlin@altlinux.org>
 <Y57x/iCSkdtU3kov@rocinante>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y57x/iCSkdtU3kov@rocinante>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022-12-18 19:57:02 +0900, Krzysztof Wilczyński wrote:

 > Thank you for sending the patch over! However, if possible,
 > can you send it as plain text without any multi-part MIME
 > involved?

ACK.

 > If possible, it would be nice to mention that this needed
 > to make sure that there is enough space to correctly
 > NULL-terminate the ID string.

ACK.

So, here goes the corrected text:

Although unlikely, the 'id' value may be as big as 4294967295
(uint32_max) and "virtfn4294967295\0" would require 17 bytes
instead of 16 to make sure that buffer has enough space to
properly NULL-terminate the ID string.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: dd7cc44d0 ("PCI: add SR-IOV API for Physical Function driver")
Signed-off-by: Alexey V. Vissarionov <gremlin@altlinux.org>


diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 9522175..ad54a07 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -14,7 +14,7 @@
 #include <linux/delay.h>
 #include "pci.h"
 
-#define VIRTFN_ID_LEN	16
+#define VIRTFN_ID_LEN	17
 
 int pci_iov_virtfn_bus(struct pci_dev *dev, int vf_id)
 {


-- 
Alexey V. Vissarionov
gremlin ПРИ altlinux ТЧК org; +vii-cmiii-ccxxix-lxxix-xlii
GPG: 0D92F19E1C0DC36E27F61A29CD17E2B43D879005 @ hkp://keys.gnupg.net
