Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754C05AC38F
	for <lists+linux-pci@lfdr.de>; Sun,  4 Sep 2022 11:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbiIDJJD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 4 Sep 2022 05:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiIDJJC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 4 Sep 2022 05:09:02 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A967491D5;
        Sun,  4 Sep 2022 02:09:01 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id e18so7906582edj.3;
        Sun, 04 Sep 2022 02:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=O2typRxdzqsHfp2kEBOr4WNIbnu/ovQ09qqv/Hu1pIU=;
        b=mEwv2YDOLkvyR5SAWvf1KvXxyVk/W4CM3FINHf0fPt6/1CATbsBeLTMvw7NAxBITnL
         beIONGwUkW/Emdz3lnPVQxGohbnsuzOSZGy0nCqHiQH17U1lMP7Z2pN0JzcqlYz3PtUj
         OO8z8KxVH1Fhbqz6ELFXF0nSOLhm34jt66kw6ypGQmUYPWk3UGNGhgsnMdY1/gp1nq38
         0rOjQ/8mWEZl7TcIG+kLCBhjNqdgkJYjpRFA5YFWfcvXVK5i0uY35XmjhLL51T/HMO5x
         GExGiQd6KOQEFt9dUqlOWWPDdWB6VOUA3yYd0eBYtMnUh8W1UVNzW1T/mTLg3GlKvt8d
         YYDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=O2typRxdzqsHfp2kEBOr4WNIbnu/ovQ09qqv/Hu1pIU=;
        b=tEznhUfTIFa17HiNm72KpBM/qBCqux3Y7FRfnVY5/5h/MQC5xFTMgpnbun1REFjTFi
         YIvffqJo4G+tq2wQfE+YLCyiRYg2j9ZKScsVCu2DThEzhjmfccanMFSfV1fkLsOwEzv9
         aLwU/AymUeIPomnWRk+6lKlkvrlAji9donRAl4sDyUDQXxp/3M7BGzOwaGYE4bmqKOh4
         vSqS7GztIPVgM8gQzmhgyYhadd005N5w825fm3AcFaGvZJsmmgJaNouLdc5yOUCWaOBM
         F0wfqHqDz7hZG34vPC+fdo0MRJOyTWGYHs0e2a/PfTfSGUj4Ski88wjlTuekcn/6nsFI
         9Sag==
X-Gm-Message-State: ACgBeo0CuoSAjenq9DFEQUfNgWhSvnVZSyyNUtvE2lhHqGTReC7XlNdo
        4eWbvrmSOOf7OKNinGU8moOCzuzgfuA=
X-Google-Smtp-Source: AA6agR4NJnx5sNg8PNykLl1mgRsJURuIQHjA9zZgAk1EeYC3FtDilwF6YINYFa0BfKPRxYHeSe0T6A==
X-Received: by 2002:a05:6402:1f8c:b0:43e:8fab:76c with SMTP id c12-20020a0564021f8c00b0043e8fab076cmr38989547edc.126.1662282539472;
        Sun, 04 Sep 2022 02:08:59 -0700 (PDT)
Received: from masalkhi.. (p5ddb3241.dip0.t-ipconnect.de. [93.219.50.65])
        by smtp.gmail.com with ESMTPSA id eg46-20020a05640228ae00b0044e7862ab3fsm447553edb.7.2022.09.04.02.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 02:08:59 -0700 (PDT)
From:   Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
To:     bhelgaas@google.com, makvihas@gmail.com, kw@linux.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
Subject: [PATCH] PCI: ibmphp: Convert a double pointer to single pointer parameter
Date:   Sun,  4 Sep 2022 11:08:22 +0200
Message-Id: <20220904090822.8083-1-abd.masalkhi@gmail.com>
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

Convert the parameter of type 'struct slot **' to 'struct slot *' of
ibmphp_init_devno() to improve code readability.

Signed-off-by: Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
---
 drivers/pci/hotplug/TODO          |  3 ---
 drivers/pci/hotplug/ibmphp.h      |  2 +-
 drivers/pci/hotplug/ibmphp_core.c | 30 +++++++++++++++---------------
 drivers/pci/hotplug/ibmphp_ebda.c |  2 +-
 4 files changed, 17 insertions(+), 20 deletions(-)

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
index 0399c60d2ec1..28fe92cf544a 100644
--- a/drivers/pci/hotplug/ibmphp.h
+++ b/drivers/pci/hotplug/ibmphp.h
@@ -734,7 +734,7 @@ struct controller {
 
 /* Functions */
 
-int ibmphp_init_devno(struct slot **);	/* This function is called from EBDA, so we need it not be static */
+int ibmphp_init_devno(struct slot *cur_slot);	/* This function is called from EBDA, so we need it not be static */
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

