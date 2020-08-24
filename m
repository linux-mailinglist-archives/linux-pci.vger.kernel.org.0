Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D276250C76
	for <lists+linux-pci@lfdr.de>; Tue, 25 Aug 2020 01:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbgHXXjZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Aug 2020 19:39:25 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36575 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgHXXjY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Aug 2020 19:39:24 -0400
Received: by mail-lj1-f194.google.com with SMTP id t23so11679906ljc.3
        for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2020 16:39:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jp4ZW19wcAcbEH/gWJvRffmIis6xins/9BDzCqpNFyE=;
        b=r3VHseRUU3J2uSgdGKXdNfMVeeX4PMqmXBrudPjX0xVdWP8FLRTi4HY9W68eNuV7Go
         H7u4QN5a4YZ1DwqRD9zqWu7aLnqd12bMaobH4CEg5DpjZnWmJJUTi4tiaSu0zEVh1iNN
         O10aoP4ygy2YDwFnAsZaMZUMIg/IFhHumzXwORjGRHSQKwvr6qkNvATuEdnBZsKg9uPk
         rIiDkA1jk0hGcwfobVr/XyhCBv6qdAPCEJCYDyoTzkmIcnLOEZuRJJRa5alvQ6wWLINR
         rDWW54DnN8Dq5Zzz6kux45g9Jt0KuL3MMGGjLT7n+2xn8JxjbiBqXu3CcMTb4W06HzHr
         V/3A==
X-Gm-Message-State: AOAM530Ct/dRvGSGa7fqZntPioUdiAc8Ot2c8dFsa+0romJXeHpXkQVT
        zwNObZSGzbQGELLO+D/IaMqjwgW4fqvZKQ==
X-Google-Smtp-Source: ABdhPJwSWmal8w/tvBd5F9q3kroyfbHD10FxDXo+emrjrsmF0cTS6B+SEPd4CK2ExAx1+8WiyGr/nQ==
X-Received: by 2002:a2e:3503:: with SMTP id z3mr3394047ljz.336.1598312362583;
        Mon, 24 Aug 2020 16:39:22 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id r6sm2492682lji.117.2020.08.24.16.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 16:39:21 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org
Subject: [PATCH 2/3] PCI: sysfs: Replace use of snprintf() with scnprintf() in driver_override_show()
Date:   Mon, 24 Aug 2020 23:39:17 +0000
Message-Id: <20200824233918.26306-3-kw@linux.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824233918.26306-1-kw@linux.com>
References: <20200824233918.26306-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Replace use of snprintf() with scnprintf() in order to adhere to the
rules in Documentation/filesystems/sysfs.txt, as per:

  show() must not use snprintf() when formatting the value to be
  returned to user space. If you can guarantee that an overflow
  will never happen you can use sprintf() otherwise you must use
  scnprintf().

There is no change to the functionality.

Related:
  https://patchwork.kernel.org/patch/9946759/#20969333
  https://lwn.net/Articles/69419

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/pci-sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 6d78df981d41..ed66d387e913 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -574,7 +574,7 @@ static ssize_t driver_override_show(struct device *dev,
 	ssize_t len;
 
 	device_lock(dev);
-	len = snprintf(buf, PAGE_SIZE, "%s\n", pdev->driver_override);
+	len = scnprintf(buf, PAGE_SIZE, "%s\n", pdev->driver_override);
 	device_unlock(dev);
 	return len;
 }
-- 
2.28.0

