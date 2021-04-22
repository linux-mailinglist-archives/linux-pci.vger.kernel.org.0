Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2470A367F18
	for <lists+linux-pci@lfdr.de>; Thu, 22 Apr 2021 12:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbhDVK4V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Apr 2021 06:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbhDVK4U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Apr 2021 06:56:20 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125E8C06174A;
        Thu, 22 Apr 2021 03:55:45 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id m11so31411180pfc.11;
        Thu, 22 Apr 2021 03:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/bcJkIrC4HHmuNP+qBdQUCnL3pSdXMOSFA6DkiZnvKU=;
        b=X60Sl5tZCCEbWiP1gGI6Hiqg8tTGLGi2OONe0jyk+rrVYrTU6PNh1Gqwk86qcCMrGF
         +jLR6zohYTnB66PjkZMmGn5SfLpnYnHI6TMAGZiAzSDL0QIOgOCv5lBIjZuP8ey14qh5
         RpvItgojJy7NbrfN7kU6sXy+Ha7pTdVQbzYpAxnVmHDQmoM7W7yzRPVTHvEqrvJr7/AB
         Gz5cFcQRbrlO+LTYJY0pT8yNMgAX4HbFaNmd4lgqvYX0llBlIrsI95jjFvvHFMC4HygX
         A2/D5C1QEvOOXo16dGVtb/qVdal+UQA5bQmLJr9QYbHHNbbDjv+JSNCyJwYMYIC8fy1k
         wD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/bcJkIrC4HHmuNP+qBdQUCnL3pSdXMOSFA6DkiZnvKU=;
        b=Hamjm4n4ufZGrquDbsmI61LUrL3dgT3tgJNcON/P0KmL7DOGquHgusVPv8mSRPIisq
         asLuSsYEGtbQVlJLTQGq8IV1tL7gbpYwhQrcZtcYHOcQ+LQOHisNXPElR/THGdJs3vlp
         bk9+vwjRBMYFQ6v2kwK3U9fTnOow9LxlVA35vS2ZO//34lZ3eRimou5J9rAXnGz2huEU
         fYwp/QyNL3B5AtEMaFuyKc6jVBoSTokbboB1ZvbIA1v/BQvIh81YuRbS8KK3Xw/YTybi
         TJ7Ro2Km+lctzIvAoZN5xc6cRYZqxhbel498d1cbFWcrh3HfhtscDle/+ZFZ6mufq0hM
         xERA==
X-Gm-Message-State: AOAM530kMAq7Sh3lnWFgAhNwVt0Aof7F3wEzcCPlu8flLwygVeczFmyu
        E1+md2WvjRR5ZiNFHqRx3Po16/my7c0=
X-Google-Smtp-Source: ABdhPJyIM4c4mUSK2LvSsKzNqHuX5IcEbv2rpxyVBi1JV5FNEd2c6BNrJK72ogK+gPzzj3JMysziUQ==
X-Received: by 2002:aa7:9984:0:b029:25e:d44c:5f86 with SMTP id k4-20020aa799840000b029025ed44c5f86mr2875545pfh.15.1619088944624;
        Thu, 22 Apr 2021 03:55:44 -0700 (PDT)
Received: from localhost.localdomain ([103.248.31.176])
        by smtp.googlemail.com with ESMTPSA id g23sm2099876pfu.142.2021.04.22.03.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 03:55:44 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leon@kernel.org>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v2] PCI: Check value of resource alignment before using __ffs
Date:   Thu, 22 Apr 2021 16:25:38 +0530
Message-Id: <20210422105538.76057-1-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Return value of __ffs is undefined if no set bit exists in
its argument. This indicates that the associated BAR has
invalid alignment.

Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
---
 drivers/pci/setup-bus.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 2ce636937c6e..ce5380bdd2fd 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1044,10 +1044,11 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 			 * resources.
 			 */
 			align = pci_resource_alignment(dev, r);
-			order = __ffs(align) - 20;
-			if (order < 0)
-				order = 0;
-			if (order >= ARRAY_SIZE(aligns)) {
+			if (align) {
+				order = __ffs(align) - 20;
+				order = (order < 0) ? 0 : order;
+			}
+			if (!align || order >= ARRAY_SIZE(aligns)) {
 				pci_warn(dev, "disabling BAR %d: %pR (bad alignment %#llx)\n",
 					 i, r, (unsigned long long) align);
 				r->flags = 0;
--
2.31.1
