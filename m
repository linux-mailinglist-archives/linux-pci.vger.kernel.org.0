Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8C7418461
	for <lists+linux-pci@lfdr.de>; Sat, 25 Sep 2021 22:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhIYUeE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Sep 2021 16:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbhIYUeD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Sep 2021 16:34:03 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19E7C061575;
        Sat, 25 Sep 2021 13:32:28 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id i23so38360199wrb.2;
        Sat, 25 Sep 2021 13:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Wb71HqjEOUF7N4+48DrIALQ2aRBPLW7pWxHbo6fkmE=;
        b=HbiIavrACDoPKKGhz91lnyYOWGe+guXmTlZquxkI+ZWBKrxLN2/KuJ6/036mrWsj+b
         TJul81dnFl8GpexEDl4/rSHBDjMyDYC46nEcQ0xZhv9W8IhKKUvXXqaxVwHyx9r2s5U7
         sGZdEmY1D0uzn5Lcf+F4qcZqIvdN6ZG/sVcpiiQVQ+aER12Z9MM/Je/7Ty/ybpbwp9ty
         ntYHBjzaFVHLGHnZgrAIkCMl+Nx8CmaKp99Q5NqqO7tcpehbZ2vadJJPq0w7Y2QUCw+q
         vetDxGuzNgJoKejT/vGWa2dRDBEF5FcY568KoHosPRa1M9vAowSufNEd0w4TqW85hKf3
         9kkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Wb71HqjEOUF7N4+48DrIALQ2aRBPLW7pWxHbo6fkmE=;
        b=CKWLfitnOm23uWO89djO0IwYunX5RyyBsShJnfw9KfZo8gsHSQHydi0BlUUMajYEl7
         VHui7jhgUZIa3PNYfHnTCL+SfPwn+ALtKvFQtb2HInNgn8MUWknSDTLo+5e1UMHhBNz3
         vC99VNtBrhRQ+Yzeg32xMsCeo7oWpd7LFdlQa5Y4d6xlgTCQqLK0bz+lkcNao9e0K9JH
         C9+anpwxk1dbIGSGDy3Xb3zIVYNX73qfyx/HkRCM1X4xzlm0fUIHf7Asbe4T8d/cmOU7
         6/U8rjsHMCzQ91QDqRt6s0lDFm/SBhaU4dts6NhRp1N+kKizZazR3gzjApz3uLAJPQWx
         A8aw==
X-Gm-Message-State: AOAM533ZOWZ+LyDcbKbOTNo4H21z57qYZqK3lPGHfUSwlrtnrfjPf1sD
        O87Gd7Sq5O8XvZCKJDEq/kg=
X-Google-Smtp-Source: ABdhPJzicsFl8kGv0kXGzP2vQVihQ9IDXNPh1hRIUUYF38RKGOcv/+47W7tmg6FpSgAZOb2nJPTX/w==
X-Received: by 2002:a5d:56c4:: with SMTP id m4mr18860182wrw.225.1632601947300;
        Sat, 25 Sep 2021 13:32:27 -0700 (PDT)
Received: from localhost.localdomain (252.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.252])
        by smtp.gmail.com with ESMTPSA id a202sm16703279wmd.15.2021.09.25.13.32.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Sep 2021 13:32:26 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     tsbogend@alpha.franken.de
Cc:     robh@kernel.org, arnd@arndb.de, catalin.marinas@arm.com,
        Liviu.Dudau@arm.com, bhelgaas@google.com, matthias.bgg@gmail.com,
        gregkh@linuxfoundation.org, linux-mips@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-staging@lists.linux.dev,
        neil@brown.name, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/6] Revert "MIPS: ralink: don't define PC_IOBASE but increase IO_SPACE_LIMIT"
Date:   Sat, 25 Sep 2021 22:32:19 +0200
Message-Id: <20210925203224.10419-2-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210925203224.10419-1-sergio.paracuellos@gmail.com>
References: <20210925203224.10419-1-sergio.paracuellos@gmail.com>
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

