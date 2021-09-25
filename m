Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA6A441806F
	for <lists+linux-pci@lfdr.de>; Sat, 25 Sep 2021 10:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235235AbhIYIsY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Sep 2021 04:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232623AbhIYIsX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Sep 2021 04:48:23 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766D4C061604;
        Sat, 25 Sep 2021 01:46:46 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u18so34622741wrg.5;
        Sat, 25 Sep 2021 01:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Wb71HqjEOUF7N4+48DrIALQ2aRBPLW7pWxHbo6fkmE=;
        b=Qb6/ebapboRHy2oxDc5q5VKXIVMIzbT8rHvoiG93lXdmxmyV273iAip7+DFT0TVWM5
         ThMCV4WQlTJfLBbPiCfXIXrJA+e96NvGpyT95pOLeR3cszXHWgK2d8/As056yObw/s6M
         hBjmb5+F0HSPxeHaF0FLKZPtLGQozqNac0tueZCGYo7UOMd3hYdqcE6RuDodhjH/GXPj
         yrP3re6Inavf+6pMuFQroemIGz8qiVLjKUDfqEPscF1uaWd2S0EoRyMplFmIPrxwEwj/
         qnTWTlTcLcoAyrZFOJI1TGPOB1aOisEOkqccb1yPx/J3qng3JIS/vMOoJDNWnxHHfYVt
         4/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Wb71HqjEOUF7N4+48DrIALQ2aRBPLW7pWxHbo6fkmE=;
        b=at+kVPorqhycMtWAWCwzC+j8cFKuIY1cf2ov1Hpg0K4avfLAo+iEtCihGmPXeHzOPm
         kjOzMruVHmCMYM3snY8EYXjl1zQmpLYsPrsUzifTV/7g73E+zgWOHJKPQofGtH826+h2
         j+XFCxQTsBPbwVdRuiVFuLCxVoT5MRsIT6ZNBqso7a0nFZDfUQcFBAHAkHsCEu5eiiB5
         Myuhj61occ7zCSechmRyFNSWshPJvnH0uutK+6DkCHfh8XBNSECaHBkvqOFZ4La35pOk
         z6ZTvZiRfCDj3xDr/mws0q04TaifwsVpTQD5twLy2/woirq1RAAdYqWIu+T0sbhX32Kt
         59qQ==
X-Gm-Message-State: AOAM531xEYfLfEjC0/rx1N2jc8BKlFRjzV12dkNbVSvXL6rqcGWUmNzR
        FOWQcWrdyg+Oarlv2Yjkbds=
X-Google-Smtp-Source: ABdhPJyHw1n6sTAwD4+nW7+bDwyTqs/z8xs5p4MbTYREbctn6X5pxMdGperx/5q5l/rxf4lfJ0zo1A==
X-Received: by 2002:a05:600c:17d1:: with SMTP id y17mr6282479wmo.135.1632559605031;
        Sat, 25 Sep 2021 01:46:45 -0700 (PDT)
Received: from localhost.localdomain (252.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.252])
        by smtp.gmail.com with ESMTPSA id y9sm17222997wmj.36.2021.09.25.01.46.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Sep 2021 01:46:44 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     tsbogend@alpha.franken.de
Cc:     robh@kernel.org, arnd@arndb.de, catalin.marinas@arm.com,
        Liviu.Dudau@arm.com, bhelgaas@google.com, matthias.bgg@gmail.com,
        gregkh@linuxfoundation.org, linux-mips@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-staging@lists.linux.dev,
        neil@brown.name, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] Revert "MIPS: ralink: don't define PC_IOBASE but increase IO_SPACE_LIMIT"
Date:   Sat, 25 Sep 2021 10:46:36 +0200
Message-Id: <20210925084642.5642-2-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210925084642.5642-1-sergio.paracuellos@gmail.com>
References: <20210925084642.5642-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This reverts commit 159697474db41732ef3b6c2e8d9395f09d1f659e.

There is no real need to increase IO_SPACE_LIMIT if PCI_IOBASE
is properly set to 'mips_io_port_base'. Hence revert this commit
first before doing anything else.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 arch/mips/include/asm/mach-ralink/spaces.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/mach-ralink/spaces.h b/arch/mips/include/asm/mach-ralink/spaces.h
index 31a3525213cf..87d085c9ad61 100644
--- a/arch/mips/include/asm/mach-ralink/spaces.h
+++ b/arch/mips/include/asm/mach-ralink/spaces.h
@@ -2,7 +2,9 @@
 #ifndef __ASM_MACH_RALINK_SPACES_H_
 #define __ASM_MACH_RALINK_SPACES_H_
 
-#define IO_SPACE_LIMIT	0x1fffffff
+#define PCI_IOBASE	_AC(0xa0000000, UL)
+#define PCI_IOSIZE	SZ_16M
+#define IO_SPACE_LIMIT	(PCI_IOSIZE - 1)
 
 #include <asm/mach-generic/spaces.h>
 #endif
-- 
2.25.1

