Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0924215F4
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 20:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236341AbhJDSEU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 14:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236449AbhJDSEO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Oct 2021 14:04:14 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DBAC061753;
        Mon,  4 Oct 2021 11:02:21 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id m26so1963340pff.3;
        Mon, 04 Oct 2021 11:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KXqbMrl5ji7P3WLEqvYvyx/g2tHqF5Pvsy98EpcbEmA=;
        b=dK+/OiASR7/FhhaAZ1YS1MI0vNDY5l52Cxz3No+1sg7HRJnIdcgAq2YwESOyPBn6U2
         ylQrlDPi0zET4PEkuZZaCD2aMFfQFJd5zq6AkC0uFi2S2rmimoy07cpRoQDo08+j3TlM
         mm82LwXdWRtUirmQLHAQH5mBG4+PmSS85QwdWqcPmhfkFCN/BNttISWbcw9IBCdZK339
         /ZZSwBhc414AE9lM7y7WmavuWwWVzavo+q3xY267R/GbDxwoAsITSos7CCXOGaq/BVj6
         IPbA+CMtTg7ClhaFo/okYXOLZ8iemQ8vLlIPKr3K54As7GRT2CBtzx3b8o6HhtlMgguf
         rAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KXqbMrl5ji7P3WLEqvYvyx/g2tHqF5Pvsy98EpcbEmA=;
        b=VUBuCbAQ5/qDQxa6SD4YIR/YWIvHomJCREOOYn/Bbsp4hUij4pSFcCGmclwIN5DPJA
         wdeT/3vaMKFU/rb4S0rhROPMqzWoT7Hek0ySMXeYjnAJV4o2gOi+M9qrUQjwgpD2Si/H
         yS0XUAuJAfcs7iafl67uxtlD8p/ukKT6j9wfjD8WvlcKlIgHbQTIZiP028EyGP+iQuZA
         8HJP4AwnliqWHg1dmgCgmoqOoiBVV90Ku2pEMs6wT+o3ocIe2bjsGaHKMGlUynkshHTD
         oCCEdd+Omh30bRFtGtTvN3QNXtx/iLalGfhlDiLpR1QwaxxHcIzwrRKsBn5xt47+AC34
         JGlQ==
X-Gm-Message-State: AOAM530dKry3KdePLLA7+UI+M9l8o++9uOISnt8TK2DTshxxdGpl5AGn
        xxmeSk8MyHmSA5gcih2OH3c=
X-Google-Smtp-Source: ABdhPJzbBvEjkhQa/NIXLQN94nJSDDapaLKAaUE41cWvqwkMormTval0zeWCNCkCWwbjm9h9m6LR6Q==
X-Received: by 2002:a65:44c4:: with SMTP id g4mr12117582pgs.254.1633370541031;
        Mon, 04 Oct 2021 11:02:21 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:e8f0:c2a7:3579:5fe8:31d9])
        by smtp.gmail.com with ESMTPSA id z2sm3641004pfe.210.2021.10.04.11.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 11:02:20 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com, tsbogend@alpha.franken.de
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH 4/6] MIPS: OCTEON: Remove redundant enable of COR/UNCOR error
Date:   Mon,  4 Oct 2021 23:29:30 +0530
Message-Id: <ba79bae65a1955cd7f7e005f352b1b32799a1781.1633369560.git.naveennaidu479@gmail.com>
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

Currently when CONFIG_PCIEAER=y, correctable/uncorrectable errors
are enabled by set_device_error_reporting() in the aer_probe()
path.

It is now no longer necessary for Octeon code to enable PCIe COR/UNCOR
errors since it's done when PCIe bus loads the AER service driver.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 arch/mips/pci/pci-octeon.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/mips/pci/pci-octeon.c b/arch/mips/pci/pci-octeon.c
index 2c251018075c..a82cf48f00ab 100644
--- a/arch/mips/pci/pci-octeon.c
+++ b/arch/mips/pci/pci-octeon.c
@@ -117,18 +117,13 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
 	/* Find the Advanced Error Reporting capability */
 	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
 	if (pos) {
-		/* Enable reporting of all uncorrectable errors */
-		/* Uncorrectable Error Mask - turned on bits disable errors */
-		pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, 0);
 		/*
 		 * Leave severity at HW default. This only controls if
 		 * errors are reported as uncorrectable or
 		 * correctable, not if the error is reported.
 		 */
 		/* PCI_ERR_UNCOR_SEVER - Uncorrectable Error Severity */
-		/* Enable reporting of all correctable errors */
-		/* Correctable Error Mask - turned on bits disable errors */
-		pci_write_config_dword(dev, pos + PCI_ERR_COR_MASK, 0);
+
 		/* Advanced Error Capabilities */
 		pci_read_config_dword(dev, pos + PCI_ERR_CAP, &dconfig);
 		/* ECRC Generation Enable */
-- 
2.25.1

