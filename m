Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC44B77F7D2
	for <lists+linux-pci@lfdr.de>; Thu, 17 Aug 2023 15:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351521AbjHQNeu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Aug 2023 09:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351508AbjHQNea (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Aug 2023 09:34:30 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E8D125;
        Thu, 17 Aug 2023 06:34:29 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5280ef23593so536960a12.3;
        Thu, 17 Aug 2023 06:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692279267; x=1692884067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JR0Q0d09hsKTDKbYA0pjf4pzrGdAoGkqv4iO4jpul4I=;
        b=AbcKmlqeyGsSF/u8D5HOpGj/IEmB2NzJ8HHpFlEBNEQ2vJ0SCZHQa9EG9+3BOw36gh
         tvlBhyAKc46muuBZcE84F+fl018ZhsfmNVxoLf3QKyGZSu4HPsSWOPwxeIzyik17Mx23
         9r1MuF5ehJHYXRD9mDq7wlmgnDvFnJwJkHXVRHXMYBiq8LXPzRV6EiVJs9yzp4Xw09NO
         I4MytnE5UqT6ufIQdxJ7L62SutQTxIzSDSkdaJxUURD+hE3gbz3jfc6YB6gVolS0pamq
         tEwoE8ATPrAexOCCFJOoEp5H9Ds+caG0ChbsijeA7QOeOAM0nVPvSAaMj/FYye0csQIZ
         VNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692279267; x=1692884067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JR0Q0d09hsKTDKbYA0pjf4pzrGdAoGkqv4iO4jpul4I=;
        b=k5Hn8Wuw11YjqmDB4xgqYE8tKhCbJP0WCj0YKI8UI5sdzfNrpesYkIWoSr5Eszs+fO
         WU8r/wEhMou+UUTAcsV9M5dH3+0Q6U0tYZMZv6Ma47iqHuo9wt4uc/+IGuflVA762xw7
         msThbTulSsdDsPhIRr9SlWqxteT6+6Ur7uXyjWrtvbH5VClCo+GKo1UwEDiYL8whh0gq
         CLV21njjiV7SwO+lTYbHKqD7zLkwioTLplqtWyHv7fxA0Mn7z05eMOXRRw3+48mEvW/t
         0hKOevAXiD+RfQjxBsrqBG2JOA+Okod0+/zIMVL8UvmKu/UAVs5er9gzWy7xEkhJys6k
         d32Q==
X-Gm-Message-State: AOJu0YwqVl1hCQmpnzO/DNNXue0Tq8Z5kZgiaWzRAjJKU98BuqY6hWbu
        SwPa1fP3++2kBx4h3Ip0cXs=
X-Google-Smtp-Source: AGHT+IH0NYrAIF80Ft5V6M0HW4OOQ/tqZky3HFMVT64UREfIeJb7VFg6HoBjKY3mhepnvtjU4h4VYQ==
X-Received: by 2002:a50:e70b:0:b0:523:38ea:48bb with SMTP id a11-20020a50e70b000000b0052338ea48bbmr4142072edn.24.1692279267291;
        Thu, 17 Aug 2023 06:34:27 -0700 (PDT)
Received: from A13PC04R.einet.ad.eivd.ch ([193.134.219.72])
        by smtp.googlemail.com with ESMTPSA id n4-20020aa7d044000000b00523eff8f3eesm7934963edo.80.2023.08.17.06.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 06:34:26 -0700 (PDT)
From:   Rick Wertenbroek <rick.wertenbroek@gmail.com>
To:     rick.wertenbroek@heig-vd.ch
Cc:     dlemoal@kernel.org, Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: endpoint: Return error code when callback is not implemented
Date:   Thu, 17 Aug 2023 15:33:41 +0200
Message-Id: <20230817133341.212747-1-rick.wertenbroek@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Return an error code when the callback for an endpoint controller
function is not implemented (is null). Among all the functions, only
map_msi_irq() had an error returned if the callback was null. Extend
this error handling to other functions as well.

Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
---
 drivers/pci/endpoint/pci-epc-core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 5a4a8b0be626..14f4256b9410 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -196,7 +196,7 @@ int pci_epc_start(struct pci_epc *epc)
 		return -EINVAL;
 
 	if (!epc->ops->start)
-		return 0;
+		return -EINVAL;
 
 	mutex_lock(&epc->lock);
 	ret = epc->ops->start(epc);
@@ -228,7 +228,7 @@ int pci_epc_raise_irq(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 		return -EINVAL;
 
 	if (!epc->ops->raise_irq)
-		return 0;
+		return -EINVAL;
 
 	mutex_lock(&epc->lock);
 	ret = epc->ops->raise_irq(epc, func_no, vfunc_no, type, interrupt_num);
@@ -340,7 +340,7 @@ int pci_epc_set_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no, u8 interrupts)
 		return -EINVAL;
 
 	if (!epc->ops->set_msi)
-		return 0;
+		return -EINVAL;
 
 	encode_int = order_base_2(interrupts);
 
@@ -408,7 +408,7 @@ int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 		return -EINVAL;
 
 	if (!epc->ops->set_msix)
-		return 0;
+		return -EINVAL;
 
 	mutex_lock(&epc->lock);
 	ret = epc->ops->set_msix(epc, func_no, vfunc_no, interrupts - 1, bir,
@@ -469,7 +469,7 @@ int pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 		return -EINVAL;
 
 	if (!epc->ops->map_addr)
-		return 0;
+		return -EINVAL;
 
 	mutex_lock(&epc->lock);
 	ret = epc->ops->map_addr(epc, func_no, vfunc_no, phys_addr, pci_addr,
@@ -537,7 +537,7 @@ int pci_epc_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 		return -EINVAL;
 
 	if (!epc->ops->set_bar)
-		return 0;
+		return -EINVAL;
 
 	mutex_lock(&epc->lock);
 	ret = epc->ops->set_bar(epc, func_no, vfunc_no, epf_bar);
@@ -575,7 +575,7 @@ int pci_epc_write_header(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 		return -EINVAL;
 
 	if (!epc->ops->write_header)
-		return 0;
+		return -EINVAL;
 
 	mutex_lock(&epc->lock);
 	ret = epc->ops->write_header(epc, func_no, vfunc_no, header);
-- 
2.25.1

