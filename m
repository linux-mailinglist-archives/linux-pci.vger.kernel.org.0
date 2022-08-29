Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8454B5A4FFA
	for <lists+linux-pci@lfdr.de>; Mon, 29 Aug 2022 17:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiH2PP5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Aug 2022 11:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiH2PP4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Aug 2022 11:15:56 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C3566A49;
        Mon, 29 Aug 2022 08:15:55 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id l5so6357966qtv.4;
        Mon, 29 Aug 2022 08:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=jJgRGDMh5QqrocPxkJGdQzX2cJb3bE82S/H7CAscWyE=;
        b=k7DtU3GaV0f7P+6hGWWYs3Z/qp9vFv2K7yaiwtBdLiIyz40bh2F3jUrfz2Px+pzlZm
         05zlDg073iABfahwL2FeExviGpDqwNyfUojWuMae/qG0JApCWmJWcQIxaVcS5a7Cd0HE
         YrU6qoEZwtFmEfrSPl4wknWqOM38BsdqshsxL8+/AD5i3OMqPlKltgWjvZmjz8/d9FHN
         F5kciKOhTs2lglrn8bmu48kC7O8yHu2T7Pgi/PYKllLnbnOddi4/FdnoYS/E7EgbnkRN
         9/zE/kU5HKGaCkLGtU4/Zg55EvdFki+s6xKRnW/aRE/T4Po65e3o9cvazKcTNCyExpCI
         C+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=jJgRGDMh5QqrocPxkJGdQzX2cJb3bE82S/H7CAscWyE=;
        b=3ijqnFwDyL0yxMfkHGrmR9y9+pSrCAaDBmOdM6zwkAcwsNc7b156PgsghUIXiv0oAg
         7AELZ32BAT8k3nQHl/DdCAYZ5qKjTn68IvDVQFnZiYOtCDSm9KZPHMTGH47RR15nEKG+
         zpF0Ep4un6oUcZNXniJjDAsnPH6fM/A/7IpUVeGV7sdyrY4LdNVbZUmroQxd2t6sbCsU
         mDLSE+vo3mpcjHya4hF1i3AQWH5v349qP1+x2RfpduyzeZ902IRebnabG1LT95M2FrQO
         NPYtkT7Tg498cqfoPfsnKeebvoqkxBehpxBXZ5v+BFca0XSxd2YJryLdTBY7mUegCd5X
         Gpig==
X-Gm-Message-State: ACgBeo1FJWXRGydGRGLOGMvXfNTKESAOqRb2zTfZ1WAlQmI3K9QGPzBP
        M2OA2l2WP9HoDSyP5kcdo3Q=
X-Google-Smtp-Source: AA6agR4uUb8CMyq5Bx/fpRKDFzFFMYkWQIA3n27IOCUea2JWTE8P4OR/N3IO21wCYyByrhhA2ma0XA==
X-Received: by 2002:a05:622a:589:b0:342:fd8c:9786 with SMTP id c9-20020a05622a058900b00342fd8c9786mr10644133qtb.150.1661786154759;
        Mon, 29 Aug 2022 08:15:54 -0700 (PDT)
Received: from pm2-ws13.praxislan02.com ([2001:470:8:67e:595c:561f:be80:7773])
        by smtp.gmail.com with ESMTPSA id cj16-20020a05622a259000b0031eb5648b86sm5311538qtb.41.2022.08.29.08.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 08:15:54 -0700 (PDT)
From:   Jason Andryuk <jandryuk@gmail.com>
To:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Jason Andryuk <jandryuk@gmail.com>, xen-devel@lists.xenproject.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] xen-pcifront: Handle missed Connected state
Date:   Mon, 29 Aug 2022 11:15:36 -0400
Message-Id: <20220829151536.8578-1-jandryuk@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

An HVM guest with linux stubdom and 2 PCI devices failed to start as
libxl timed out waiting for the PCI devices to be added.  It happens
intermittently but with some regularity.  libxl wrote the two xenstore
entries for the devices, but then timed out waiting for backend state 4
(Connected) - the state stayed at 7 (Reconfiguring).  (PCI passthrough
to an HVM with stubdomain is PV passthrough to the stubdomain and then
HVM passthrough with the QEMU inside the stubdomain.)

The stubdom kernel never printed "pcifront pci-0: Installing PCI
frontend", so it seems to have missed state 4 which would have
called pcifront_try_connect -> pcifront_connect_and_init_dma

Have pcifront_detach_devices special-case state Initialised and call
pcifront_connect_and_init_dma.  Don't use pcifront_try_connect because
that sets the xenbus state which may throw off the backend.  After
connecting, skip the remainder of detach_devices since none have been
initialized yet.  When the backend switches to Reconfigured,
pcifront_attach_devices will pick them up again.

Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
---
 drivers/pci/xen-pcifront.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

--- a/drivers/pci/xen-pcifront.c
+++ b/drivers/pci/xen-pcifront.c
@@ -1012,13 +1012,26 @@ static int pcifront_detach_devices(struc
 {
 	int err = 0;
 	int i, num_devs;
+	enum xenbus_state state;
 	unsigned int domain, bus, slot, func;
 	struct pci_dev *pci_dev;
 	char str[64];
 
-	if (xenbus_read_driver_state(pdev->xdev->nodename) !=
-	    XenbusStateConnected)
+	state = xenbus_read_driver_state(pdev->xdev->nodename);
+	if (state == XenbusStateInitialised) {
+		dev_dbg(&pdev->xdev->dev, "Handle skipped connect.\n");
+		/* We missed Connected and need to initialize. */
+		err = pcifront_connect_and_init_dma(pdev);
+		if (err && err != -EEXIST) {
+			xenbus_dev_fatal(pdev->xdev, err,
+					 "Error setting up PCI Frontend");
+			goto out;
+		}
+
+		goto out_switch_state;
+	} else if (state != XenbusStateConnected) {
 		goto out;
+	}
 
 	err = xenbus_scanf(XBT_NIL, pdev->xdev->otherend, "num_devs", "%d",
 			   &num_devs);
@@ -1079,6 +1092,7 @@ static int pcifront_detach_devices(struc
 			domain, bus, slot, func);
 	}
 
+ out_switch_state:
 	err = xenbus_switch_state(pdev->xdev, XenbusStateReconfiguring);
 
 out:
