Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA9E21D6D5
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jul 2020 15:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730115AbgGMNYD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 09:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730019AbgGMNXU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jul 2020 09:23:20 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DA9C061755;
        Mon, 13 Jul 2020 06:23:18 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id dr13so17160086ejc.3;
        Mon, 13 Jul 2020 06:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ySb4cVyYF18JeJj5T0tFW5w6nctyAdZFTa9nqX2wG3w=;
        b=bzzU4rigZM9VgRrJDuA8G5wyBzew6OWrk1bRB1hncHk2DuUfRSXS9DugQIKc+P3SL2
         4q/JI8q53ZGvCgnkAgEVAwL2QWxLBuEmO6jpKHwClHiE+ceDHaXRFPmv3UeTlaDhUSpV
         Qd9OKdINsDyM83qMCnxqiVA17fifLRggAWNQsyb5vPCCVL1srTdbmNuNqUaJRmhsPYyp
         zJYRYPPNLE+A98f3jqiDrGLhVKlUw2xIDzN+eRfrWuJKy/NDKGQivQMgwjVEJHHqAEQ1
         YR5OC7esz4U91cA6VE8pdCHKVv1BLtr+EzJZsU41cXjZ672C4P+VU0M4ULWWghne2yto
         z+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ySb4cVyYF18JeJj5T0tFW5w6nctyAdZFTa9nqX2wG3w=;
        b=iLtbqfdYgCDHXI/Ns9fcjnNAlo3ZxDV/CAtxESQr4AVSmwd2OAHp7YaHNU0H9jQ/JY
         8On93cmMZHQxq3gff7kezpln9U0KThQOh1UNSoVLVJlQ+jGyt4w5xle+4kXUk+sscWhd
         ZFkqazMrIBfORQoY1jUuLw7jWCG9rXQU+PDaNp1iOQzjNJMh5Vt6UnCLTprBe+B9voKO
         GUUqaIb3mav62XlxXR+15jxugHKx5yfLyl3drLvJYZSh2lTLPPCbo4GWVpVjkF8o56gw
         FzASDcu8LB1aS+YjGqXYAo4ZU241tOinChDP8ibP21CAGKmfhBdkDJmSfdUtnt5tHzkI
         rr6Q==
X-Gm-Message-State: AOAM5335EscPJVlLI1NFSVivKG1hYyGDtAdVkEVwpmSZfMtdn03j2en1
        g38Wu4sZ/fHfRmigYoVrlhA=
X-Google-Smtp-Source: ABdhPJz3ndHhmUstEcyV1mn6y1reXaOd6GVIU3cHrLl2Y08PMWPQUjU3IZX1hl4wZmswvHyE2N4Y6Q==
X-Received: by 2002:a17:906:4dd4:: with SMTP id f20mr77157529ejw.170.1594646597332;
        Mon, 13 Jul 2020 06:23:17 -0700 (PDT)
Received: from net.saheed (54007186.dsl.pool.telekom.hu. [84.0.113.134])
        by smtp.gmail.com with ESMTPSA id n9sm11806540edr.46.2020.07.13.06.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 06:23:16 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org, Michal Simek <monstr@monstr.eu>
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 30/35] microblaze: Change PCIBIOS_SUCCESSFUL to 0
Date:   Mon, 13 Jul 2020 14:22:42 +0200
Message-Id: <20200713122247.10985-31-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200713122247.10985-1-refactormyself@gmail.com>
References: <20200713122247.10985-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In reference to the PCI spec (Chapter 2), PCIBIOS* is an x86 concept.
Their scope should be limited within arch/x86.

Change all PCIBIOS_SUCCESSFUL to 0

Signed-off-by: "Saheed O. Bolarinwa" <refactormyself@gmail.com>
---
 arch/microblaze/pci/indirect_pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/microblaze/pci/indirect_pci.c b/arch/microblaze/pci/indirect_pci.c
index 1caf7d3e0eef..1f04a1f2c30b 100644
--- a/arch/microblaze/pci/indirect_pci.c
+++ b/arch/microblaze/pci/indirect_pci.c
@@ -65,7 +65,7 @@ indirect_read_config(struct pci_bus *bus, unsigned int devfn, int offset,
 		*val = in_le32(cfg_data);
 		break;
 	}
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int
@@ -132,7 +132,7 @@ indirect_write_config(struct pci_bus *bus, unsigned int devfn, int offset,
 		break;
 	}
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static struct pci_ops indirect_pci_ops = {
-- 
2.18.2

