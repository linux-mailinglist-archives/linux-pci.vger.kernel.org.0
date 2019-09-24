Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF2FABD47A
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2019 23:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731714AbfIXVqh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Sep 2019 17:46:37 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46651 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730387AbfIXVqh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Sep 2019 17:46:37 -0400
Received: by mail-ot1-f68.google.com with SMTP id f21so2876244otl.13
        for <linux-pci@vger.kernel.org>; Tue, 24 Sep 2019 14:46:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nUMQJjbKdzG8fJovseyEjJTdZDpiXcUeaTLwPOLfwVY=;
        b=RQuMKbyqXLEgRcmiPO6t/OJEcUnzJPvGH91v4LKVvt9lBHYy5CYNDmBVMF40QWLlh7
         GFpSsrkTs/9Jf0Wy+j/6nic2plSUhBqbIZW2EOj8nVksFldXewcopITQ05F9Njt+dbH3
         l9Vs+glOvB7CjcP1Pp4VddjQboWQq8kUCZiaO6pvRZ7IPGUNMFzgSQGWFq6OMuCeHPBe
         QBmKbZReZUqgH3viI8k01oHEgHmq/oxfSDWxiGAvpeOdOA1Hh7E9B5iVmumR+AYZcBbK
         RqoYJV+q+YqU22W6KXFj6LU8w3in7BK6xRa7AHSgZeIwtnxTwgIc6S7O61kPfpWhBJdF
         nObA==
X-Gm-Message-State: APjAAAU5AdbuNAr6ZXQKL+n3zto4R7Md9VQP6zK98byjohge5cLyLok6
        eXvWpSKE7Y7+F1jTcNJYkqlIjuE=
X-Google-Smtp-Source: APXvYqyg7yvUFOkUsVxlA7key/e9KBKgkSIx3+rHguO4P9+U7CNTQzvdx4bwLQPOpg+DK1Jj4MZmnw==
X-Received: by 2002:a9d:6c4d:: with SMTP id g13mr3465796otq.95.1569361596591;
        Tue, 24 Sep 2019 14:46:36 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id s66sm976787otb.65.2019.09.24.14.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 14:46:36 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org
Subject: [PATCH 04/11] PCI: versatile: Enable COMPILE_TEST
Date:   Tue, 24 Sep 2019 16:46:23 -0500
Message-Id: <20190924214630.12817-5-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924214630.12817-1-robh@kernel.org>
References: <20190924214630.12817-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since commit a574795bc383 ("PCI: generic,versatile: Remove unused
pci_sys_data structures") the build dependency on ARM is gone, so let's
enable COMPILE_TEST for versatile.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index fe9f9f13ce11..14836229357e 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -135,7 +135,7 @@ config PCI_V3_SEMI
 
 config PCI_VERSATILE
 	bool "ARM Versatile PB PCI controller"
-	depends on ARCH_VERSATILE
+	depends on ARCH_VERSATILE || COMPILE_TEST
 
 config PCIE_IPROC
 	tristate
-- 
2.20.1

