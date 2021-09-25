Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD37418073
	for <lists+linux-pci@lfdr.de>; Sat, 25 Sep 2021 10:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235512AbhIYIsZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Sep 2021 04:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbhIYIsX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Sep 2021 04:48:23 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F76BC061740;
        Sat, 25 Sep 2021 01:46:48 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id i24so18623397wrc.9;
        Sat, 25 Sep 2021 01:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=17lAPdZ/wrC5MQWHWYujyp8BZtV5RPbk2EUbs/RKr5Y=;
        b=oFNoN7WuFkLkL4Gbhxk9ErtpomJ5l4gZxKbX39MGxDRQspEYedNasXU80Ma+WnQnK9
         pJC36nZcvyPPvvKo4zR5iXzjuwXsYJUUl1oPCcnhhTzHfUrpcYmx0aBH+9AaKEjeeCg6
         BLehZGKfRl24MSHQleIeKVkRxLnxslWpNI9pmO6jwSNyBY3NX5Y0+OucRmvM9GGpTlKd
         JymiB70g2KdAMsgvLqjdabT/h6e0wTiqQynrhbtb6/zjStg0ZnBeZRckHeU841lPNXBA
         m4zH7e4TaxSTNV44nUhWHzyXqzM8PUeOQhG2mGwShkQPbVdHNkHZIzp6xpyXb95PkxiO
         gfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=17lAPdZ/wrC5MQWHWYujyp8BZtV5RPbk2EUbs/RKr5Y=;
        b=Qne5gxbwP920cufWK2MlLYkjDpAqgwlWrKuMLwM0adEQMd4Cg5wQ79XlhuqbSXY04N
         e7UHFZ7ZiQhlqX1VeZp3Sw6xLzKzoDIM5n4/jiJH7qFbv5pucLkMjlCWxAqjqZ469uWM
         tg0tA38QR279ANRMuZH/X0aMt+aMX3++sOkHLbRUxg5qxxCGKNAaqUAnv0Yg2+EGTeXe
         ldDtCvJ9KKMtrMggCo6AeB2LLuGxH6RK+G/uh9FO3RLHgMl8hqm+dhtUkkczhsM5nexN
         ZGWdUzzE+xky78QJJEoyUWaJgcOgy+RC9k9rjrX99cHHVeTzDR1JF2ccj5NTPKtaKKop
         vU8Q==
X-Gm-Message-State: AOAM530qWW4OyX9ZCuprcEBv21a/imKFxiWT5z61I8USE0q/AsYRmiLI
        OmGjw0fcGv2GaBJGOXg3WPM=
X-Google-Smtp-Source: ABdhPJw6v5mraRqYTfIkNChWpvs73b6BY/vyVc7/YjnI1vijps0erveCsIWOw7ofbOwqV8nesCDApg==
X-Received: by 2002:a1c:a713:: with SMTP id q19mr5984719wme.42.1632559607176;
        Sat, 25 Sep 2021 01:46:47 -0700 (PDT)
Received: from localhost.localdomain (252.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.252])
        by smtp.gmail.com with ESMTPSA id y9sm17222997wmj.36.2021.09.25.01.46.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Sep 2021 01:46:46 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     tsbogend@alpha.franken.de
Cc:     robh@kernel.org, arnd@arndb.de, catalin.marinas@arm.com,
        Liviu.Dudau@arm.com, bhelgaas@google.com, matthias.bgg@gmail.com,
        gregkh@linuxfoundation.org, linux-mips@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-staging@lists.linux.dev,
        neil@brown.name, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] MIPS: ralink: set PCI_IOBASE to 'mips_io_port_base'
Date:   Sat, 25 Sep 2021 10:46:38 +0200
Message-Id: <20210925084642.5642-4-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210925084642.5642-1-sergio.paracuellos@gmail.com>
References: <20210925084642.5642-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

By default MIPS architecture use function 'set_io_port_base()' to set the
virtual address of the first IO port. This function at the end sets variable
'mips_io_port_base' with the desired address. To align things and allow
to change first IO port location address for PCI, set PCI_IOBASE definition
as 'mips_io_port_base'.

Fixes: 222b27713d7f ("MIPS: ralink: Define PCI_IOBASE")
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 arch/mips/include/asm/mach-ralink/spaces.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/mach-ralink/spaces.h b/arch/mips/include/asm/mach-ralink/spaces.h
index 87d085c9ad61..05d14c21c417 100644
--- a/arch/mips/include/asm/mach-ralink/spaces.h
+++ b/arch/mips/include/asm/mach-ralink/spaces.h
@@ -2,8 +2,8 @@
 #ifndef __ASM_MACH_RALINK_SPACES_H_
 #define __ASM_MACH_RALINK_SPACES_H_
 
-#define PCI_IOBASE	_AC(0xa0000000, UL)
-#define PCI_IOSIZE	SZ_16M
+#define PCI_IOBASE	mips_io_port_base
+#define PCI_IOSIZE	SZ_64K
 #define IO_SPACE_LIMIT	(PCI_IOSIZE - 1)
 
 #include <asm/mach-generic/spaces.h>
-- 
2.25.1

