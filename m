Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A1E490645
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jan 2022 11:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238773AbiAQKwE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jan 2022 05:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbiAQKwD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jan 2022 05:52:03 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94109C061574;
        Mon, 17 Jan 2022 02:52:03 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id g22so17297405edu.1;
        Mon, 17 Jan 2022 02:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=iHEJ7aPY/vyeKyL4IrOawGrgT3E6eTiteUfS/PavmY4=;
        b=iNs8s0CIp2CW6jnGcysUC78KZIW+mkhe0ZFvEoskbn8MWlnCvVZUN/x1kuv4qNCwRM
         4UFcXcdtVje0rjHeSe/zxw4B1tSdUHFu7JHGNfH71IrOmB4SVhk6EFS1o2M7u6Iahrhp
         RAJjZfPvOA4yAPzIBTH0yjXopMVWU10Nn2ZuuA4nq2QQvow8tznS6up9JHfdIeH52O3P
         E6KNmieCeAkI3CQVrPwo+GGnSZoG5LXIp4sKbqPoL5zbVwC6qGBfXXeTQ/zO2e/dbqJ5
         hGmYhADMo0v5F1zv8AoT03I4ZjrV9tQ8SSc54vmmQXichYhqtQBYD8bn3hFR3OcpQIez
         FIMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=iHEJ7aPY/vyeKyL4IrOawGrgT3E6eTiteUfS/PavmY4=;
        b=7eaoF91+Q6Ej8jYJS8YaWDVuixPSqCygNRT8TBrQQ7Tz0XR1Kf/UtqHYRXbMiEW00q
         aH2wIHW3k932Y5NBUfWzriT3WMXxvD/zKC+mi7MoXw46pHss5fwN8KKvyVDlZ9/G9wBJ
         28cchUgGs0M5bBvA4iCDbdz/AxmgAq0FkXceBOjdrEBSc531rY4tNZNWVJiBVgwSbJgJ
         H+2V9c4JgU7X/LYLvhw/02Og6jwtU5OCTQZoLkPOTwWl0FIVrr5wAu/gtIBdso3+8PTf
         IIli40VaDVnOZXAoGityznATSv284jneM74ss2M3K2NtH/iJUMBKEJ4IpFtTpdgxb/u/
         u2mA==
X-Gm-Message-State: AOAM5327YO7vPiDxAay90+8WYfV3Mmkq9Rc7XLtK8mTt6pJLZDyemCsI
        4Uvk6CsHkykJmxDpjTyyJVw=
X-Google-Smtp-Source: ABdhPJwcz89uAhbQ/PxhSMbS21X8jl1M0muLAE1r3yiBA67LZ9Flhk0/FBGVIdrdxh9dIiq8jUK3dg==
X-Received: by 2002:a05:6402:d0a:: with SMTP id eb10mr20155973edb.48.1642416722143;
        Mon, 17 Jan 2022 02:52:02 -0800 (PST)
Received: from ?IPV6:2003:ea:8f2f:5b00:cd6d:ebf4:94e9:c321? (p200300ea8f2f5b00cd6debf494e9c321.dip0.t-ipconnect.de. [2003:ea:8f2f:5b00:cd6d:ebf4:94e9:c321])
        by smtp.googlemail.com with ESMTPSA id l25sm2951078edc.20.2022.01.17.02.52.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 02:52:01 -0800 (PST)
Message-ID: <cadbd4eb-40bb-1fa8-1e00-dc95dab62295@gmail.com>
Date:   Mon, 17 Jan 2022 11:51:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] PCI: Forbid RPM on ACPI systems before 5.0 only
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently PCI core forbids RPM and requires opt-in from userspace,
apart from few drivers calling pm_runtime_allow(). Reason is that some
early ACPI PM implementations conflict with RPM, see [0].
Note that as of today pm_runtime_forbid() is also called for non-ACPI
systems. Maybe it's time to allow RPM per default for non-ACPI systems
and recent enough ACPI versions. Let's allow RPM from ACPI 5.0 which
was published in 2011.

[0] https://lkml.org/lkml/2020/11/17/1548

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/pci.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 428afd459..26e3a500c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3101,7 +3101,12 @@ void pci_pm_init(struct pci_dev *dev)
 	u16 status;
 	u16 pmc;
 
-	pm_runtime_forbid(&dev->dev);
+#ifdef CONFIG_ACPI
+	/* Some early ACPI PM implementations conflict with RPM. */
+	if (acpi_gbl_FADT.header.revision > 0 &&
+	    acpi_gbl_FADT.header.revision < 5)
+		pm_runtime_forbid(&dev->dev);
+#endif
 	pm_runtime_set_active(&dev->dev);
 	pm_runtime_enable(&dev->dev);
 	device_enable_async_suspend(&dev->dev);
-- 
2.34.1

