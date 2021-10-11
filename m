Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2787B429606
	for <lists+linux-pci@lfdr.de>; Mon, 11 Oct 2021 19:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233952AbhJKRtM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Oct 2021 13:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbhJKRtM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Oct 2021 13:49:12 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EA9C061570;
        Mon, 11 Oct 2021 10:47:12 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id t11so11790968plq.11;
        Mon, 11 Oct 2021 10:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zxhtuL3HeCmtsqnFNhK74x+usx81ot+S79+zUUitvW0=;
        b=PD6GjrTQM3KCyYIuR3r9KfKJBDMUoyykds5CzWH4OLLp1/gaFDA33/40tedbUytqNs
         C6NA/4F//BIJVTDGSfpoVfnI+Sy0cLXqFyLEeS9emQR5US4Ef/UihfKbAwb6TwV7SZUa
         s1zyFoWYgwEzSCBV1E4l8hJUbSkzs9IE1/H8VwZ7Ygsxm3IV0tjVz3pejMNZsPCjKtXI
         uMzkMWo0th9vtZqV9Wfx+y+U2utQB5dcO3l3iCFp5LeutR/FRvONywzoVEakuMgKRs7Z
         0OIg+au2Cc2rP3ui4D9HbMR9Cwrg4a3oN/FgcJP+ZjbF6c9OEFXLLKmMaw1OyqZqdau+
         m/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zxhtuL3HeCmtsqnFNhK74x+usx81ot+S79+zUUitvW0=;
        b=RM9Len42ANp242wYZJ4wjyUj7Hh+TG25co2PQ4LRW0r6yHr78PVReYVBz/uwlqjh8T
         Vps3OXjgOoSuaguMbLwv9Xa0blMMiHInXx5HbQ7nfBrUXH52CO6JPzK/kMEJvrSNVnZi
         nQ15PkkTfD7pLAD3u23qtEk2h5PN31Oi2R3Qgt/aIRQfSGnsH6QZ5EbnkCpcuxYUWHH7
         dwRMFO+N5cirCkctt4EnNRUWjsKkd9kQ/y3Hwsd3UnUBnqjXq4N9r4oxzFkQczed7NiR
         iqGNkZLWzHRKYQgJ+AtHJfYRSwZqRMLfcB6zaej7Fq50DjXoaVp0JHIRyzrg8tmEsmIP
         UJ/A==
X-Gm-Message-State: AOAM533xC1XZrhWbOQwDg0t0j5yyL7nhdt6t7bzZPhtiXvw0aD9MXLj7
        6N/t8+KuL3B9xqD1pZYgHxQ=
X-Google-Smtp-Source: ABdhPJwIuCQK1VwvP8TNFW8MaB2ve+rMxNFXCiuNx3vXpGFnMP0GHInKPnTxQN1MiUFBM+LvNGahcQ==
X-Received: by 2002:a17:90a:9f8c:: with SMTP id o12mr437340pjp.96.1633974431830;
        Mon, 11 Oct 2021 10:47:11 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:9f95:848b:7cc8:d852:ad42])
        by smtp.gmail.com with ESMTPSA id m2sm8824461pgd.70.2021.10.11.10.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 10:47:11 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM IPROC ARM
        ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM IPROC ARM
        ARCHITECTURE)
Subject: [PATCH 04/22] PCI: iproc: Use SET_PCI_ERROR_RESPONSE() when device not found
Date:   Mon, 11 Oct 2021 23:16:36 +0530
Message-Id: <b08c40280615fe9de232a50126b220c5966a69ad.1633972263.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1633972263.git.naveennaidu479@gmail.com>
References: <cover.1633972263.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

An MMIO read from a PCI device that doesn't exist or doesn't respond
causes a PCI error.  There's no real data to return to satisfy the
CPU read, so most hardware fabricates ~0 data.

Use SET_PCI_ERROR_RESPONSE() to set the error response, when a faulty
hardware read occurs.

This helps unify PCI error response checking and make error check
consistent and easier to find.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/controller/pcie-iproc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index 30ac5fbefbbf..f182dc2cdb0c 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -660,7 +660,7 @@ static int iproc_pci_raw_config_read32(struct iproc_pcie *pcie,
 
 	addr = iproc_pcie_map_cfg_bus(pcie, 0, devfn, where & ~0x3);
 	if (!addr) {
-		*val = ~0;
+		SET_PCI_ERROR_RESPONSE(val);
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
 
-- 
2.25.1

