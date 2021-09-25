Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84AE4418465
	for <lists+linux-pci@lfdr.de>; Sat, 25 Sep 2021 22:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhIYUeG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Sep 2021 16:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbhIYUeG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Sep 2021 16:34:06 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC403C061570;
        Sat, 25 Sep 2021 13:32:30 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id t8so38336755wrq.4;
        Sat, 25 Sep 2021 13:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uSEYmLllNjJftf9n5AprTfaaSYD64ry9qHpFZHlSP5E=;
        b=mK9eDOopE4EeNRjuJv79Vfu0yg1xqvz1s1EEyvjCOHsg5UuI90jlrsxHA0ICR0xRZi
         Advw48cgO/XZjkSf/CP1jzDIAi5R+VgbDKMoQjGnAZOq+UDSP1itc/QHbNeC/npV/fyX
         y4QSZJuf7xRmpFiLoO1Il5dAyyrjE3I0eN5JEYbSA8eVMvRVzzbYsVJzcclDtNhO+uGi
         EvqhX5msauPSAJ/yTRpXc2yx2Ecosw1GMTsGpJeC3vx3Tw5mkC0zO1sTlpkcGdRd2mXX
         pA3CRybJs0ZbWCDrNPBtj3sTSYW1eTUqPSbkQ+ZstrYYIPmlrsDp5LaBrtJa22CfnjG6
         Ab+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uSEYmLllNjJftf9n5AprTfaaSYD64ry9qHpFZHlSP5E=;
        b=eU6qN0Oz9bOwX1tuYscQieTpGduLpmbYuvNv5Lp/70Gnyf4BtvOC3vVL+JVvSYgoal
         27T3HaZS1dIULA3hLMT4tIhXEf+1tDFME7z5bqADT6jiNbZdpQlnyg2ffxdJFbkhRSv2
         4kchozXADAUbcRvTmLMQPRZ6PzibjIh98XdbAX0KAB1GSX/FfjWVHNV/gSDSFRPPYeZK
         xiBpV2ZnhC5r8XNI1/hbUMvOMCxFSfyr85GtPA1TJGOWDPgGM2V0oQtHlnoyXfqho7Vi
         Ep7ZIQhUbIeoxRor0FOZu/jnP9Yt7uuaSBqkEdxRb+wplkk6kdEpoHUCreylv+hdd7vM
         0pJg==
X-Gm-Message-State: AOAM532wZCltz5eYGgeQMr27RtUqeXM4LFit1CDR5O2evx80cx3I/lab
        47PMaXoMSVBLXcLJ/AUaAAE=
X-Google-Smtp-Source: ABdhPJw1wJuIcSQdsCcNqDifiu5l3xy9TQ+mGAYLfv7U7/t0+L1QAKHkglr6WgQuix7pkZUZy2pmnA==
X-Received: by 2002:a5d:4388:: with SMTP id i8mr18259416wrq.340.1632601949390;
        Sat, 25 Sep 2021 13:32:29 -0700 (PDT)
Received: from localhost.localdomain (252.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.252])
        by smtp.gmail.com with ESMTPSA id a202sm16703279wmd.15.2021.09.25.13.32.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Sep 2021 13:32:29 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     tsbogend@alpha.franken.de
Cc:     robh@kernel.org, arnd@arndb.de, catalin.marinas@arm.com,
        Liviu.Dudau@arm.com, bhelgaas@google.com, matthias.bgg@gmail.com,
        gregkh@linuxfoundation.org, linux-mips@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-staging@lists.linux.dev,
        neil@brown.name, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/6] MIPS: ralink: set PCI_IOBASE to 'mips_io_port_base'
Date:   Sat, 25 Sep 2021 22:32:21 +0200
Message-Id: <20210925203224.10419-4-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210925203224.10419-1-sergio.paracuellos@gmail.com>
References: <20210925203224.10419-1-sergio.paracuellos@gmail.com>
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
Acked-by: Arnd Bergmann <arnd@arndb.de>
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

