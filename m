Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E35004658A1
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 22:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353307AbhLAVzT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 16:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353177AbhLAVy4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Dec 2021 16:54:56 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB54C061574;
        Wed,  1 Dec 2021 13:51:34 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id j3so55361472wrp.1;
        Wed, 01 Dec 2021 13:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o3XUpWa6+1DXUAt7w4vSplRb3YE72oXrdXq5mYAn8E8=;
        b=nUNKvTiylaT/oSLbkLZjB1slHcDpnS/DsfQ5raYHmniDr+B6FjCKFTo6CaoEOpKRTf
         mSS+rWFlglrnwQ3zwLz6kWx+E5mAraBiJ7qnSx8dFFtdd8pgyb4lIksiOT9lbOKjyILD
         An+xqLSQ/f5Hh+KRdiZW7neYtAO3vsn3uXAwdr2+ubBHSPR4IQd+w1iqL/rHTaZXRL7H
         p5342XYk6q8yiTEpuEV0o05iEy9UKr4Gcfr6uGQVf0F19BQzO6LfkaJo6htZobMgqTdN
         wjWeqnZQgsAGfnkDkfmUq2hjpy8CgYaNldprlfZoPx/yyqokb/dNbITW4KxPViuEV4Li
         txSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o3XUpWa6+1DXUAt7w4vSplRb3YE72oXrdXq5mYAn8E8=;
        b=MQ41+hzn1RIouw9ajLIsIcFZ5BGtDa4mwXTsfrajgbw17oD9NEcj8QdSsDPLZ1IK07
         Cns9R500SqHWH/NDt/W8SEe1mOwe2H7sPScHOQmNWU2OlplJD497zFFNzvrAB0cr/V4d
         gxblR/GeEIbdI2uSjbIvrUXpZsLExOtXnuxFEEIStrxi0ME81Y436Vy0v0ejLB+5OFbD
         MQGJuYOCaDTLI0iRKTREkeTw6LFrqM5UavoFaoiphnWp0B5OVXBNwl+aq57sLPbpetP1
         E89GhaS1PtA2Yt2WO4DqsyqUmj63RWdnwn+SHBtLa4SSA9aUlBYRIzARezKqgKaPAbOT
         JLNA==
X-Gm-Message-State: AOAM533GDXatBwvuqTfF5Stc2aV2l4zro8wD6MGeotef+n442OXVGJOk
        sEPYp8IWx1LBLhdtBNVXj6eI+1FF1xA=
X-Google-Smtp-Source: ABdhPJwv8yBgZ93ZrFgFmS1gzRyupMYLkDwjVA2UviZeKjsUT3wScpUl2WBaFuVIt0eCJZErld9Uzg==
X-Received: by 2002:adf:d1e2:: with SMTP id g2mr9930385wrd.179.1638395493244;
        Wed, 01 Dec 2021 13:51:33 -0800 (PST)
Received: from localhost.localdomain (252.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.252])
        by smtp.gmail.com with ESMTPSA id c10sm877879wrb.81.2021.12.01.13.51.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Dec 2021 13:51:32 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com, arnd@arndb.de,
        linux@roeck-us.net, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2 3/5] PCI: mt7621: Avoid custom MIPS code in driver code
Date:   Wed,  1 Dec 2021 22:51:25 +0100
Message-Id: <20211201215127.23550-4-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211201215127.23550-1-sergio.paracuellos@gmail.com>
References: <20211201215127.23550-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Driver code is setting up MIPS specific I/O coherency units addresses config.
This MIPS specific thing has been moved to be done when PCI code call the
'pcibios_root_bridge_prepare()' function which has been implemented for MIPS
ralink mt7621 platform. Hence, remove MIPS specific code from driver code.
After this change there is also no need to add any MIPS specific includes
to avoid some errors reported by Kernet Test Robot with W=1 builds.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/pci/controller/pcie-mt7621.c | 37 ----------------------------
 1 file changed, 37 deletions(-)

diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controller/pcie-mt7621.c
index 4138c0e83513..42cce31df943 100644
--- a/drivers/pci/controller/pcie-mt7621.c
+++ b/drivers/pci/controller/pcie-mt7621.c
@@ -208,37 +208,6 @@ static inline void mt7621_control_deassert(struct mt7621_pcie_port *port)
 		reset_control_assert(port->pcie_rst);
 }
 
-static int setup_cm_memory_region(struct pci_host_bridge *host)
-{
-	struct mt7621_pcie *pcie = pci_host_bridge_priv(host);
-	struct device *dev = pcie->dev;
-	struct resource_entry *entry;
-	resource_size_t mask;
-
-	entry = resource_list_first_type(&host->windows, IORESOURCE_MEM);
-	if (!entry) {
-		dev_err(dev, "cannot get memory resource\n");
-		return -EINVAL;
-	}
-
-	if (mips_cps_numiocu(0)) {
-		/*
-		 * FIXME: hardware doesn't accept mask values with 1s after
-		 * 0s (e.g. 0xffef), so it would be great to warn if that's
-		 * about to happen
-		 */
-		mask = ~(entry->res->end - entry->res->start);
-
-		write_gcr_reg1_base(entry->res->start);
-		write_gcr_reg1_mask(mask | CM_GCR_REGn_MASK_CMTGT_IOCU0);
-		dev_info(dev, "PCI coherence region base: 0x%08llx, mask/settings: 0x%08llx\n",
-			 (unsigned long long)read_gcr_reg1_base(),
-			 (unsigned long long)read_gcr_reg1_mask());
-	}
-
-	return 0;
-}
-
 static int mt7621_pcie_parse_port(struct mt7621_pcie *pcie,
 				  struct device_node *node,
 				  int slot)
@@ -557,12 +526,6 @@ static int mt7621_pci_probe(struct platform_device *pdev)
 		goto remove_resets;
 	}
 
-	err = setup_cm_memory_region(bridge);
-	if (err) {
-		dev_err(dev, "error setting up iocu mem regions\n");
-		goto remove_resets;
-	}
-
 	return mt7621_pcie_register_host(bridge);
 
 remove_resets:
-- 
2.33.0

