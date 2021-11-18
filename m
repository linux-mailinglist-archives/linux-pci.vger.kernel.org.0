Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7479A455D7A
	for <lists+linux-pci@lfdr.de>; Thu, 18 Nov 2021 15:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbhKROKz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Nov 2021 09:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbhKROKy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Nov 2021 09:10:54 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E93C061570;
        Thu, 18 Nov 2021 06:07:54 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id x5so6175666pfr.0;
        Thu, 18 Nov 2021 06:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MC+uMtAqzrUGxiPuMGV2uquDaVscrAuApobHOB73Khc=;
        b=iujRsX4QPoiun7MHP0bUBZW28PjBf6o6gfGjY/YCm/Lpia8P/wzPGdCWhiyGfZG09g
         Gjrmitr/DvKW1Se/u30W1xBctEtQ460BlEKz4w4a4RRLsG/Z9uYu8quQ3S8YNaXabwUL
         c0ODX2zYAPzZEc+6s3kYCQfPner0LQoYLnPLwcCCQxCnx5DSiPpfmdj91JA28o2Bh+zR
         Xxth8mCjdAdYY8DkskQ2AL8PFVJqPwsIgFNlvyqn9V5Q7seZuDDq1aaOMfpUVkRLcLVb
         p2wov/u8f1vPaBr2+y9SQZFEwiXZ5iREzuqbl0+ygDk3ftzRQ2vbE6NVCZ+zPwJOU+sx
         PG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MC+uMtAqzrUGxiPuMGV2uquDaVscrAuApobHOB73Khc=;
        b=4AmvMsilUFcc9yAL0G1NHGdVHQX1A7b376rkqlxdCW3fwAule/EkVKnarNDNZD3Xu5
         tw4mRzYvBHUKfiaiNzF2p9tjsSBevq4V9FOCFvpE8yPhMviUvEw/XB+Bx0Y2Q//kGoW1
         8ALbAfFz87Bs6bf3PDZC12jP2z1a/mU+45oXSzBuw7p8hzzJ/z/QfOtEsh9tEo9sUmxY
         fDxW/SoMlmOoBAtuNDyFG4cBYMHi0bdrWWV8DNjOKn9aj8S/AYNF7V3bHUWrNY9O8xpA
         SlNGlem4d4+n1R9jhu92AB0e+ejDvdcmFwdNBWzPIVsEPLlvFcnDoXGZsze7PimU23gG
         1R/w==
X-Gm-Message-State: AOAM530nda8+C5DufGi/C/JmEO2M1TdPnqCfjpgdGjG/TehvRG0JrR3x
        G0qPPrz7epsTWAQALOGPXJw=
X-Google-Smtp-Source: ABdhPJyuYGF3D5BwP9dBQadEZLcKBgGb+caRhXPH1nLvYia+cdRfnIzBQGuarTkOzB+UKMsDzzIvlg==
X-Received: by 2002:a63:725e:: with SMTP id c30mr11339989pgn.240.1637244474011;
        Thu, 18 Nov 2021 06:07:54 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:63:2c47:5ffe:fc34:61f0:f1ea])
        by smtp.gmail.com with ESMTPSA id x14sm2822878pjl.27.2021.11.18.06.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 06:07:53 -0800 (PST)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-renesas-soc@vger.kernel.org (open list:PCI DRIVER FOR RENESAS
        R-CAR)
Subject: [PATCH v4 14/25] PCI: rcar: Remove redundant error fabrication when device read fails
Date:   Thu, 18 Nov 2021 19:33:24 +0530
Message-Id: <83540eb3ae76a0d28bbe03d69d685a6d549b456b.1637243717.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1637243717.git.naveennaidu479@gmail.com>
References: <cover.1637243717.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

An MMIO read from a PCI device that doesn't exist or doesn't respond
causes a PCI error. There's no real data to return to satisfy the
CPU read, so most hardware fabricates ~0 data.

The host controller drivers sets the error response values (~0) and
returns an error when faulty hardware read occurs. But the error
response value (~0) is already being set in PCI_OP_READ and
PCI_USER_READ_CONFIG whenever a read by host controller driver fails.

Thus, it's no longer necessary for the host controller drivers to
fabricate any error response.

This helps unify PCI error response checking and make error check
consistent and easier to find.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/controller/pcie-rcar-host.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index e12c2d8be05a..6bd5619fbbf4 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -159,10 +159,8 @@ static int rcar_pcie_read_conf(struct pci_bus *bus, unsigned int devfn,
 
 	ret = rcar_pcie_config_access(host, RCAR_PCI_ACCESS_READ,
 				      bus, devfn, where, val);
-	if (ret != PCIBIOS_SUCCESSFUL) {
-		*val = 0xffffffff;
+	if (ret != PCIBIOS_SUCCESSFUL)
 		return ret;
-	}
 
 	if (size == 1)
 		*val = (*val >> (BITS_PER_BYTE * (where & 3))) & 0xff;
-- 
2.25.1

