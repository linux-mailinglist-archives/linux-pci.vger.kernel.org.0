Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E60647E62
	for <lists+linux-pci@lfdr.de>; Fri,  9 Dec 2022 08:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiLIHRM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Dec 2022 02:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiLIHRJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Dec 2022 02:17:09 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D83A31DD7;
        Thu,  8 Dec 2022 23:17:08 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id j5-20020a05600c410500b003cfa9c0ea76so2741290wmi.3;
        Thu, 08 Dec 2022 23:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8/LCy/d/7cFCAy3kAThheVqXGRbKxH6e9mviumbYm7c=;
        b=Ep5jefDyiLAXJnhqR+U2NKELAg+lA97eqqHMhvkVV+aRjYE4InGCkBCOle7ysDnbTO
         PKaVDBdtcp1EJkvwwrSCcY2AtQ8tI6w95+Xk4YBQbgQ+cwPBl7rwCAEI8P6hN+ofp7M7
         XlL0rLPuFw5YiPjyKeuDl21SWZfgwuIKSFQuOe6NFhEyUIILCCNwUaiw8PxUeDLQV3xt
         GNAeDtGIJu9z2sqZ/Z33nJc+IiW5WvysqNV3g4psYxP2rqJ3rCtZFpXss8JYqkanavfV
         1vaOFJElsrkSL8x2TLqq+mb1OW2wYptbCsS1uI+Sqjw7P3GHodmlu2NUDsTXQiXVKmSy
         aMOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8/LCy/d/7cFCAy3kAThheVqXGRbKxH6e9mviumbYm7c=;
        b=lhTFyMvN6jHI4dAJ2X0yvFAzW6P9WaMLDxoJVuyV4FfnOOreX0HHXQHYHc7EYmIcrd
         6q1d+YWFdpqz5EaBCSpUhw/Z7I3qtFNN1R7ObfIXmxbD9KHtDmn9gw1nCS9p5RwxZA3B
         i/MeQrqusR15IcM27uhwSku9lF/jDyXI1C/vZoHhmAVGWQ/Y/M5HYgjQIHRq1ZCZbqGF
         ygcdYjUHNuYL/aNp9iTtEMKnzYKYNeFpQgz924htw040WXbQnQwYyq8HglrugV6vapcZ
         7VjlEZjQUfh1Qg7fJ3VZEQT7/06o2jVzOYeOJ35sS4U4gOQ0v/CRXfmrbuQ0ZbbCA1Dz
         zzPg==
X-Gm-Message-State: ANoB5pnG8utuda3PiINGHkmlVvGbnTwh1QqiQCW5RblCjrJkpNNOBCLk
        CIMEY4ho5r3ffVX3gR5iZo3yglghY/8=
X-Google-Smtp-Source: AA0mqf5yU2g+sGKdKn91qa1TmxluiqjdrDClfICOFqEJUtyO738YTISN0kqyFNWFPXVxdyE4s+4AJA==
X-Received: by 2002:a05:600c:4fd1:b0:3d0:6c60:b4d1 with SMTP id o17-20020a05600c4fd100b003d06c60b4d1mr4820311wmq.6.1670570226308;
        Thu, 08 Dec 2022 23:17:06 -0800 (PST)
Received: from localhost.localdomain (188.red-88-10-59.dynamicip.rima-tde.net. [88.10.59.188])
        by smtp.gmail.com with ESMTPSA id j10-20020a05600c1c0a00b003b49bd61b19sm8249488wms.15.2022.12.08.23.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 23:17:05 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     bhelgaas@google.com, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, matthias.bgg@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: mt7621: Sleep a bit after power on the PCIs phy ports
Date:   Fri,  9 Dec 2022 08:17:03 +0100
Message-Id: <20221209071703.2891714-1-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some devices like ZBT WE1326 and ZBT WF3526-P need to sleep a bit after call
to mt7621_pcie_init_port() driver function to get into reliable boots for
both warn and hard resets. The needed time for these devices to always detect
the ports seems to be from 75 to 100 milliseconds. Hence, properly add an
extra 100 milliseconds msleep() call to make also these devices work.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
Hi Bjorn / Lorenzo,

I send previous patch here [0] related with this issue. Since after a bit
of testing with these devices by openwrt community [1] we end up that there is
no need of increasing PERST_DELAY_MS definition. This is also the reason
of not sending a v2 for this but a new patch with the proper solution.
I preferred to just use the same PERST_DELAY_MS define also for this to
not perform extra changes but the needed to the driver. If you prefer
me to write new definitions for all the sleep paths you pointed out in
[0], just let me know and I will send them also.

Thanks in advance for your time.

Best regards,
    Sergio Paracuellos

[0]: https://lore.kernel.org/linux-pci/20221119110837.2419466-1-sergio.paracuellos@gmail.com/T/#u
[1]: https://github.com/openwrt/openwrt/pull/11220

 drivers/pci/controller/pcie-mt7621.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controller/pcie-mt7621.c
index 4bd1abf26008..3311ca64b315 100644
--- a/drivers/pci/controller/pcie-mt7621.c
+++ b/drivers/pci/controller/pcie-mt7621.c
@@ -369,6 +369,7 @@ static int mt7621_pcie_init_ports(struct mt7621_pcie *pcie)
 		}
 	}
 
+	msleep(PERST_DELAY_MS);
 	mt7621_pcie_reset_ep_deassert(pcie);
 
 	tmp = NULL;
-- 
2.25.1

