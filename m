Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9B89327838
	for <lists+linux-pci@lfdr.de>; Mon,  1 Mar 2021 08:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbhCAHWq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Mar 2021 02:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbhCAHWo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Mar 2021 02:22:44 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0094BC061756;
        Sun, 28 Feb 2021 23:22:03 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id u11so9274251plg.13;
        Sun, 28 Feb 2021 23:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IThTwekI4XM8rq4lBOf5YlVybHfLGC0F77zKTFbjBzM=;
        b=Ia8PGxrFRL5mZwYtVG0IeKrFiFgYtlTXY1xeWlHq/QI0MtoV4rGUPdIfR9WV4VsQg/
         LaLUxaJWbl+9FDWBDxji3crtd2YA2U8F9zMqXQMbwMbGjHKuOsSwv/eG3QqdmJPofMWB
         ayjlGevbDfHqjnlRibgqyPVnZGHNXQYLmHNcroq7PR1h10QifR7DlTh3icetXFI4AOvc
         e+06J+br4ouPCzX1QSWdaQu+h9E0loXQxLUMg1Ni8RBn4nvYE3pUOeqzou39xIAMwpQV
         vNKRnooxzOb+d9DRsK0pGs83iZNATgVSF9F86Z4HzHa2W/mqsCxsbli1aZ5YtNuMr4S7
         9FtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IThTwekI4XM8rq4lBOf5YlVybHfLGC0F77zKTFbjBzM=;
        b=X4b/3Zdt0EfiW8FmZWDrGQDy6Ym58Am4IZ6L2F+z2H2+8OtQRpef0aGQBg/OHefiXl
         A9wSr9vp3ocH9R2BJXWGV6KIWeb58e/v6WfJfE+guVLTT6HtVc6vXMx6sG+YJpXHF+ux
         tjcGXwRqVFctVY/lnH134hKX8RDK2JQ97U+wTxAgkBQ8iraUjxRrRvm95hRsDJt/d9sQ
         KP2otBNwt5f6YYdDv2xfXZcZ+UoPuT0AQUyafj7t2fAah49BegGhvGQk5Z1Ck75y22qT
         R11VzHQ209xCuWKisLmhIKy94b+3sv6SzoC9DZGqlFhfS6aX5jEJIWNgH1QtA+pAL+6f
         /FoQ==
X-Gm-Message-State: AOAM531zPrM010cIhc+B3ymS6WmRdAhMGeP0P9hg+H+YNy/Fo2rC4MIt
        NaXwylTsQKaIKqbdJcuRlS0koze0Kxmmew==
X-Google-Smtp-Source: ABdhPJyWCkfDfK317QY++613co0oSVnhflBb5cDANGa7DfX0jIbqjSSOaJx+HPw0Tdk/vLOk86YNhw==
X-Received: by 2002:a17:902:edcb:b029:df:cce5:1105 with SMTP id q11-20020a170902edcbb02900dfcce51105mr14651251plk.2.1614583323544;
        Sun, 28 Feb 2021 23:22:03 -0800 (PST)
Received: from rayare.domain.name ([106.51.141.71])
        by smtp.googlemail.com with ESMTPSA id r123sm16512994pfc.211.2021.02.28.23.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 23:22:03 -0800 (PST)
From:   chakravarthikulkarni <chakravarthikulkarni2021@gmail.com>
Cc:     chakravarthikulkarni2021@gmail.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: acpiphp:  Fixed coding style
Date:   Mon,  1 Mar 2021 12:51:45 +0530
Message-Id: <20210301072145.19018-1-chakravarthikulkarni2021@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In this commit fixed coding style for braces and comments.

Signed-off-by: chakravarthikulkarni <chakravarthikulkarni2021@gmail.com>
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

