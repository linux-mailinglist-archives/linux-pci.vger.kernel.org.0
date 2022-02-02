Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE79F4A7763
	for <lists+linux-pci@lfdr.de>; Wed,  2 Feb 2022 19:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbiBBR7g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Feb 2022 12:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232829AbiBBR7f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Feb 2022 12:59:35 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0539C06173B;
        Wed,  2 Feb 2022 09:59:35 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id i10-20020a4aab0a000000b002fccf890d5fso18766oon.5;
        Wed, 02 Feb 2022 09:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p90WUEGo/kpHlCivga9jC0a+0hAZe9bVzxQ08IV244Y=;
        b=QNqHAVrApvvRAoCEuxDtN+Lpyc7ot5ZIXUbZGPezliuwvwBovkwhO3FMS5beNOJFE9
         d6rp2iKtAIKqd+yJsYVz1NG8T3ruziSqIng4r3NSSMTfNS04b/85DWID8F/Kh6jGGQrh
         8ywXWYVMBjlkdjnzFwM8Io/hobkgyugJSupHUyAemeVuecUKDReRR1BqdyL1kFW324v9
         WXS/4rjyH8Ah9FcUBIPclOyXloGSccifnJZ0RmM4L/2OH/YqG1yoV7eVkk61Wmm9bZlY
         xSa2at8mkCqbiIOyNGIDeRmcahT4rRo1+PsKaVhNXISlT1auepM55D2JTUGi20AYmq4H
         7EYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p90WUEGo/kpHlCivga9jC0a+0hAZe9bVzxQ08IV244Y=;
        b=NnSV8SPUFTd5aoY8wduc7XVSGjBVFkYVcV+Nv72bEIzi4bpCeCr2ZEp4ogF8ky+4Ds
         G+aFORDPScNOSGQIylaxLkwZCtyvWLZgB+aUuO47+qGo3V5CULNokzpJwVXPk4rTjz01
         LQkIKFBjAX44PLKkl2M5J1ay0Y3q29sUGmt5ybI+IWdfOmt4cr5K90ImenBOcA8h5tIW
         W7Cl8F96s8HusHSAAMxGC603Xf2yUoolZMIPner4WDpAvVJ7x7p+ONpDoP9woQ1fODAv
         LZZ6kIsbRLr2EqHmFC8dbmudfyMy4eSfcPQVwdzSzBsuQJMTtU32wz7aun01PeuyZQZo
         VuFg==
X-Gm-Message-State: AOAM530oxrqqJeYncQVQnXgxwPiS8H9YakMwGfiSzEG4UZq5N3SY4bDD
        75C/OXbfE1CXjNbrcgSmsuM=
X-Google-Smtp-Source: ABdhPJw+yVcuvoOICtO86PIBuEslUrQqFILPafuq/muxCpjmCqakdmNJ83WaGhbU7GlgqezMy3dfrA==
X-Received: by 2002:a4a:a5d1:: with SMTP id k17mr15398534oom.38.1643824775237;
        Wed, 02 Feb 2022 09:59:35 -0800 (PST)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id v10sm16122725oto.53.2022.02.02.09.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 09:59:35 -0800 (PST)
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Keith Busch <kbusch@kernel.org>, kw@linux.com,
        mariusz.tkaczyk@linux.intel.com, helgaas@kernel.org,
        lukas@wunner.de, pavel@ucw.cz, linux-cxl@vger.kernel.org,
        martin.petersen@oracle.com, James.Bottomley@hansenpartnership.com,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [RFC PATCH v2 3/3] Register auxiliary device for PCIe enclosure management
Date:   Wed,  2 Feb 2022 11:59:13 -0600
Message-Id: <88898bbc85c85dce3c355c5f0399b593da0d4d27.1643822289.git.stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1643822289.git.stuart.w.hayes@gmail.com>
References: <cover.1643822289.git.stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch will register an auxiliary devivce for the pcie_em driver,
allowing it to attach and provide access to PCIe enclosure management
(LEDs), if present.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
---
 drivers/nvme/host/pci.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ca2ee806d74b..22ff10798333 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -27,6 +27,8 @@
 #include <linux/io-64-nonatomic-hi-lo.h>
 #include <linux/sed-opal.h>
 #include <linux/pci-p2pdma.h>
+#include <linux/auxiliary_bus.h>
+#include <linux/pcie_em.h>
 
 #include "trace.h"
 #include "nvme.h"
@@ -159,6 +161,9 @@ struct nvme_dev {
 	unsigned int nr_poll_queues;
 
 	bool attrs_added;
+
+	/* auxiliary_device for pcie_em driver (LEDs) */
+	struct auxiliary_device *pcie_em_auxdev;
 };
 
 static int io_queue_depth_set(const char *val, const struct kernel_param *kp)
@@ -2838,6 +2843,11 @@ static void nvme_reset_work(struct work_struct *work)
 		nvme_unfreeze(&dev->ctrl);
 	}
 
+	/*
+	 * register auxiliary device if this supports PCIe enclosure management
+	 */
+	dev->pcie_em_auxdev = register_pcie_em_auxdev(dev->dev, dev->ctrl.instance);
+
 	/*
 	 * If only admin queue live, keep it to do further investigation or
 	 * recovery.
@@ -3135,6 +3145,7 @@ static void nvme_remove(struct pci_dev *pdev)
 	nvme_free_queues(dev, 0);
 	nvme_release_prp_pools(dev);
 	nvme_dev_unmap(dev);
+	unregister_pcie_em_auxdev(dev->pcie_em_auxdev);
 	nvme_uninit_ctrl(&dev->ctrl);
 }
 
-- 
2.31.1

