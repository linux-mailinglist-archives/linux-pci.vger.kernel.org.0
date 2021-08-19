Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC1233F1C28
	for <lists+linux-pci@lfdr.de>; Thu, 19 Aug 2021 17:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbhHSPFl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Aug 2021 11:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhHSPFj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Aug 2021 11:05:39 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD24C061575;
        Thu, 19 Aug 2021 08:05:02 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id q11so9597242wrr.9;
        Thu, 19 Aug 2021 08:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KNs0XZsqcquyt15ij0j3IP+57uuSZytRU9SIhFpuBmM=;
        b=UGNu2HwU59wSnOuHp67G1NVODqe3RooN/VXZzBGZzDl1cLYK1Ch2q2HeadXUz/YjLn
         hF4XD+Pne3OL2s34pYMRQaN8qTfpTmYlxef3TseXCMEXTIlZED+W2TXYdSnK7UT+Rxq9
         Kfspv950zUgmWQ/qWbxF1cg5HwFPB0EvpflTfOGW1maudY8Sf+hy/nKxJwj6H8n9G2/c
         mEK3QtZbao1DFAqX3xMEwnQWvIm2fUNiuHs8ML5nbbZZdZJglVhDI8aLmtN75ZF+lm6Z
         kVHJfr6tOP/DYJo2KzyuJzyo2pJkknvGjkTOaEj5Csy7+1NmZsPFjq8JwDff1JyBTPxO
         c6Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KNs0XZsqcquyt15ij0j3IP+57uuSZytRU9SIhFpuBmM=;
        b=AnRrkzyzye6QhOl6zSBKP2H5PmLe1RHPXtpBemVOFGFTS8Onj10OpwLDIIPmSHlQcj
         GYfeihQd3eV6YPnZ5q9BVmMNtBMbQO3RzdQqu+B1zsXBdEy74wz7XLTM2S60X5kCVjnl
         QzXY1LBnxU3kv1HP5cs0n3ijH4o8xkTLmlFBn363mEmTqg6NY9f48P0jIVGC9NFM0tv2
         M2iFfXE+6y3xUoY/d7m84Uxg77b1Sn4axfEsfGdD3PlvhG5XgDOI/Ca7VBD/uB6XlZuZ
         c2QNd/QZYj/pNv/BlIn8e9bHz/LMVkITukP7V6T8TNPnNcr/OJ/ssLA7IkN48j4AxOah
         NrWQ==
X-Gm-Message-State: AOAM53079P6S3IZ+pp2WB/wLXdrAU8Ti5eyvncQkhnw5N+IYh/muupyd
        IciuryHRUT2lhsAt60uCCOt/x2sKDhc=
X-Google-Smtp-Source: ABdhPJxKSOc3ZQM5yn5QTGXL+01uzh0smupx/0lNuR2ntoSFnY73l4TL68PSCBcNcRlnfM1z6R0yXw==
X-Received: by 2002:a5d:4490:: with SMTP id j16mr4358642wrq.272.1629385501287;
        Thu, 19 Aug 2021 08:05:01 -0700 (PDT)
Received: from localhost.localdomain (arl-84-90-178-246.netvisao.pt. [84.90.178.246])
        by smtp.gmail.com with ESMTPSA id z137sm8234022wmc.14.2021.08.19.08.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 08:05:00 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Tomas Winkler <tomas.winkler@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Ionel-Catalin Mititelu <ionel-catalin.mititelu@intel.com>,
        Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v2] mei: improve Denverton HSM & IFSI support
Date:   Thu, 19 Aug 2021 17:04:59 +0200
Message-Id: <20210819150459.21545-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Intel Denverton chip provides HSM & IFSI. In order to access
HSM & IFSI at the same time, provide two HECI hardware IDs for accessing.

Suggested-by: Ionel-Catalin Mititelu <ionel-catalin.mititelu@intel.com>
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Tomas, please pick this quick helpful extension for the hardware.

 drivers/misc/mei/hw-me-regs.h | 3 ++-
 drivers/misc/mei/pci-me.c     | 1 +
 drivers/pci/quirks.c          | 3 +++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/mei/hw-me-regs.h b/drivers/misc/mei/hw-me-regs.h
index cb34925e10f1..a436cbde2dd2 100644
--- a/drivers/misc/mei/hw-me-regs.h
+++ b/drivers/misc/mei/hw-me-regs.h
@@ -68,7 +68,8 @@
 #define MEI_DEV_ID_BXT_M      0x1A9A  /* Broxton M */
 #define MEI_DEV_ID_APL_I      0x5A9A  /* Apollo Lake I */
 
-#define MEI_DEV_ID_DNV_IE     0x19E5  /* Denverton IE */
+#define MEI_DEV_ID_DNV_IE     0x19E5  /* Denverton for HECI1 - IFSI */
+#define MEI_DEV_ID_DNV_IE_2   0x19E6  /* Denverton 2 for HECI2 - HSM */
 
 #define MEI_DEV_ID_GLK        0x319A  /* Gemini Lake */
 
diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index c3393b383e59..30827cd2a1c2 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -77,6 +77,7 @@ static const struct pci_device_id mei_me_pci_tbl[] = {
 	{MEI_PCI_DEVICE(MEI_DEV_ID_APL_I, MEI_ME_PCH8_CFG)},
 
 	{MEI_PCI_DEVICE(MEI_DEV_ID_DNV_IE, MEI_ME_PCH8_CFG)},
+	{MEI_PCI_DEVICE(MEI_DEV_ID_DNV_IE_2, MEI_ME_PCH8_SPS_CFG)},
 
 	{MEI_PCI_DEVICE(MEI_DEV_ID_GLK, MEI_ME_PCH8_CFG)},
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 6899d6b198af..2ab767ef8469 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4842,6 +4842,9 @@ static const struct pci_dev_acs_enabled {
 	{ PCI_VENDOR_ID_INTEL, 0x15b7, pci_quirk_mf_endpoint_acs },
 	{ PCI_VENDOR_ID_INTEL, 0x15b8, pci_quirk_mf_endpoint_acs },
 	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID, pci_quirk_rciep_acs },
+	/* Denverton */
+	{ PCI_VENDOR_ID_INTEL, 0x19e5, pci_quirk_mf_endpoint_acs },
+	{ PCI_VENDOR_ID_INTEL, 0x19e6, pci_quirk_mf_endpoint_acs },
 	/* QCOM QDF2xxx root ports */
 	{ PCI_VENDOR_ID_QCOM, 0x0400, pci_quirk_qcom_rp_acs },
 	{ PCI_VENDOR_ID_QCOM, 0x0401, pci_quirk_qcom_rp_acs },
-- 
2.26.2

