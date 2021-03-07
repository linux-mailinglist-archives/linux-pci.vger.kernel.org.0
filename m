Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A584A33053C
	for <lists+linux-pci@lfdr.de>; Mon,  8 Mar 2021 00:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbhCGXyo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 7 Mar 2021 18:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbhCGXyS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 7 Mar 2021 18:54:18 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31964C06174A;
        Sun,  7 Mar 2021 15:54:18 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id l7so6062204pfd.3;
        Sun, 07 Mar 2021 15:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8R7+UaAKzntZZEV87N+admABCX8PPQ5Cic70DpQyEY0=;
        b=cvbo2oY/11KlR6OFS2NCBxNr3WyqdE/7yJGqyU4BRTSafcUADTHpQJDeqQpnapgddH
         xyjsg+6NNCJsmPIZWsS/5Un1Jp5sZ63+Knel1fcM+j+d157ofWQid1dZ4Z//XRwcBKNK
         IfDgLFChCtBYj+YXZlq3WpW1uYidj1MCoxlsC5lmoiKtaMR8Tsm/CPxPJkm3o5BMvlYV
         KU/z/kb2xqnAJzW04QGDm+SWVvG8gA2y9aJ0oTxI7qFup3wPRsSmmGMMQN4As3+uN84h
         iZ5ylwK3dW41KCe9JjjfPCVRfpqoc8n3Wy/cfxiNFUgzsHA9gq5ZcwMTysXGVXUCLdS+
         iMrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8R7+UaAKzntZZEV87N+admABCX8PPQ5Cic70DpQyEY0=;
        b=MBrQvAXY1S6EWolLcL3seVK92WW+7Te8sGmWAf7VbrjEK3XiRQdQEm8KUM1XJgNqqd
         6A2FrdRqU8RFmnKuFs7ilHqK2ITGRZRIcsDb66yW9yMOH0XASVt7R+ghnq9j2o5zm1oh
         Vj5NFZJiTS3k/41gF7AhnhHo59cOvVLgFVd+DG3h6pVPnihPuyWA0fCvnAqMnyXJiK/b
         6qNHQbDV+v4IqE+2KxidhghV6p5/G1PGmBl7ycfG1cXIMjq6jrO0EpmjuD+yZjGb8EDk
         Fa3diYXzVwNHXUzhTiPKJBzo7zKovGJNo0jSo7TIrqlmvcSbt5Fdt6NuaeD4j4+NzQTl
         f3qg==
X-Gm-Message-State: AOAM533A1PmIWeHDhAPPG4/YjhlfFYQ1Q849Oaol89+PDRFmbclxAWqc
        Q9i5b1OcOcYTROOZhi30jKg=
X-Google-Smtp-Source: ABdhPJzQoofHXfA0wxyZK4TDRjzHoMT4QilWOaQ8yg8rd9QR9iJHRM2lZFHRwjdNuMY0wCx84VPXjA==
X-Received: by 2002:a62:a108:0:b029:1c1:119b:8713 with SMTP id b8-20020a62a1080000b02901c1119b8713mr18843469pff.74.1615161257796;
        Sun, 07 Mar 2021 15:54:17 -0800 (PST)
Received: from rayare.domain.name ([106.51.141.71])
        by smtp.googlemail.com with ESMTPSA id t10sm8542099pjf.30.2021.03.07.15.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 15:54:17 -0800 (PST)
From:   chakravarthikulkarni <chakravarthikulkarni2021@gmail.com>
Cc:     chakravarthikulkarni2021@gmail.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: acpiphp: Fixed coding style of open braces and comments
Date:   Mon,  8 Mar 2021 05:24:01 +0530
Message-Id: <20210307235401.2011-1-chakravarthikulkarni2021@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fixed WARNING and ERROR message provided by ./checkpatch.pl scripts.

Signed-off-by: chakravarthi kulkarni <chakravarthikulkarni2021@gmail.com>
---
 drivers/pci/hotplug/acpiphp.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp.h b/drivers/pci/hotplug/acpiphp.h
index a74b274a8c45..e0964600a78f 100644
--- a/drivers/pci/hotplug/acpiphp.h
+++ b/drivers/pci/hotplug/acpiphp.h
@@ -80,8 +80,8 @@ struct acpiphp_bridge {
 struct acpiphp_slot {
 	struct list_head node;
 	struct pci_bus *bus;
-	struct list_head funcs;		/* one slot may have different
-					   objects (i.e. for each function) */
+	struct list_head funcs;		/* one slot may have different */
+					/* objects (i.e. for each function) */
 	struct slot *slot;
 
 	u8		device;		/* pci device# */
@@ -148,8 +148,7 @@ static inline struct acpiphp_root_context *to_acpiphp_root_context(struct acpi_h
  * ACPI has no generic method of setting/getting attention status
  * this allows for device specific driver registration
  */
-struct acpiphp_attention_info
-{
+struct acpiphp_attention_info {
 	int (*set_attn)(struct hotplug_slot *slot, u8 status);
 	int (*get_attn)(struct hotplug_slot *slot, u8 *status);
 	struct module *owner;
-- 
2.17.1

