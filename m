Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E096376CD9
	for <lists+linux-pci@lfdr.de>; Sat,  8 May 2021 00:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhEGWaY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 May 2021 18:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhEGWaY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 May 2021 18:30:24 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFF5C061574
        for <linux-pci@vger.kernel.org>; Fri,  7 May 2021 15:29:22 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id w3so15795497ejc.4
        for <linux-pci@vger.kernel.org>; Fri, 07 May 2021 15:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=D8CMSysmCUq6T7qxreBvmApNBU5N6Ri6bP9BoVDgxvY=;
        b=T1io0telvVrROkAXEm2mI2YCDBbIeGFrLVTkMO+LcefmOIq3KJWrt/8zAynDUsntkp
         LmD3Ck2qgzJBdyQziv1lI10eS6We0xM4fjqajdKLk5s7hCOjZ6D2Z7JcgsyCXMdJRZGT
         1tqjLsoY2+dJ6/0Trfk/OLo17FS4W3qx5VgKLEv+Yb3pT5l/r1C7ucIBIXGSv0zhvRpY
         gx1yrwA4mQOQIINfFtS4J3NUnYtrB31yvMvEjrl/gbXoO+rQb4lV0ZdJN2rHJLWhQXQy
         jcPnl2Hm6C1XMEGUn/fdG55id18ff9xw0eE2ESlXMPLfnQ/7UnVecshHq5tJGSNGBd5i
         24AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=D8CMSysmCUq6T7qxreBvmApNBU5N6Ri6bP9BoVDgxvY=;
        b=sXzkIJV6qtWn/bu8Ct9k5Oxmpv9bQXsM8r9nDhT6htEKxPG2f7iQck6N8pWVHVFNSg
         wm5Uo2YmHpNRbJKGudR0kQUaFoWFEX3LI4dCCmtr5j3z/XpZfGmfsb0G0tN3b/hhpUNl
         6b6YZPeLU2TvGPcW8ULPRuNz7qYBYVo43SoOE9x0Ps50MtLurfOfCtHTgr9eePbsfZHo
         HjNZkRxz5V+5LYQ9SZIpWA1HLNE001EzXnd5Crr0WXDLiJrouTmLiETGK1PEdSxxk9LK
         uOzuvawGUTC+MpSOTxBPXETsfLLZZ1aoWe2W2aTbJWV5AYH9PAZHrh7odCLpP2jpfjA5
         L/Aw==
X-Gm-Message-State: AOAM533+5zXMRjO+biin9U8JP/zo94BHeFTQf/kX8PV0TQqKsS0Kr9ow
        x/7XGcD48D4ookv/nmywixGiupw7gsINKw==
X-Google-Smtp-Source: ABdhPJxjQWkdE0WkAzuyftHk+7FBfH0dhio/sX8O7PnZMeUrCpFuG1uxwaisri034Ka9REKClBUINg==
X-Received: by 2002:a17:906:9381:: with SMTP id l1mr12375497ejx.45.1620426561348;
        Fri, 07 May 2021 15:29:21 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f38:4600:b4c6:4571:e0db:c0d3? (p200300ea8f384600b4c64571e0dbc0d3.dip0.t-ipconnect.de. [2003:ea:8f38:4600:b4c6:4571:e0db:c0d3])
        by smtp.googlemail.com with ESMTPSA id u11sm4979567edr.13.2021.05.07.15.29.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 May 2021 15:29:20 -0700 (PDT)
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH v2] PCI/VPD: Use unaligned access helpers in pci_vpd_read
Message-ID: <5719b91c-9f91-0029-0a28-386f1cb29d31@gmail.com>
Date:   Sat, 8 May 2021 00:29:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

With this patch we avoid some unnecessary looping if the platform defines
HAVE_EFFICIENT_UNALIGNED_ACCESS and we make the code better readable.
No functional change intended.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2: remove not needed tmpbuf variable
---
 drivers/pci/vpd.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 741e7a505..ab886e5f4 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -163,12 +163,11 @@ static int pci_vpd_wait(struct pci_dev *dev)
 }
 
 static ssize_t pci_vpd_read(struct pci_dev *dev, loff_t pos, size_t count,
-			    void *arg)
+			    void *buf)
 {
 	struct pci_vpd *vpd = dev->vpd;
 	int ret;
 	loff_t end = pos + count;
-	u8 *buf = arg;
 
 	if (pos < 0)
 		return -EINVAL;
@@ -197,8 +196,8 @@ static ssize_t pci_vpd_read(struct pci_dev *dev, loff_t pos, size_t count,
 		goto out;
 
 	while (pos < end) {
+		unsigned int len, skip;
 		u32 val;
-		unsigned int i, skip;
 
 		ret = pci_user_write_config_word(dev, vpd->cap + PCI_VPD_ADDR,
 						 pos & ~3);
@@ -215,14 +214,17 @@ static ssize_t pci_vpd_read(struct pci_dev *dev, loff_t pos, size_t count,
 			break;
 
 		skip = pos & 3;
-		for (i = 0;  i < sizeof(u32); i++) {
-			if (i >= skip) {
-				*buf++ = val;
-				if (++pos == end)
-					break;
-			}
-			val >>= 8;
+		len = min_t(unsigned int, 4 - skip, end - pos);
+
+		if (len == 4)  {
+			put_unaligned_le32(val, buf);
+		} else {
+			cpu_to_le32s(&val);
+			memcpy(buf, (u8 *)&val + skip, len);
 		}
+
+		buf += len;
+		pos += len;
 	}
 out:
 	mutex_unlock(&vpd->lock);
-- 
2.31.1

