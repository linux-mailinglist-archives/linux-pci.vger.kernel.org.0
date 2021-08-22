Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8331E3F4063
	for <lists+linux-pci@lfdr.de>; Sun, 22 Aug 2021 18:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234499AbhHVQKz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 22 Aug 2021 12:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234427AbhHVQKx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 22 Aug 2021 12:10:53 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DAEC061575;
        Sun, 22 Aug 2021 09:10:11 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id w21-20020a7bc1150000b02902e69ba66ce6so9130889wmi.1;
        Sun, 22 Aug 2021 09:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R7ftxM96YAq/VWL5+bWMfsnR3bh1EBHc546zzPpFbiU=;
        b=LGP4ALA/JTlwPIgsdrrLU6uI7R7+r40480lxGGI68rxhMYGHzVLJcOkmkb8m9SDvDh
         PtJbcdWv3EQappKQ8ntAoV1csSxQAQY7zkpz/afZeuAl6PI1kNVQd04tAevto7uBrxXR
         UYCtQoo2GHWPN/mol+ljL8DTJ+aurnCiGtw98z8idB1aCbCIOuQHmcUd5Hr+6s2Hg/HS
         xdJzH6fmpqau0aUmU/PbfnPZtiVtuz4nyXk1Esxy2sFMoVioqPf0Nb0bvvrQas+xwSKk
         k9+qOFpKXa/Nx2RU9qX7CWpTocoNvIddeSpv42UW6gU3C1rZa7XS+b7AEtq8ZjH6p9iJ
         zUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R7ftxM96YAq/VWL5+bWMfsnR3bh1EBHc546zzPpFbiU=;
        b=hnhj1vnZyZ9/qbdNoCLXb+/4UIHSYdAfbM6KmLHbLzoKNX2DCtcyY/jiSfyhc5F6w5
         ZjqYUi9hBERmjvwZFdj+lURcLyASqFbhDIyblXRPi+OL0LKUn+4AJzA2uBqfMUSJAAYm
         Clx8+gnPHs4XcP4AfPpD81jysrfhUEMeiCM/98fGrnrB2vT5NRB7kZhO1nBIQzkHN1o9
         sYmwi5qR6gcfnaMt7Bj6AeIzZ2FC7iIBl5vouchvwhTpbvXZeLJxYjFMWCTtjNTqYxqF
         Q+7s9/JOtXvazKH/18LkgydtEYcqYnFK96RxQQVSTBi06Ug+c3by3JVpfn3q4OZzdVj0
         Pfpw==
X-Gm-Message-State: AOAM530myPyr9WLJzewx+rN3BrEGUxTTDpfqZt1FnsVWVormFhCj3E1H
        /NvaMj6W1/5DU0mHKlZSC/U=
X-Google-Smtp-Source: ABdhPJz0Ifgs694Lr7lE65X7ZFHXH3p5AcKAwElxNzWF/0oSucA9XkoQjob8X7gM/LL5A3TtuEDUxA==
X-Received: by 2002:a1c:27c5:: with SMTP id n188mr12575469wmn.126.1629648610344;
        Sun, 22 Aug 2021 09:10:10 -0700 (PDT)
Received: from localhost.localdomain (10.red-83-57-27.dynamicip.rima-tde.net. [83.57.27.10])
        by smtp.gmail.com with ESMTPSA id y11sm14861976wru.0.2021.08.22.09.10.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Aug 2021 09:10:09 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     tsbogend@alpha.franken.de
Cc:     bhelgaas@google.com, matthias.bgg@gmail.com,
        gregkh@linuxfoundation.org, linux-mips@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-staging@lists.linux.dev,
        neil@brown.name, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] staging: mt7621-pci: set end limit for 'ioport_resource'
Date:   Sun, 22 Aug 2021 18:10:05 +0200
Message-Id: <20210822161005.22467-4-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210822161005.22467-1-sergio.paracuellos@gmail.com>
References: <20210822161005.22467-1-sergio.paracuellos@gmail.com>
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

