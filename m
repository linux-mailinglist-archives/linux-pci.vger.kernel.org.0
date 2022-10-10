Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D55E5FA0D5
	for <lists+linux-pci@lfdr.de>; Mon, 10 Oct 2022 17:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiJJPCT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Oct 2022 11:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiJJPCN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Oct 2022 11:02:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96C35005B
        for <linux-pci@vger.kernel.org>; Mon, 10 Oct 2022 08:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665414131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=EJVKwLqocd1P/QUyrxFovCUhzEl6J8XeKirmLR8bowg=;
        b=BaFrpqdSIJXZHjZXvrAmgrKk4Ro+K3Ne7d70exA8NtXZKcs7UUneY3uXEbS/lSNi/L0mko
        ELNgSWf/+N4GsiF9TnMaCtdQH6WvmZN73GcUhUgGpmcnLg6Qb1X9hLh/WE8dqWQFFkTVNM
        WB53VSl5iysEEG7vnGLhKSdS1ISRf1I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-343--nR8o2z9MhWoRKLRJMsrzg-1; Mon, 10 Oct 2022 11:02:08 -0400
X-MC-Unique: -nR8o2z9MhWoRKLRJMsrzg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 59A52901850;
        Mon, 10 Oct 2022 15:02:08 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.192.179])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 66B4FC2C8CC;
        Mon, 10 Oct 2022 15:02:07 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linuxkernelml@undead.fr,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH] x86/PCI: Disable E820 reserved region clipping for Clevo NL4XLU laptops
Date:   Mon, 10 Oct 2022 17:02:06 +0200
Message-Id: <20221010150206.142615-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Clevo NL4XLU barebones have the same E820 reservation covering
the entire _CRS 32-bit window issue as the Lenovo *IIL* and
Clevo X170KM-G models, relevant dmesg bits (with pci=no_e820):

 BIOS-e820: [mem 0x000000005bc50000-0x00000000cfffffff] reserved
 pci_bus 0000:00: root bus resource [mem 0x6d800000-0xbfffffff window]

Note how the e820 reservation covers the entire PCI root mem window.

Add a no_e820 quirk for these models to fix the touchpad not working
(due to Linux being unable to assign a PCI BAR for the i2c-controller).

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216565
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/x86/pci/acpi.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 2f82480fd430..45ef65d31a40 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -189,6 +189,19 @@ static const struct dmi_system_id pci_crs_quirks[] __initconst = {
 			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
 		},
 	},
+
+	/*
+	 * Clevo NL4XLU barebones have the same E820 reservation covering
+	 * the entire _CRS 32-bit window issue as the Lenovo *IIL* models.
+	 * See https://bugzilla.kernel.org/show_bug.cgi?id=216565
+	 */
+	{
+		.callback = set_no_e820,
+		.ident = "Clevo NL4XLU Barebone",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "NL4XLU"),
+		},
+	},
 	{}
 };
 
-- 
2.37.3

