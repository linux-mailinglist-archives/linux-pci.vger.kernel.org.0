Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075A0599C1F
	for <lists+linux-pci@lfdr.de>; Fri, 19 Aug 2022 14:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348704AbiHSMiT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Aug 2022 08:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348748AbiHSMiS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Aug 2022 08:38:18 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631BE219D;
        Fri, 19 Aug 2022 05:38:12 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id dc19so8516499ejb.12;
        Fri, 19 Aug 2022 05:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=raMryu2vCH2S3V8GGqzDxZVNX0m8mdoI5L8nOpctxJ8=;
        b=aPR+kP0MVM/8BJHCNqQqPvtpIN/mzrQcddUg2B43G2ixLypoEU0g/sFoAETuc/K2sB
         t0LqPAFMGteW2XUw/72PNdHnHEcmUajrL4yUedrocliSh/0RIfYN3dQEJke020om9IMu
         f8MU5pEJGJ1M0k4sycTjoyNcrkift/K1rHIXHTJZMiW4bW8rc5xhe22b1yNVhFBC2/It
         Jj8lhtLX4EazKXQC7Y8VhlIiQCQ637SjI6PGBt9gTFbO5Ur24ecfikdE9B7F2R+1qhaZ
         I1f3dXxGf4Mgjjx32zOElmKkLGMKojQIiqOUzEjaNQ1t3wEbtEx4KLmB9C77E0T/GSt5
         NxEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=raMryu2vCH2S3V8GGqzDxZVNX0m8mdoI5L8nOpctxJ8=;
        b=K7cvvQW0rrQWRxfNA4uD7kVRCoJ+xn+z77Y2End8k81xiIrEZxxMot0CtAp/iUF3NN
         WdNsoxHZ2puP2O/vCKqug5Nuj758NJrtA+BqY9ZRVONhyf7WbyKkhmjduU74MzhCKxAv
         g2fRpgM99fAJQ1gAdgeRpZjvSM1cucWtY6y1W9MJQRxIQpyhmmP4f8Hhkypa2sbFD0xv
         jSsmZXRwYcEUlcTvPurX9n0mRpWlsTBXMaG0zWY62JkfpijJoLN5vVW+MM6rYypzflYD
         1yrGGyop58ftCg6NWghTP4D+YFifG+A687LwMMB4z0dpCco5IrkOfAguNpIRDpH5tgRN
         CClQ==
X-Gm-Message-State: ACgBeo2ktPsFjzXNBfklOSxgC/mZSCE9jHkexWGOzGwBeLpRbCBKBp7v
        W/V4TXbzEppsn2F9YB5NtJQ=
X-Google-Smtp-Source: AA6agR4SeJGuU+x5DBnDSJZShXQlOwBpCC+0oKQ9e2LGlRIVdfX/EIaULLsdBDUZtzHqD1SGj/k+wQ==
X-Received: by 2002:a17:906:6a0f:b0:730:df34:6ec4 with SMTP id qw15-20020a1709066a0f00b00730df346ec4mr4921259ejc.659.1660912690758;
        Fri, 19 Aug 2022 05:38:10 -0700 (PDT)
Received: from masalkhi.. (p5495ba80.dip0.t-ipconnect.de. [84.149.186.128])
        by smtp.gmail.com with ESMTPSA id s22-20020a056402015600b00445f545e4besm3018078edu.59.2022.08.19.05.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 05:38:10 -0700 (PDT)
From:   Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
To:     bhelgaas@google.com, helgaas@kernel.org
Cc:     kw@linux.com, os.vaslot@gmail.com, makvihas@gmail.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
Subject: [PATCH v2] PCI: ibmphp: Convert from double pointer to single pointer parameter
Date:   Fri, 19 Aug 2022 14:38:07 +0200
Message-Id: <20220819123807.16541-1-abd.masalkhi@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1.dirty
In-Reply-To: <20220818230755.GA2403414@bhelgaas>
References: <20220818230755.GA2403414@bhelgaas>
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

Change the parameter of type 'struct slot **' to 'struct slot *' of
ibmphp_init_devno() since using a double pointer is unnecessary in
this case and converting it to a single pointer parameter is better
for performance and readability.

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

