Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3FDB426E
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2019 22:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbfIPUr4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Sep 2019 16:47:56 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39084 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732405AbfIPUr4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Sep 2019 16:47:56 -0400
Received: by mail-wr1-f67.google.com with SMTP id r3so837246wrj.6;
        Mon, 16 Sep 2019 13:47:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9mHQn9yr9ukPszYJrf03cNkjP7/MXLX6PUP4ZK8/EQw=;
        b=AsNs4BJ22RLrJfUZLd5+zl7vDYpqTPyLlH7LNo55QbbAsSiba41+32EkMl1y4WHyNL
         6jlotrJlCm5cfCqhqbz/idlPtwRQ6GS09BpA5e6om8X7KYyzNfx4mzUzOHkKvw1F6Osu
         VVH1coUrLZ9fLkAXDqKqq5WR2z9wxyFAbj5jXBc7l0EZdWUeMebBxxqGlsmhYf2ykmtI
         rTFdyJj4OJzD/bA7nZTScnpe43EcCO/LvOU9d5ryPX1GPj0Rsdx8l+WBntVXt1tN6r/H
         nr82aT5ja7eW9CO1Mk01B14gqZ57MnojzU3SLJF4DrtwBavqz6nM+oBd9XUMjlZqzvLz
         6hag==
X-Gm-Message-State: APjAAAV8wXlW/AvnFTZ43mBJhF9ure9i8yogRmcd5gNDf8/eYjN2C8Xs
        yhKZNK1JYlDBVrWPKtxOQ7A=
X-Google-Smtp-Source: APXvYqx33KDcFK0Om4/tnCLMJ86ojpQA68+cViMbTRgcRz3yunFkKYXsiLmKSzvLZ+f1yeXDeqcFuA==
X-Received: by 2002:adf:e7c2:: with SMTP id e2mr166037wrn.319.1568666874026;
        Mon, 16 Sep 2019 13:47:54 -0700 (PDT)
Received: from black.home (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id x6sm231437wmf.38.2019.09.16.13.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 13:47:53 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Andrew Murray <andrew.murray@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 26/26] devres: use PCI_STD_NUM_BARS
Date:   Mon, 16 Sep 2019 23:41:58 +0300
Message-Id: <20190916204158.6889-27-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190916204158.6889-1-efremov@linux.com>
References: <20190916204158.6889-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use define PCI_STD_NUM_BARS instead of PCI_ROM_RESOURCE for the number of
PCI BARs.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 lib/devres.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/devres.c b/lib/devres.c
index 6a0e9bd6524a..ab75d73122b8 100644
--- a/lib/devres.c
+++ b/lib/devres.c
@@ -262,7 +262,7 @@ EXPORT_SYMBOL(devm_ioport_unmap);
 /*
  * PCI iomap devres
  */
-#define PCIM_IOMAP_MAX	PCI_ROM_RESOURCE
+#define PCIM_IOMAP_MAX	PCI_STD_NUM_BARS
 
 struct pcim_iomap_devres {
 	void __iomem *table[PCIM_IOMAP_MAX];
-- 
2.21.0

