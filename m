Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD8B137FF88
	for <lists+linux-pci@lfdr.de>; Thu, 13 May 2021 22:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbhEMVAJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 May 2021 17:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbhEMVAI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 May 2021 17:00:08 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55505C061574
        for <linux-pci@vger.kernel.org>; Thu, 13 May 2021 13:58:58 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id x8so5831461wrq.9
        for <linux-pci@vger.kernel.org>; Thu, 13 May 2021 13:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UeYFsUJJmpRUKdSs0Tp5gwBJrNb4ZqLnzL0AtDJ8jmo=;
        b=hv+fhFd7CNhwioZm7JU2OoKRyTmXEaezFNM6n6JHVxBExaMaLs0qJJd4qCW7UpIygW
         maWMwk5pv4aPYr59tBPQ3cgxe3Eg/qIGUsA/enYF1y7NxiuHYgn0LQmlxAzzOcgC18Wf
         kx4upvml/9twmd08BXpzkIeyD8Kdb6cn8F5NJysxlvR70al69Te6T/YCobB3MjEalEE0
         8oP26ghIOyFyINboELcaH/SmLnKdTnkGAMHrmsWQY+INbtEU/wDVawShvF9/2VuEbqdv
         z4vkMtilaaAprgudDFEc0LAQI9BJ3JAcsLGpC/6iy5UxolTODb7ylO6ZJ3gTvqrTTXnt
         rgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UeYFsUJJmpRUKdSs0Tp5gwBJrNb4ZqLnzL0AtDJ8jmo=;
        b=e1MC23mkRkUgTP8lLBgK1acpkkFpwQBmiDncL5RV/wsl2ujep7PlheP+wGRRyrIKQ4
         XGNoN87WE79LwBvWR5Z3gX5oW1/ZjzlW1MltUyBnBUL6qMa1Ib4SCjMHfys8pmuzh150
         0mr5APjK+V3fB7FzV58JK/QwLvFXW1Ve/gOgVXr3iQRr201QYVgCY+aXfVfp+sUgJGuG
         beA3GO8Lu8WFDfJCB0JdCaye17t+QQ05S6Yos78rDkSrMUv1qQBRWkwcbdMdfGhGeu9R
         tYZfHy53ETAXjd94NJ21yDTwOTBCDExTj5MPCZz6n2dSP0ey2yjCrVnUwjW2XMCPAjkz
         3oFA==
X-Gm-Message-State: AOAM5304N0vhh7MadR+ZnpPTUSVj0XbKnmnr971gKwl5fQzOLhryeETV
        JxOx8J204VoD2CNtUikeK2v+3fgTwh/zFg==
X-Google-Smtp-Source: ABdhPJwlmFJ8wL0ycVobv7bgFFql5UJrDCrJgLJtlU4yH7HFdCZvXGagCQzlQT37GJQtVnv22OR2sA==
X-Received: by 2002:a5d:64c6:: with SMTP id f6mr54774765wri.18.1620939536817;
        Thu, 13 May 2021 13:58:56 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f38:4600:dc15:2d50:47c3:384f? (p200300ea8f384600dc152d5047c3384f.dip0.t-ipconnect.de. [2003:ea:8f38:4600:dc15:2d50:47c3:384f])
        by smtp.googlemail.com with ESMTPSA id p12sm3179909wme.20.2021.05.13.13.58.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 May 2021 13:58:56 -0700 (PDT)
Subject: [PATCH 2/5] PCI: Clean up VPD constants and functions in pci.h
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <dc566e6c-4c9b-bcd5-1f33-edba94cedd00@gmail.com>
Message-ID: <97f81466-96a8-4895-aafe-c7317c852db7@gmail.com>
Date:   Thu, 13 May 2021 22:55:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <dc566e6c-4c9b-bcd5-1f33-edba94cedd00@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Move some constants that are used by vpd.c only from include/linux/pci.h
to drivers/pci/vpd.c. In addition remove some unused VPD inline functions.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/vpd.c   |  7 +++++++
 include/linux/pci.h | 43 -------------------------------------------
 2 files changed, 7 insertions(+), 43 deletions(-)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index ecdce170f..ff537371c 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -13,6 +13,13 @@
 
 /* VPD access through PCI 2.2+ VPD capability */
 
+/* Small Resource Data Type */
+#define PCI_VPD_SRDT_TAG_SIZE	1
+#define PCI_VPD_SRDT_END	(0x0f << 3) /* end tag */
+
+/* Large Resource Data Type */
+#define PCI_VPD_LRDT_TIN_MASK	0x7f
+
 struct pci_vpd_ops {
 	ssize_t (*read)(struct pci_dev *dev, loff_t pos, size_t count, void *buf);
 	ssize_t (*write)(struct pci_dev *dev, loff_t pos, size_t count, const void *buf);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c20211e59..c21558821 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2240,17 +2240,7 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask);
 #define PCI_VPD_LRDT_RO_DATA		PCI_VPD_LRDT_ID(PCI_VPD_LTIN_RO_DATA)
 #define PCI_VPD_LRDT_RW_DATA		PCI_VPD_LRDT_ID(PCI_VPD_LTIN_RW_DATA)
 
-/* Small Resource Data Type Tag Item Names */
-#define PCI_VPD_STIN_END		0x0f	/* End */
-
-#define PCI_VPD_SRDT_END		(PCI_VPD_STIN_END << 3)
-
-#define PCI_VPD_SRDT_TIN_MASK		0x78
-#define PCI_VPD_SRDT_LEN_MASK		0x07
-#define PCI_VPD_LRDT_TIN_MASK		0x7f
-
 #define PCI_VPD_LRDT_TAG_SIZE		3
-#define PCI_VPD_SRDT_TAG_SIZE		1
 
 #define PCI_VPD_INFO_FLD_HDR_SIZE	3
 
@@ -2271,39 +2261,6 @@ static inline u16 pci_vpd_lrdt_size(const u8 *lrdt)
 	return (u16)lrdt[1] + ((u16)lrdt[2] << 8);
 }
 
-/**
- * pci_vpd_lrdt_tag - Extracts the Large Resource Data Type Tag Item
- * @lrdt: Pointer to the beginning of the Large Resource Data Type tag
- *
- * Returns the extracted Large Resource Data Type Tag item.
- */
-static inline u16 pci_vpd_lrdt_tag(const u8 *lrdt)
-{
-	return (u16)(lrdt[0] & PCI_VPD_LRDT_TIN_MASK);
-}
-
-/**
- * pci_vpd_srdt_size - Extracts the Small Resource Data Type length
- * @srdt: Pointer to the beginning of the Small Resource Data Type tag
- *
- * Returns the extracted Small Resource Data Type length.
- */
-static inline u8 pci_vpd_srdt_size(const u8 *srdt)
-{
-	return (*srdt) & PCI_VPD_SRDT_LEN_MASK;
-}
-
-/**
- * pci_vpd_srdt_tag - Extracts the Small Resource Data Type Tag Item
- * @srdt: Pointer to the beginning of the Small Resource Data Type tag
- *
- * Returns the extracted Small Resource Data Type Tag Item.
- */
-static inline u8 pci_vpd_srdt_tag(const u8 *srdt)
-{
-	return ((*srdt) & PCI_VPD_SRDT_TIN_MASK) >> 3;
-}
-
 /**
  * pci_vpd_info_field_size - Extracts the information field length
  * @info_field: Pointer to the beginning of an information field header
-- 
2.31.1


