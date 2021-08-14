Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE0C03EC4E8
	for <lists+linux-pci@lfdr.de>; Sat, 14 Aug 2021 22:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbhHNUM4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 14 Aug 2021 16:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhHNUM4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 14 Aug 2021 16:12:56 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E26C061764;
        Sat, 14 Aug 2021 13:12:27 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id q2so16181215plr.11;
        Sat, 14 Aug 2021 13:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9BuMHZCK/3y9CRDPc/hvQGRGcyrxlBAyc1hOdgLXm00=;
        b=Ek5ibqaBQZ4Nndleea5q9lbyU351R5pXkslE7iM/mUSanQzJy5gXj2cr7Sd6BmwPYj
         wF8zjo+GR58fQuZCXq3SAJHvK3Yj3reVRzoQcSSXqfCi0zZsDuaPT4fXE0H/EjPLdvod
         bJRIfHIgqfeUXjkeqzVHlYtHoAdHJw/uCalQm+vu9tXY+bo4BdVpq1YV584t82qPOAzu
         67jyl03ITMIndzo5u3tq+PKH3YXQGzH/l2Aru7mn5sK9+GWTJ9eewYz08yf63ivrF4cR
         xk6r6v6i6pUN5oeZMbviVS4YefpjWvXUNrBi1A8o9kaKAsHcDW7gLgyr5oUtP8U1X1TF
         nvIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9BuMHZCK/3y9CRDPc/hvQGRGcyrxlBAyc1hOdgLXm00=;
        b=r4V2NADs9RPYn06/qYRqtVR06FlY06L/n23HmMLMlHLemIuAu2gcUrK5pDfebIsHvQ
         hcMZW6Q7w6pG93jZKcxFnWGi5lp4ZIrYZZ9dH8ysreANVs0xZQdOL1Mg5OPUsxAFy2tm
         VVsjp2VrOMLthI2yhOOZpip0Xr5wZATWoMO9mzdfihYlZRxX4o1ugQa89ieDrU8Ka39c
         YmdKmJSmgrCV1PKbQWLfrWKTIav9kvYazm6ZWQf/Kbn2WY/RpjOLzQTqGn+2fIWRlcIQ
         FiUQy513HLQNQl4paBeXfZL40WvfMljo5o8vS/AJKob9+YAo+b7cQC9ja2g+GZgXfI5S
         +5KA==
X-Gm-Message-State: AOAM531QkorewC5Z9g86YPt7aF4ZGOJpQdfBHSTaBmNnXYLv36Ud37Ck
        D/V5Mbxxl2jWtLRH/kos8WU=
X-Google-Smtp-Source: ABdhPJw0x11pzvsMuKd49tG2SMsH2ee+sApVGIcd2qaDUbG+BKaXtsI7TMhOyCMZ5DSE49m5aNnwYg==
X-Received: by 2002:a65:5acf:: with SMTP id d15mr8036596pgt.217.1628971946947;
        Sat, 14 Aug 2021 13:12:26 -0700 (PDT)
Received: from xps.yggdrasil ([49.207.137.16])
        by smtp.gmail.com with ESMTPSA id r14sm6511132pff.106.2021.08.14.13.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Aug 2021 13:12:26 -0700 (PDT)
From:   Aakash Hemadri <aakashhemadri123@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Shuah Khan <skhan@foundation.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] PCI: Missing blank line after declarations
Date:   Sun, 15 Aug 2021 01:42:04 +0530
Message-Id: <7631ef94afd60f1e0ff90ada695db1bcf85bea40.1628957100.git.aakashhemadri123@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1628957100.git.aakashhemadri123@gmail.com>
References: <cover.1628957100.git.aakashhemadri123@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix checkpatch.pl WARNING: Missing a blank line after declarations

Signed-off-by: Aakash Hemadri <aakashhemadri123@gmail.com>
---
 drivers/pci/slot.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index 751a26668e3a..6ee4ccaf30b3 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -20,6 +20,7 @@ static ssize_t pci_slot_attr_show(struct kobject *kobj,
 {
 	struct pci_slot *slot = to_pci_slot(kobj);
 	struct pci_slot_attribute *attribute = to_pci_slot_attr(attr);
+
 	return attribute->show ? attribute->show(slot, buf) : -EIO;
 }
 
@@ -28,6 +29,7 @@ static ssize_t pci_slot_attr_store(struct kobject *kobj,
 {
 	struct pci_slot *slot = to_pci_slot(kobj);
 	struct pci_slot_attribute *attribute = to_pci_slot_attr(attr);
+
 	return attribute->store ? attribute->store(slot, buf, len) : -EIO;
 }
 
@@ -123,6 +125,7 @@ static char *make_slot_name(const char *name)
 
 	for (;;) {
 		struct kobject *dup_slot;
+
 		dup_slot = kset_find_obj(pci_slots_kset, new_name);
 		if (!dup_slot)
 			break;
-- 
2.32.0

