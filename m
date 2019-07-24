Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64D48729DE
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2019 10:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbfGXIY0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Jul 2019 04:24:26 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43408 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfGXIY0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Jul 2019 04:24:26 -0400
Received: by mail-pf1-f195.google.com with SMTP id i189so20556235pfg.10;
        Wed, 24 Jul 2019 01:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J8pPUPa+7KidfkfCCesIgwvHvDbcsp6l3tDDYNj1D/w=;
        b=KP10og6p+c1YyV6KpNEDZY3gPvMy67nELMiAceHA1Ih3fFSzdPMwuk6siMrPnKB3Q7
         1AMNi0nwafWiDFpl5e0UVDq4vc4GllnrK9vf/CNGTtdZRh2mmuDuWe7NDpK6zZ0sGW1F
         a6TE87WGTngv5hvfhLty3C7BsJE9bKZERBow3+qgXqSSQ4MDP8mf9SHKcqzwA02vqdmn
         GYpYTTwJ3juEYDrY6alqaF6GE3iy9oxAheJvIons5DdEexHYP1WLVC6vXga83slgoGbA
         u/WixjsvBVaU2FT1+VEWBIOXuQmo9q+lYAQJaYOjcMEtw69lU3av29Q7q2YbPNJHsj11
         mCjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J8pPUPa+7KidfkfCCesIgwvHvDbcsp6l3tDDYNj1D/w=;
        b=pcBmIigMF5xEugVHZgIKYykGi8hgbMIHwynBbpVWn+D8puKbhpjDGWvosO5RVaDptB
         WHj1WAbZ6j0TVLDC/TKsvDmeXD39p8ns9Ir5ml+LJz6LSh8UjS6lB0uVKpIv/R6YUhsc
         I/GcnzLA37lhDOwJ/U61qYf6wGqHosNj5Rg6qqDVeaCMGkbFX7VMtF0RSEYWdIQEJScw
         pnbh9s5EgasEkqyAs5bC0taXd/h3Lo0P4jr9bO4cZyyTKSr4VLXQct5Bf8qb5p1jZ7tO
         NITBCVCxigyQ0pye5wGHJFLx+SNLswfQMh/lCy+E3XNbrBA/AopuTKMbDbTCiBsXf6Yi
         0h0A==
X-Gm-Message-State: APjAAAXP2ATePMNVAtS1VX788iiJ1pkNS04CH2KFeFTkQvk+19eA5Oxd
        SgpS653ePssSIrkPrmIL6FM=
X-Google-Smtp-Source: APXvYqw280x2Tt5H16gFgHEdDaquPHYzBtNz3Lse9hNztSoqw6v2qbLRmcABPuac59iXkEeHzru78Q==
X-Received: by 2002:a17:90a:2244:: with SMTP id c62mr88450151pje.29.1563956665667;
        Wed, 24 Jul 2019 01:24:25 -0700 (PDT)
Received: from localhost.localdomain ([110.227.69.93])
        by smtp.gmail.com with ESMTPSA id g8sm44040438pgk.1.2019.07.24.01.24.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 01:24:24 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     thierry.reding@gmail.com, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH] PCI: tegra: Add of_node_put() before return to fix reference leak
Date:   Wed, 24 Jul 2019 13:54:12 +0530
Message-Id: <20190724082412.9943-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Each iteration of for_each_child_of_node() puts the previous node, but
in the case of a return from the middle of the loop, there is no put,
thus causing a reference leak.

Hence store these mid-loop return values in variable err and add a new
label err_node_put which puts the previous node and returns err. Change
six mid-loop return statements to point to this new label instead.

Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
Changes in v2: 
- Edit subject line to better reflect changes and match other patches on
  this driver.
- Edit commit message for readability and accuracy.

 drivers/pci/controller/pci-tegra.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 9a917b2456f6..673a1725ef38 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -2237,14 +2237,15 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
 		err = of_pci_get_devfn(port);
 		if (err < 0) {
 			dev_err(dev, "failed to parse address: %d\n", err);
-			return err;
+			goto err_node_put;
 		}
 
 		index = PCI_SLOT(err);
 
 		if (index < 1 || index > soc->num_ports) {
 			dev_err(dev, "invalid port number: %d\n", index);
-			return -EINVAL;
+			err = -EINVAL;
+			goto err_node_put;
 		}
 
 		index--;
@@ -2253,12 +2254,13 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
 		if (err < 0) {
 			dev_err(dev, "failed to parse # of lanes: %d\n",
 				err);
-			return err;
+			goto err_node_put;
 		}
 
 		if (value > 16) {
 			dev_err(dev, "invalid # of lanes: %u\n", value);
-			return -EINVAL;
+			err = -EINVAL;
+			goto err_node_put;
 		}
 
 		lanes |= value << (index << 3);
@@ -2272,13 +2274,15 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
 		lane += value;
 
 		rp = devm_kzalloc(dev, sizeof(*rp), GFP_KERNEL);
-		if (!rp)
-			return -ENOMEM;
+		if (!rp) {
+			err = -ENOMEM;
+			goto err_node_put;
+		}
 
 		err = of_address_to_resource(port, 0, &rp->regs);
 		if (err < 0) {
 			dev_err(dev, "failed to parse address: %d\n", err);
-			return err;
+			goto err_node_put;
 		}
 
 		INIT_LIST_HEAD(&rp->list);
@@ -2330,6 +2334,10 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
 		return err;
 
 	return 0;
+
+err_node_put:
+	of_node_put(port);
+	return err;
 }
 
 /*
-- 
2.19.1

