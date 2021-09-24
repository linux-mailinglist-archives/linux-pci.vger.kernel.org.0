Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE214417CCF
	for <lists+linux-pci@lfdr.de>; Fri, 24 Sep 2021 23:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347039AbhIXVNU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Sep 2021 17:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346993AbhIXVNT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Sep 2021 17:13:19 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB01EC061571;
        Fri, 24 Sep 2021 14:11:45 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id t8so31254721wrq.4;
        Fri, 24 Sep 2021 14:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OyR/G6OXJUzzgXbsVp3sTRgTYQYfQEC/z3g1X2aYcVs=;
        b=U+vJPGAxYG540bH5jV7NX7OpXK5kcakRlMMMOAE88V+10eHOaRVf9WET7nVoo4BCYK
         U6x2xqgSI7d9lu5+DIm7LeT10jAf+s2DcYJtd9mzkTQS0pXH0xrMZJAI1OcdvMYAGK3v
         DHir/VhLYLnPTF8ElRQz8n33B+jzEHp6lnCw7O7F3k4ccHbBu+VXEW6j1iCpu0NdBVUc
         2aDtdnXNYBJwqDfV5XX2gCayCJEAAydMoC5B86qyUp9LbZGXA7UzskL8F8785InymAtq
         eYMKYrhrFNra/0yzqhjWLkN4QnWuPxWrRhCtRa4k0N7DNjwKdBRnlIapwIQ8NJaF1AFI
         8u7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OyR/G6OXJUzzgXbsVp3sTRgTYQYfQEC/z3g1X2aYcVs=;
        b=eE7VGeb5uLjXzoQe242aNYG42c4ZlTMgSpI9SGYoE1Q2yZVxLVf+CSMTWMd8IuI76/
         HS9/A75kQFB37l3R1HGCkQ8UD1vPidY6Xn8hOq5s5WbfDtZREDN1lSpZu15aSoYhPAUd
         92P0QBvd0qGTzim7HOYekkwrQiLemt3Z7t+nPIhYtZnOZPTQ6wDKT8JqImkKsuYdwPsY
         Q9ADDa0ILYlSDy+jcG7g4OuiTckdS4bHS4YDrsOU8vgRI8i69LG69rs0KhxFiKZvEY2v
         Ah4bTpT9aZEKX8+0ild3rzoEbXZZSDVRnfO4HeF4K7116guzZGXHZP1tf8VTVZO+egHt
         N4ZA==
X-Gm-Message-State: AOAM531IXM3zP1JY4iyO8VdYmQNXnmcC6RnWtzf4f9Lwont5O5/cp3FM
        0dUGBTd5ahAo3gHpzBrZddU=
X-Google-Smtp-Source: ABdhPJxsqQ7CQbB882G/Opgnfqeh4McKw5bFQkjiLaO0XftIVxWdCOu2Mr1R7/kvq0H+w2yIRZ9W0A==
X-Received: by 2002:a5d:64ca:: with SMTP id f10mr13408326wri.93.1632517904436;
        Fri, 24 Sep 2021 14:11:44 -0700 (PDT)
Received: from localhost.localdomain (252.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.252])
        by smtp.gmail.com with ESMTPSA id y64sm10344297wmc.38.2021.09.24.14.11.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Sep 2021 14:11:44 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     tsbogend@alpha.franken.de
Cc:     robh@kernel.org, arnd@arndb.de, catalin.marinas@arm.com,
        Liviu.Dudau@arm.com, bhelgaas@google.com, matthias.bgg@gmail.com,
        gregkh@linuxfoundation.org, linux-mips@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-staging@lists.linux.dev,
        neil@brown.name, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] Revert "staging: mt7621-pci: set end limit for 'ioport_resource'"
Date:   Fri, 24 Sep 2021 23:11:35 +0200
Message-Id: <20210924211139.3477-3-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210924211139.3477-1-sergio.paracuellos@gmail.com>
References: <20210924211139.3477-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This reverts commit 50fb34eca2944fd67493717c9fbda125336f1655.

Since IO_SPACE_LIMIT is not really being changed there is no
real need to adjust the ioport_resource end limit.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/staging/mt7621-pci/pci-mt7621.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/mt7621-pci/pci-mt7621.c b/drivers/staging/mt7621-pci/pci-mt7621.c
index 86d9c3d122e2..6acfc94a16e7 100644
--- a/drivers/staging/mt7621-pci/pci-mt7621.c
+++ b/drivers/staging/mt7621-pci/pci-mt7621.c
@@ -526,8 +526,6 @@ static int mt7621_pci_probe(struct platform_device *pdev)
 	if (!dev->of_node)
 		return -ENODEV;
 
-	ioport_resource.end = IO_SPACE_LIMIT;
-
 	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
 	if (!bridge)
 		return -ENOMEM;
-- 
2.25.1

