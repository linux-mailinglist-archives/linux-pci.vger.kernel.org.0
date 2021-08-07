Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8423E33EF
	for <lists+linux-pci@lfdr.de>; Sat,  7 Aug 2021 09:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbhHGHYj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 7 Aug 2021 03:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbhHGHYg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 7 Aug 2021 03:24:36 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AFAC061799;
        Sat,  7 Aug 2021 00:24:16 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id h14so13955479wrx.10;
        Sat, 07 Aug 2021 00:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R7ftxM96YAq/VWL5+bWMfsnR3bh1EBHc546zzPpFbiU=;
        b=sZLLxwEWV9J5yunhWg5//rALHj1gZZePQ7WsHujX4g9G03lxTND/mt4PkF5sMPYH+Q
         hrgWKrSW1DcTIfVsl9klcZlPu6SEvoffobF9yNgm6Irnj44wOP42jOqSb5bPnac+BZnN
         IRjOIDOKn71LkpnDNl0UW224yDmIxUMxp6xzQ2027jrwrKGbknmOXkMmXHM1qDQ5e6f6
         Rhc/XiJO1j6Ftsx+WQU6RG9WcVRJZ9xnPcOW09YrDiKXmYjDr/Z6QswQVVjs1k2Vhs4n
         ttQMkVrb1tTGHBJENXW4N1QwKjQ0uRedyOxjyFohwu5uoxsFKLQ/rTIpceY8vFlM/ch+
         pi/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R7ftxM96YAq/VWL5+bWMfsnR3bh1EBHc546zzPpFbiU=;
        b=Hi0MAPTk7bO2IZK8YeGzVSuVjTTMFTPRa+0KMbJq+cvnHqoXCbz8mXpFOuib6amN+j
         d+X5IHH8UQmbs3WPrAILYfzfk5gHNm2sNheiPzkekdLtZ9/2E5RRvMe3BhyBASML7QED
         91pi7vUycVQeHt4BgzwK+LNhOzTGpULE8kThOByPjHbqOa5cjyJoENOr3oGPj//ycoom
         ZjSdR6rAWv0pW7C/u6MPJJ7+N6QT4octdYoQDHyPNqbm9d481ca8UwxdUxuGm3OKdg8G
         oZ0XkUkdsAiAey3FOMLbGZ2Ysvp0RoTq54kVQvQ7ZlWcR8zSEoi/QNoVzp8dZRQRtuQi
         i8gA==
X-Gm-Message-State: AOAM530K7DRAKXZZJ4aV0KTVjm0/ZPOa9+32bHLL1k9eqAcLraAYremk
        NJXinMWze+zE1eBYiZdYpGc=
X-Google-Smtp-Source: ABdhPJwNGEq+ZFP/ntg1NMH8/P4Ab2bebvv/2QrPdAwubsH8gqoIAFfnziwWMZ31+U5xcL5/IR4Xtw==
X-Received: by 2002:a5d:5147:: with SMTP id u7mr14634265wrt.181.1628321054751;
        Sat, 07 Aug 2021 00:24:14 -0700 (PDT)
Received: from localhost.localdomain (10.red-83-57-27.dynamicip.rima-tde.net. [83.57.27.10])
        by smtp.gmail.com with ESMTPSA id g5sm13915017wmh.31.2021.08.07.00.24.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Aug 2021 00:24:14 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     tsbogend@alpha.franken.de
Cc:     bhelgaas@google.com, matthias.bgg@gmail.com,
        gregkh@linuxfoundation.org, linux-mips@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-staging@lists.linux.dev,
        neil@brown.name, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] staging: mt7621-pci: set end limit for 'ioport_resource'
Date:   Sat,  7 Aug 2021 09:24:09 +0200
Message-Id: <20210807072409.9018-4-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210807072409.9018-1-sergio.paracuellos@gmail.com>
References: <20210807072409.9018-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We have increase IO_SPACE_LIMIT for ralink platform to get PCI IO resources
properly handled using PCI core APIs. To align those changes with driver
code we have to set 'ioport_resource' end limit to IO_SPACE_LIMIT to avoid
errors.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/staging/mt7621-pci/pci-mt7621.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/mt7621-pci/pci-mt7621.c b/drivers/staging/mt7621-pci/pci-mt7621.c
index 691030e1a5ed..6301397c3987 100644
--- a/drivers/staging/mt7621-pci/pci-mt7621.c
+++ b/drivers/staging/mt7621-pci/pci-mt7621.c
@@ -522,6 +522,8 @@ static int mt7621_pci_probe(struct platform_device *pdev)
 	if (!dev->of_node)
 		return -ENODEV;
 
+	ioport_resource.end = IO_SPACE_LIMIT;
+
 	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
 	if (!bridge)
 		return -ENOMEM;
-- 
2.25.1

