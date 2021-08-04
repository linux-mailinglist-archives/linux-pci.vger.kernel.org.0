Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAECB3E0986
	for <lists+linux-pci@lfdr.de>; Wed,  4 Aug 2021 22:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240955AbhHDUmz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Aug 2021 16:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240941AbhHDUmy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Aug 2021 16:42:54 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DA0C0613D5;
        Wed,  4 Aug 2021 13:42:40 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id u21-20020a17090a8915b02901782c36f543so1684197pjn.4;
        Wed, 04 Aug 2021 13:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iybQZ12qC8zX6NnxQv/Qw71ae7yPExH0GdYjIRAaEIA=;
        b=krXVd6iYOCiBmrISEPNKZoS0nJTAWjnZlkp62UzBFBcp5nG5UD0Ho2D+fycqcckAtV
         6zrp3+YnF1+lyMNc55OBYROIzoolTEg+Z/uR0uGu6kmHu14D2W4jgXMrL92qp6F/d4YN
         4Nt6z1sRPE/mRk+nGAkydo1zMAEcNpmZ27h5fO+y8TfTgr78FfI2zvSnk2vW3ExZESqe
         p34ur/Rw+eMDFNu+5wrYe2hxSnsvNxKgUYbxwcMWrkIICJAvP+vmpIi76d23bMfsJNQ2
         HAiLq89ROG/kJ+L3pwlc1iBG+bOMfhMM3GUEwoqbufqAGIbTXZnEOZ7WoYEz1qwW3elo
         eZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iybQZ12qC8zX6NnxQv/Qw71ae7yPExH0GdYjIRAaEIA=;
        b=iVmXTexnz24A9ESXBM1qIqLBQMEc3IBVCWXxZb3Q8tJv2TpTKxrsgCG4eYxBePkUFC
         +M0WAkDWDMSI/ljz7zdN3lhI/DSPAZ0uUlFGfmekUOyTbOApXHGbOh6wxHIpRldaCFM2
         RLAKV9ILTGiK4ZPWM2zz4NHAO1X2aAG94QQ3rrognWz+1BDedtv5yVvNcD0WAh353q/q
         l7zeSYnzmTjs/6bGexIpmv2xDVHxTUA+w/I6AXQPqgumnKGOEZ1q/eLZeXgaQmHUEP2u
         Ish1saIE9uJVDgOXcZjCJP8H3uzfiDBb1kgznAbCZJAi6wEddafPHc+CCvf1lfL/efbQ
         r8MQ==
X-Gm-Message-State: AOAM531ZeaU6/hB5taJ92a8VlOeDD4kik+cPSwA4Bvicp4/IrbQJT14e
        zu8z8x9p0BuG2MphPZgvQQk=
X-Google-Smtp-Source: ABdhPJzTHis84eT4EZ7sX7bfL1Wgr7J/x9/vNfVxiO8Po8g/xqbMOfHk3pQeskvu41mNxf60ol9FZA==
X-Received: by 2002:a62:584:0:b029:32e:3b57:a1c6 with SMTP id 126-20020a6205840000b029032e3b57a1c6mr1498411pff.13.1628109760029;
        Wed, 04 Aug 2021 13:42:40 -0700 (PDT)
Received: from localhost.localdomain ([139.5.31.161])
        by smtp.googlemail.com with ESMTPSA id w2sm7064922pjt.14.2021.08.04.13.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 13:42:39 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v14 6/9] PCI: Define a function to set ACPI_COMPANION in pci_dev
Date:   Thu,  5 Aug 2021 02:11:58 +0530
Message-Id: <20210804204201.1282-7-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210804204201.1282-1-ameynarkhede03@gmail.com>
References: <20210804204201.1282-1-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Shanker Donthineni <sdonthineni@nvidia.com>

Move the existing code logic from acpi_pci_bridge_d3() to a separate
function pci_set_acpi_fwnode() to set the ACPI fwnode.

No functional change with this patch.

Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
---
 drivers/pci/pci-acpi.c | 12 ++++++++----
 drivers/pci/pci.h      |  2 ++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 36bc23e21759..eaddbf701759 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -934,6 +934,13 @@ static pci_power_t acpi_pci_choose_state(struct pci_dev *pdev)
 
 static struct acpi_device *acpi_pci_find_companion(struct device *dev);
 
+void pci_set_acpi_fwnode(struct pci_dev *dev)
+{
+	if (!ACPI_COMPANION(&dev->dev) && !pci_dev_is_added(dev))
+		ACPI_COMPANION_SET(&dev->dev,
+				   acpi_pci_find_companion(&dev->dev));
+}
+
 static bool acpi_pci_bridge_d3(struct pci_dev *dev)
 {
 	const struct fwnode_handle *fwnode;
@@ -945,11 +952,8 @@ static bool acpi_pci_bridge_d3(struct pci_dev *dev)
 		return false;
 
 	/* Assume D3 support if the bridge is power-manageable by ACPI. */
+	pci_set_acpi_fwnode(dev);
 	adev = ACPI_COMPANION(&dev->dev);
-	if (!adev && !pci_dev_is_added(dev)) {
-		adev = acpi_pci_find_companion(&dev->dev);
-		ACPI_COMPANION_SET(&dev->dev, adev);
-	}
 
 	if (adev && acpi_device_power_manageable(adev))
 		return true;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 31458d48eda7..8ef379b6cfad 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -703,7 +703,9 @@ static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL
 #ifdef CONFIG_ACPI
 int pci_acpi_program_hp_params(struct pci_dev *dev);
 extern const struct attribute_group pci_dev_acpi_attr_group;
+void pci_set_acpi_fwnode(struct pci_dev *dev);
 #else
+static inline void pci_set_acpi_fwnode(struct pci_dev *dev) {}
 static inline int pci_acpi_program_hp_params(struct pci_dev *dev)
 {
 	return -ENODEV;
-- 
2.32.0

