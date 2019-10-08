Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9F6DCF069
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2019 03:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729839AbfJHBX2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Oct 2019 21:23:28 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46070 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729389AbfJHBX2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Oct 2019 21:23:28 -0400
Received: by mail-ot1-f66.google.com with SMTP id 41so12694811oti.12
        for <linux-pci@vger.kernel.org>; Mon, 07 Oct 2019 18:23:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c1JUp7u0KSGfaRux5uJpGZoHHwUhNboiyuQ9nvLMtvk=;
        b=n3+mx5Wt056mGhMeBr7Aa2IJ86KEdCCndbzR+hgNWsKOmoJuWbGbsfaDRTGR3PCIET
         ODTN3tDIWrWhk74wE/qDv9b/gyMLXrOjx0mMaDQcHWS92X+gIEp4jyRCGleYc43cGpKj
         mlTXu1VAe36l52Tock4eo5oQ3PK1TIDzfS2fqIXiMHZ2RvhRE0RdGSxzDE2Hk3AXcWJB
         /SKhQNGfi5WBPQbiMG3bA0Y/fmn3TbrulSed3rOPHi7X26z8GZhlwx6A2k+SKh2dbfiY
         r+4Fj71v26Z0bKpj1jVow30f5GDgxsf72K6qxB+q8bRkLDaLLX23HNjhT8/R1vkVOLpj
         ju1w==
X-Gm-Message-State: APjAAAXOJMIOhQmqbPx3NEcHzkl71q5xNXpRoMYfnh/MWsexPtR8h4CG
        51WZuJiRXYadGDhi7ZttjwlnQgg=
X-Google-Smtp-Source: APXvYqyCu5soxFuz898V8afhHSfm3B3RsbwqsNBr0/hFhO3oE64DnXno1/3nvSd9iJYEKYqKhbHMxA==
X-Received: by 2002:a9d:72d4:: with SMTP id d20mr1362905otk.214.1570497806548;
        Mon, 07 Oct 2019 18:23:26 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id n4sm5165190oij.9.2019.10.07.18.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 18:23:25 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Srinath Mannam <srinath.mannam@broadcom.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: Fix missing bridge dma_ranges resource list cleanup
Date:   Mon,  7 Oct 2019 20:23:25 -0500
Message-Id: <20191008012325.25700-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit e80a91ad302b ("PCI: Add dma_ranges window list") added a
dma_ranges resource list, but failed to correctly free the list when
devm_pci_alloc_host_bridge() is used.

Only the iproc host bridge driver is using the dma_ranges list.

Fixes: e80a91ad302b ("PCI: Add dma_ranges window list")
Cc: Srinath Mannam <srinath.mannam@broadcom.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/probe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 3d5271a7a849..bdbc8490f962 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -572,6 +572,7 @@ static void devm_pci_release_host_bridge_dev(struct device *dev)
 		bridge->release_fn(bridge);
 
 	pci_free_resource_list(&bridge->windows);
+	pci_free_resource_list(&bridge->dma_ranges);
 }
 
 static void pci_release_host_bridge_dev(struct device *dev)
-- 
2.20.1

