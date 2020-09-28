Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0A6627A51E
	for <lists+linux-pci@lfdr.de>; Mon, 28 Sep 2020 03:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgI1BLy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Sep 2020 21:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgI1BLs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Sep 2020 21:11:48 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE48C0613D3;
        Sun, 27 Sep 2020 18:11:48 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d6so7816349pfn.9;
        Sun, 27 Sep 2020 18:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=RbUPOCBGx+/qJrr8Ez4S2C0kNlWb8mn3aBv1N3ThozA=;
        b=nHs4v/psceHvzps3ZT99hLuEQ8WjgLpnAExURL2mvFuUFcCPQPc3uoNAW4I9Qlkbe0
         oJgP4cmyax8rXOIoA6my6s9p2ttuZL6MxggpLXsvdw6pWHea/DuYlSv4JOn5shKePQTR
         d1mHTNUp+G6cNrPy9CDjgCR2J8tWGEZyhcrljQrKfQSwPAAiAc6GdXHcArxH/hLN8Htq
         FxT0y5LMWKKRyOpZ9RcZw4TsUs2yfZDNn09gEv3YGP+Qp492WUH99Usy0Z16vYXXBv8U
         PFyPtwmeQTDou3Juv7N08BZCT3xYYXoAAOtLPEq2H/ZOd5xlEA8cHixo+FUUDG7IMBkH
         JEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=RbUPOCBGx+/qJrr8Ez4S2C0kNlWb8mn3aBv1N3ThozA=;
        b=s4FOyvLj3AQM6euacwkTQx6j+sLYvacn5EMZofSuPZVQ7lxVrOQEz//wVR0U83ULdj
         oVSq5Q4QtBurHhtZVDieUdu1sBiY5Zm/Iibav+R+6QuEJGInGa4P2KP/YED+qDgAWsZR
         XsJbWFhNr3HaPCnJkzYwyZl9TjnDNynoVs8oot449P3VB52Jy5i3ytJGO5Vn8Wz8+Qsq
         +nTnOdehPddRyR5UNPndyhaAmIJJXKvMmoFxbdZ7x+6xDWIG25Xu+rjk3zKjYpWV/eqi
         ugbs3B2O70ZqaVDBeUsuxNLhALjVheWyhGWzDqB7Ih4PHVpyI9hXwSl62ktvwnZ8BDUo
         y3QA==
X-Gm-Message-State: AOAM5336bR9cPBxqwvvq+91l2EXGtOq98wqX5yQlOG9NbxqPEbg+/BGw
        mYkJhtDNF9418SgScys0aMk=
X-Google-Smtp-Source: ABdhPJzR6mNaHD4aBGMs33RtBN05y5uhj/c3/4/5pGOMJI/j41YGeCvXWhJjAQGxaY27lCVYaZ7oZg==
X-Received: by 2002:a63:c112:: with SMTP id w18mr7035284pgf.31.1601255507887;
        Sun, 27 Sep 2020 18:11:47 -0700 (PDT)
Received: from skuppusw-mobl5.amr.corp.intel.com (jfdmzpr04-ext.jf.intel.com. [134.134.137.73])
        by smtp.gmail.com with ESMTPSA id 137sm9368048pfb.183.2020.09.27.18.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 18:11:47 -0700 (PDT)
From:   Kuppuswamy Sathyanarayanan <sathyanarayanan.nkuppuswamy@gmail.com>
X-Google-Original-From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v9 5/5] PCI/DPC: Move AER/DPC dependency checks out of DPC driver
Date:   Sun, 27 Sep 2020 18:11:36 -0700
Message-Id: <2c112fb150348099af5db2f399b21968ab6577e3.1600457297.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1600457297.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1600457297.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <cover.1600457297.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1600457297.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently, AER and DPC Capabilities dependency checks is
distributed between DPC and portdrv service drivers. So move
them out of DPC driver.

Also, since services & PCIE_PORT_SERVICE_AER check already
ensures AER native ownership, no need to add additional
pcie_aer_is_native() check.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/pcie/dpc.c          | 4 ----
 drivers/pci/pcie/portdrv_core.c | 1 +
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 5b1025a2994d..6261b0382f65 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -280,14 +280,10 @@ void pci_dpc_init(struct pci_dev *pdev)
 static int dpc_probe(struct pcie_device *dev)
 {
 	struct pci_dev *pdev = dev->port;
-	struct pci_host_bridge *host = pci_find_host_bridge(pdev->bus);
 	struct device *device = &dev->device;
 	int status;
 	u16 ctl, cap;
 
-	if (!pcie_aer_is_native(pdev) && !host->native_dpc)
-		return -ENOTSUPP;
-
 	status = devm_request_threaded_irq(device, dev->irq, dpc_irq,
 					   dpc_handler, IRQF_SHARED,
 					   "pcie-dpc", pdev);
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index e257a2ca3595..ffa1d9fc458e 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -252,6 +252,7 @@ static int get_port_device_capability(struct pci_dev *dev)
 	 * permission to use AER.
 	 */
 	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
+	    host->native_dpc &&
 	    (host->native_dpc || (services & PCIE_PORT_SERVICE_AER)))
 		services |= PCIE_PORT_SERVICE_DPC;
 
-- 
2.17.1

