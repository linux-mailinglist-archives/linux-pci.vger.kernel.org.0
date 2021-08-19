Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB4C3F1BEF
	for <lists+linux-pci@lfdr.de>; Thu, 19 Aug 2021 16:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240621AbhHSOv7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Aug 2021 10:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240633AbhHSOvz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Aug 2021 10:51:55 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF36EC061756;
        Thu, 19 Aug 2021 07:51:18 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id f5so9481889wrm.13;
        Thu, 19 Aug 2021 07:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n01mXawYd9GTWQOxDU1mYfKl1cowyI/OnBiVepqTeqs=;
        b=oPPbee0GqE4ewK/FAEWTkdj5TUSEICN8k101RajknLDdMv2CBPrqqSm3a+O2lk3dEo
         VCcVFr5mI5R233Ruse6tIx8d/OVIQQyjywMUEwy4qN8JJXibvpi/M6A+tXgnZ8w9UVj+
         HMr5zq+jBTtmdn+YjFdqYzT3lJw14hxmO7wu82fRWD6vx4mPHqvdsgrtY3jR3v8w8l7T
         Sp3tuzVDOL5Pxk3AqAdY7IuphY4hzBZkH8/q7fZ4wZftAZZoYUnn5hu2YTtISmWmY/CS
         UEu2D3+i+3bF+jHcKf2VDG0lsUku4UFyijD4JfAFclAVzh30YVSk3AlcXH60VQn2CLGT
         m25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n01mXawYd9GTWQOxDU1mYfKl1cowyI/OnBiVepqTeqs=;
        b=bKDMdfaJnXd0xLR6oQMzSVs1EX09KTzFmNLPpluHn+Mcg5ZqFpuXn1h4nr1Ynn2zVW
         5w5YF/owJSGb+TtjRmZGk4JamPs/CQkC7Okra9u3/qSnJnWLRMfHWsrQ4mvlvFDAl3BB
         FtqlilP5MRQLufFV+UJdTU2/P61bTM0d5OqvKFPjEvqoPqufrfJ//s+w4uPP2ElO9t3B
         sr31GoIzn+/wiIkK9a5zTr5aq7vuAe/lAlqUv3B6u1IMDhuJigeWTH8IXOCMNpl7mtNM
         EkLKAX5FvLBZT5SLFeZV+/vLzAiVTzCAE8WhmwJ9BKroLXb7BjwlJKEvOy5unsM2yW0T
         OJ1Q==
X-Gm-Message-State: AOAM5338aVN+yWJqyz3RqyaihoahnK2Ap5d5s8b7+5rp/aV/CbmKD68d
        4qeYq/s0iaN14ElbmxeIkyI=
X-Google-Smtp-Source: ABdhPJzB7iw8BxrewWuO3O3F01Pq3pYPwGDE5tVt/ni0S9YkiGGiJoccvP1kM8YIO8+9sKVhcx02sA==
X-Received: by 2002:a5d:4fc9:: with SMTP id h9mr4461685wrw.2.1629384677424;
        Thu, 19 Aug 2021 07:51:17 -0700 (PDT)
Received: from localhost.localdomain (arl-84-90-178-246.netvisao.pt. [84.90.178.246])
        by smtp.gmail.com with ESMTPSA id o14sm3150409wrw.17.2021.08.19.07.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 07:51:16 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Tomas Winkler <tomas.winkler@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Ionel-Catalin Mititelu <ionel-catalin.mititelu@intel.com>,
        Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] mei: improve Denverton HSM & IFSI support
Date:   Thu, 19 Aug 2021 16:51:14 +0200
Message-Id: <20210819145114.21074-1-lukas.bulwahn@gmail.com>
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
index cb34925e10f1..c1c41912bb72 100644
--- a/drivers/misc/mei/hw-me-regs.h
+++ b/drivers/misc/mei/hw-me-regs.h
@@ -68,7 +68,8 @@
 #define MEI_DEV_ID_BXT_M      0x1A9A  /* Broxton M */
 #define MEI_DEV_ID_APL_I      0x5A9A  /* Apollo Lake I */
 
-#define MEI_DEV_ID_DNV_IE     0x19E5  /* Denverton IE */
+#define MEI_DEV_ID_DNV_IE	0x19E5  /* Denverton for HECI1 - IFSI */
+#define MEI_DEV_ID_DNV_IE_2	0x19E6  /* Denverton 2 for HECI2 - HSM */
 
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

