Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAF2318DFC0
	for <lists+linux-pci@lfdr.de>; Sat, 21 Mar 2020 12:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgCULWG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 21 Mar 2020 07:22:06 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37132 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgCULWG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 21 Mar 2020 07:22:06 -0400
Received: by mail-wr1-f67.google.com with SMTP id w10so10546932wrm.4;
        Sat, 21 Mar 2020 04:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wrykALwAZHn2gI4OIvSp4Cr1q7UfqoQL07MxjhgqGhI=;
        b=iokK+tj+ES8Dz+zcq6RpuEqINz9k7mZVDpnL+mOZkdhMW0Z2/zEhFQJ24GS11Yq7ms
         M7hSQuZrik3r6nZbAKLKKmmtMAmu1S2tgVHkKDuYxcjA3XdOQwM5OP17Px1MMjqiGfZd
         zmOrQoxr40OMSS2V2D4KLCFTo64Iu+GVX98to2jItoILC9ZoAizm5TBPkEPxCzZ5UDZv
         tmjPe5MCaRi8D3EObUeTdX+g8lxJEaM/3+xVO+rdU/CZ4rxtIMsCuBy55YGpMkaBi7os
         f0kwEiAhnLBbpPHTP9f1fl0BEVJ7x0KAnkD+b3JFtPY+Palrrr6ySVVuJCE2bhtyapgc
         +M+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wrykALwAZHn2gI4OIvSp4Cr1q7UfqoQL07MxjhgqGhI=;
        b=LKCDRZtdV4M38ZZ6RNZAU7Z0o7EyopJ8UrgcZmdh+PLKMS6ppONM5Di5NdkBloR8xU
         bgGJ05j0wM2rxD5J8z3bAZRc+u79TvkBfn7rNwVBDMbPoCSkhTwMP9VRbgXgI769f0te
         vILAA1IYTZAtmVMNlET9uNiySOdm6JTvq6zFqw9KYLZyNbBOSwLUDE0nFBkTuIf8UwWH
         cd+6bWisCMPWbxwudxAwfDP5pWKoBb/v5k4efy0MQ4aszzNWSlVNOkAPR2hdhaXku68z
         3uWBI9njVqcaCZsPJl+10MNHuxStw3+gHWjZBYvF1O1NMaUERdyx9QZgl3+B7nlj5pw8
         O+Rg==
X-Gm-Message-State: ANhLgQ0GEUlrBIRqaRvMPBPJSG8t30fgyaddTIu1tLba3XWbV0nhn8gU
        2FEQgog+QmTes1CWJXwrOcQ=
X-Google-Smtp-Source: ADFU+vvUdBv4IbyytOzeaYSUEhatmuthQBOlPFK2tmwCRSwKRlZbN1HaAN305D2qc31CAbtmwZ+XPQ==
X-Received: by 2002:adf:e345:: with SMTP id n5mr17736309wrj.220.1584789724226;
        Sat, 21 Mar 2020 04:22:04 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2510:d000:a04f:dbc7:8e23:adad])
        by smtp.gmail.com with ESMTPSA id x24sm11986616wmc.36.2020.03.21.04.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 04:22:03 -0700 (PDT)
From:   Lad Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lad Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] misc: pci_endpoint_test: remove duplicate macro PCI_ENDPOINT_TEST_STATUS
Date:   Sat, 21 Mar 2020 11:21:39 +0000
Message-Id: <20200321112139.17184-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI_ENDPOINT_TEST_STATUS is already defined in pci_endpoint_test.c along
with the status bits, so this patch drops duplicate definition.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 This patch applies on top of pci/endpoint branch [1].
 
 [1] https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git

 drivers/misc/pci_endpoint_test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index b536ca4b14ca..a1bb94902b5a 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -53,7 +53,6 @@
 #define STATUS_SRC_ADDR_INVALID			BIT(7)
 #define STATUS_DST_ADDR_INVALID			BIT(8)
 
-#define PCI_ENDPOINT_TEST_STATUS		0x8
 #define PCI_ENDPOINT_TEST_LOWER_SRC_ADDR	0x0c
 #define PCI_ENDPOINT_TEST_UPPER_SRC_ADDR	0x10
 
-- 
2.20.1

