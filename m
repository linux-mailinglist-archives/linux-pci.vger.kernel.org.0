Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F22728CC2
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2019 23:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388466AbfEWV5j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 May 2019 17:57:39 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38534 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387701AbfEWV5j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 May 2019 17:57:39 -0400
Received: by mail-pf1-f196.google.com with SMTP id b76so3986972pfb.5
        for <linux-pci@vger.kernel.org>; Thu, 23 May 2019 14:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=5bG8FDPCw5QDc0u1AHZFZoHnM7vNJL8HNA0ePZzdpDk=;
        b=Fl3Pw/aWVCJMn6SdFWbo1CqRqGB0mnVIW3e7yT0Jp6ccc/IaYhJGmLRABpEpkm4chI
         hzN1v219lL1YsQYsp8ulmY3B7xLKFqj+lHIIPnadVhUbsM1kceLOAUawiv/G4mx8sror
         d3mgOjFFOkJjmEG08rzXgIEcVizuEjC23kgWJoheQr2kmJWyapUxyxsN55q8T5Mz3arE
         A33k6AviekRkWiRb7uTEoj6NDqlxJYfQaEv7m5ZbfSUqcS+uRBsGdZcO7ruHsqiydTy0
         O8ju2Wgv+gipF2XFbz6z/arhAzMKA5M30weGAWeVW/ApnJcLxzNUYkrQjkDBZ//BkRrf
         tjHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5bG8FDPCw5QDc0u1AHZFZoHnM7vNJL8HNA0ePZzdpDk=;
        b=bnS8nT2lKpL3l0wLjstItUns4Fj2hPdSMXWxYE8004B+gIJVPgSAzLrEfF8f60RUqW
         dgZNZ3XMLlS8L0C1Xbb2tQHlyGADwRha68ReWfzMUxZBt40h/rovqf8ibY/XH0Aq4YWC
         i5ed6DFfT3dYnSSXHx8byasnIzprSYfZxXJFSrvP2OFmHixA5JyfI2mK6y/CW9PgvzrV
         3i6sFQdlqssdAP7jQ4DUOOCLuXi6Kcve9a3mxEny/gnpOkT/EhdtzKNw8FWXmRg5sgrp
         bEpSG2Y5jy/HzcUGurWwBpx4hoZd/isRETmgmV5xiFrAk3wjE1BCQHqCwscQKtWiEcOp
         9xZw==
X-Gm-Message-State: APjAAAUmKZHIpJ5t1CNOHXD6HKgT1lpAYGZrjehl1KWMKjAaIIjOe6cL
        0gYyHkGLlDwxnLp8hYl7QGD6+1ffIIg=
X-Google-Smtp-Source: APXvYqxPKvovRIfrtaL1O8c2k6QXUDaH/Pjn7UuZ6wkFFjX1eXQhHuYnrqOEHn9sDUqRH4JPFj1wjQ==
X-Received: by 2002:a63:1e5b:: with SMTP id p27mr100433871pgm.213.1558648658166;
        Thu, 23 May 2019 14:57:38 -0700 (PDT)
Received: from nuc7.sifive.com ([12.206.222.2])
        by smtp.gmail.com with ESMTPSA id n37sm321966pjb.0.2019.05.23.14.57.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 May 2019 14:57:37 -0700 (PDT)
From:   Alan Mikhak <alan.mikhak@sifive.com>
X-Google-Original-From: Alan Mikhak < alan.mikhak@sifive.com >
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kishon@ti.com, lorenzo.pieralisi@arm.com,
        linux-riscv@lists.infradead.org, palmer@sifive.com,
        paul.walmsley@sifive.com
Cc:     Alan Mikhak <alan.mikhak@sifive.com>
Subject: [PATCH v2] PCI: endpoint: Clear BAR before freeing its space
Date:   Thu, 23 May 2019 14:57:27 -0700
Message-Id: <1558648647-14324-1-git-send-email-alan.mikhak@sifive.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Associated pci_epf_bar structure is needed in pci_epc_clear_bar() but
would be cleared in pci_epf_free_space(), if called first, and BAR
would not get cleared.

Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 27806987e93b..f81a219dde5b 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -381,8 +381,8 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
 		epf_bar = &epf->bar[bar];
 
 		if (epf_test->reg[bar]) {
-			pci_epf_free_space(epf, epf_test->reg[bar], bar);
 			pci_epc_clear_bar(epc, epf->func_no, epf_bar);
+			pci_epf_free_space(epf, epf_test->reg[bar], bar);
 		}
 	}
 }
-- 
2.7.4

