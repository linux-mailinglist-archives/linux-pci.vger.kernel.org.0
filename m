Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF155429647
	for <lists+linux-pci@lfdr.de>; Mon, 11 Oct 2021 20:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbhJKSEf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Oct 2021 14:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhJKSEf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Oct 2021 14:04:35 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C8FC061570;
        Mon, 11 Oct 2021 11:02:34 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id pi19-20020a17090b1e5300b0019fdd3557d3so555087pjb.5;
        Mon, 11 Oct 2021 11:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YKejBUXkQbFhZRkUnaq6l+1PH6Sz7FGa86StL/2yA7g=;
        b=N5/LXxrSPtzTlFWoWqamkfy3kBLnmyFDVScezpSJYyRD5QcCvn200Fka9H6+0+VOf3
         tTt0MhVGZvd3lwaRHStu6TWmWzOPb/cJ0DKkEUpXKibbZYnzKQy+6ysbfPK8eFtCLACm
         vtuV2H5LbuSFYwwM38d11WDwE/jgeMM4amuYYBpGDm8YNv5uG1UIfA+soSCXntepKaLN
         XZBB7jDW683ieY6/vdNS3TIcUiHnwB2Uw+r5zET7NijjiLOn0i47biNT1i1RtWrnes/j
         yVg9u7JK8BJY7Y8PGKtz4x8g2XLeMrV/X08n5CHDCCfCVFiHRBJTmxO5PxMuYw+17lPu
         JeQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YKejBUXkQbFhZRkUnaq6l+1PH6Sz7FGa86StL/2yA7g=;
        b=gBs+3ndlcAAd8FEoX1hHX4ZHCx5ZBNPfOtQDnC0IcemDnDUcmqsrxIRp7fjgzwmKUo
         nStcqIIzqs6dceOemtm8mw6h8lSCps4ellFxvr2vhcXJiPynZGQQGIEqeJl5N8sOFAwx
         kdODI2yzI7tY1+lyXknalT+QnXl7fS9EEpQp5WUVTV4vWVqB5bNu4NyrOwjN69Bkza4p
         RHAogHV2qniugPIisPrsXbQDfBu9y42SJWxT8EnTsL8nlD2pqKRy1UY7j+o4KBlMSk8A
         e+mFl7n0AS5qWn+e8D3BBCBmckXSBax7c0FTGTJ+jOXDr688U28Aq99dNBEe8YWTP+eE
         8+bA==
X-Gm-Message-State: AOAM531SI4/Bnt9MMNqhkjYDXv/se3J8rYSphYdPvQ6wjY9sYuVLMATs
        EoPMWG3q/oYDP0vAj54c5ww=
X-Google-Smtp-Source: ABdhPJz3lTB1pRJC7LeANbY1RFJS7aAmpd27So5fwNvaM/OYQkGoVvaRsE4e7b1VyseJvPswRSBjDw==
X-Received: by 2002:a17:90b:390b:: with SMTP id ob11mr471890pjb.145.1633975354253;
        Mon, 11 Oct 2021 11:02:34 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:9f95:848b:7cc8:d852:ad42])
        by smtp.gmail.com with ESMTPSA id t9sm120679pjm.36.2021.10.11.11.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 11:02:33 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-renesas-soc@vger.kernel.org (open list:PCI DRIVER FOR RENESAS
        R-CAR)
Subject: [PATCH 12/22] PCI: rcar: Use SET_PCI_ERROR_RESPONSE() when device not found
Date:   Mon, 11 Oct 2021 23:32:06 +0530
Message-Id: <f7227e04a56e83c0a68db96b35194dddd7386a90.1633972263.git.naveennaidu479@gmail.com>
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
read occurs.

This helps unify PCI error response checking and make error check
consistent and easier to find.

Compile tested only.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/controller/pcie-rcar-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index 8f3131844e77..80dbc6f717d6 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -162,7 +162,7 @@ static int rcar_pcie_read_conf(struct pci_bus *bus, unsigned int devfn,
 	ret = rcar_pcie_config_access(host, RCAR_PCI_ACCESS_READ,
 				      bus, devfn, where, val);
 	if (ret != PCIBIOS_SUCCESSFUL) {
-		*val = 0xffffffff;
+		SET_PCI_ERROR_RESPONSE(val);
 		return ret;
 	}
 
-- 
2.25.1

