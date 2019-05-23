Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7753128B65
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2019 22:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387615AbfEWUOw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 May 2019 16:14:52 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43833 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387786AbfEWUOv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 May 2019 16:14:51 -0400
Received: by mail-pl1-f195.google.com with SMTP id gn7so3170267plb.10
        for <linux-pci@vger.kernel.org>; Thu, 23 May 2019 13:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5G1ZPvgTrdgyW2PxGOXC6vH5P8E8ivAkNJzVwGirtqo=;
        b=AKnEDntflvnhyaBSvVK099GiNRlWgGmribqV0Gw/VdWTjwxzjpNafTbPuqKigoe2V5
         FttiilstLFzz13VHtqQ9Ow5qJWcSTmkZod1V/o67Oz7JpP4zndSuIOsjZEnzgLgC45Dg
         1OBKSki/z8keLPmKvajpOynSqHY7geZI+K/YsdtLyEKBdPCcZVy7j/HKpK1eqApnmVRU
         B6d9wKjRuRWn4waIsXQHcEJCqUAi1LCpXsW0bGQxXG81fDN09MqYT2dprU1jScxQcw8k
         jZAoSGnyRTN6nFsLblRD2D74d6EvdPLSc5r6ch8s3TeUUG7GD2LjrY8535TP8yf89ZX9
         Yk5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5G1ZPvgTrdgyW2PxGOXC6vH5P8E8ivAkNJzVwGirtqo=;
        b=r3kfYuIgO71/RFjgXlcBMhjGXMjjRy47aodrCG7j+s3Q/8CJ2pSVjHciThOAFkRhun
         g2sag+7p9sPxNc2mGIh3soj+M+DHLLi4eaKfGga/QkUBwX1PlVvzU2avsJVULSPsL0wg
         97YONFtPeL7xiU8id8dtLrdK+9jrviN19ZctUYKmKEiRG8qwTBc+gDw/IEXSoZg9NPoU
         sCnpN5ULqM8JGIXdXpHbesh+ZDc1Wyoty+i0wC9PHHhhuD1fMPnmt7ZROYqlHOODl0gr
         R5YFjBP/8IlvVQWrWjWquYsrnV0x9WfWE4tWOsUbI8uN+/sunaya2aHxENcz63p3ufSU
         zGvg==
X-Gm-Message-State: APjAAAXCD1MQ+xV0uRVCBNzfArTX9oWxOgUOWAmn+LtwbZw8fTZ0kxq1
        rY4pQGOA0P0RK7L4GLs7vZ4wQ7ZEK4U=
X-Google-Smtp-Source: APXvYqyocPUBK+x86to4bFHTsugKXVdIxgBB30akfZUKLbQ4YlaRtHksF4iUavWEP335zXjgDmppXQ==
X-Received: by 2002:a17:902:59c3:: with SMTP id d3mr29255894plj.273.1558642490753;
        Thu, 23 May 2019 13:14:50 -0700 (PDT)
Received: from nuc7.sifive.com ([12.206.222.2])
        by smtp.gmail.com with ESMTPSA id i12sm180839pgb.61.2019.05.23.13.14.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 May 2019 13:14:50 -0700 (PDT)
From:   Alan Mikhak <alan.mikhak@sifive.com>
X-Google-Original-From: Alan Mikhak < alan.mikhak@sifive.com >
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kishon@ti.com, lorenzo.pieralisi@arm.com,
        linux-riscv@lists.infradead.org, palmer@sifive.com,
        paul.walmsley@sifive.com
Cc:     Alan Mikhak <alan.mikhak@sifive.com>
Subject: [PATCH 2/2] tools: PCI: Fix compiler warning in pcitest
Date:   Thu, 23 May 2019 13:14:24 -0700
Message-Id: <1558642464-9946-3-git-send-email-alan.mikhak@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558642464-9946-1-git-send-email-alan.mikhak@sifive.com>
References: <1558642464-9946-1-git-send-email-alan.mikhak@sifive.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Alan Mikhak <alan.mikhak@sifive.com>

Fixes: fbca0b284bd0 ("tools: PCI: Add 'h' in optstring of getopt()")

Fix the following compiler warning in pcitest:

pcitest.c: In function main:
pcitest.c:214:4: warning: too many arguments for
format [-Wformat-extra-args]
    "usage: %s [options]\n"

Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
Reviewed-by: Paul Walmsley <paul.walmsley@sifive.com>
---
 tools/pci/pcitest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
index 6dce894667f6..6f1303104d84 100644
--- a/tools/pci/pcitest.c
+++ b/tools/pci/pcitest.c
@@ -223,7 +223,7 @@ int main(int argc, char **argv)
 			"\t-r			Read buffer test\n"
 			"\t-w			Write buffer test\n"
 			"\t-c			Copy buffer test\n"
-			"\t-s <size>		Size of buffer {default: 100KB}\n",
+			"\t-s <size>		Size of buffer {default: 100KB}\n"
 			"\t-h			Print this help message\n",
 			argv[0]);
 		return -EINVAL;
-- 
2.7.4

