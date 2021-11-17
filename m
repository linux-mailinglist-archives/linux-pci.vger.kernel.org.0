Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 347CA4549E9
	for <lists+linux-pci@lfdr.de>; Wed, 17 Nov 2021 16:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237851AbhKQPcz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Nov 2021 10:32:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237048AbhKQPcz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Nov 2021 10:32:55 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518E4C061570;
        Wed, 17 Nov 2021 07:29:56 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id i12so2591580wmq.4;
        Wed, 17 Nov 2021 07:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qBzBp8GIfyp2D1Erl6efh8JxYlnrM6s9+4t5tWGRE+s=;
        b=HvQQmcGc2NEZf5Y/CbnzKXI2otrtqRm76eMS8ZS/0q05bKPKI4XucUI1vywNvIJ+GL
         NuSJHYQPbtnK7Gi7l1DoL46UQQqDa58EImLTOFNEe3Ag+QREcwPlJDCcvJmlaIkrj8qv
         xGSo5XN4gfmpDjRFRiPPo4iLw/shA2j0Qvss8iLO9n6j6fohsIm/TPx5hGFGmUiesqqE
         mUGkzOOQRADpWD3fOJTL3CRbV7K54QeCR+Bne8uke8FEnMX0Gv5KLhTGwzlemwa2BVQN
         bFe/HDnhXzC37KpHCLX8hn/4PIvCgPFoNPDxGCBGXFxVRU0hoZeORDVQZFTKB9UyTS85
         iOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qBzBp8GIfyp2D1Erl6efh8JxYlnrM6s9+4t5tWGRE+s=;
        b=dGGCWed95Svxka2RYpYbGSH6VkrwMvtxTzeRKJPsU+4wMrb8q1/yFk0ddLnRusOIHL
         /ZrGfpDSM1U/ZCz5XU1BgRVfbHw9QVS1GqMf4vxwQJT0cYZR8yk/CuA81cbDcnRxclRA
         mVykITE1VJQ62PZRqy58c8CseSS+k/Fg59rsoT3vhueTNTYgFwqeoSgw9Wb3SZVZ0JdR
         dEAY+X+5pnwwL3upb4fPInpqbpAQTBNZUmdC6c44zkc2avzSpI2KJ7GEwShLyHfZqkCm
         zfSgey3euy0qY/xE5t7mpkkP9N7BiKlOS1y38ZYHklPGzuQtc/HWRQKCrgWMFGWN2iDa
         6Qog==
X-Gm-Message-State: AOAM532ImltMCvCt1yk+71h0uD+cv+RBkPeaWZ+yKUCKQcKaIN8KbErs
        iSdNOP2H5bQaeQzxAQn8QV3FXZIJTrg=
X-Google-Smtp-Source: ABdhPJwM7Pu/v5vaEEZRsqG6xSQ1HFYDaE0LSyYiHXQP8CV1jceDhMVZCUix2IGDVyOo3B+pr9gZkA==
X-Received: by 2002:a05:600c:1ca0:: with SMTP id k32mr650203wms.74.1637162994574;
        Wed, 17 Nov 2021 07:29:54 -0800 (PST)
Received: from localhost.localdomain (252.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.252])
        by smtp.gmail.com with ESMTPSA id b14sm313716wrd.24.2021.11.17.07.29.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Nov 2021 07:29:54 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH] PCI: mt7621: declare 'mt7621_pci_ops' static
Date:   Wed, 17 Nov 2021 16:29:52 +0100
Message-Id: <20211117152952.12271-1-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Sparse complains about 'mt7621_pci_ops' symbol is not declared and asks if
it should be declared as 'static' instead. Sparse is right. Hence declare
symbol as static.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/pci/controller/pcie-mt7621.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controller/pcie-mt7621.c
index b60dfb45ef7b..4138c0e83513 100644
--- a/drivers/pci/controller/pcie-mt7621.c
+++ b/drivers/pci/controller/pcie-mt7621.c
@@ -148,7 +148,7 @@ static void __iomem *mt7621_pcie_map_bus(struct pci_bus *bus,
 	return pcie->base + RALINK_PCI_CONFIG_DATA + (where & 3);
 }
 
-struct pci_ops mt7621_pci_ops = {
+static struct pci_ops mt7621_pci_ops = {
 	.map_bus	= mt7621_pcie_map_bus,
 	.read		= pci_generic_config_read,
 	.write		= pci_generic_config_write,
-- 
2.33.0

