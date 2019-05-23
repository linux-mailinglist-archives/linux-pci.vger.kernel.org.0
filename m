Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8A3B28CA6
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2019 23:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388335AbfEWVsM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 May 2019 17:48:12 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34054 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388404AbfEWVsL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 May 2019 17:48:11 -0400
Received: by mail-pl1-f195.google.com with SMTP id w7so3270380plz.1
        for <linux-pci@vger.kernel.org>; Thu, 23 May 2019 14:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=cRjsWIBkFu7xChKc5ODPWxRtyAuuqlLwnhGlual1d7o=;
        b=Zhdv63Etq9ZqvxrpKVb9soHIGj0Q24oISvjDjej3wPUUd/Cnb+UldZiZtfrDTaIgu4
         k/3l6z4swcOXGNbr7U7MmMkvFFMhvHlsvYBN1lmFjkeK6VbWXm5sjP1aWe9DSHu1k1fH
         +cN0PVDMxA8slbCi7HJThOcm7ANy2YsLJFyrzLpf3iC3NXZ/pUASClHd3DQAmJYekNSX
         u5PpK/415fxUlaYwU1eLb6sqZCWwrUM4eIeYNMam/BkP+B1PYCzfQsTmmVxb+B6ApH+H
         bd7TG4fOrpjsWnsZoHWIFNl/habsr+Nqb1HSaXiq0no7Go4qLaX7JC+frOnhw9DqukLe
         ySFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cRjsWIBkFu7xChKc5ODPWxRtyAuuqlLwnhGlual1d7o=;
        b=GiwDqwWWHgqCSHCF1a+02EmqDu5z7B1BWSHMgoNQapW/nenQhfpctCOiH0A7af32yi
         spOmlGeSfyHbx9ShsnH0g8NLyRWvdZs0Rnu6e7e/oY9a89aHK+6mqPhl5ml7NoXNrYm1
         zbT880SHBNjDBTmPDBZbp0f2AEhbMcPOXSBejiBZVrAEhg1/7goE20bW+KD/0yqdKAGD
         xAJZj9Ozc3b5kn33b/P4KC48TkkPkrb0eQ4WHou6MV56uTD3ehrMecyl9onXB2/GGj5z
         0Lazy3L1SHh6ZI3iNjFItvCIypbm+K5zz8TWA6/j2gEZMX7j/Y5hVmD5NAgeSXbtbjOD
         dGtA==
X-Gm-Message-State: APjAAAUsDANBBkgGOaj6HLInrSp9sCZmLXclyQ4VTxvWfREJLZceiuS0
        88nuCnQmGV392LjGB6Etgch3fhSDxzc=
X-Google-Smtp-Source: APXvYqwYpmQE4QulweV//CaaANh0ZzjwCj5mOtvZC5LJ9Go4sqfKX4lZUjjLrMyvaVKS4b5H7zgJWw==
X-Received: by 2002:a17:902:4e:: with SMTP id 72mr49493273pla.80.1558648091144;
        Thu, 23 May 2019 14:48:11 -0700 (PDT)
Received: from nuc7.sifive.com ([12.206.222.2])
        by smtp.gmail.com with ESMTPSA id f22sm280757pgl.25.2019.05.23.14.48.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 May 2019 14:48:10 -0700 (PDT)
From:   Alan Mikhak <alan.mikhak@sifive.com>
X-Google-Original-From: Alan Mikhak < alan.mikhak@sifive.com >
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kishon@ti.com, lorenzo.pieralisi@arm.com,
        linux-riscv@lists.infradead.org, palmer@sifive.com,
        paul.walmsley@sifive.com
Cc:     Alan Mikhak <alan.mikhak@sifive.com>
Subject: [PATCH v2] PCI: endpoint: Allocate enough space for fixed size BAR
Date:   Thu, 23 May 2019 14:47:59 -0700
Message-Id: <1558648079-13893-1-git-send-email-alan.mikhak@sifive.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI endpoint test function code should honor the .bar_fixed_size parameter
from underlying endpoint controller drivers or results may be unexpected.

In pci_epf_test_alloc_space(), check if BAR being used for test register
space is a fixed size BAR. If so, allocate the required fixed size.

Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 27806987e93b..7d41e6684b87 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -434,10 +434,16 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 	int bar;
 	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
 	const struct pci_epc_features *epc_features;
+	size_t test_reg_size;
 
 	epc_features = epf_test->epc_features;
 
-	base = pci_epf_alloc_space(epf, sizeof(struct pci_epf_test_reg),
+	if (epc_features->bar_fixed_size[test_reg_bar])
+		test_reg_size = bar_size[test_reg_bar];
+	else
+		test_reg_size = sizeof(struct pci_epf_test_reg);
+
+	base = pci_epf_alloc_space(epf, test_reg_size,
 				   test_reg_bar, epc_features->align);
 	if (!base) {
 		dev_err(dev, "Failed to allocated register space\n");
-- 
2.7.4

