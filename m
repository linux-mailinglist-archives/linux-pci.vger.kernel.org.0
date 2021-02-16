Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6991231D1CE
	for <lists+linux-pci@lfdr.de>; Tue, 16 Feb 2021 22:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhBPVAT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Feb 2021 16:00:19 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:45986 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhBPVAT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Feb 2021 16:00:19 -0500
Received: by mail-wr1-f53.google.com with SMTP id v7so14961862wrr.12
        for <linux-pci@vger.kernel.org>; Tue, 16 Feb 2021 13:00:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jEO0REltWycHmOyy+3ZDFWWdMIM1IhhKHYVeX58bE90=;
        b=mTbUsgIvHo1ZZumIjGHwLleMwei+ufxETqY5YiunmaXeLlT1wGa6sjmE0SbXp+BPh/
         nVFAeP1rkx4tiLx8Z2NVVk97cg3Sf181SNHs9rZkr98GI912GakFukFVnsjpHUqkW6nJ
         cliqqMdmcMu4TdK6quMkXehW33u15Pe/wKslk+ddy7RQpSeHwa1Hl/ha5bdzLMFosvE0
         n6180QOCPLEFXZSlykOlOqDY/rlvZiia1G9wlOvsHcyfEDaqSMa5jETEZfTjLoNLkMMd
         KHLt3CkqXl6urYoCd8WLit09gMR3hPTl0pjO+ffQ+yLFnbSVAK/udjMkeA7kucrKlWaa
         Etlw==
X-Gm-Message-State: AOAM530zdOMtxJO4+xUEnsed9QSXkSQKmKAV6U/QVzazt16zKOB0+Skw
        8eEWQzNjeyC980sYJQTI/64=
X-Google-Smtp-Source: ABdhPJxNV2oENdEijYNTHZ6O6dWgIJPTN+CkqJtoED18cAFHGSamUJBMwrMPTDz5tYsvCYUiR4CjEQ==
X-Received: by 2002:adf:e80d:: with SMTP id o13mr26153999wrm.113.1613509177318;
        Tue, 16 Feb 2021 12:59:37 -0800 (PST)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id c140sm5372496wmd.37.2021.02.16.12.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 12:59:36 -0800 (PST)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Tom Joseph <tjoseph@cadence.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH] PCI: cadence: Fix erroneous early return from an iterator
Date:   Tue, 16 Feb 2021 20:59:35 +0000
Message-Id: <20210216205935.3112661-1-kw@linux.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Function cdns_pcie_host_map_dma_ranges() iterates over a PCIe host
bridge DMA ranges using the resource_list_for_each_entry() iterator.

With every iteration it calls cdns_pcie_host_bar_config() on each entry
in the list, and performs error checking following execution of said
function.

Normally, should there be an error, the iteration would be interrupted
and the function would terminate returning an error, but following the
merge commit 49e427e6bdd1 ("Merge branch 'pci/host-probe-refactor'")
that also had to resolve a merge conflict of the pcie-cadence-host.c
file, where an if-statement involved in the error handling has been
unintentionally altered causing a return statement to be outside of the
code block, and thus an undesired early return takes place on first
iteration.

Fix the if-statement and move the return statement inside the correct
code block so that the error checking works correctly, and to prevent
undesired early return.

Fixes: 49e427e6bdd1 ("Merge branch 'pci/host-probe-refactor'")
Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/controller/cadence/pcie-cadence-host.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index 811c1cb2e8de..1cb7cfc75d6e 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -321,9 +321,10 @@ static int cdns_pcie_host_map_dma_ranges(struct cdns_pcie_rc *rc)
 
 	resource_list_for_each_entry(entry, &bridge->dma_ranges) {
 		err = cdns_pcie_host_bar_config(rc, entry);
-		if (err)
+		if (err) {
 			dev_err(dev, "Fail to configure IB using dma-ranges\n");
-		return err;
+			return err;
+		}
 	}
 
 	return 0;
-- 
2.30.0

