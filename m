Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0E927A51B
	for <lists+linux-pci@lfdr.de>; Mon, 28 Sep 2020 03:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgI1BLy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Sep 2020 21:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbgI1BLs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Sep 2020 21:11:48 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718F1C0613CF;
        Sun, 27 Sep 2020 18:11:47 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id t14so6841211pgl.10;
        Sun, 27 Sep 2020 18:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=hYz3i09bYgde1rM0vRaT4FyzhxaWTWU/cqJ37aNXCfU=;
        b=DqzZ+x7nmPQ2Ds0EYkdUfdcxZq3rASUJrsBAtBQLGXZxji6U9ldHXshTGNwgJqj8xB
         7z29FO3brGUwpmiu62ZpKoJRb4Ti3dfGHpLRcaku7zyERoquJRs5EN1RfS/16tO/QiDr
         QWZQbMpwowNDLwzj5Zo9fyucDQIUM9YDjtpB0yFgoXn+R5bl4ydHOiwnoZFlfS5Dza83
         vpj5zt6uzE65i2txu0mHErN6r5TBLLcl+ppxFbEUwZotp7NV9I+QeymYjLx7BB01b+e2
         ciHqEhOz0UFR58YjWFBW8Gn2Z1Wm3KofZviVsD2pxDXytUQ0pKi3JSyNI+fLKsL8u3mK
         Dx8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=hYz3i09bYgde1rM0vRaT4FyzhxaWTWU/cqJ37aNXCfU=;
        b=MlD3XUrnBYvWwA8lklc60lhqPgMCbeqBqf6z+GuJuyZdn5xlh8UngSzaFkek/90tjT
         qdlsFZ3Z2oGCDXEksHIt42IByJfiAdfQbVNk6dv+Wmt9weHA/pkaDyIXyjTrBBM5EnJC
         wBcCSlN/9BEnqgzk3/NnjnY7tUfZUw7CRw2t8BD89ORS/sShVP32iJp+MiXvg0hHUHWC
         S4mQ2/QkodW0E2GeO88nC4/x9wZ6pTtgcxY9Nf2i2WjhIYvDISMexrCoQJIYQegsXaSA
         M2ce6t9MDFD3vVLBj9Yv0tpXs0PibCIysQJ3tyP/I7ke1dxLXew1pbehWfusXGJplGcx
         S+hQ==
X-Gm-Message-State: AOAM530FtLxt5Bx5V4UQrqQcl26fcvrdFYzBa+8WFLRPS+S/zO0cQE7e
        SikMOovgV5FZ/jxRoVXY2AA=
X-Google-Smtp-Source: ABdhPJx8WB4TvNPMl7TWltTHFi1r1gFVatcp+Sm2ZyO8n1/HhlFi8kJLgj3mjBbzWc4lNTYOmF+r6A==
X-Received: by 2002:a63:d155:: with SMTP id c21mr6982053pgj.55.1601255507099;
        Sun, 27 Sep 2020 18:11:47 -0700 (PDT)
Received: from skuppusw-mobl5.amr.corp.intel.com (jfdmzpr04-ext.jf.intel.com. [134.134.137.73])
        by smtp.gmail.com with ESMTPSA id 137sm9368048pfb.183.2020.09.27.18.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 18:11:46 -0700 (PDT)
From:   Kuppuswamy Sathyanarayanan <sathyanarayanan.nkuppuswamy@gmail.com>
X-Google-Original-From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v9 4/5] PCI/portdrv: Remove redundant pci_aer_available() check in DPC enable logic
Date:   Sun, 27 Sep 2020 18:11:35 -0700
Message-Id: <e4f72276c8bd363a97b747f4a806c27fcf49ca28.1600457297.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1600457297.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1600457297.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <cover.1600457297.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1600457297.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In DPC service enable logic, check for
services & PCIE_PORT_SERVICE_AER implies pci_aer_available()
is true. So there is no need to explicitly check it again.

Also, passing pcie_ports=dpc-native in kernel command line
implies DPC needs to be enabled in native mode irrespective
of AER ownership status. So checking for pci_aer_available()
without checking for pcie_ports status is incorrect.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/pcie/portdrv_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 2c0278f0fdcc..e257a2ca3595 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -252,7 +252,6 @@ static int get_port_device_capability(struct pci_dev *dev)
 	 * permission to use AER.
 	 */
 	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
-	    pci_aer_available() &&
 	    (host->native_dpc || (services & PCIE_PORT_SERVICE_AER)))
 		services |= PCIE_PORT_SERVICE_DPC;
 
-- 
2.17.1

