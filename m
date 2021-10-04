Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 045214215EE
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 20:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236296AbhJDSD4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 14:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235835AbhJDSDz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Oct 2021 14:03:55 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE879C061749;
        Mon,  4 Oct 2021 11:02:05 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id k26so15212478pfi.5;
        Mon, 04 Oct 2021 11:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gPh5qiPFI3S0XIvBtJdJh517PYOVsE4NLDG4oIGpMoo=;
        b=mzYG7nKQV4n2HxRXM9fB7rETP3sJkX4/Rn82nC53JPOMhlckHng8L/wMMqqYreUoVU
         1q0yC+5vomo21R4lPjPJCW6sO3brNvQ5NmyQ7oSHweT1yCJ5zDn2fwH+v4osk9SIqI/b
         F64BEgmapf4JRVbxncKTSykF2ePnFj806kvrXZ5IZpw9pmpuxPq0jR65C+tcAi3wXKGx
         ra3gpTCW0HCK5Cyuyucs/yCDjdojuIeSMYc6X6ZGG9rZSEHpoVVEuM/CuD22yHO2i3tH
         +wX7xYaYDFO54xAJwJ2DCy+4YQro7wCRvKBqJiERX8FnrZt+qkx/nVbgMV+JMuzUM31u
         WFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gPh5qiPFI3S0XIvBtJdJh517PYOVsE4NLDG4oIGpMoo=;
        b=uponVvKfXPu+rLS9aTuubRJqZf+U24/UXtNkY4QieKgieWMKSy3kp21598NopFpt3v
         PP6GllmhaesI2/iClLb6ns0ydrsopswGL4J8PpTUwCvzeb/maGRgyH0OZhVq7kVNmlFx
         cDO5Z2O0VsBYGtZoNxQ6wB/MeW5cNRnJanOWfCm5UwR2Ea2QXbu3gT1mI88Gd2BxBaLv
         HZRYk+I5+deeIHfgmkZZ5dVRgWD9pZha5Lfv88khju3olAB3koQEORdqWGOR7+7r667P
         3ldhtze+ZDs/KTnHNpKhJJYXfKfosCMyBDg/BAg6eqaZMFmq9e8tvK364uEG327uQ8i8
         K7lA==
X-Gm-Message-State: AOAM530f7OJ6Si1V6se5IZG1gBEBdUQnjcsrMFPGLbKm4WXory4cso5b
        9lN32lYC9jUveAe0OArw9tMkrbbRGd1TZUt1
X-Google-Smtp-Source: ABdhPJzerTveTTqnmsEBHMgmpX4JByTTvA8Nw57fjbDy07nms6vrNcoekHMr7OeeNEK5XeDdbB4wQw==
X-Received: by 2002:a05:6a00:1789:b0:43d:ea98:7ea8 with SMTP id s9-20020a056a00178900b0043dea987ea8mr27393301pfg.67.1633370525385;
        Mon, 04 Oct 2021 11:02:05 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:e8f0:c2a7:3579:5fe8:31d9])
        by smtp.gmail.com with ESMTPSA id z2sm3641004pfe.210.2021.10.04.11.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 11:02:05 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com, tsbogend@alpha.franken.de
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH 3/6] MIPS: OCTEON: Remove redundant enable of PCIe normal error reporting
Date:   Mon,  4 Oct 2021 23:29:29 +0530
Message-Id: <b7eb2cae4f81648a8df5885d5d5f7371a6c436e2.1633369560.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1633369560.git.naveennaidu479@gmail.com>
References: <cover.1633369560.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

e8635b484f64 ("MIPS: Add Cavium OCTEON PCI support.") added MIPS
specific code to enable PCIe and AER error reporting (*irrespective
of CONFIG_PCIEAER value*) because PCI core didn't do that at the time.

Currently when CONFIG_PCIEAER=y, the PCIe normal error reporting is
enabled by pci_enable_pcie_error_reporting() in the aer_probe() path.

It is now no longer necessary for Octeon code to enable PCIe normal
error since it's done when PCIe bus loads the AER service driver.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 arch/mips/pci/pci-octeon.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/mips/pci/pci-octeon.c b/arch/mips/pci/pci-octeon.c
index 8e8b282226cc..2c251018075c 100644
--- a/arch/mips/pci/pci-octeon.c
+++ b/arch/mips/pci/pci-octeon.c
@@ -114,13 +114,6 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
 		pci_write_config_word(dev, PCI_BRIDGE_CONTROL, config);
 	}
 
-	/* Enable the PCIe normal error reporting */
-	config = PCI_EXP_DEVCTL_CERE; /* Correctable Error Reporting */
-	config |= PCI_EXP_DEVCTL_NFERE; /* Non-Fatal Error Reporting */
-	config |= PCI_EXP_DEVCTL_FERE;	/* Fatal Error Reporting */
-	config |= PCI_EXP_DEVCTL_URRE;	/* Unsupported Request */
-	pcie_capability_set_word(dev, PCI_EXP_DEVCTL, config);
-
 	/* Find the Advanced Error Reporting capability */
 	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
 	if (pos) {
-- 
2.25.1

