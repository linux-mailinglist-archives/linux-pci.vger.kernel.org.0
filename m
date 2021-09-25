Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40786418463
	for <lists+linux-pci@lfdr.de>; Sat, 25 Sep 2021 22:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhIYUeF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Sep 2021 16:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhIYUeE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Sep 2021 16:34:04 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8E2C061570;
        Sat, 25 Sep 2021 13:32:29 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id r23so12932369wra.6;
        Sat, 25 Sep 2021 13:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oY+ehST4wA6FiZDaz59HXjjwDmgVx1fzGmc8GDxtC+8=;
        b=n4M61+uEZFS1EockQ3PZFF5TgXu3qhFC/4VdpqCXW1ywiyuUuMZgPqxTgm7qPJLfGC
         uAy1c0jSgM33eFOZUGAJ+5+xVYqc544jDnlbGzW9a30fBK1NBGA4L+b2v90yA7FhYZM6
         6xZtyVxbfNTY/0B461sTYKXObRg5MFflLuytA+cUi0ppY6n2x3SgVVKaQ8bP4sH2l7x/
         apCcVo/je2+jwWqyd5lmLNpj+RYf64j2jAvOcApJZ8/sQgHemC0vgJbz07nPP1Irpn+u
         PFplbG50nEdZEdQM/A9f6Jap9dXTCoFDizgP3RB56mvdZptLbku14vd7qScoSF5Z6FhI
         DolA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oY+ehST4wA6FiZDaz59HXjjwDmgVx1fzGmc8GDxtC+8=;
        b=YqOuxrUI0cQIbbExaR4NtQ17VEgVFWn8F3/T5rzZOC8+2Zy1oEJtsEW0KhF+3VFPcd
         1wQTfZxcfC45AV3l0msPxjB7A/97jCUSx7oWFFMOdFAaLiZQGdoQtUKdUqhCI8BC371o
         kUpKz5D1Es2n4/cFj5AnGmahhKFuUyZ15B8E2pdcovLWuqbG++Ii6LEeJJCXQcBe/Lyr
         sbJZmXDpOOabtdmYKQpFy/7ZChlmMLoPnTEojsTU+wB+I8pg04E5wx5l7QwlkFEkio+l
         9dVQZZcRcyi1FHF5mNm58xY5hDHJKXNWivJGu2vozq/BxUKXYwzURB2kDcXzpgPVCY6I
         xAOg==
X-Gm-Message-State: AOAM530N1XMUbP3VolzzPNPIucZ+tBqdDV+44OV16fh0O8WuD+x7hOIe
        OEd1zL9HWl35K0eYOxubQnY=
X-Google-Smtp-Source: ABdhPJzFetuuD8I1kF2Kxi1e7fnCMBC2vyQnEn9VwPsSUkTNiO5tfoUQ9VfUAozd2orCAEjRt70gFA==
X-Received: by 2002:a7b:c932:: with SMTP id h18mr8228480wml.112.1632601948320;
        Sat, 25 Sep 2021 13:32:28 -0700 (PDT)
Received: from localhost.localdomain (252.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.252])
        by smtp.gmail.com with ESMTPSA id a202sm16703279wmd.15.2021.09.25.13.32.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Sep 2021 13:32:28 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     tsbogend@alpha.franken.de
Cc:     robh@kernel.org, arnd@arndb.de, catalin.marinas@arm.com,
        Liviu.Dudau@arm.com, bhelgaas@google.com, matthias.bgg@gmail.com,
        gregkh@linuxfoundation.org, linux-mips@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-staging@lists.linux.dev,
        neil@brown.name, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/6] Revert "staging: mt7621-pci: set end limit for 'ioport_resource'"
Date:   Sat, 25 Sep 2021 22:32:20 +0200
Message-Id: <20210925203224.10419-3-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210925203224.10419-1-sergio.paracuellos@gmail.com>
References: <20210925203224.10419-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This reverts commit 50fb34eca2944fd67493717c9fbda125336f1655.

Since IO_SPACE_LIMIT is not really being changed there is no
real need to adjust the ioport_resource end limit.

Acked-by: Arnd Bergmann <arnd@arndb.de>
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

