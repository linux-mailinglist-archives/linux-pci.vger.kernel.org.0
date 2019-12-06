Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D912C1158CE
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2019 22:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfLFVxB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Dec 2019 16:53:01 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33918 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfLFVxB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Dec 2019 16:53:01 -0500
Received: by mail-ot1-f66.google.com with SMTP id a15so7144408otf.1
        for <linux-pci@vger.kernel.org>; Fri, 06 Dec 2019 13:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gigaio-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=+yZ096ffWoHnZdWk0Lurkki+m3tHoPGT4v3BuDAq9y8=;
        b=wwnS9lpSGYXNU751TKNSEEFm01hjPd79P9VTRnMmQ0LR8F83CcA/CVrLrWiBQh1T0I
         2d2ChQi0rXW32iJDcUIvYBhTTrPFocQ1cv7GTYeIUSaONtBzPqfLNr8mMkMgR2jjSN1e
         UrggbQmYrvEJm2qTrmwt9pjG2BA48VehiiYof4pmhc+Zh5Dxk6bIkDUqwPxShyAkSd1Q
         lKKcjgZKFJ4D5T812aCLEykad1+2GnOsAqFwjMhHySFui4G66RPqeaZvxj9YWbCcv/5H
         kMryqrzlGVM0Y3R75rhiR20WQ6259u5RfNZLHj+IKtZf65E8qrjJlpFFX8vgH++H0h02
         +7uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+yZ096ffWoHnZdWk0Lurkki+m3tHoPGT4v3BuDAq9y8=;
        b=egXQ9NmUMVx5gnuZUqh7djE9bHJuC+ucNe9lnB/HXXiCI++HtSkwlX8udNBw6XGScF
         YkxbVRvu6lIeLp8fdnuEkexKab7KEG97RxVWzxiwWcp/rNKiCxwSqwP+cidfX3sQqTmW
         RgQU+JaL0QMfnsiqTfyutDAyG4UovAxPk6Mv6q0RZP/se4Yl+vxpTN7B4MDLPkIvowKM
         c1e/SJr5F56FQLCeipKHp8EYSUHgpbgpFi4GLd4uV0lV1HsE53hXjN9MUxQ0flMzZ05C
         gzA2e3ax+wxdG8CyV3hLtJflkklvYgIPxDroDDu6FYM6Bbc/ghB8xQUzAxwVehQkf9tU
         WliA==
X-Gm-Message-State: APjAAAWiKkhZQFO0jRIrV9qm7Xfjz/W4zUIYQbAuj8V/gUZKAME1wPv+
        5ZspvZN3z1SybE4bGCngg57/mQ==
X-Google-Smtp-Source: APXvYqxkQ6TbhDKMhqAMLlD4skRGcaQbVJLyySOxTgEg9abnB3lXyVynFeTe9feXDast4Ymr4gnuFA==
X-Received: by 2002:a05:6830:1f35:: with SMTP id e21mr13481123oth.229.1575669180636;
        Fri, 06 Dec 2019 13:53:00 -0800 (PST)
Received: from lowers.gigaio.com ([12.235.129.34])
        by smtp.gmail.com with ESMTPSA id p24sm5125992oth.28.2019.12.06.13.52.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Dec 2019 13:53:00 -0800 (PST)
From:   Armen Baloyan <abaloyan@gigaio.com>
To:     logang@deltatee.com, armbaloyan@gmail.com, epilmore@gigaio.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org
Cc:     Armen Baloyan <abaloyan@gigaio.com>
Subject: [PATCH] PCI/P2PDMA: Add Intel SkyLake-E to the whitelist
Date:   Fri,  6 Dec 2019 13:52:45 -0800
Message-Id: <1575669165-31697-1-git-send-email-abaloyan@gigaio.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Intel SkyLake-E was successfully tested for p2pdma
transactions spanning over a host bridge and PCI
bridge with IOMMU on.

Signed-off-by: Armen Baloyan <abaloyan@gigaio.com>
---
 drivers/pci/p2pdma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 79fcb8d8f1b1..9f8e9df8f4ca 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -324,6 +324,9 @@ static const struct pci_p2pdma_whitelist_entry {
 	/* Intel Xeon E7 v3/Xeon E5 v3/Core i7 */
 	{PCI_VENDOR_ID_INTEL,	0x2f00, REQ_SAME_HOST_BRIDGE},
 	{PCI_VENDOR_ID_INTEL,	0x2f01, REQ_SAME_HOST_BRIDGE},
+	/* Intel SkyLake-E. */
+	{PCI_VENDOR_ID_INTEL,	0x2030, 0},
+	{PCI_VENDOR_ID_INTEL,	0x2020, 0},
 	{}
 };
 
-- 
2.16.5

