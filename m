Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC5944CC68
	for <lists+linux-pci@lfdr.de>; Wed, 10 Nov 2021 23:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbhKJWUn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Nov 2021 17:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233592AbhKJWUZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Nov 2021 17:20:25 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAC4C0797BA;
        Wed, 10 Nov 2021 14:15:14 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id b4so3434234pgh.10;
        Wed, 10 Nov 2021 14:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EzGuitgr5O7QkVIiJlPIGcCv/kBFTEjV8U/C16lgEUk=;
        b=FanXgsDdNmpBuR87HQ/95pOEL7eiqfg809EOeaUMLygY4L8gdozqDhl4Rww2YnyJuY
         hRKNlXUd4/M/dt87G/Wr19KZKa0XLq5EtTdC2aQAK76liCfodzUFvoZDgPgXEYHbkRSw
         RIPf6RyKu20IaT/rMAx1gRBmO3sLjNYrgEyN9ayQMfbUrVilQiTfGQjfQaoCKqHGe84m
         EXFHCdaL0iBPcMRwmfkmvxCmWAZB9zZ4YjvJpHPczN3EIqFw6jxMd5ckKQKzjWYxHuPc
         x/J0D9VoxTB6QlF+VJtSojweXim03rliOICN2RDlE84OwhmOne1a5h+9zZKccaXpuJdm
         SRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EzGuitgr5O7QkVIiJlPIGcCv/kBFTEjV8U/C16lgEUk=;
        b=KIiL0kyPMCrewZQOl69LtuID/FTALwumceDh63S1OQVpfdQHtI+0P1C79jepLWlBc3
         AL9WyZo2MmX1u8OCwKjJ9P49yK7wMIZOENaDGYbS4On3NFfkEwpDDggVUWt38ta9NO4j
         NLSDgF9hH6BmZmlQFv3ezKkJ82IxeGCRPngKgJwuJGSvRx/lF1TNjNjYGSr463gynTeU
         rJzql53YmOKKwmmS+6r9Y1/kI3uju8MCK0zKec6zNSsnhSrcrw8bokqNCeKlMOj02GmG
         Z0cdPJ413Q87fiM1+QEAX4LOMzfI+prCho7OqN/8VKtyRPnBWWqNR94YuQ+XXf/rSpns
         jTFw==
X-Gm-Message-State: AOAM533Qr87eRjE8loc58FIL1/aJhh54/R4JIT3dD0lhxd3bAKTlIvC9
        98JDEQ1cc5tf37z7JKc6WLwyK5AVmhRMVg==
X-Google-Smtp-Source: ABdhPJw4Nk8losN6D8MhiPpD5tsdOSh608Q5s6DLTLlcmUPPrtsJ1nAaftriEL21/t/6yrICZBC1MQ==
X-Received: by 2002:a05:6a00:10d1:b0:47b:aa9b:1e7a with SMTP id d17-20020a056a0010d100b0047baa9b1e7amr2325924pfu.57.1636582513951;
        Wed, 10 Nov 2021 14:15:13 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id q11sm611774pfk.192.2021.11.10.14.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 14:15:13 -0800 (PST)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Sean V Kelley <sean.v.kelley@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Keith Busch <kbusch@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v8 4/8] PCI/portdrv: Create pcie_is_port_dev() func from existing code
Date:   Wed, 10 Nov 2021 17:14:44 -0500
Message-Id: <20211110221456.11977-5-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211110221456.11977-1-jim2101024@gmail.com>
References: <20211110221456.11977-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The function will be needed elsewhere in a few commits.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/pci.h              |  2 ++
 drivers/pci/pcie/portdrv_pci.c | 23 ++++++++++++++++++-----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 1cce56c2aea0..c2bd1995d3a9 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -744,4 +744,6 @@ extern const struct attribute_group aspm_ctrl_attr_group;
 
 extern const struct attribute_group pci_dev_reset_method_attr_group;
 
+bool pcie_is_port_dev(struct pci_dev *dev);
+
 #endif /* DRIVERS_PCI_H */
diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index c7ff1eea225a..63f2a87e9db8 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -90,6 +90,23 @@ static const struct dev_pm_ops pcie_portdrv_pm_ops = {
 #define PCIE_PORTDRV_PM_OPS	NULL
 #endif /* !PM */
 
+bool pcie_is_port_dev(struct pci_dev *dev)
+{
+	int type;
+
+	if (!dev)
+		return false;
+
+	type = pci_pcie_type(dev);
+
+	return pci_is_pcie(dev) &&
+		((type == PCI_EXP_TYPE_ROOT_PORT) ||
+		 (type == PCI_EXP_TYPE_UPSTREAM) ||
+		 (type == PCI_EXP_TYPE_DOWNSTREAM) ||
+		 (type == PCI_EXP_TYPE_RC_EC));
+}
+EXPORT_SYMBOL_GPL(pcie_is_port_dev);
+
 /*
  * pcie_portdrv_probe - Probe PCI-Express port devices
  * @dev: PCI-Express port device being probed
@@ -104,11 +121,7 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
 	int type = pci_pcie_type(dev);
 	int status;
 
-	if (!pci_is_pcie(dev) ||
-	    ((type != PCI_EXP_TYPE_ROOT_PORT) &&
-	     (type != PCI_EXP_TYPE_UPSTREAM) &&
-	     (type != PCI_EXP_TYPE_DOWNSTREAM) &&
-	     (type != PCI_EXP_TYPE_RC_EC)))
+	if (!pcie_is_port_dev(dev))
 		return -ENODEV;
 
 	if (type == PCI_EXP_TYPE_RC_EC)
-- 
2.17.1

