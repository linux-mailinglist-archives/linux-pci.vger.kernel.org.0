Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE9A37FF8A
	for <lists+linux-pci@lfdr.de>; Thu, 13 May 2021 22:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbhEMVAQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 May 2021 17:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbhEMVAQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 May 2021 17:00:16 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA373C061574
        for <linux-pci@vger.kernel.org>; Thu, 13 May 2021 13:59:04 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 8so839498wmc.5
        for <linux-pci@vger.kernel.org>; Thu, 13 May 2021 13:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ta99OcHaPrzvQEEzZKq7Wr4h68NLduJIqHZlGn9OJ9M=;
        b=DkUtse0CZY3ebLOAq+Bodgq1ZB8Uq4Jdu6f7xaPuVXMxbDaIikFdOZiDgVR3FJfTqI
         tApky8g+JqLteXQe9AJkucPB9W01c23jxU+GJQqoblPglO+syxufMjfHgFPI3VxV//CU
         bj6rxEfl3Pgy2TAM1F8h1/Pc1GjsfNxn8/lLCiTn1qXT5HQblIRycLzohYpde4EVxEDA
         Jf13MKfxPpYs6mJC4WBDzTT4wEWUHtrjbBoO2Dyr8s8frtm5L09wnzepvdNK9gutgBst
         YtHuogpDSgsQ/xg1RJsfEq+sK3JL+ok29XVuuyF/4AgIxtEAK13NMsC4Y8b8NAIKZdQ4
         yyiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ta99OcHaPrzvQEEzZKq7Wr4h68NLduJIqHZlGn9OJ9M=;
        b=NG4p45sOssBvOOg95pUV6mQDA4eh4O8KcVtvmACzZc3BbA2uBI4Ckaa0GYhw4e7Eaw
         3s6RWswm/nTavgnERobOjIBdAMLL3y0H+IlEFfVXKEYPFoAoNURn/Zru8K2H+BZyCi1a
         uArqzHM+k1Pnok2A3qG96YMi8FeKjZcRoW3L9QU484MJotY7RPdgWUYPDYHHBgnkhgb6
         VzRJYEZtbxrOewbM5jIf0rKXGAPTKvxXrjGbVPKf4WAgMNUMpTsE6rObDybHHeR6b4/A
         x+/42GG/rsS4JDZSVITj0l0uFcjPZsZM6CQi8iAzT9wuEgSSD1V7d8Tp6n8v4cMVnqot
         MjBA==
X-Gm-Message-State: AOAM5315wf3Csmy/941KpWwhpx1E5rO1RWCPNYSKq0B2ArNbWOVltDdJ
        fPcn8XEY35crz3PhskgdO2mhoNv1p12Qkg==
X-Google-Smtp-Source: ABdhPJxHTVGu6j5jS0dFt9mG6pmeLn2H/XAibFnVegvd3t0NpV6tfu9elG6GuwHpmqwxzkhC/p33cA==
X-Received: by 2002:a05:600c:4fd6:: with SMTP id o22mr23984811wmq.83.1620939543333;
        Thu, 13 May 2021 13:59:03 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f38:4600:dc15:2d50:47c3:384f? (p200300ea8f384600dc152d5047c3384f.dip0.t-ipconnect.de. [2003:ea:8f38:4600:dc15:2d50:47c3:384f])
        by smtp.googlemail.com with ESMTPSA id k10sm10374422wmf.0.2021.05.13.13.59.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 May 2021 13:59:03 -0700 (PDT)
Subject: [PATCH 4/5] PCI/VPD: Make pci_vpd_wait uninterruptible
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <dc566e6c-4c9b-bcd5-1f33-edba94cedd00@gmail.com>
Message-ID: <258bf994-bc2a-2907-9181-2c7a562986d5@gmail.com>
Date:   Thu, 13 May 2021 22:56:41 +0200
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

Reading/writing 4 bytes should be fast enough even on a slow bus,
therefore pci_vpd_wait() doesn't have to be interruptible.
Making it uninterruptible allows to simplify the code.
In addition make VPD writes uninterruptible in general.
It's about vital data, and allowing writes to be interruptible may
leave the VPD in an inconsistent state.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/vpd.c | 33 +++++++++------------------------
 1 file changed, 9 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index e73a3a55f..76b20a13a 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -31,7 +31,6 @@ struct pci_vpd {
 	unsigned int	len;
 	u16		flag;
 	u8		cap;
-	unsigned int	busy:1;
 	unsigned int	valid:1;
 };
 
@@ -121,22 +120,14 @@ static int pci_vpd_wait(struct pci_dev *dev)
 	u16 status;
 	int ret;
 
-	if (!vpd->busy)
-		return 0;
-
 	do {
 		ret = pci_user_read_config_word(dev, vpd->cap + PCI_VPD_ADDR,
 						&status);
 		if (ret < 0)
 			return ret;
 
-		if ((status & PCI_VPD_ADDR_F) == vpd->flag) {
-			vpd->busy = 0;
+		if ((status & PCI_VPD_ADDR_F) == vpd->flag)
 			return 0;
-		}
-
-		if (fatal_signal_pending(current))
-			return -EINTR;
 
 		if (time_after(jiffies, timeout))
 			break;
@@ -154,7 +145,7 @@ static ssize_t pci_vpd_read(struct pci_dev *dev, loff_t pos, size_t count,
 			    void *arg)
 {
 	struct pci_vpd *vpd = dev->vpd;
-	int ret;
+	int ret = 0;
 	loff_t end = pos + count;
 	u8 *buf = arg;
 
@@ -180,19 +171,19 @@ static ssize_t pci_vpd_read(struct pci_dev *dev, loff_t pos, size_t count,
 	if (mutex_lock_killable(&vpd->lock))
 		return -EINTR;
 
-	ret = pci_vpd_wait(dev);
-	if (ret < 0)
-		goto out;
-
 	while (pos < end) {
 		u32 val;
 		unsigned int i, skip;
 
+		if (fatal_signal_pending(current)) {
+			ret = -EINTR;
+			break;
+		}
+
 		ret = pci_user_write_config_word(dev, vpd->cap + PCI_VPD_ADDR,
 						 pos & ~3);
 		if (ret < 0)
 			break;
-		vpd->busy = 1;
 		vpd->flag = PCI_VPD_ADDR_F;
 		ret = pci_vpd_wait(dev);
 		if (ret < 0)
@@ -212,7 +203,7 @@ static ssize_t pci_vpd_read(struct pci_dev *dev, loff_t pos, size_t count,
 			val >>= 8;
 		}
 	}
-out:
+
 	mutex_unlock(&vpd->lock);
 	return ret ? ret : count;
 }
@@ -242,10 +233,6 @@ static ssize_t pci_vpd_write(struct pci_dev *dev, loff_t pos, size_t count,
 	if (mutex_lock_killable(&vpd->lock))
 		return -EINTR;
 
-	ret = pci_vpd_wait(dev);
-	if (ret < 0)
-		goto out;
-
 	while (pos < end) {
 		u32 val;
 
@@ -262,7 +249,6 @@ static ssize_t pci_vpd_write(struct pci_dev *dev, loff_t pos, size_t count,
 		if (ret < 0)
 			break;
 
-		vpd->busy = 1;
 		vpd->flag = 0;
 		ret = pci_vpd_wait(dev);
 		if (ret < 0)
@@ -270,7 +256,7 @@ static ssize_t pci_vpd_write(struct pci_dev *dev, loff_t pos, size_t count,
 
 		pos += sizeof(u32);
 	}
-out:
+
 	mutex_unlock(&vpd->lock);
 	return ret ? ret : count;
 }
@@ -333,7 +319,6 @@ void pci_vpd_init(struct pci_dev *dev)
 		vpd->ops = &pci_vpd_ops;
 	mutex_init(&vpd->lock);
 	vpd->cap = cap;
-	vpd->busy = 0;
 	vpd->valid = 0;
 	dev->vpd = vpd;
 }
-- 
2.31.1


