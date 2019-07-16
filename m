Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 002E46A1E6
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2019 07:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfGPFk7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Jul 2019 01:40:59 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35078 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfGPFk7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Jul 2019 01:40:59 -0400
Received: by mail-pl1-f194.google.com with SMTP id w24so9501285plp.2;
        Mon, 15 Jul 2019 22:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FBJREbuUcQWvvYEwTt/8v4/mfr5H4JRh9nPtsgNKrFQ=;
        b=FStmaG2fXrwX5CzFkIZg6EO/YNw+qvDhp92DyCelPa2sJi3LZq5MVUSbeVcSxVQxmc
         Y1Ot6uNNUSYfk0ZBQtcKNsSZJ1463h1Grj5kZxG2U+bUxidHX3za/l9Pb54SlbNBCzDm
         3gdic5/FUWKqPDyA/W6iwnzjgxUATLruZ525qiMSLAD9E1O+xc4h+CFBHSYB/JzIHwKZ
         qSzjyqPEy0APeFMRVOheO6iBLEMR5kQvKmEahCgJixTDHuJcQIqX0DWNRINI2zfEg3DM
         cEY2uuJheuQa7QpwZmH4CpWrVsrZexkrl9yFx1FVFwloR1sAWH3GNnQjyN4lMi9ZuxB+
         pQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FBJREbuUcQWvvYEwTt/8v4/mfr5H4JRh9nPtsgNKrFQ=;
        b=tJbux785XUNPIVVhRejmeKJieitaqQCNUyLDFj9b/J9VHZ1bpaIpo627sJPMAXILiq
         uhOQugUCYc6JwIVT9WgXjsBCQAOE/xtpw/aoiqafWrMC2UhUdOIBlw4a75Mshc+Elyiq
         ypvvDFNNy/h2zgK3dBjWK7u7xrcf9pwATyNCUSvGLPuQKL15WQriy24mEtRw9vhmw09A
         piKYEavdg8F2QlHiHTPmIhAc4yXQMBMcKFLdft2X6syx3PA1Q65dEYibNaO/+V6Ogrso
         lqxMouZhc1+3Eq9fSCNiBik+/bzdJ86fhvV68vWGn33jVCi6z501fx50H7ElHjcgVZ/6
         /Mkw==
X-Gm-Message-State: APjAAAWVBsUtWVE2c2ZX9hPpC7Vmbh7NrJsTVsuODajbjsiCbZ6Grlj9
        ltsxbRYJWY91ct/Agmel9aY=
X-Google-Smtp-Source: APXvYqwq+1lfPSWJQECU5s9UXm+3HSo/0MSuFP1nDOLpfciit8pWelaC7M1gUlgCfCljFzHUcWivPQ==
X-Received: by 2002:a17:902:9a95:: with SMTP id w21mr32672559plp.126.1563255658943;
        Mon, 15 Jul 2019 22:40:58 -0700 (PDT)
Received: from localhost.localdomain ([110.227.64.207])
        by smtp.gmail.com with ESMTPSA id d21sm8842201pgm.75.2019.07.15.22.40.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 22:40:58 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     thierry.reding@gmail.com, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH] pci: controller: pci-tegra: Add of_node_put() before return
Date:   Tue, 16 Jul 2019 11:10:47 +0530
Message-Id: <20190716054047.2671-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Each iteration of for_each_child_of_node puts the previous node, but in
the case of a return from the middle of the loop, there is no put, thus
causing a memory leak.
Hence store these mid-loop return values in variable err and add a new
label err_node_put which puts the previous node and returns err. Change
six mid-loop return statements to point to this new label instead.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
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

