Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F1A417CCD
	for <lists+linux-pci@lfdr.de>; Fri, 24 Sep 2021 23:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346968AbhIXVNT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Sep 2021 17:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346959AbhIXVNS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Sep 2021 17:13:18 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A719FC061571;
        Fri, 24 Sep 2021 14:11:44 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t8so31254639wrq.4;
        Fri, 24 Sep 2021 14:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Wb71HqjEOUF7N4+48DrIALQ2aRBPLW7pWxHbo6fkmE=;
        b=BusIi8Wf3opfOwB9LOvTJkb0RBGN9c/AZMXhKEu4/Zd/WTaN08+/I75PzRUBOSkaoW
         e0EI+VltJpRJs0yUoDiq2JYVEUQGNuMf0SFb38p2kayOyEtoK/eCwcDrP5gRqU2UnCDl
         UUVFQLK9insrtEsq/sFDGKJjYrE2zMrGGiakhDn8H79RsS0YQOQgMA3Chl1Syecv+7cM
         B/2iF+pqUOMGWWOIZO1cQTKjC8VxOSJruJ+7+jwKVIafQcIOhL+P39juIlH1LgkcWJj9
         m+15mdSxhi5pDVGUh8eaYX1H4CnUuCfIvbMnomiLuN/cNbltXvHIOxe/T4da0YYuEi0K
         d/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Wb71HqjEOUF7N4+48DrIALQ2aRBPLW7pWxHbo6fkmE=;
        b=VM7ue101Txe19Zcfm+aI6OF4L0slqCd9WgJkZUDIVk1byawoIZxjSY3dpyoQTE3Xis
         Nl+CN0mGuGG1A3fdCPyAHuSbAHf3tU0WlfPKzkOiBCQLqQI5c+l/ZMiq1bTX7R4tiG84
         pYCX3xcXkJv/WQ4k5tLBxLiI0XDzDLpC7vThuTRqG+eahiXM0U9y6CVK8SSr3GsJTWQH
         TmxO7a2hco+mbMi3Pt2xg6ncy/m7AQ9yOTXVcc8gi1WnC4bDsuSN9w+/Gvz6W/EmC/Gb
         5KxIImyPadII/TMJ7GPYAO2Ymj9IjHTp2wj09OzYNuGUWGASsWUeqdwROGDHXkQbPeRB
         VlgA==
X-Gm-Message-State: AOAM530heSBBMo41Q08+4LvlngLev4TRStdJeDBJJJRdYJIcnWcnZ144
        g+F7d1DYE7tiHwITvJOFOCJnHijoj+M=
X-Google-Smtp-Source: ABdhPJwPb2VG2AAM5DJqJrFmCevyaxdyzhF4Xp4YRXzrfAKWASEzuLIa1qyzO7+829+r7vINf5tQXQ==
X-Received: by 2002:adf:ecc9:: with SMTP id s9mr14287341wro.2.1632517903364;
        Fri, 24 Sep 2021 14:11:43 -0700 (PDT)
Received: from localhost.localdomain (252.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.252])
        by smtp.gmail.com with ESMTPSA id y64sm10344297wmc.38.2021.09.24.14.11.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Sep 2021 14:11:43 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     tsbogend@alpha.franken.de
Cc:     robh@kernel.org, arnd@arndb.de, catalin.marinas@arm.com,
        Liviu.Dudau@arm.com, bhelgaas@google.com, matthias.bgg@gmail.com,
        gregkh@linuxfoundation.org, linux-mips@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-staging@lists.linux.dev,
        neil@brown.name, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] Revert "MIPS: ralink: don't define PC_IOBASE but increase IO_SPACE_LIMIT"
Date:   Fri, 24 Sep 2021 23:11:34 +0200
Message-Id: <20210924211139.3477-2-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210924211139.3477-1-sergio.paracuellos@gmail.com>
References: <20210924211139.3477-1-sergio.paracuellos@gmail.com>
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

