Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0807E31C59D
	for <lists+linux-pci@lfdr.de>; Tue, 16 Feb 2021 03:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbhBPCkC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Feb 2021 21:40:02 -0500
Received: from m12-16.163.com ([220.181.12.16]:55920 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229713AbhBPCkC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Feb 2021 21:40:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=AARYkRayiGFTgZjLdJ
        EzuTfDkzsRTsvYgF8PsXcfCJ4=; b=drFmtWNh40sCp9tfsaZPGxvXvG6sFbf/bC
        iy9b8LoBWu23omZdqg/w89v+GMJN+McG17HLm9HXuM6tWwNXzruY6/IqLa8leQSG
        B0CMu20d8WSMhgQ9Io6hdmgDtqOBkoemayU3MCFXB4Wt/SS2P3cxa2oCaRVwyAFN
        XXFLg7HeU=
Received: from localhost.localdomain (unknown [125.70.193.99])
        by smtp12 (Coremail) with SMTP id EMCowADnOT7qLytgKjrYcA--.3200S2;
        Tue, 16 Feb 2021 10:37:33 +0800 (CST)
From:   Chen Lin <chen45464546@163.com>
To:     rjw@rjwysocki.net
Cc:     lenb@kernel.org, bhelgaas@google.com, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chen Lin <chen.lin5@zte.com.cn>
Subject: [PATCH] PCI: hotplug: Remove unused function pointer typedef acpiphp_callback
Date:   Tue, 16 Feb 2021 10:38:40 +0800
Message-Id: <1613443120-4279-1-git-send-email-chen45464546@163.com>
X-Mailer: git-send-email 1.7.9.5
X-CM-TRANSID: EMCowADnOT7qLytgKjrYcA--.3200S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr1UAr4kJr15GF43Wr48JFb_yoWfuFgEgF
        1Dtr17Kr15GFnakFn8Jw15ZFyjgay3uFyrWw48tFn3Ar48KrsxC3yUGw45ZF97AryYgF1j
        y347Xr1vyr97tjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0LvtJUUUUU==
X-Originating-IP: [125.70.193.99]
X-CM-SenderInfo: hfkh0kqvuwkkiuw6il2tof0z/xtbBdg47nlUMQAw9iAAAs9
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Chen Lin <chen.lin5@zte.com.cn>

Remove the 'acpiphp_callback' typedef as it is not used.

Signed-off-by: Chen Lin <chen.lin5@zte.com.cn>
---
 drivers/pci/hotplug/acpiphp.h |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp.h b/drivers/pci/hotplug/acpiphp.h
index a2094c0..a74b274 100644
--- a/drivers/pci/hotplug/acpiphp.h
+++ b/drivers/pci/hotplug/acpiphp.h
@@ -176,9 +176,6 @@ struct acpiphp_attention_info
 int acpiphp_register_hotplug_slot(struct acpiphp_slot *slot, unsigned int sun);
 void acpiphp_unregister_hotplug_slot(struct acpiphp_slot *slot);
 
-/* acpiphp_glue.c */
-typedef int (*acpiphp_callback)(struct acpiphp_slot *slot, void *data);
-
 int acpiphp_enable_slot(struct acpiphp_slot *slot);
 int acpiphp_disable_slot(struct acpiphp_slot *slot);
 u8 acpiphp_get_power_status(struct acpiphp_slot *slot);
-- 
1.7.9.5


