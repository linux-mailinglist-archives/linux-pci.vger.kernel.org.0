Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C412250C75
	for <lists+linux-pci@lfdr.de>; Tue, 25 Aug 2020 01:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbgHXXjY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Aug 2020 19:39:24 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37090 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbgHXXjX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Aug 2020 19:39:23 -0400
Received: by mail-lj1-f193.google.com with SMTP id w14so11673436ljj.4
        for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2020 16:39:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P19COcW9VFSCcSArDZsGWHv7rSgtnEzm72g6mhefLIg=;
        b=CfsrYYLtcxre1Zdr/+2aC4IgGx+bsMvDrPU5tD1WNBaPN+PtkmAFRW0YfRc2A3eyMj
         JbsbwDb813+xWwkOo2Qei4w5zwWVFzcIZ8nrMzyZ7d3gUruAllgi9GjMjFtkg10YP/3a
         8eBdEyLdO0wDRI6RY47IAUu/kYho8TetvRhYNizExn6kRmv1ArXxjruIjK8TipH2Q+xZ
         zNGSE4hWhycpgbieAZpVJGYlAEj3ISiMLUKWfLhb9ydVhDA+aVx6P6c0fgqLwF/pEYea
         pulMhn6dErTjkdsw439465Zjmk5itelMd72ronmRiipaELGP6WkaItUgwd2O7QPbc1Qo
         uQ3A==
X-Gm-Message-State: AOAM532ltexeqh7fvWhPh+yeqBZdRyV9JbXDlCcTSIjByTtp012uo7g1
        r3Nn1IlPzpavLiyFCX/2byo=
X-Google-Smtp-Source: ABdhPJyUiX93v+vHJr4ZoXk3VfOl+tDDBcYBuPajekhZ3bj96obNBfVWjbDdOsgGrNQFeut5+Auy7Q==
X-Received: by 2002:a2e:8145:: with SMTP id t5mr3407776ljg.398.1598312361611;
        Mon, 24 Aug 2020 16:39:21 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id r6sm2492682lji.117.2020.08.24.16.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 16:39:21 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org
Subject: [PATCH 1/3] PCI: Replace use of snprintf() with scnprintf() in resource_alignment_show()
Date:   Mon, 24 Aug 2020 23:39:16 +0000
Message-Id: <20200824233918.26306-2-kw@linux.com>
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
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e39c5499770f..e6c904cbf983 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6350,7 +6350,7 @@ static ssize_t resource_alignment_show(struct bus_type *bus, char *buf)
 
 	spin_lock(&resource_alignment_lock);
 	if (resource_alignment_param)
-		count = snprintf(buf, PAGE_SIZE, "%s", resource_alignment_param);
+		count = scnprintf(buf, PAGE_SIZE, "%s", resource_alignment_param);
 	spin_unlock(&resource_alignment_lock);
 
 	/*
-- 
2.28.0

