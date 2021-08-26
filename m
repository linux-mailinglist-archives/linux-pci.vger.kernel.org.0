Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20B843F8E59
	for <lists+linux-pci@lfdr.de>; Thu, 26 Aug 2021 20:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243409AbhHZS73 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Aug 2021 14:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243432AbhHZS73 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Aug 2021 14:59:29 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C1BC061757
        for <linux-pci@vger.kernel.org>; Thu, 26 Aug 2021 11:58:41 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id u15so2428762wmj.1
        for <linux-pci@vger.kernel.org>; Thu, 26 Aug 2021 11:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=13raq/fbB+++wadaSwIhFLoGvj1KRluAlpxJAjLJwn4=;
        b=ESVmdVVo2Xa6EHSkdCQwchiqtzPI4YunfVaLz8qFr1se8hh2O8LYcWc+SSrvtd5apj
         7qD6gSBsX5M8Y6e/H5Qk58nd+Z3eaSKUAbAGYakVqyZii0HroKuStWrAmus5erRBcekK
         KLGVu8d5cZub5u+O+yJ4JDSw+S5nelctuL8J1i9FWHx+EjhffIujgQsAUd+97069n1Qc
         /WMRbGtWQaWBF/sD+wbDpyEnxkbAGFQdPsNzURgZdbaHttWy+7iW9or7MwMIxgTUSTQD
         iervk3Ftq6YaYCgDL/5nrbTjGv5M/E81IcqfljmCLm7HTrCj87CopNiInt4PNCPtCZkN
         8J3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=13raq/fbB+++wadaSwIhFLoGvj1KRluAlpxJAjLJwn4=;
        b=ZSuCl6ZW3GjSGNi3mvsYGA8ByOTL0c1cj+4+eo2/mAXxhG51mgRJpC3TJ7guCuBT9H
         gRmWNOPUEz8mlhaOCYDRJRhBCcSvmuzp4iB+otWbWZ+Fw6YiTLU4kY0viIKkFF8NIuGN
         iz8V7LvYfkCTdxd45Ov9lh5wMuB/tIHp91B+W1fEm+HHygy5QdDASuz4mg7aaCmtJ8uW
         TxdF1bS9QOx+C+Rt2bcgkXgpHUy5dC06l4nN/0YvjtzStlodcTJxePqrJerp3JOGFDEn
         uvRz7snXTvGzA+kACvjlH4xecg9gbJh4B7QaNNsPLArETm0eFc40A3d7s4YCNztHzHnc
         CfEw==
X-Gm-Message-State: AOAM530C3C8ogBeIT6biD5R/OlDh+MBbs2bYH0uYMIfprnQnriOEIEi4
        zslqYbyU35oB37o1zPD4R2z66bHGrDxH+w==
X-Google-Smtp-Source: ABdhPJx2IJdgYg+m9iLF9oXwy2X7eQHtLvcUOQsPEmcRIJ/fLbnKqxCzRJons+DY1PHx5zF7N90yHw==
X-Received: by 2002:a05:600c:1551:: with SMTP id f17mr15611235wmg.44.1630004320082;
        Thu, 26 Aug 2021 11:58:40 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f08:4500:b5d8:a3dc:f88f:cae2? (p200300ea8f084500b5d8a3dcf88fcae2.dip0.t-ipconnect.de. [2003:ea:8f08:4500:b5d8:a3dc:f88f:cae2])
        by smtp.googlemail.com with ESMTPSA id d4sm4065613wrz.35.2021.08.26.11.58.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 11:58:39 -0700 (PDT)
Subject: [PATCH 7/7] PCI/VPD: Use unaligned access helpers
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <5fa6578d-1515-20d3-be5f-9e7dc7db4424@gmail.com>
Message-ID: <0f1c7e21-5330-72ab-139d-f5ce3c65f04a@gmail.com>
Date:   Thu, 26 Aug 2021 20:58:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <5fa6578d-1515-20d3-be5f-9e7dc7db4424@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use unaligned access helpers to simplify the code.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/vpd.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index ff600dff4..25557b272 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -9,6 +9,7 @@
 #include <linux/delay.h>
 #include <linux/export.h>
 #include <linux/sched/signal.h>
+#include <asm/unaligned.h>
 #include "pci.h"
 
 #define PCI_VPD_LRDT_TAG_SIZE		3
@@ -19,7 +20,7 @@
 
 static u16 pci_vpd_lrdt_size(const u8 *lrdt)
 {
-	return (u16)lrdt[1] + ((u16)lrdt[2] << 8);
+	return get_unaligned_le16(lrdt + 1);
 }
 
 static u8 pci_vpd_srdt_tag(const u8 *srdt)
@@ -218,14 +219,8 @@ static ssize_t pci_vpd_write(struct pci_dev *dev, loff_t pos, size_t count,
 		return -EINTR;
 
 	while (pos < end) {
-		u32 val;
-
-		val = *buf++;
-		val |= *buf++ << 8;
-		val |= *buf++ << 16;
-		val |= *buf++ << 24;
-
-		ret = pci_user_write_config_dword(dev, vpd->cap + PCI_VPD_DATA, val);
+		ret = pci_user_write_config_dword(dev, vpd->cap + PCI_VPD_DATA,
+						  get_unaligned_le32(buf));
 		if (ret < 0)
 			break;
 		ret = pci_user_write_config_word(dev, vpd->cap + PCI_VPD_ADDR,
@@ -237,6 +232,7 @@ static ssize_t pci_vpd_write(struct pci_dev *dev, loff_t pos, size_t count,
 		if (ret < 0)
 			break;
 
+		buf += sizeof(u32);
 		pos += sizeof(u32);
 	}
 
-- 
2.33.0


