Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2DA592059
	for <lists+linux-pci@lfdr.de>; Sun, 14 Aug 2022 17:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiHNPUL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 14 Aug 2022 11:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiHNPUK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 14 Aug 2022 11:20:10 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994266444;
        Sun, 14 Aug 2022 08:20:09 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id fy5so9793202ejc.3;
        Sun, 14 Aug 2022 08:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=7OMCuOCLGwAh5koLHIT9qXwTr/SNzv9NQ1uazP6CGPM=;
        b=dbyduEEpnWafipf9BxN1hPR26rqTRmESvubs8JHBVQQ4fOjVju208MmPMJIszfxpf5
         fz7XtWQrbdSGTlBb3OJqJ++KHEWsF5L7tCT+W+jMY/RWRui6fyRmF2wQ6CcTfQzWr3PQ
         6RM1MiWeVj1PaDIo7/2ywSZwTv8XRq2seSXjApJPe+U5bMom84JYNDlkrDZUFN2T/ti/
         vK1vOSyRy/phTyRdmxCem+RRNx0vhz0ZBeMXH7kRcvrUUOUKGbxOCKN8qL1yjz+BJdN3
         lG1LA+zDW03IO0Jr6ANUkQ3dsw+F5PCqI74RPF7heP2zVdErqED9FNLuNStWUYrUaoXm
         EqtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=7OMCuOCLGwAh5koLHIT9qXwTr/SNzv9NQ1uazP6CGPM=;
        b=5i0S41apDop4hfwlaJP7komjd6wWPcqk3zlGTMQGMwcOERzzKGdU1YoUwN/7MwEb8x
         auXmixCqLCpt5jcUCax3kBchBxNMYQAOb3/S0VCOOH9hr1v1qxvxB61IvISjtUym3Ky6
         80yE44DJeMKl6IDvCZ1T6kLvP2RMIW9jYdI5Gqpuj3V7qH3nhBsPuhY7KZNRAOo3Y1d5
         Otd5ArL9YV2XwZMk8sJzHAyhyZoF4SUd0dX6H9IS7i41SYs7TQB/MuLjhj3R5CKV2csS
         opLqpA9PWgPgcdxt9OYaDvV9Mfu7YOqvgwdqcfKifV8PS4eqT00SLQ0coDh/+RmIPPHq
         2z3w==
X-Gm-Message-State: ACgBeo0JTTG7M5+xP0VLU/E0Obkdce/SdUNOeccpzM/3ZpxEzrxwz+DN
        dxBv4IuPH0qmXlko1Jnn4LI=
X-Google-Smtp-Source: AA6agR54x/G2fEIUhzDFc2KT7dhLSkkQ8KWGtOJIPp8A4kJAjIUiB665NpcaXZtNX6SXIdbwFgQLYA==
X-Received: by 2002:a17:907:1c8a:b0:6e9:2a0d:d7b7 with SMTP id nb10-20020a1709071c8a00b006e92a0dd7b7mr7684908ejc.572.1660490408175;
        Sun, 14 Aug 2022 08:20:08 -0700 (PDT)
Received: from masalkhi.. (p5ddb3241.dip0.t-ipconnect.de. [93.219.50.65])
        by smtp.gmail.com with ESMTPSA id u4-20020a50eac4000000b0043ba7df7a42sm4891734edp.26.2022.08.14.08.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 08:20:07 -0700 (PDT)
From:   Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
To:     bhelgaas@google.com
Cc:     kw@linux.com, os.vaslot@gmail.com, makvihas@gmail.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
Subject: [PATCH] PCI: ibmphp: Adjusting the parameter list of a function
Date:   Sun, 14 Aug 2022 17:19:56 +0200
Message-Id: <20220814151956.16950-1-abd.masalkhi@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1.dirty
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

ibmphp_init_devno() takes a struct slot **, and it should be changed
to take struct slot * instead.

Signed-off-by: Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
---
 drivers/pci/hotplug/TODO          |  3 ---
 drivers/pci/hotplug/ibmphp.h      |  3 ++-
 drivers/pci/hotplug/ibmphp_core.c | 30 +++++++++++++++---------------
 drivers/pci/hotplug/ibmphp_ebda.c |  2 +-
 4 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/hotplug/TODO b/drivers/pci/hotplug/TODO
index 88f217c82b4f..63a9fed407ed 100644
--- a/drivers/pci/hotplug/TODO
+++ b/drivers/pci/hotplug/TODO
@@ -30,9 +30,6 @@ ibmphp:
   or ibmphp should store a pointer to its bus in struct slot.  Probably the
   former.
 
-* ibmphp_init_devno() takes a struct slot **, it could instead take a
-  struct slot *.
-
 * The return value of pci_hp_register() is not checked.
 
 * The various slot data structures are difficult to follow and need to be
diff --git a/drivers/pci/hotplug/ibmphp.h b/drivers/pci/hotplug/ibmphp.h
index 0399c60d2ec1..148a421eb262 100644
--- a/drivers/pci/hotplug/ibmphp.h
+++ b/drivers/pci/hotplug/ibmphp.h
@@ -734,7 +734,8 @@ struct controller {
 
 /* Functions */
 
-int ibmphp_init_devno(struct slot **);	/* This function is called from EBDA, so we need it not be static */
+/* ibmphp_init_devno() is called from EBDA, so we need it not be static */
+int ibmphp_init_devno(struct slot *cur_slot);
 int ibmphp_do_disable_slot(struct slot *slot_cur);
 int ibmphp_update_slot_info(struct slot *);	/* This function is called from HPC, so we need it to not be static */
 int ibmphp_configure_card(struct pci_func *, u8);
diff --git a/drivers/pci/hotplug/ibmphp_core.c b/drivers/pci/hotplug/ibmphp_core.c
index 197997e264a2..107752b11f2c 100644
--- a/drivers/pci/hotplug/ibmphp_core.c
+++ b/drivers/pci/hotplug/ibmphp_core.c
@@ -109,7 +109,7 @@ static int __init get_max_slots(void)
  * Parameters: struct slot
  * Returns 0 or errors
  */
-int ibmphp_init_devno(struct slot **cur_slot)
+int ibmphp_init_devno(struct slot *cur_slot)
 {
 	struct irq_routing_table *rtable;
 	int len;
@@ -130,21 +130,21 @@ int ibmphp_init_devno(struct slot **cur_slot)
 		return -1;
 	}
 	for (loop = 0; loop < len; loop++) {
-		if ((*cur_slot)->number == rtable->slots[loop].slot &&
-		    (*cur_slot)->bus == rtable->slots[loop].bus) {
-			(*cur_slot)->device = PCI_SLOT(rtable->slots[loop].devfn);
+		if (cur_slot->number == rtable->slots[loop].slot &&
+		    cur_slot->bus == rtable->slots[loop].bus) {
+			cur_slot->device = PCI_SLOT(rtable->slots[loop].devfn);
 			for (i = 0; i < 4; i++)
-				(*cur_slot)->irq[i] = IO_APIC_get_PCI_irq_vector((int) (*cur_slot)->bus,
-						(int) (*cur_slot)->device, i);
-
-			debug("(*cur_slot)->irq[0] = %x\n",
-					(*cur_slot)->irq[0]);
-			debug("(*cur_slot)->irq[1] = %x\n",
-					(*cur_slot)->irq[1]);
-			debug("(*cur_slot)->irq[2] = %x\n",
-					(*cur_slot)->irq[2]);
-			debug("(*cur_slot)->irq[3] = %x\n",
-					(*cur_slot)->irq[3]);
+				cur_slot->irq[i] = IO_APIC_get_PCI_irq_vector((int) cur_slot->bus,
+						(int) cur_slot->device, i);
+
+			debug("cur_slot->irq[0] = %x\n",
+					cur_slot->irq[0]);
+			debug("cur_slot->irq[1] = %x\n",
+					cur_slot->irq[1]);
+			debug("cur_slot->irq[2] = %x\n",
+					cur_slot->irq[2]);
+			debug("cur_slot->irq[3] = %x\n",
+					cur_slot->irq[3]);
 
 			debug("rtable->exclusive_irqs = %x\n",
 					rtable->exclusive_irqs);
diff --git a/drivers/pci/hotplug/ibmphp_ebda.c b/drivers/pci/hotplug/ibmphp_ebda.c
index 7fb75401ad8a..5c7821ad9c2c 100644
--- a/drivers/pci/hotplug/ibmphp_ebda.c
+++ b/drivers/pci/hotplug/ibmphp_ebda.c
@@ -880,7 +880,7 @@ static int __init ebda_rsrc_controller(void)
 			if (rc)
 				goto error;
 
-			rc = ibmphp_init_devno(&tmp_slot);
+			rc = ibmphp_init_devno(tmp_slot);
 			if (rc)
 				goto error;
 			tmp_slot->hotplug_slot.ops = &ibmphp_hotplug_slot_ops;
-- 
2.29.0.rc1.dirty

