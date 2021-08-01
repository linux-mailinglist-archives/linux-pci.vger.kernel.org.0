Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 346523DCC0D
	for <lists+linux-pci@lfdr.de>; Sun,  1 Aug 2021 16:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbhHAO0A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 1 Aug 2021 10:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbhHAOZ7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 1 Aug 2021 10:25:59 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4AFC0613D5;
        Sun,  1 Aug 2021 07:25:50 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id u2so8400699plg.10;
        Sun, 01 Aug 2021 07:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iybQZ12qC8zX6NnxQv/Qw71ae7yPExH0GdYjIRAaEIA=;
        b=eVCWxov1kLBKxhp+ey72e4XW3PPvLfWABIIKNCk5VxNW0OZOfGrXzMDSfAI5BOgxAy
         6b3nHdNKEv08kqA0s5MRLY/4PUExHOoD0IQNoyyxREj6MjnW1t2W9rlrRb2D1hMdptgL
         61p8U82+DJse9VHhMEgVLZTFRYSxU70toVASXYle0QjchzCjQTTUV/I/ZckNTh/Zm10e
         uYrhU8PK03kRIDWwF093brISAenalODaMpkPViDdzyw79PRvt+Ccp6wlM8fSHfvcjTha
         IPMGUJ+qbNGwaa6mQ3eIipRFAHV0LLsPpsxuX9W8gmDRuZ07qTG7hwV/OO9GR37bLcyT
         alBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iybQZ12qC8zX6NnxQv/Qw71ae7yPExH0GdYjIRAaEIA=;
        b=HtvssVIZU9LKuLd4NdujQLh9SZBNPhD4F7vNigKvNtkDpcdJ9s6Una+slDXCGQ93ny
         ZSD4N0SqgFXf1v3bkbrdgH3w697ZoP+baXEfIH9aEUsPUVTzecbRlMDqxS9D+BM1Dl3U
         pyAV1pi0KBlpTKWU941392iolT704/G0Nr9G7wpEiqKk9daxV1QopwA7QAX1hQx/Cgdm
         tbf5zi3rOGfMQFhGLBgTDL9VAd41+/IpQHaCwHnzmzgqnCSKCE2E6mUwqA0jRrm/OOdS
         a3ZvN7qs/DAKoc0v6wWtSfIUL5Qe0X2kO9+VlR+t1/hM4VGgf3VoLkJ9ZszyuVmyeywO
         MX8g==
X-Gm-Message-State: AOAM531/9MKa9jBeGA8eX4tAg0j+Bgn8IJ+T1410nHZUkwYtGkj5ALoo
        FEkaPreCj8W7HMA4ROYI7JY=
X-Google-Smtp-Source: ABdhPJz8BDQA8ZXZqmZyKa4HZSNJlkZNaoWn9DRk5+dWJ1PQswsQfZtUpohTNm1m49AgoG7NC8T/RA==
X-Received: by 2002:a62:ee11:0:b029:32f:955e:aec with SMTP id e17-20020a62ee110000b029032f955e0aecmr12471537pfi.31.1627827950324;
        Sun, 01 Aug 2021 07:25:50 -0700 (PDT)
Received: from localhost.localdomain ([139.5.31.186])
        by smtp.googlemail.com with ESMTPSA id g11sm7740897pju.13.2021.08.01.07.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 07:25:50 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v13 6/9] PCI: Define a function to set ACPI_COMPANION in pci_dev
Date:   Sun,  1 Aug 2021 19:55:15 +0530
Message-Id: <20210801142518.1224-7-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210801142518.1224-1-ameynarkhede03@gmail.com>
References: <20210801142518.1224-1-ameynarkhede03@gmail.com>
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

