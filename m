Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28CBF21EDBA
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jul 2020 12:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgGNKQL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jul 2020 06:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgGNKQK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jul 2020 06:16:10 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F438C061755
        for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2020 03:16:10 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id f5so21743915ljj.10
        for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2020 03:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=FPHneS2Wgi7Yu+9Efua6HrCu2110FaGhfqlfbGbLXBE=;
        b=UrGcdK3GamcoHcLzv9WMqXxfKBMIvM4kbuDtiqyWKNJgcnfEJWNoB5sftrqkyTaOMC
         pr9q2AgvFZdnkl6M0H8xdtw8N52MrtX9KoGF1VYg6+VX8n7g+th2MEWwA827O+Z4Xpi5
         G05CZHfbh11MlPhD5DfTIwgvVKPbJYYe5sf669PJcp5UQdalf+P2HX2oPN5gHAaoxOMM
         ShOgYpxoEV5HrnIhXJwiZB6HsobnF1ig1d/B0zKyL8+HYulPSR+rG9xhaJqfWU9RTngT
         3j7XZLKWkiiYUI0UrvdxBVbnhLBC2+RLLPZJLrzPNWKvzGwoLlboDAJG4kSIiYDCJv7F
         AN+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=FPHneS2Wgi7Yu+9Efua6HrCu2110FaGhfqlfbGbLXBE=;
        b=any5MmiBh9SaLWsDVdbRdzXRrSB2yn8fHatHrfdNrj2prlqr9aez3E+Kyh+dKfM+mG
         e/uqWJodkrYtYXSZQR8DrDXLuqIdLs9oLWW/jUJjha14joic+6bX/3WlNB56CB6SD+hf
         txxbjgXuejEc0pm2FlUG0vnYCbuVAd2bpCSrUHitlf5Zc1zVaG+wLoH13m3tGKRevX0I
         XZ972ms7DVRsiTm3lNhDQwdHKwGfH1ImswE7WkiLnG45+KolK11Pu6RsxKJeUMrIyXX2
         ZYhl2sHm4s8jVwg5Z8K04PAXfjbQlvU+9prcPY+hMIHCQE2xODVrEcxnDKNZRmcmxYQx
         eOPQ==
X-Gm-Message-State: AOAM532vFflGgJkaoI8lX3pvuv9kGWtz8iHzdJYf8j29RWb4/ngE3kRo
        i7poglh2GWvUbbC9RuVh/CW1V8UFr1Q=
X-Google-Smtp-Source: ABdhPJw6sadvpJDeTuOjLrc2k2/J8BV1a8bY1VEnv+ZS853T2R1sCVCy218AtQ6Po1PHgcP15OWbAg==
X-Received: by 2002:a2e:571c:: with SMTP id l28mr1897531ljb.432.1594721767911;
        Tue, 14 Jul 2020 03:16:07 -0700 (PDT)
Received: from [192.168.0.110] ([178.71.129.223])
        by smtp.gmail.com with ESMTPSA id r25sm6194105ljg.9.2020.07.14.03.16.06
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 03:16:07 -0700 (PDT)
To:     linux-pci@vger.kernel.org
From:   =?UTF-8?B?0KDRg9GB0LvQsNC9INCY0YHQsNC10LI=?= <ubijca16@gmail.com>
Subject: [PATCH] pci: ibmphp: Remove unused functions get_max_adapter_speed(),
 and get_bus_name() in ibmphp_core.c
Message-ID: <4b9310fa-f030-b82c-1440-fe2a3a39e21d@gmail.com>
Date:   Tue, 14 Jul 2020 13:16:04 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

These functions are commented out and because of that, are unused.

Signed-off-by: Ruslan Isaev <ubijca16@gmail.com>
---
  drivers/pci/hotplug/TODO          |  5 ---
  drivers/pci/hotplug/ibmphp_core.c | 74 -------------------------------
  2 files changed, 79 deletions(-)

diff --git a/drivers/pci/hotplug/TODO b/drivers/pci/hotplug/TODO
index a32070be5adf..856535858ddf 100644
--- a/drivers/pci/hotplug/TODO
+++ b/drivers/pci/hotplug/TODO
@@ -30,11 +30,6 @@ ibmphp:
    or ibmphp should store a pointer to its bus in struct slot. Probably the
    former.

-* The functions get_max_adapter_speed() and get_bus_name() are 
commented out.
-  Can they be deleted?  There are also forward declarations at the top of
-  ibmphp_core.c as well as pointers in ibmphp_hotplug_slot_ops, likewise
-  commented out.
-
  * ibmphp_init_devno() takes a struct slot **, it could instead take a
    struct slot *.

diff --git a/drivers/pci/hotplug/ibmphp_core.c 
b/drivers/pci/hotplug/ibmphp_core.c
index 17124254d897..197997e264a2 100644
--- a/drivers/pci/hotplug/ibmphp_core.c
+++ b/drivers/pci/hotplug/ibmphp_core.c
@@ -50,14 +50,6 @@ static int irqs[16];    /* PIC mode IRQs we're using 
so far (in case MPS

  static int init_flag;

-/*
-static int get_max_adapter_speed_1 (struct hotplug_slot *, u8 *, u8);
-
-static inline int get_max_adapter_speed (struct hotplug_slot *hs, u8 
*value)
-{
-    return get_max_adapter_speed_1 (hs, value, 1);
-}
-*/
  static inline int get_cur_bus_info(struct slot **sl)
  {
      int rc = 1;
@@ -401,69 +393,6 @@ static int get_max_bus_speed(struct slot *slot)
      return rc;
  }

-/*
-static int get_max_adapter_speed_1(struct hotplug_slot *hotplug_slot, 
u8 *value, u8 flag)
-{
-    int rc = -ENODEV;
-    struct slot *pslot;
-    struct slot myslot;
-
-    debug("get_max_adapter_speed_1 - Entry hotplug_slot[%lx] 
pvalue[%lx]\n",
-                        (ulong)hotplug_slot, (ulong) value);
-
-    if (flag)
-        ibmphp_lock_operations();
-
-    if (hotplug_slot && value) {
-        pslot = hotplug_slot->private;
-        if (pslot) {
-            memcpy(&myslot, pslot, sizeof(struct slot));
-            rc = ibmphp_hpc_readslot(pslot, READ_SLOTSTATUS,
-                        &(myslot.status));
-
-            if (!(SLOT_LATCH (myslot.status)) &&
-                    (SLOT_PRESENT (myslot.status))) {
-                rc = ibmphp_hpc_readslot(pslot,
-                        READ_EXTSLOTSTATUS,
-                        &(myslot.ext_status));
-                if (!rc)
-                    *value = SLOT_SPEED(myslot.ext_status);
-            } else
-                *value = MAX_ADAPTER_NONE;
-        }
-    }
-
-    if (flag)
-        ibmphp_unlock_operations();
-
-    debug("get_max_adapter_speed_1 - Exit rc[%d] value[%x]\n", rc, *value);
-    return rc;
-}
-
-static int get_bus_name(struct hotplug_slot *hotplug_slot, char *value)
-{
-    int rc = -ENODEV;
-    struct slot *pslot = NULL;
-
-    debug("get_bus_name - Entry hotplug_slot[%lx]\n", (ulong)hotplug_slot);
-
-    ibmphp_lock_operations();
-
-    if (hotplug_slot) {
-        pslot = hotplug_slot->private;
-        if (pslot) {
-            rc = 0;
-            snprintf(value, 100, "Bus %x", pslot->bus);
-        }
-    } else
-        rc = -ENODEV;
-
-    ibmphp_unlock_operations();
-    debug("get_bus_name - Exit rc[%d] value[%x]\n", rc, *value);
-    return rc;
-}
-*/
-
  /****************************************************************************
   * This routine will initialize the ops data structure used in the 
validate
   * function. It will also power off empty slots that are powered on 
since BIOS
@@ -1231,9 +1160,6 @@ const struct hotplug_slot_ops 
ibmphp_hotplug_slot_ops = {
      .get_attention_status =        get_attention_status,
      .get_latch_status =        get_latch_status,
      .get_adapter_status =        get_adapter_present,
-/*    .get_max_adapter_speed =    get_max_adapter_speed,
-    .get_bus_name_status =        get_bus_name,
-*/
  };

  static void ibmphp_unload(void)
-- 
2.27.0.windows.1


