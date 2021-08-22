Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34CE53F405D
	for <lists+linux-pci@lfdr.de>; Sun, 22 Aug 2021 18:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234374AbhHVQKv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 22 Aug 2021 12:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234312AbhHVQKu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 22 Aug 2021 12:10:50 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F252C061575;
        Sun, 22 Aug 2021 09:10:09 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id l7-20020a1c2507000000b002e6be5d86b3so9130191wml.3;
        Sun, 22 Aug 2021 09:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9iPYiB9P0MXl5MIldnO2JAw/ZmMfLkJnaCtEYcgC+G0=;
        b=Nx/X6Mtx1X8yXKSqH60hv5xFiHTRjFdulRlVSrvCQnAzAfROfv1zaadiIT5IBZNM2q
         ZNzsgywSmdLY0LI+ld2dOM2IEjh7qG+jyrnW6IZC3ZoO1M6f0apZGYZpx2IErAkGawnR
         WGPKqdEGUp1Ai70OWTl4hDA04cfZLFtgcz7Szwq2fE6X8hhzGNJPbrS9H04FUuv+m2B6
         Oy2TnAsRm2WZrfNI17Xzc139Xdz1sIuZWGPepDlj25hVSTyOJHQgi1ZxtTiQpS3C3EP7
         89cCEqlky+/cNJaAUGaVSzLkc+Cspsp/SE0lEVWfwh2aA1gd1VWWgLAfebvDF6/B0FHl
         WH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9iPYiB9P0MXl5MIldnO2JAw/ZmMfLkJnaCtEYcgC+G0=;
        b=K3Ovuysgb1iNwQuyVsZukXslUNrwTbF8y8ncKJrdgNi+yXm0uhuIOBVxhLv192lUSi
         DQdzJJI/ObovPOIutqbRMe8VEY2KTRlKzwEruyP99VKx/OGf8OyJsfofIsdYLObmi5qA
         0yCQt6vb91mWIyJtUSsoJFLIGSqlxYax6vXw8qqgGwPYtxW8CAfh3yb0COoOOhpZWAUi
         ECVVrQN0M273rjx8B+5iIzqz4SUVjjcuaNXEbRXD8Ko9PWf42s8Nh2IfmwnODic9w55C
         WsOjclIhYTfPZmEzWJhWkG+narsnPdv0z0Y3W1O1J7yTKx4xmmjbIWyV0FQ+RWT6p2b/
         MWdw==
X-Gm-Message-State: AOAM530T5bMfqQ0VvQSc7ayNbSc+m6SM14E5VlVrN6tWVSSiO3CZmdvP
        wEAFO9DJBFANXMkq1Eln+Jw=
X-Google-Smtp-Source: ABdhPJyCY7IpuQyVLQmn1AHmTtihcWx5mRPyQ1CyFjU5AjrMeT2dn9KoGviyYoZvE7mx6Qam31mQ+g==
X-Received: by 2002:a1c:7714:: with SMTP id t20mr12544059wmi.175.1629648608189;
        Sun, 22 Aug 2021 09:10:08 -0700 (PDT)
Received: from localhost.localdomain (10.red-83-57-27.dynamicip.rima-tde.net. [83.57.27.10])
        by smtp.gmail.com with ESMTPSA id y11sm14861976wru.0.2021.08.22.09.10.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Aug 2021 09:10:07 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     tsbogend@alpha.franken.de
Cc:     bhelgaas@google.com, matthias.bgg@gmail.com,
        gregkh@linuxfoundation.org, linux-mips@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-staging@lists.linux.dev,
        neil@brown.name, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] MIPS: ralink: don't define PC_IOBASE but increase IO_SPACE_LIMIT
Date:   Sun, 22 Aug 2021 18:10:03 +0200
Message-Id: <20210822161005.22467-2-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210822161005.22467-1-sergio.paracuellos@gmail.com>
References: <20210822161005.22467-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Defining PCI_IOBASE results in pci resource handling working but the
addresses generated for IO accesses are wrong since the ioremap in the pci core
function 'pci_parse_request_of_pci_ranges' tries to remap to a fixed virtual
address (PC_IOBASE) which can't work for KSEG1 addresses. To get it working this
way, we would need to put PCI_IOBASE somewhere into KSEG2 which will result in
creating TLB entries for IO addresses, which most of the time isn't needed on
MIPS because of access via KSEG1. So avoid to define PCI_IOBASE and increase
IO_SPACE_LIMIT resource for ralink MIPS platform instead, to get valid IO
addresses for resources from pci core 'pci_address_to_pio' function.

Fixes: 222b27713d7f ("MIPS: ralink: Define PCI_IOBASE)
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 arch/mips/include/asm/mach-ralink/spaces.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/mach-ralink/spaces.h b/arch/mips/include/asm/mach-ralink/spaces.h
index 87d085c9ad61..31a3525213cf 100644
--- a/arch/mips/include/asm/mach-ralink/spaces.h
+++ b/arch/mips/include/asm/mach-ralink/spaces.h
@@ -2,9 +2,7 @@
 #ifndef __ASM_MACH_RALINK_SPACES_H_
 #define __ASM_MACH_RALINK_SPACES_H_
 
-#define PCI_IOBASE	_AC(0xa0000000, UL)
-#define PCI_IOSIZE	SZ_16M
-#define IO_SPACE_LIMIT	(PCI_IOSIZE - 1)
+#define IO_SPACE_LIMIT	0x1fffffff
 
 #include <asm/mach-generic/spaces.h>
 #endif
-- 
2.25.1

