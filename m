Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A474564ED
	for <lists+linux-pci@lfdr.de>; Thu, 18 Nov 2021 22:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhKRVN3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Nov 2021 16:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234463AbhKRVN1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Nov 2021 16:13:27 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A15BC061574
        for <linux-pci@vger.kernel.org>; Thu, 18 Nov 2021 13:10:26 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 77-20020a1c0450000000b0033123de3425so8784746wme.0
        for <linux-pci@vger.kernel.org>; Thu, 18 Nov 2021 13:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to
         :content-language:cc:content-transfer-encoding;
        bh=G3fZmKOo/J9cc206xBW7iBHSldwFZyhKfuaM71Z1/Po=;
        b=EUI7Yjr6PJbdl9Z8xf4Xz1E/djlxVs2HuBooZkqP+CVefp01q9aV/aQhRYVQctlByM
         DLRJ/9IEKF7RwtI+OvQBQb9NkPPXYSOdjbe/S3acS0rKZwJamZSo38TFRyXNvmEgmDkH
         8ZMgq2+r4OxH6vRD6aHK34RRmUZzOZOSdi17hxoyoTOP9xoyyOBeQeksGWJT+ncuah7r
         prAtY/bncBUoplU+PX0k8Ikoxkcp2mpgbzv/WKHCHTzJ3ihzKcxABW/5+DyV/JSsXXOR
         vmXtnK50gtKUiOIq+Di35WX3Bl/78iV6iJa5ypWu59nloACdSs4VYMHP7g9d/obRKDLM
         rNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:content-language:cc:content-transfer-encoding;
        bh=G3fZmKOo/J9cc206xBW7iBHSldwFZyhKfuaM71Z1/Po=;
        b=Trg6PRIPMf9CcERV3YkEocQfcQa8kBIXbXl5Rfj+JkLyV+fMcE1vkaVG3LvsJLJ8u4
         OiALS4iGtvyIc4862AWd7Q7CgwA6cBN5TVKzROI6lAjanJu9THqSrdx/z9oimWzxGC3o
         5PgiCe8XSp8Cy3QJbfpF+NUpm8lVdWAG5VOwr452mGp5Qh/V2LLcYfPz5j/aJ3p6Ex+p
         npjqL0OiFxmGDs+Ek+ugVfhtoRJ+kEhymBsg3LbUkrszwVif5hT5xmcKCKrccdu+Nxrc
         jGMMyNdL94YtSq1Ap+ELFbu98lVGSWQyBu54uj55Vlcr7I9q08b1ZaZQTDBZDGTqkU5X
         rGbg==
X-Gm-Message-State: AOAM530SlgGo63984XPrAnRPgQXbZ9zJny4oplVR+yvLVD9oENAA/MvE
        GJ9LiHdjjgLku4Z/K6wVY1SMySTwvPQ=
X-Google-Smtp-Source: ABdhPJw84dfiy8hK+ubShRdBkCDJ0q07Ir1no6rwQWtv7C+6oTLappCVyAFqo2xmuRLLh+SbqbqVaw==
X-Received: by 2002:a1c:2b04:: with SMTP id r4mr182858wmr.48.1637269824937;
        Thu, 18 Nov 2021 13:10:24 -0800 (PST)
Received: from ?IPV6:2003:ea:8f1a:f00:fc8d:4de8:c1d1:9213? (p200300ea8f1a0f00fc8d4de8c1d19213.dip0.t-ipconnect.de. [2003:ea:8f1a:f00:fc8d:4de8:c1d1:9213])
        by smtp.googlemail.com with ESMTPSA id g5sm1569117wri.45.2021.11.18.13.10.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Nov 2021 13:10:24 -0800 (PST)
Message-ID: <8dd245a0-c088-c5e1-a2be-913c96f44bc9@gmail.com>
Date:   Thu, 18 Nov 2021 22:10:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH RESEND] PCI/VPD: Add simple VPD read cache
To:     Bjorn Helgaas <bhelgaas@google.com>
Content-Language: en-US
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

VPD reads can be time-consuming operations, and when reading bytes
sequentially then worst-case we may read the same VPD dword four times.
Typically it happens in pci_vpd_size() already that the same VPD dword
is read more than once. Therefore let's add a simple read cache that
caches the last read VPD dword.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/vpd.c   | 13 +++++++++++++
 include/linux/pci.h |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 75e48df2e..2315e45f6 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -194,6 +194,11 @@ static ssize_t pci_vpd_read(struct pci_dev *dev, loff_t pos, size_t count,
 			break;
 		}
 
+		if (vpd->cached_offset == (pos & ~3)) {
+			val = vpd->cached_val;
+			goto process;
+		}
+
 		ret = pci_user_write_config_word(dev, vpd->cap + PCI_VPD_ADDR,
 						 pos & ~3);
 		if (ret < 0)
@@ -206,6 +211,9 @@ static ssize_t pci_vpd_read(struct pci_dev *dev, loff_t pos, size_t count,
 		if (ret < 0)
 			break;
 
+		vpd->cached_val = val;
+		vpd->cached_offset = pos & ~3;
+process:
 		skip = pos & 3;
 		for (i = 0;  i < sizeof(u32); i++) {
 			if (i >= skip) {
@@ -242,6 +250,10 @@ static ssize_t pci_vpd_write(struct pci_dev *dev, loff_t pos, size_t count,
 		return -EINTR;
 
 	while (pos < end) {
+		/* invalidate read cache */
+		if (vpd->cached_offset == pos)
+			vpd->cached_offset = -1;
+
 		ret = pci_user_write_config_dword(dev, vpd->cap + PCI_VPD_DATA,
 						  get_unaligned_le32(buf));
 		if (ret < 0)
@@ -270,6 +282,7 @@ void pci_vpd_init(struct pci_dev *dev)
 
 	dev->vpd.cap = pci_find_capability(dev, PCI_CAP_ID_VPD);
 	mutex_init(&dev->vpd.lock);
+	dev->vpd.cached_offset = -1;
 }
 
 static ssize_t vpd_read(struct file *filp, struct kobject *kobj,
diff --git a/include/linux/pci.h b/include/linux/pci.h
index cd8aa6fce..fb123c248 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -297,6 +297,8 @@ enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev);
 struct pci_vpd {
 	struct mutex	lock;
 	unsigned int	len;
+	u32		cached_val;
+	int		cached_offset;
 	u8		cap;
 };
 
-- 
2.33.0

