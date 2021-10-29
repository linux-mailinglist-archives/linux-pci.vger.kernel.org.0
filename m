Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F464403B8
	for <lists+linux-pci@lfdr.de>; Fri, 29 Oct 2021 22:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbhJ2UGD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Oct 2021 16:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbhJ2UGA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Oct 2021 16:06:00 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A309C061570;
        Fri, 29 Oct 2021 13:03:31 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id r28so10933062pga.0;
        Fri, 29 Oct 2021 13:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GIjfy/tGNtent3A9GnfPiCrIze+injINArkbcqn2zVE=;
        b=p+oAlOuiUVwiubxNDXtb5Ls8Dz9z5SXr5I3LZ0YJHmrSlX48A0HxNxBvlGEE8wAI3Y
         X8FJ1uRcQUhwBDqord3ZjwqnuHclhvoxY3jodljBl3RliRFfz/dx9cPcfAUIqd9Xth8K
         2IuDrxzx+LdsTVm6t/UxMozCExb/+dK5nypbOpmiFkT4Ve65enJZF5b4lej6hP8dCvVd
         ZdgReamjmkybX8X4Corsg4kw42BRiS7/GXkcm6+PieHDkoFo8VjdzEsmu/uwjyQigJPG
         jPK6mqDCxnd2UaUz+XfcOWB19PMdYL+eek1NfIo577KdxJBlCGJEYFJL1uMGmjEU7T3f
         +8bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GIjfy/tGNtent3A9GnfPiCrIze+injINArkbcqn2zVE=;
        b=vf5Q8Yb9zuk05EIfRHmV2WjDyF5vbbqPXl79p4SSZmx90WIUkCZ6NQHQrfKZn3gv4z
         zNuPHdming7RZmZXOCW3SmiIbj9ba0eMjY+rxFxuqkiHKPpI17ieDFK5aGVC4uPOL2oq
         BmRJQraFX4X4KUeFViEqbJQgyxk/gX2IEe46PErGwIHesVQLtOPoen6vF2reSkPiWZvN
         7Fl13hay1pq4/LvhU1wZiL1JIH4tjz0yil0YS48sxsue0Jye4MCEW8IaS5tfRovZblG2
         nfKsvtYE8Zx6ntSzOPN/h4E7Ej2uQhomYLorX5+mb0zc6/TDZOvvoERilB6jZJ//8XLa
         9kbQ==
X-Gm-Message-State: AOAM531aeO4dDHURp+2KH6UR+gZ4oonSwvqOZkWbQ9YRu2FMYdIAONze
        8QYoaUFjOXrT+13UhhipMRgfyfEUxlRqGg==
X-Google-Smtp-Source: ABdhPJzxj7D8qpXxRVKpPoqOezXeQnpGkTqP0uawpq/cR8dn5DTZHWuwbA8spZhKN+VcNvbp0+yUsA==
X-Received: by 2002:aa7:8b49:0:b0:44d:65a9:fb9d with SMTP id i9-20020aa78b49000000b0044d65a9fb9dmr12897641pfd.24.1635537810877;
        Fri, 29 Oct 2021 13:03:30 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id j16sm8775041pfj.16.2021.10.29.13.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 13:03:30 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 3/9] PCI: move pci_device_add() call
Date:   Fri, 29 Oct 2021 16:03:11 -0400
Message-Id: <20211029200319.23475-4-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211029200319.23475-1-jim2101024@gmail.com>
References: <20211029200319.23475-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Move call to pci_device_add() from pci_scan_single_device() to
pci_scan_device().  No other functions call pci_scan_device() so
this should be harmless.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/probe.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index d9fc02a71baa..f3fc807b4fe8 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2391,6 +2391,7 @@ static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
 		kfree(dev);
 		return NULL;
 	}
+	pci_device_add(dev, bus);
 
 	return dev;
 }
@@ -2540,13 +2541,7 @@ struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn)
 		return dev;
 	}
 
-	dev = pci_scan_device(bus, devfn);
-	if (!dev)
-		return NULL;
-
-	pci_device_add(dev, bus);
-
-	return dev;
+	return pci_scan_device(bus, devfn);
 }
 EXPORT_SYMBOL(pci_scan_single_device);
 
-- 
2.17.1

